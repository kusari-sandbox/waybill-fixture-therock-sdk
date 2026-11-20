"""Census of CMake project() declarations (waybill #1616, spec 1618 T001).

Usage: python3 -I -B projects.py <tree> <out.json> [seed]

For every literal project(<name> ...) in a CMakeLists.txt below <tree>:

  (a) directory, name, VERSION form (literal / ${} / none) and whether a
      literal set() in the same file resolves a ${} version;
  (b) which names the tree's package searches (find_package,
      pkg_check_modules, pkg_search_module) ask for have a declaration;
  (c) how many project directories each candidate test / example /
      benchmark directory name catches;
  (d) per project, which candidate vendored signals hold;
  (e) names declared in more than one directory, and their versions;
  (f) names that equal a fetch's declared name, an installed
      <name>ConfigVersion.cmake / <name>-config-version.cmake stem, or a
      git submodule directory's basename.

It also draws a seeded random sample of projects for hand-labelling
(vendored or first-party) with the evidence a label is made from: the
licence file's copyright lines and the README's first heading.

A measuring script, not a model of waybill's reader. The "reached" signal
follows literal add_subdirectory() from the root CMakeLists.txt only, an
approximation of waybill's reach (which also follows include()); it is
labelled as such in the output.
"""

import collections
import json
import os
import pathlib
import random
import re
import subprocess
import sys

ROOT = pathlib.Path(sys.argv[1]).resolve()
OUT = pathlib.Path(sys.argv[2])
SEED = int(sys.argv[3]) if len(sys.argv) > 3 else 1618

FETCH = {"fetchcontent_declare", "externalproject_add", "cpmaddpackage"}
FIND = {"find_package", "pkg_check_modules", "pkg_search_module"}
BRACKET_OPEN = re.compile(r"\[(=*)\[")
TEST_DIRS = {"test", "tests", "unittests"}
EXAMPLE_DIRS = {"example", "examples", "sample", "samples", "benchmark", "benchmarks", "bench"}
VENDOR_SEGMENTS = {"third_party", "third-party", "thirdparty", "3rdparty", "external", "extern", "vendor", "deps"}
LICENCE = re.compile(r"^(licen[cs]e|copying|notice)(\.[a-z0-9]+)?$", re.I)
CONFIG_VERSION = re.compile(r"^(.+?)(?:ConfigVersion|-config-version)\.cmake$")


def commands(text):
    """Yield (name_lower, args, line) for each command invocation.
    Copied from census/includes.py."""
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


def tokens(args):
    out, cur, q = [], "", False
    for ch in args:
        if ch == '"':
            q = not q
            continue
        if ch.isspace() and not q:
            if cur:
                out.append(cur)
            cur = ""
            continue
        cur += ch
    if cur:
        out.append(cur)
    return out


def rel(p):
    try:
        return str(p.relative_to(ROOT)) or "."
    except ValueError:
        return str(p)


def submodule_dirs():
    try:
        r = subprocess.run(["git", "-C", str(ROOT), "submodule", "status", "--recursive"],
                           capture_output=True, text=True, timeout=120)
    except (OSError, subprocess.TimeoutExpired):
        return set()
    dirs = set()
    for line in r.stdout.splitlines():
        parts = line[1:].split()
        if len(parts) >= 2:
            dirs.add(parts[1])
    return dirs


def licence_evidence(d):
    for f in sorted(d.iterdir()) if d.is_dir() else []:
        if f.is_file() and LICENCE.match(f.name):
            try:
                text = f.read_text(errors="replace")
            except OSError:
                return f.name, []
            cr = [l.strip() for l in text.splitlines() if re.search(r"copyright", l, re.I)][:3]
            return f.name, cr
    return None, []


def readme_heading(d):
    for name in ("README.md", "README.rst", "README.txt", "README"):
        f = d / name
        if f.is_file():
            try:
                for l in f.read_text(errors="replace").splitlines():
                    s = l.strip().lstrip("#").strip()
                    if s:
                        return f"{name}: {s[:120]}"
            except OSError:
                return None
    return None


