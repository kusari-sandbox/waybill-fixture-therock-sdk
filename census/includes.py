"""Census of CMake include() in a source tree (waybill #1605).

waybill's CMake reader reads every CMakeLists.txt and *.cmake file on its own,
each with an empty condition stack. This census measures what that misses:

  A. Every include() call: how its argument resolves.
       std-name    a path to a CMakeLists.txt or *.cmake file (read on its own)
       other-name  a path to a file under any other name (never read)
       module      a bare module name found as <name>.cmake in the tree
       builtin     a bare module name not found in the tree (CMake's own)
       variable    the path still holds ${...} after substituting
                   CMAKE_CURRENT_SOURCE_DIR / CMAKE_CURRENT_LIST_DIR
       missing     a literal path that does not exist
  B. Declarations in files reached only through other-name includes (never
     read today), following include() onward from those files.
  C. Declarations whose condition is lost: unconditional inside their own
     file, but the file is included (std-name or module) only from inside an
     if() block.
  D. Context: add_subdirectory() inside an if() block, and the declarations
     under that directory that are unconditional in their own file
     (approximate: every CMake file in the subtree is counted).

  E. Per package name: whether EVERY declaration of it is conditional once
     the condition of the include() / add_subdirectory() chain that reaches
     its file is counted ("effective"), and whether its own file's if()
     blocks alone already make it so ("in-file"). A file is conditionally
     reached when every include() or add_subdirectory() of it is inside an
     if() block, or sits in a file that is itself conditionally reached.
     Files nothing reaches (tree roots, or reached only through unresolved
     paths) count as unconditional.

  F. Each find_package name, classified (first match wins):
       first-party-project   a project(<name>) in the tree
       first-party-config    a <name>Config.cmake[.in] / <name>-config.cmake[.in]
                             in the tree (the tree installs it)
       project-find-module   a Find<name>.cmake in the tree
       cmake-find-module     a Find<name>.cmake in CMake's own Modules/
                             (directory given by $CMAKE_MODULES)
       other                 none of these: an external package found by
                             config file on the system

Declarations: FetchContent_Declare, ExternalProject_Add, CPMAddPackage,
find_package, pkg_check_modules, pkg_search_module, file(DOWNLOAD).

Reads files only; evaluates nothing. Usage: includes.py <root> <out.json>
"""
import collections
import json
import os
import pathlib
import re
import sys

ROOT = pathlib.Path(sys.argv[1]).resolve()
OUT = pathlib.Path(sys.argv[2])
FETCH = {"fetchcontent_declare", "externalproject_add", "cpmaddpackage"}
FIND = {"find_package", "pkg_check_modules", "pkg_search_module"}
BRACKET_OPEN = re.compile(r"\[(=*)\[")
VAR = re.compile(r"\$\{[^}]*\}")


def commands(text):
    """Yield (name_lower, args, line) for each command invocation.
    Copied from census/fetches.py."""
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


def is_std_name(p):
    return p.name == "CMakeLists.txt" or p.name.lower().endswith(".cmake")


def rel(p):
    try:
        return str(p.relative_to(ROOT))
    except ValueError:
        return str(p)


def kind(name, args):
    if name in FETCH:
        return "fetch"
    if name in FIND:
        return "find"
    if name == "file" and first_arg(args).upper() == "DOWNLOAD":
        return "download"
    return None


_parsed = {}


def parse(path):
    """Commands of one file with the condition stack each sits under.
    Returns {decls: [(kind, line, conds, in_body)], includes: [...],
    subdirs: [...]}."""
    if path in _parsed:
        return _parsed[path]
    try:
        text = path.read_text(errors="replace")
    except OSError:
        _parsed[path] = None
        return None
    conds, body = [], 0
    out = {"decls": [], "includes": [], "subdirs": []}
    for name, args, line in commands(text):
        if name == "if":
            conds.append(" ".join(args.split()))
        elif name in ("elseif", "else") and conds:
            conds[-1] = conds[-1] + " | " + name
        elif name == "endif" and conds:
            conds.pop()
        elif name in ("function", "macro"):
            body += 1
        elif name in ("endfunction", "endmacro") and body:
            body -= 1
        k = kind(name, args)
        if k:
            nm = first_arg(args)
            if name == "cpmaddpackage" and nm.upper() == "NAME":
                nm = (args.split() + ["", ""])[1].strip('"')
            out["decls"].append({"kind": k, "name": nm.lower(), "line": line, "conditional": bool(conds), "in_body": body > 0})
        elif name == "include":
            out["includes"].append({"arg": first_arg(args), "line": line, "conds": list(conds), "in_body": body > 0,
                                    "optional": "OPTIONAL" in args.split()})
        elif name == "add_subdirectory":
            out["subdirs"].append({"arg": first_arg(args), "line": line, "conds": list(conds), "in_body": body > 0})
    _parsed[path] = out
    return out


