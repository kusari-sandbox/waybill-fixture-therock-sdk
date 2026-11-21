"""Census of CMake fetches whose URL, GIT_REPOSITORY or GIT_TAG stays unresolved
(waybill spec 1638, #1595, task T001).

For every CMakeLists.txt and *.cmake file under <root> (skipping .git), each
FetchContent_Declare / ExternalProject_Add call is expanded with the same
file's single-literal set() values. A call whose URL, GIT_REPOSITORY or
GIT_TAG still holds `${`, and that names a URL or a GIT_REPOSITORY + GIT_TAG,
is counted, split into:
  * github-repo   literal GitHub GIT_REPOSITORY, unresolved GIT_TAG
  * other-repo    literal non-GitHub GIT_REPOSITORY, unresolved GIT_TAG
  * unresolved-repo  GIT_REPOSITORY itself unresolved
  * url           a URL fetch (no GIT_REPOSITORY + GIT_TAG pair)
  * other         anything else unresolved (e.g. literal tag, unresolved URL)
and, separately, the subset whose declared name is itself unexpanded.

A call inside a function()/macro() body whose name is one of the body's
parameters (or ARGV/ARGN) is a wrapper template (waybill spec 1539), not a
declaration; it is reported on its own line, never in the split.

With [scan.cdx.json], each counted declaration is reconciled against waybill's
own output, declaration by declaration (spec 1638 research R7):
  found       its file is in waybill:source-files of a component whose
              waybill:unresolved-reason is the CMake reason
  accounted   unexpanded name (C231 unresolved.identity), or its file is in
              some component's waybill:superseded-declarations (C233)
  unexplained neither

A measuring script, not a model of waybill's reader. Reads files only.
Usage: unresolved_fetches.py <root> <out.json> [scan.cdx.json]
"""
import collections
import json
import os
import pathlib
import re
import sys

ROOT = pathlib.Path(sys.argv[1]).resolve()
OUT = pathlib.Path(sys.argv[2])
SCAN = pathlib.Path(sys.argv[3]) if len(sys.argv) > 3 else None
FETCH = {"fetchcontent_declare", "externalproject_add"}
CMAKE_REASON = "URL or GIT_TAG uses a CMake variable with no literal set() in the same file"
GITHUB = re.compile(r"^https?://github\.com/([^/]+)/([^/\.\s]+)")
SET = re.compile(r'(?im)^\s*set\s*\(\s*([A-Za-z_][A-Za-z0-9_.+-]*)\s+(?:"([^"\n]*)"|([^\s()"]+))\s*\)')
REF = re.compile(r"\$\{([A-Za-z_][A-Za-z0-9_.+-]*)\}")
BRACKET_OPEN = re.compile(r"\[(=*)\[")


def cmake_files(root):
    for dirpath, dirnames, filenames in os.walk(root):
        dirnames[:] = [d for d in dirnames if d != ".git"]
        for f in filenames:
            if f == "CMakeLists.txt" or f.lower().endswith(".cmake"):
                yield pathlib.Path(dirpath, f)


def commands(text):
    """Yield (name_lower, args, line) for each command invocation (as census/fetches.py)."""
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


def set_vars(text):
    out = {}
    for m in SET.finditer(text):
        name = m.group(1)
        value = m.group(2) if m.group(2) is not None else m.group(3)
        if name in out and out[name] != value:
            out[name] = None
        else:
            out.setdefault(name, value)
    return out


def expand(s, vars_):
    for _ in range(8):
        nxt = REF.sub(lambda m: vars_[m.group(1)] if vars_.get(m.group(1)) is not None else m.group(0), s)
        if nxt == s:
            break
        s = nxt
    return s


def keyword(body, kw):
    m = re.search(r"\b%s\s+(\S+)" % re.escape(kw), body)
    return m.group(1).strip('"') if m else None


def first_arg(args):
    a = args.strip()
    if a.startswith('"'):
        return a[1:].split('"', 1)[0]
    return a.split(None, 1)[0] if a else ""


def classify(repo, tag, url):
    if repo is not None and tag is not None:
        if "${" in repo:
            return "unresolved-repo"
        if "${" in tag and (url is None or "${" not in url):
            return "github-repo" if GITHUB.match(repo) else "other-repo"
        return "other"
    return "url"


