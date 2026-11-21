"""Census of waybill's catch-all CMake conditionals (waybill #1639, spec 1641
T007).

Reads the `waybill::cmake_conditions` debug events a log-only waybill build
writes for every fetch or package search whose only reason for being
optional is an enclosing condition (spec 1538's `cmake-conditional`), and
tallies them. It counts what the binary reports; it does not model the
reader.

usage: conditions.py TARGET SCAN_LOG OUT_JSON

Each event: kind (fetch | search), subject (PURL or search name), versioned,
category (platform | superbuild | option-on | option-off | literal |
unknown | compound), eval (holds | does-not-hold | unknown | platform), and
conditions (C232/C236's strings, as JSON).
"""

import collections
import json
import re
import sys

ANSI = re.compile(r"\x1b\[[0-9;]*m")
FIELD = re.compile(r'(\w+)=(?:"((?:[^"\\]|\\.)*)"|(\S+))')


def events(log_path):
    out = []
    with open(log_path, encoding="utf-8", errors="replace") as f:
        for line in f:
            line = ANSI.sub("", line)
            if "waybill::cmake_conditions" not in line:
                continue
            fields = {k: (q if q else b) for k, q, b in FIELD.findall(line)}
            if "kind" in fields and "eval" in fields:
                out.append(fields)
    return out


def main():
    target, log_path, out_path = sys.argv[1:4]
    evs = events(log_path)
    in_scope = lambda e: e["eval"] != "does-not-hold"

    table = collections.Counter((e["kind"], e["category"], e["eval"]) for e in evs)
    fetches = [e for e in evs if e["kind"] == "fetch"]
    searches = [e for e in evs if e["kind"] == "search"]
    fetch_change = [e for e in fetches if in_scope(e)]
    # A search name is Optional today when it has a conditional search and no
    # unconditional one; it changes when some conditional search's chain is
    # not does-not-hold. Unconditional searches emit no event, so this is an
    # upper bound on the names that change.
    search_names = collections.defaultdict(list)
    for e in searches:
        search_names[e["subject"].lower()].append(e)
    names_possibly_change = sorted(n for n, es in search_names.items() if any(in_scope(e) for e in es))
    examples = collections.defaultdict(collections.Counter)
    for e in evs:
        examples[e["category"]][e.get("conditions", "")] += 1

    result = {
        "target": target,
        "events": len(evs),
        "by_kind_category_eval": [
            {"kind": k, "category": c, "eval": v, "count": n} for (k, c, v), n in sorted(table.items())
        ],
        "fetches": len(fetches),
        "fetches_versioned": sum(1 for e in fetches if e.get("versioned") == "true"),
        "fetches_change_scope": len(fetch_change),
        "fetches_change_scope_versioned": sum(1 for e in fetch_change if e.get("versioned") == "true"),
        "fetches_change_scope_unknown_only": sum(1 for e in fetch_change if e["eval"] == "unknown"),
        "fetch_subjects_change_scope": sorted({e["subject"] for e in fetch_change}),
        "searches": len(searches),
        "search_names": len(search_names),
        "search_names_possibly_change": names_possibly_change,
        "top_conditions_by_category": {
            c: [{"conditions": k, "count": n} for k, n in cnt.most_common(15)] for c, cnt in sorted(examples.items())
        },
    }
    with open(out_path, "w", encoding="utf-8") as f:
        json.dump(result, f, indent=2, sort_keys=True)
        f.write("\n")

    print(f"## {target}\n")
    print(f"- events: {len(evs)} (fetches {len(fetches)}, searches {len(searches)})")
    print(f"- fetches that change scope: {len(fetch_change)} ({result['fetches_change_scope_versioned']} versioned; "
          f"{result['fetches_change_scope_unknown_only']} through unknown)")
    print(f"- search names: {len(search_names)}; possibly change: {len(names_possibly_change)}\n")
    print("| kind | category | eval | count |\n|---|---|---|---|")
    for r in result["by_kind_category_eval"]:
        print(f"| {r['kind']} | {r['category']} | {r['eval']} | {r['count']} |")
    print()


if __name__ == "__main__":
    main()
