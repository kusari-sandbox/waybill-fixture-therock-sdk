"""Census of waybill's requirements ownership and root-anchor immunity
(waybill #1640, spec 1642 T005).

Reads the `waybill::owner_census` debug events a log-only waybill build
writes, and tallies them. It counts what the binary reports; it does not
recompute ownership (that would be a second model of waybill's owner rule).

usage: owners.py TARGET SCAN_LOG OUT_JSON

Events (each `event="<name>" payload=<json>`):
- merge_source: a pip main module merged into an existing same-PURL entry
  (purl, tier, source_path, manifest_source_path, editable, agrees);
- owner_candidates: a directory with more than one candidate at the best
  rank (dir, candidates [{purl, rank, non_runtime, first_path}], step, owner);
- dev_only_main_module: a main module with a non-runtime scope
  (purl, derivation, first_path, is_root, added_seed);
- anchor_seed: a root anchor that may protect what it anchors (purl, kind);
- anchor_immunity: a component only the anchor seeds keep runtime
  (purl, ecosystem, scope_without).
"""

import collections
import json
import re
import sys

ANSI = re.compile(r"\x1b\[[0-9;]*m")
EVENT = re.compile(r'event="(\w+)" payload=(\{.*\})\s*$')
LOCKFILES = {"uv.lock", "poetry.lock", "Pipfile.lock"}


def events(log_path):
    out = collections.defaultdict(list)
    seen = set()
    with open(log_path, encoding="utf-8", errors="replace") as f:
        for line in f:
            line = ANSI.sub("", line)
            if "waybill::owner_census" not in line:
                continue
            m = EVENT.search(line)
            if not m:
                continue
            key = (m.group(1), m.group(2))
            # The owner index is built more than once per scan; count each
            # distinct event once.
            if key in seen:
                continue
            seen.add(key)
            out[m.group(1)].append(json.loads(m.group(2)))
    return out


def base(p):
    return (p or "").replace("\\", "/").rsplit("/", 1)[-1]


def main():
    target, log_path, out_path = sys.argv[1:4]
    ev = events(log_path)
    merges = ev["merge_source"]
    owners = ev["owner_candidates"]
    dev = ev["dev_only_main_module"]
    seeds = ev["anchor_seed"]
    immune = ev["anchor_immunity"]

    lockfile_first = sorted({c["purl"] for o in owners for c in o["candidates"] if base(c["first_path"]) in LOCKFILES})
    result = {
        "target": target,
        "merge_source": {
            "total": len(merges),
            "by_tier": dict(collections.Counter(str(m["tier"]) for m in merges)),
            "lockfile_merges_reordered_by_r2": sum(1 for m in merges if m["tier"] != "deployed"),
            "installed_merges_left_alone": sorted(m["purl"] for m in merges if m["tier"] == "deployed"),
            "editable_disagreements": sorted(m["purl"] for m in merges if m["editable"] and not m["agrees"]),
        },
        "owner_candidates": {
            "directories": len(owners),
            "by_step": dict(collections.Counter(o["step"] for o in owners)),
            "lockfile_first_candidates": lockfile_first,
            "rows": owners,
        },
        "dev_only_main_module": {
            "total": len(dev),
            "is_root": sorted(d["purl"] for d in dev if d["is_root"]),
            "added_seed": sorted(d["purl"] for d in dev if d["added_seed"]),
            "rows": dev,
        },
        "anchor_seed": dict(collections.Counter(s["kind"] for s in seeds)),
        "anchor_immunity": {
            "total": len(immune),
            "by_ecosystem": dict(collections.Counter(i["ecosystem"] for i in immune)),
            "purls": sorted(i["purl"] for i in immune),
        },
    }
    with open(out_path, "w", encoding="utf-8") as f:
        json.dump(result, f, indent=2, sort_keys=True)

    r = result
    print(f"### {target}\n")
    print(f"- merges: {r['merge_source']['total']} {r['merge_source']['by_tier']}; reordered by R2: {r['merge_source']['lockfile_merges_reordered_by_r2']}; installed left alone: {len(r['merge_source']['installed_merges_left_alone'])}; editable disagreements: {len(r['merge_source']['editable_disagreements'])}")
    print(f"- same-rank directories: {r['owner_candidates']['directories']} {r['owner_candidates']['by_step']}; lockfile-first candidates: {len(lockfile_first)}")
    print(f"- non-runtime main modules: {r['dev_only_main_module']['total']}; chosen as root: {len(r['dev_only_main_module']['is_root'])}; added seeds: {len(r['dev_only_main_module']['added_seed'])}")
    print(f"- anchor seeds: {r['anchor_seed']}")
    print(f"- kept runtime only by anchors: {r['anchor_immunity']['total']} {r['anchor_immunity']['by_ecosystem']}")
    for p in r["anchor_immunity"]["purls"][:60]:
        print(f"  - `{p}`")
    print()


if __name__ == "__main__":
    main()
