"""Census of CMake fetch declarations in a source tree (waybill spec 1538).

For every CMakeLists.txt and *.cmake file under <root> (skipping .git):
  * each FetchContent_Declare and ExternalProject_Add call: its file, line,
    name, the conditions of every enclosing if()/elseif()/else(), and whether
    it sits inside a function() or macro() body (a wrapper, waybill#1518);
  * the fallback shapes waybill spec 1538 recognises: FIND_PACKAGE_ARGS on the
    declaration, an enclosing `NOT TARGET` condition, an enclosing
    BUILD_TESTING condition;
  * where FETCHCONTENT_TRY_FIND_PACKAGE_MODE is set, and where
    cmake_language(SET_DEPENDENCY_PROVIDER ...) is called;
  * whether the declaring file is in waybill's current CMake file set (root
    CMakeLists.txt, cmake/**, Modules/**, third_party/* at depth 1);
  * whether the declaring file is reachable from the root through literal
    add_subdirectory() / include() paths;
  * FetchContent names declared in more than one file, and declared in an
    ancestor directory of another declaration (first-declaration-wins);
  * find_package / pkg_check_modules / pkg_search_module call counts outside
    the current file set (waybill spec 1538 SC-008).

Reads files only; evaluates nothing. Usage: fetches.py <root> <out.json>
"""
import collections
import json
import os
import pathlib
import re
import sys

ROOT = pathlib.Path(sys.argv[1]).resolve()
OUT = pathlib.Path(sys.argv[2])
TEST_DIRS = {"test", "tests", "unittests"}
FETCH = {"fetchcontent_declare", "externalproject_add"}
FIND = {"find_package", "pkg_check_modules", "pkg_search_module"}


def cmake_files(root):
    for dirpath, dirnames, filenames in os.walk(root):
        dirnames[:] = [d for d in dirnames if d != ".git"]
        for f in filenames:
            if f == "CMakeLists.txt" or f.lower().endswith(".cmake"):
                yield pathlib.Path(dirpath, f)


def in_current_set(rel):
    parts = rel.parts
    if parts == ("CMakeLists.txt",):
        return True
    if parts and parts[0] in ("cmake", "Modules"):
        return True
    return len(parts) == 3 and parts[0] == "third_party"


BRACKET_OPEN = re.compile(r"\[(=*)\[")


def commands(text):
    """Yield (name_lower, args, line) for each command invocation."""
    i, n, line = 0, len(text), 1
    while i < n:
        c = text[i]
        if c == "\n":
            line += 1
            i += 1
            continue
        if c == "#":
            m = BRACKET_OPEN.match(text, i + 1)
            if m:
                close = "]" + m.group(1) + "]"
                j = text.find(close, m.end())
                j = n if j < 0 else j + len(close)
            else:
                j = text.find("\n", i)
                j = n if j < 0 else j
            line += text.count("\n", i, j)
            i = j
            continue
        if c.isalpha() or c == "_":
            j = i
            while j < n and (text[j].isalnum() or text[j] == "_"):
                j += 1
            k = j
            while k < n and text[k] in " \t":
                k += 1
            if k < n and text[k] == "(":
                start_line = line
                depth, p = 1, k + 1
                while p < n and depth:
                    ch = text[p]
                    if ch == "\n":
                        line += 1
                    elif ch == '"':
                        p += 1
                        while p < n and text[p] != '"':
                            if text[p] == "\\":
                                p += 1
                            elif text[p] == "\n":
                                line += 1
                            p += 1
                    elif ch == "[" and BRACKET_OPEN.match(text, p):
                        m = BRACKET_OPEN.match(text, p)
                        close = "]" + m.group(1) + "]"
                        q = text.find(close, m.end())
                        q = n if q < 0 else q + len(close) - 1
                        line += text.count("\n", p, q)
                        p = q
                    elif ch == "#":
                        q = text.find("\n", p)
                        p = n if q < 0 else q - 1
                    elif ch == "(":
                        depth += 1
                    elif ch == ")":
                        depth -= 1
                    p += 1
                yield text[i:j].lower(), text[k + 1 : p - 1], start_line
                i = p
                continue
            i = j
            continue
        i += 1


def first_arg(args):
    a = args.strip()
    if a.startswith('"'):
        return a[1:].split('"', 1)[0]
    return a.split(None, 1)[0] if a else ""


def norm(cond):
    return " ".join(cond.split())


