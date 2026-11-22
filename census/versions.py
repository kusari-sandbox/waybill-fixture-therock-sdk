"""Census of waybill's curated embedded-version matches by the byte before
each literal (waybill #1568, #1641, spec 1643 T005).

Reads the `waybill::version_census` debug events a log-only waybill build
writes, one per occurrence of a curated pattern found with no boundary test,
and tallies them. It counts what the binary reports; it never re-scans bytes
(that would be a second model of waybill's patterns).

usage: versions.py TARGET SCAN_LOG OUT_JSON

Event fields: path=<binary> hit=<json> with library, version, offset,
preceding (start | nul | whitespace | other_non_identifier | identifier),
accepted_main, accepted_new, context_before, context_after (hex).
"""

import collections
import json
import re
import sys

ANSI = re.compile(r"\x1b\[[0-9;]*m")
EVENT = re.compile(r"path=(.*?) hit=(\{.*\})\s*$")


def events(log_path):
    out = []
    with open(log_path, encoding="utf-8", errors="replace") as f:
        for line in f:
            line = ANSI.sub("", line)
            if "waybill::version_census" not in line:
                continue
            m = EVENT.search(line)
            if not m:
                raise SystemExit(f"unparsed census line: {line[:300]}")
            hit = json.loads(m.group(2))
            hit["path"] = m.group(1)
            out.append(hit)
    return out


def printable(hexstr):
    b = bytes.fromhex(hexstr)
    return "".join(chr(c) if 32 <= c < 127 else f"\\x{c:02x}" for c in b)


def main():
    target, log_path, out_path = sys.argv[1:4]
    hits = events(log_path)
    by_lib = collections.defaultdict(collections.Counter)
    for h in hits:
        by_lib[h["library"]][h["preceding"]] += 1
    changed = [h for h in hits if h["accepted_new"] != h["accepted_main"]]

    def versions(rule):
        per = collections.defaultdict(set)
        for h in hits:
            if h[rule]:
                per[(h["path"], h["library"])].add(h["version"])
        return per

    main_v, new_v = versions("accepted_main"), versions("accepted_new")
    gained = [
        {"path": p, "library": lib, "main": sorted(main_v.get((p, lib), ())), "new": sorted(vs)}
        for (p, lib), vs in sorted(new_v.items())
        if vs != main_v.get((p, lib), set())
    ]
    lost = [
        {"path": p, "library": lib, "main": sorted(vs)}
        for (p, lib), vs in sorted(main_v.items())
        if not vs <= new_v.get((p, lib), set())
    ]
    two_versions = [g for g in gained if len(g["new"]) > 1]
    report = {
        "target": target,
        "events": len(hits),
        "binaries_with_hits": len({h["path"] for h in hits}),
        "by_library": {k: dict(v) for k, v in sorted(by_lib.items())},
        "changed_verdicts": changed,
        "binaries_gaining_or_changing": gained,
        "binaries_losing": lost,
        "newly_two_versions": two_versions,
    }
    with open(out_path, "w", encoding="utf-8") as f:
        json.dump(report, f, indent=2, sort_keys=True)

    print(f"## {target}\n")
    print(f"{len(hits)} events in {report['binaries_with_hits']} binaries.\n")
    print("| library | start | nul | whitespace | other_non_identifier | identifier |")
    print("|---|---|---|---|---|---|")
    cols = ["start", "nul", "whitespace", "other_non_identifier", "identifier"]
    for lib, c in sorted(by_lib.items()):
        print(f"| {lib} | " + " | ".join(str(c.get(k, 0)) for k in cols) + " |")
    print(f"\n**Verdicts that change:** {len(changed)}; binaries gaining or changing a version: "
          f"{len(gained)}; losing: {len(lost)}; newly two versions: {len(two_versions)}\n")
    for h in sorted(changed, key=lambda h: (h["preceding"] != "whitespace", h["library"], h["path"])):
        print(f"- `{h['library']}@{h['version']}` [{h['preceding']}] new={h['accepted_new']} `{h['path']}`")
        print(f"  - before: `{printable(h['context_before'])}`")
        print(f"  - from: `{printable(h['context_after'])}`")


if __name__ == "__main__":
    main()