def main():
    cmake_files, by_stem = [], collections.defaultdict(list)
    for dirpath, dirnames, filenames in os.walk(ROOT):
        dirnames[:] = [d for d in dirnames if d != ".git"]
        for f in filenames:
            p = pathlib.Path(dirpath, f)
            if is_std_name(p):
                cmake_files.append(p)
            if f.lower().endswith(".cmake"):
                by_stem[f[: -len(".cmake")]].append(p)
    cmake_files.sort()

    def resolve(includer, arg):
        d = includer.parent
        s = arg.replace("${CMAKE_CURRENT_SOURCE_DIR}", str(d)).replace("${CMAKE_CURRENT_LIST_DIR}", str(d))
        if VAR.search(s):
            return "variable", None
        if "/" not in s and not s.lower().endswith(".cmake") and "." not in s:
            # a module name: the nearest <name>.cmake under an ancestor of
            # the includer (approximates CMAKE_MODULE_PATH)
            cands = [c for c in by_stem.get(s, []) if any(a in c.parents for a in [includer.parent, *includer.parents])]
            if cands:
                cands.sort(key=lambda c: -len(os.path.commonpath([c, includer]).split(os.sep)))
                return "module", cands[0]
            return "builtin", None
        p = pathlib.Path(s) if pathlib.Path(s).is_absolute() else d / s
        p = pathlib.Path(os.path.normpath(p))
        if not p.is_file():
            return "missing", None
        return ("std-name" if is_std_name(p) else "other-name"), p

    classes = collections.Counter()
    sites = []  # every include() with its resolution
    included_from = collections.defaultdict(list)  # target -> [(includer, conds, cls)]
    queue, seen = list(cmake_files), set(cmake_files)
    while queue:
        f = queue.pop()
        info = parse(f)
        if not info:
            continue
        for inc in info["includes"]:
            cls, target = resolve(f, inc["arg"])
            classes[cls] += 1
            sites.append({"file": rel(f), "line": inc["line"], "arg": inc["arg"], "class": cls,
                          "target": rel(target) if target else None, "conditional": bool(inc["conds"]),
                          "conds": inc["conds"], "in_body": inc["in_body"], "optional": inc["optional"]})
            if target:
                included_from[target].append((f, inc["conds"], cls))
                if target not in seen:  # follow other-name files onward
                    seen.add(target)
                    queue.append(target)

    # B. never-read files: reached only through other-name includes
    never_read = sorted(t for t in included_from if not is_std_name(t))
    b_rows, b_counts = [], collections.Counter()
    for t in never_read:
        info = parse(t) or {"decls": []}
        c = collections.Counter(d["kind"] for d in info["decls"])
        b_counts.update(c)
        b_rows.append({"file": rel(t), "decls": dict(c),
                       "included_from": [{"file": rel(f), "conds": conds} for f, conds, _ in included_from[t]]})

    # C. std-name / module targets included only from inside if() blocks
    c_rows, c_counts = [], collections.Counter()
    for t, froms in included_from.items():
        if not is_std_name(t):
            continue
        if not all(conds for _, conds, _ in froms):
            continue
        info = parse(t) or {"decls": []}
        lost = [d for d in info["decls"] if not d["conditional"] and not d["in_body"]]
        if lost:
            c = collections.Counter(d["kind"] for d in lost)
            c_counts.update(c)
            c_rows.append({"file": rel(t), "lost": dict(c),
                           "included_from": [{"file": rel(f), "conds": conds} for f, conds, _ in froms]})

    # D. context: conditional add_subdirectory and what lies beneath
    d_rows, d_counts, d_dirs = [], collections.Counter(), set()
    for f in cmake_files:
        info = parse(f)
        if not info:
            continue
        for sd in info["subdirs"]:
            if not sd["conds"] or VAR.search(sd["arg"]):
                continue
            d = pathlib.Path(os.path.normpath(f.parent / sd["arg"]))
            if not d.is_dir() or d in d_dirs:
                continue
            d_dirs.add(d)
            c = collections.Counter()
            for g in cmake_files:
                if d in g.parents:
                    gi = parse(g)
                    if gi:
                        c.update(x["kind"] for x in gi["decls"] if not x["conditional"] and not x["in_body"])
            if c:
                d_counts.update(c)
                d_rows.append({"from": rel(f), "line": sd["line"], "dir": rel(d), "conds": sd["conds"], "decls": dict(c)})

    # F. classify find_package names
    projects, configs, find_modules = set(), set(), set()
    cfg_re = re.compile(r"^(.+?)(?:-config|Config)\.cmake(?:\.in)?$")
    for dirpath, dirnames, filenames in os.walk(ROOT):
        dirnames[:] = [d for d in dirnames if d != ".git"]
        for fn in filenames:
            m = cfg_re.match(fn)
            if m:
                configs.add(m.group(1).lower())
            if fn.startswith("Find") and fn.endswith(".cmake"):
                find_modules.add(fn[4:-6].lower())
    for f in cmake_files:
        try:
            text = f.read_text(errors="replace")
        except OSError:
            continue
        for name, args, _ in commands(text):
            if name == "project":
                nm = first_arg(args)
                if nm and "${" not in nm:
                    projects.add(nm.lower())
    cmake_mod_dir = pathlib.Path(os.environ.get("CMAKE_MODULES", "/nonexistent"))
    cmake_find = {fn[4:-6].lower() for fn in os.listdir(cmake_mod_dir) if fn.startswith("Find") and fn.endswith(".cmake")} if cmake_mod_dir.is_dir() else set()

    def find_class(nm):
        if nm in projects:
            return "first-party-project"
        if nm in configs:
            return "first-party-config"
        if nm in find_modules:
            return "project-find-module"
        if nm in cmake_find:
            return "cmake-find-module"
        return "other"

    # E. effective conditionality per package name
    reached_by = collections.defaultdict(list)  # file -> [(parent, conditional_site)]
    for t, froms in included_from.items():
        for f, conds, _ in froms:
            reached_by[t].append((f, bool(conds)))
    for f in cmake_files:
        info = parse(f)
        if not info:
            continue
        for sd in info["subdirs"]:
            if VAR.search(sd["arg"]):
                continue
            d = pathlib.Path(os.path.normpath(f.parent / sd["arg"]))
            target = d / "CMakeLists.txt"
            if target.is_file():
                reached_by[target].append((f, bool(sd["conds"])))
    memo = {}

    def cond_reached(f, stack=()):
        if f in memo:
            return memo[f]
        if f in stack:
            return False
        edges = reached_by.get(f, [])
        r = bool(edges) and all(c or cond_reached(p, stack + (f,)) for p, c in edges)
        memo[f] = r
        return r

    per_name = collections.defaultdict(lambda: {"decls": 0, "in_file": 0, "effective": 0, "in_body": 0, "files": set()})
    for f in cmake_files + never_read:
        info = parse(f)
        if not info:
            continue
        reached = cond_reached(f)
        for d in info["decls"]:
            if d["kind"] not in ("find", "fetch") or not d["name"] or "${" in d["name"]:
                continue
            e = per_name[(d["kind"], d["name"])]
            e["decls"] += 1
            e["files"].add(rel(f))
            if d["in_body"]:
                e["in_body"] += 1
            if d["conditional"]:
                e["in_file"] += 1
            if d["conditional"] or reached:
                e["effective"] += 1
    e_rows = []
    for (k, nm), e in sorted(per_name.items()):
        e_rows.append({"kind": k, "name": nm, "class": find_class(nm) if k == "find" else None, "decls": e["decls"], "in_file_conditional": e["in_file"],
                       "effective_conditional": e["effective"], "in_body": e["in_body"],
                       "only_conditional_in_file": e["in_file"] == e["decls"],
                       "only_conditional_effective": e["effective"] == e["decls"], "files": sorted(e["files"])[:20]})
    e_summary = collections.Counter()
    for r in e_rows:
        e_summary[(r["kind"], "names")] += 1
        if r["only_conditional_in_file"]:
            e_summary[(r["kind"], "only-conditional, in-file alone")] += 1
        if r["only_conditional_effective"]:
            e_summary[(r["kind"], "only-conditional, effective")] += 1

    result = {
        "root": str(ROOT),
        "cmake_files": len(cmake_files),
        "include_calls": dict(classes),
        "include_calls_conditional": sum(1 for s in sites if s["conditional"]),
        "A_sites": sites,
        "B_never_read": {"files": len(never_read), "decls": dict(b_counts), "rows": b_rows},
        "C_condition_lost": {"files": len(c_rows), "decls": dict(c_counts), "rows": c_rows},
        "D_conditional_subdirs": {"dirs": len(d_rows), "decls": dict(d_counts), "rows": d_rows},
        "E_per_name": {"summary": {f"{k}: {v}": n for (k, v), n in sorted(e_summary.items())}, "rows": e_rows},
    }
    OUT.write_text(json.dumps(result, indent=1, sort_keys=True))

    p = print
    p("## include() census (waybill #1605)\n")
    p(f"CMake files read on their own: {len(cmake_files)}\n")
    p("| include() resolves to | calls |\n|---|---|")
    for k in ("std-name", "other-name", "module", "builtin", "variable", "missing"):
        p(f"| {k} | {classes.get(k, 0)} |")
    p(f"\ninclude() calls inside an if() block: {result['include_calls_conditional']}\n")
    p(f"### B. Never read: {len(never_read)} files reached only by other-name include()\n")
    p(f"Declarations in them: {dict(b_counts)}\n")
    for r in b_rows:
        if r["decls"]:
            p(f"- `{r['file']}` {r['decls']} from " + "; ".join(f"`{x['file']}`" + (f" if {x['conds']}" if x["conds"] else "") for x in r["included_from"]))
    p(f"\n### C. Condition lost: {len(c_rows)} files included only under if()\n")
    p(f"Unconditional declarations in them: {dict(c_counts)}\n")
    for r in sorted(c_rows, key=lambda r: -sum(r["lost"].values()))[:40]:
        p(f"- `{r['file']}` {r['lost']} from " + "; ".join(f"`{x['file']}` if {x['conds']}" for x in r["included_from"][:3]))
    p("\n### E. Package names declared only under conditions\n")
    p("| kind | names | only conditional, in-file alone | only conditional, effective |\n|---|---|---|---|")
    for k in ("find", "fetch"):
        p(f"| {k} | {e_summary[(k, 'names')]} | {e_summary[(k, 'only-conditional, in-file alone')]} | {e_summary[(k, 'only-conditional, effective')]} |")
    p(f"\n### F. find_package names by class (CMake modules: {len(cmake_find)} Find*.cmake in {cmake_mod_dir})\n")
    p("| class | names | only conditional, effective | examples |\n|---|---|---|---|")
    by_cls = collections.defaultdict(list)
    for r in e_rows:
        if r["kind"] == "find":
            by_cls[r["class"]].append(r)
    for c in ("first-party-project", "first-party-config", "project-find-module", "cmake-find-module", "other"):
        rs = sorted(by_cls.get(c, []), key=lambda r: -r["decls"])
        p(f"| {c} | {len(rs)} | {sum(r['only_conditional_effective'] for r in rs)} | {', '.join(r['name'] for r in rs[:14])} |")
    p(f"\n### D. Context: {len(d_rows)} conditional add_subdirectory() with declarations beneath\n")
    p(f"Unconditional declarations beneath them (approximate): {dict(d_counts)}\n")
    for r in sorted(d_rows, key=lambda r: -sum(r["decls"].values()))[:25]:
        p(f"- `{r['dir']}` {r['decls']} if {r['conds']} (from `{r['from']}`:{r['line']})")


main()