def main():
    files = sorted(cmake_files(ROOT))
    fetches, finds_outside, finds_inside = [], collections.Counter(), collections.Counter()
    try_mode, providers, subdirs, includes = [], [], collections.defaultdict(set), collections.defaultdict(set)
    unresolved_subdirs = 0
    for path in files:
        rel = path.relative_to(ROOT)
        try:
            text = path.read_text(errors="replace")
        except OSError:
            continue
        stack = []  # entries: ("if", cond) | ("fn", name) | ("loop", "")
        for name, args, line in commands(text):
            if name == "if":
                stack.append(["if", norm(args)])
            elif name == "elseif" and stack and stack[-1][0] == "if":
                stack[-1][1] = norm(args)
            elif name == "else" and stack and stack[-1][0] == "if":
                stack[-1][1] = "else: " + stack[-1][1]
            elif name == "endif" and stack and stack[-1][0] == "if":
                stack.pop()
            elif name in ("function", "macro"):
                stack.append(["fn", first_arg(args)])
            elif name in ("endfunction", "endmacro") and stack and stack[-1][0] == "fn":
                stack.pop()
            elif name in ("foreach", "while"):
                stack.append(["loop", ""])
            elif name in ("endforeach", "endwhile") and stack and stack[-1][0] == "loop":
                stack.pop()
            elif name in FETCH:
                conds = [c for k, c in stack if k == "if"]
                fns = [c for k, c in stack if k == "fn"]
                fetches.append({
                    "file": str(rel), "line": line, "kind": name, "name": first_arg(args),
                    "conditions": conds, "in_function": fns[-1] if fns else None,
                    "in_loop": any(k == "loop" for k, _ in stack),
                    "find_package_args": bool(re.search(r"\bFIND_PACKAGE_ARGS\b", args)),
                    "not_target": any(re.search(r"\bNOT\s+TARGET\b", c) for c in conds),
                    "build_testing": any(re.search(r"\bBUILD_TESTING\b", c) for c in conds),
                    "test_dir": bool(TEST_DIRS & set(rel.parts[:-1])),
                    "current_set": in_current_set(rel),
                })
            elif name in FIND:
                (finds_inside if in_current_set(rel) else finds_outside)[name] += 1
            elif name == "set" and first_arg(args) == "FETCHCONTENT_TRY_FIND_PACKAGE_MODE":
                try_mode.append({"file": str(rel), "line": line, "args": norm(args)})
            elif name == "cmake_language" and "SET_DEPENDENCY_PROVIDER" in args:
                providers.append({"file": str(rel), "line": line, "args": norm(args)})
            elif name == "add_subdirectory":
                d = first_arg(args)
                if "$" in d or not d:
                    unresolved_subdirs += 1
                else:
                    subdirs[rel].add((rel.parent / d).as_posix())
            elif name == "include":
                f = first_arg(args)
                if f.endswith(".cmake") and "$" not in f:
                    includes[rel].add((rel.parent / f).as_posix())

    # Literal reachability from the root CMakeLists.txt.
    def norm_path(p):
        return os.path.normpath(p)
    reach, todo = set(), ["CMakeLists.txt"]
    while todo:
        f = norm_path(todo.pop())
        if f in reach:
            continue
        reach.add(f)
        r = pathlib.Path(f)
        for d in subdirs.get(r, ()):
            todo.append(os.path.join(d, "CMakeLists.txt"))
        for inc in includes.get(r, ()):
            todo.append(inc)
    for x in fetches:
        x["reachable_literal"] = norm_path(x["file"]) in reach

    by_name = collections.defaultdict(list)
    for x in fetches:
        if x["kind"] == "fetchcontent_declare":
            by_name[x["name"].lower()].append(x)
    multi = {k: sorted({v["file"] for v in vs}) for k, vs in by_name.items() if len({v["file"] for v in vs}) > 1}
    shadowed = 0
    for k, vs in by_name.items():
        dirs = [pathlib.PurePosixPath(v["file"]).parent for v in vs]
        for v, d in zip(vs, dirs):
            if any(o != d and (o == pathlib.PurePosixPath(".") or o in d.parents) for o in dirs):
                v["enclosing_same_name"] = True
                shadowed += 1

    def count(pred):
        return sum(1 for x in fetches if pred(x))

    summary = {
        "cmake_files": len(files),
        "cmake_files_in_current_set": sum(1 for f in files if in_current_set(f.relative_to(ROOT))),
        "cmake_files_reachable_literal": len(reach),
        "add_subdirectory_unresolved_variable": unresolved_subdirs,
        "fetch_calls": {k: count(lambda x, k=k: x["kind"] == k) for k in sorted(FETCH)},
        "fetch_in_current_set": count(lambda x: x["current_set"]),
        "fetch_reachable_literal": count(lambda x: x["reachable_literal"]),
        "fetch_in_function_or_macro": count(lambda x: x["in_function"]),
        "fetch_in_loop": count(lambda x: x["in_loop"]),
        "fetch_under_any_if": count(lambda x: x["conditions"]),
        "fetch_unconditional": count(lambda x: not x["conditions"]),
        "shape_find_package_args": count(lambda x: x["find_package_args"]),
        "shape_not_target": count(lambda x: x["not_target"]),
        "shape_build_testing": count(lambda x: x["build_testing"]),
        "fetch_in_test_dir": count(lambda x: x["test_dir"]),
        "fetchcontent_names_in_several_files": len(multi),
        "fetchcontent_shadowed_by_enclosing_same_name": shadowed,
        "try_find_package_mode_sets": try_mode,
        "dependency_providers": providers,
        "find_calls_outside_current_set": dict(finds_outside),
        "find_calls_in_current_set": dict(finds_inside),
        "functions_wrapping_fetches": dict(collections.Counter(x["in_function"] for x in fetches if x["in_function"]).most_common()),
        "top_conditions": dict(collections.Counter(c for x in fetches for c in x["conditions"]).most_common(25)),
        "names_in_several_files": dict(sorted(multi.items())),
    }
    OUT.write_text(json.dumps({"summary": summary, "fetches": fetches}, indent=1))
    print("## CMake fetch census\n")
    for k, v in summary.items():
        if k in ("names_in_several_files",):
            continue
        print(f"- **{k}**: `{json.dumps(v)[:600]}`")


if __name__ == "__main__":
    main()
