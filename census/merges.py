"""Census of waybill merges that join two source mechanisms (waybill #1558,
spec 1639 T005).

Reads the `waybill::also_detected` debug events a log-only waybill build
writes at each merge site (S1-S9, spec 1639 research R3) and tallies them.
It counts what the binary reports; it does not model waybill's readers.

usage: merges.py TARGET SCAN_LOG SCAN_CDX OUT_JSON

Each event: site, subject (the survivor's PURL), kept (the survivor's C55 at
the time, or "-"), absorbed (the absorbed member's C55, or "-"), and at S1
rank_winner (which member milestone 105's ranking would have kept).
"""

import collections
import json
import re
import sys

ANSI = re.compile(r"\x1b\[[0-9;]*m")
FIELD = re.compile(r'(\w+)="([^"]*)"')


def events(log_path):
    out = []
    with open(log_path, encoding="utf-8", errors="replace") as f:
        for line in f:
            line = ANSI.sub("", line)
            if "waybill::also_detected" not in line:
                continue
            fields = dict(FIELD.findall(line))
            if "site" in fields:
                out.append(fields)
    return out


def components(doc):
    stack = list(doc.get("components", []))
    while stack:
        c = stack.pop()
        yield c
        stack.extend(c.get("components", []))


def prop(c, name):
    for p in c.get("properties", []) or []:
        if p.get("name") == name:
            return p.get("value")
    return None


def main():
    target, log_path, cdx_path, out_path = sys.argv[1:5]
    evs = events(log_path)

    by_site = collections.Counter(e["site"] for e in evs)
    groups = collections.OrderedDict()
    for e in evs:
        groups.setdefault((e["site"], e["subject"]), []).append(e)

    # What C56 would record: per group, the survivor's C55 after the merge
    # (at S1 a survivor without C55 takes the first absorbed member's, the
    # deduplicator's existing fold), then every absorbed C55 that differs.
    pairs = collections.Counter()
    recording_groups = collections.Counter()
    anchorless = collections.Counter()
    for (site, subject), es in groups.items():
        kept = es[0]["kept"]
        if kept == "-" and site == "S1":
            kept = next((e["absorbed"] for e in es if e["absorbed"] != "-"), "-")
        if kept == "-":
            if any(e["absorbed"] != "-" for e in es):
                anchorless[site] += 1
            continue
        recorded = sorted({e["absorbed"] for e in es if e["absorbed"] not in ("-", kept)})
        if recorded:
            recording_groups[site] += 1
        for m in recorded:
            pairs[(site, kept, m)] += 1

    # S1 groups milestone 105's ranking would have resolved differently.
    s1 = [es for (site, _), es in groups.items() if site == "S1"]
    rank_changes = sum(1 for es in s1 if any(e.get("rank_winner") == "absorbed" for e in es))
    unranked = sum(1 for es in s1 for e in es if e.get("rank_winner") == "unranked")

    # The old fingerprint-collision key: on a log-only build nothing else
    # writes `waybill:also-detected-via`, so any occurrence is the collision.
    with open(cdx_path, encoding="utf-8") as f:
        doc = json.load(f)
    collisions = [c.get("purl") for c in components(doc) if prop(c, "waybill:also-detected-via") is not None]

    result = {
        "target": target,
        "events": len(evs),
        "events_by_site": dict(sorted(by_site.items())),
        "merge_groups_by_site": dict(sorted(collections.Counter(s for s, _ in groups).items())),
        "groups_that_would_record_c56_by_site": dict(sorted(recording_groups.items())),
        "groups_with_no_survivor_c55_by_site": dict(sorted(anchorless.items())),
        "pairs": [{"site": s, "kept": k, "absorbed": a, "groups": n} for (s, k, a), n in sorted(pairs.items())],
        "s1_groups": len(s1),
        "s1_groups_ranking_would_change": rank_changes,
        "s1_events_unranked": unranked,
        "fingerprint_collisions_old_key": sorted(p for p in collisions if p),
    }
    with open(out_path, "w", encoding="utf-8") as f:
        json.dump(result, f, indent=2, sort_keys=True)
        f.write("\n")

    print(f"## {target}\n")
    print(f"- events: {len(evs)}; by site: {result['events_by_site']}")
    print(f"- merge groups by site: {result['merge_groups_by_site']}")
    print(f"- groups that would record C56: {result['groups_that_would_record_c56_by_site']}")
    print(f"- groups with no survivor C55 (research R5): {result['groups_with_no_survivor_c55_by_site']}")
    print(f"- S1 groups: {len(s1)}; ranking would change: {rank_changes}; unranked events: {unranked}")
    print(f"- fingerprint collisions under the old key: {len(result['fingerprint_collisions_old_key'])}\n")
    print("| site | kept | absorbed | groups |\n|---|---|---|---|")
    for p in result["pairs"]:
        print(f"| {p['site']} | {p['kept']} | {p['absorbed']} | {p['groups']} |")
    print()


if __name__ == "__main__":
    main()