def main():
    decls, templates = [], []
    for path in sorted(cmake_files(ROOT)):
        try:
            text = path.read_text(errors="replace")
        except OSError:
            continue
        rel = path.relative_to(ROOT).as_posix()
        vars_ = set_vars(text)
        params = []  # stack of parameter-name sets of open function()/macro() bodies
        for name, args, line in commands(text):
            if name in ("function", "macro"):
                ps = args.split()[1:]
                params.append(set(ps) | {"ARGV", "ARGN", "ARGV0", "ARGV1", "ARGV2"})
                continue
            if name in ("endfunction", "endmacro"):
                if params:
                    params.pop()
                continue
            if name not in FETCH:
                continue
            raw_name = first_arg(args)
            body = expand(" ".join(args.split()[1:]), vars_)
            repo, tag, url = keyword(body, "GIT_REPOSITORY"), keyword(body, "GIT_TAG"), keyword(body, "URL")
            unresolved = any(v is not None and "${" in v for v in (repo, tag, url))
            if not unresolved or not (url is not None or (repo is not None and tag is not None)):
                continue
            row = {
                "file": rel,
                "line": line,
                "rule": name,
                "name": raw_name,
                "category": classify(repo, tag, url),
                "name_unexpanded": "${" in expand(raw_name, vars_) or "$<" in raw_name,
                "repository": repo,
                "tag": tag,
                "url": url,
            }
            if params and any(("${%s}" % p) in raw_name for p in params[-1]):
                templates.append(row)
            else:
                decls.append(row)

    split = collections.Counter(d["category"] for d in decls)
    unexpanded = collections.Counter(d["category"] for d in decls if d["name_unexpanded"])
    result = {
        "root": str(ROOT),
        "declarations": len(decls),
        "split": dict(sorted(split.items())),
        "name_unexpanded": dict(sorted(unexpanded.items())),
        "wrapper_templates": len(templates),
        "wrapper_template_split": dict(sorted(collections.Counter(t["category"] for t in templates).items())),
        "literal_repository_cases": [d for d in decls if d["category"] in ("github-repo", "other-repo")],
        "wrapper_template_cases": templates,
    }

    if SCAN is not None:
        doc = json.loads(SCAN.read_text())
        stack, comps = list(doc.get("components", [])), []
        while stack:
            c = stack.pop()
            comps.append(c)
            stack.extend(c.get("components", []))

        def prop(c, n):
            return next((p["value"] for p in c.get("properties", []) if p["name"] == n), None)

        def jlist(v):
            try:
                x = json.loads(v) if v else []
            except ValueError:
                return []
            return x if isinstance(x, list) else []

        found, superseded_files = {}, set()
        cmake_c151 = 0
        for c in comps:
            if prop(c, "waybill:unresolved-reason") == CMAKE_REASON:
                cmake_c151 += 1
                for f in jlist(prop(c, "waybill:source-files")):
                    found[(c.get("name", "").lower(), f)] = c.get("bom-ref") or c.get("purl")
            for s in jlist(prop(c, "waybill:superseded-declarations")):
                if isinstance(s, dict) and s.get("file"):
                    superseded_files.add(s["file"])
        cov = next((json.loads(p["value"]) for p in doc.get("metadata", {}).get("properties", [])
                    if p["name"] == "waybill:cmake-fetch-coverage"), None)
        verdicts = collections.Counter()
        unexplained = []
        matched = set()
        for d in decls:
            key = (expand(d["name"], set_vars((ROOT / d["file"]).read_text(errors="replace"))).lower(), d["file"])
            if d["name_unexpanded"]:
                v = "accounted"
            elif key in found:
                v = "found"
                matched.add(key)
            elif d["file"] in superseded_files:
                v = "accounted"
            else:
                v = "unexplained"
                unexplained.append(d)
            verdicts[v] += 1
            d["verdict"] = v
        result["reconcile"] = {
            "components_with_cmake_c151": cmake_c151,
            "verdicts": dict(sorted(verdicts.items())),
            "unexplained": unexplained,
            "c151_components_matching_no_declaration": sorted(found[k] for k in set(found) - matched),
            "cmake_fetch_coverage": cov,
        }

    OUT.write_text(json.dumps(result, indent=2, sort_keys=True))
    print(f"## Unresolved CMake fetches: `{ROOT.name}`\n")
    print(f"- declarations taking the unresolved branch: **{len(decls)}**")
    print(f"- split: `{json.dumps(result['split'])}`")
    print(f"- of which the declared name is unexpanded: `{json.dumps(result['name_unexpanded'])}`")
    print(f"- wrapper templates (not declarations): {len(templates)} `{json.dumps(result['wrapper_template_split'])}`")
    for d in result["literal_repository_cases"]:
        print(f"  - {d['category']} `{d['file']}:{d['line']}` {d['rule']}({d['name']}) repo=`{d['repository']}` tag=`{d['tag']}`")
    for t in templates:
        print(f"  - template {t['category']} `{t['file']}:{t['line']}` {t['rule']}({t['name']}) repo=`{t['repository']}` tag=`{t['tag']}`")
    if "reconcile" in result:
        r = result["reconcile"]
        print(f"- reconcile against main: verdicts `{json.dumps(r['verdicts'])}`, components with the CMake C151 reason: {r['components_with_cmake_c151']}")
        print(f"- C231: `{json.dumps(r['cmake_fetch_coverage'])}`")
        print(f"- CMake C151 components matching no counted declaration (expected: wrapper call sites): {len(r['c151_components_matching_no_declaration'])}")
        for ref in r["c151_components_matching_no_declaration"]:
            print(f"  - `{ref}`")
        for d in r["unexplained"]:
            print(f"  - unexplained `{d['file']}:{d['line']}` {d['rule']}({d['name']}) {d['category']}")


main()