def main():
    lists, decls, searches, fetch_names, cfg_versions = [], [], collections.Counter(), set(), set()
    subdir_edges = collections.defaultdict(set)
    for dirpath, dirnames, filenames in os.walk(ROOT):
        dirnames[:] = [d for d in dirnames if d != ".git"]
        for fn in filenames:
            m = CONFIG_VERSION.match(fn)
            if m:
                cfg_versions.add(m.group(1).lower())
            if fn == "CMakeLists.txt" or fn.lower().endswith(".cmake"):
                lists.append(pathlib.Path(dirpath) / fn)
    for f in lists:
        try:
            text = f.read_text(errors="replace")
        except OSError:
            continue
        sets = {}
        for name, args, line in commands(text):
            t = tokens(args)
            if name == "set" and len(t) >= 2 and "${" not in t[1]:
                sets[t[0]] = t[1]
            elif name in FIND and t and "${" not in t[0]:
                searches[t[0].lower()] += 1
            elif name in FETCH and t:
                nm = t[1] if name == "cpmaddpackage" and t[0].upper() == "NAME" and len(t) > 1 else t[0]
                if "${" not in nm:
                    fetch_names.add(nm.lower())
            elif name == "add_subdirectory" and t and "${" not in t[0]:
                subdir_edges[f.parent.resolve()].add((f.parent / t[0]).resolve())
            elif name == "project" and f.name == "CMakeLists.txt":
                if not t or "${" in t[0]:
                    continue
                version, form, resolved = None, "none", None
                if "VERSION" in t:
                    i = t.index("VERSION")
                    v = t[i + 1] if i + 1 < len(t) else ""
                    if v.startswith("${") and v.endswith("}") and v.count("${") == 1:
                        form = "variable"
                        resolved = sets.get(v[2:-1])
                        version = resolved
                    elif "${" in v:
                        form = "expression"
                    else:
                        form, version = "literal", v
                decls.append({"name": t[0].lower(), "dir": rel(f.parent), "line": line,
                              "version": version, "form": form, "resolved_by_set": resolved is not None})

    # reach: literal add_subdirectory from the root CMakeLists.txt only (approximation)
    reached = set()
    if (ROOT / "CMakeLists.txt").is_file():
        stack = [ROOT]
        while stack:
            d = stack.pop()
            if d in reached:
                continue
            reached.add(d)
            stack.extend(subdir_edges.get(d, ()))
    subs = submodule_dirs()

    projects = []
    for d in decls:
        parts = [] if d["dir"] == "." else d["dir"].split("/")
        lower = [p.lower() for p in parts]
        signals = []
        if any(p in VENDOR_SEGMENTS for p in lower):
            signals.append("path-segment")
        if any(d["dir"] == s or d["dir"].startswith(s + "/") for s in subs):
            signals.append("submodule-boundary")
        lic, cr = licence_evidence(ROOT / d["dir"])
        if lic:
            signals.append("licence-file")
        if (ROOT / "CMakeLists.txt").is_file() and (ROOT / d["dir"]).resolve() not in reached:
            signals.append("not-reached")
        projects.append({**d, "signals": signals, "test_dir": [p for p in lower if p in TEST_DIRS],
                         "example_dir": [p for p in lower if p in EXAMPLE_DIRS],
                         "licence": lic, "copyright": cr, "readme": readme_heading(ROOT / d["dir"])})

    names = collections.defaultdict(list)
    for p in projects:
        names[p["name"]].append((p["dir"], p["version"]))
    dup = {n: v for n, v in names.items() if len({d for d, _ in v}) > 1}
    searched_with_project = sorted(n for n in searches if n in names)
    sub_basenames = {s.rsplit("/", 1)[-1].lower() for s in subs}
    collisions = {
        "fetch": sorted(n for n in names if n in fetch_names),
        "installed-config-version": sorted(n for n in names if n in cfg_versions),
        "submodule-basename": sorted(n for n in names if n in sub_basenames),
    }
    dir_catch = collections.Counter()
    for p in projects:
        for seg in set(p["test_dir"] + p["example_dir"]):
            dir_catch[seg] += 1
    signal_counts = collections.Counter(s for p in projects for s in p["signals"])

    rng = random.Random(SEED)
    sample = rng.sample(projects, min(len(projects), 40))

    out = {"root": str(ROOT), "seed": SEED, "declarations": len(projects), "distinct_names": len(names),
           "forms": dict(collections.Counter(p["form"] for p in projects)),
           "variable_resolved_by_set": sum(1 for p in projects if p["form"] == "variable" and p["resolved_by_set"]),
           "searched_names": len(searches), "searched_with_project": searched_with_project,
           "duplicates": dup, "collisions": collisions, "dir_catch": dict(dir_catch),
           "signal_counts": dict(signal_counts), "reach_note": "add_subdirectory only (approximation)",
           "submodules": len(subs), "projects": projects, "sample": sample}
    OUT.write_text(json.dumps(out, indent=1, sort_keys=True))

    print(f"## project() census: {ROOT.name}\n")
    print(f"- declarations: {len(projects)} ({len(names)} distinct names); forms: {out['forms']}; "
          f"variable versions resolved by a same-file set(): {out['variable_resolved_by_set']}")
    print(f"- searched names: {len(searches)}; with a project declaration: {len(searched_with_project)}")
    print(f"- names in more than one directory: {len(dup)}")
    print(f"- collisions: " + ", ".join(f"{k} {len(v)}" for k, v in collisions.items()))
    print(f"- directory names caught: {dict(sorted(dir_catch.items()))}")
    print(f"- vendored signals: {dict(sorted(signal_counts.items()))}; submodules: {len(subs)}")
    print(f"- sample for labelling: {len(sample)} (seed {SEED})")


main()
