"""Census of waybill's curated embedded-version matches by the byte before
each literal (waybill #1568, #1641, spec 1643 T005).

Reads the `waybill::version_census` debug events a log-only waybill build
writes, one per occurrence of a curated pattern found with no boundary test,
and tallies them. It counts what the binary reports; it never re-scans bytes
(that would be a second model of waybill's patterns).

usage: versions.py TARGET SCAN_LOG OUT_JSON [SCAN_CDX]

Event fields: path=<binary> hit=<json> with library, version, offset,
preceding (start | nul | whitespace | other_non_identifier | identifier),
accepted_main, accepted_new, context_before, context_after (hex).

Spec 1644 (waybill #1641) adds two event kinds, both summarised here:
  path=<binary> anchored=<json>    library, anchors, candidates, shared,
                                   verdict, version (bzip2, gmp, liblzma)
  path=<binary> unanchored=<json>  bzip2 date-form strings in a binary with
                                   no bzip2 anchor (census only)
With SCAN_CDX, the components the same scan already names bzip2, gmp,
liblzma, xz or lzma are listed with their evidence (FR-001's third bullet).

Spec 1645 (waybill #1662) adds three more, all summarised here:
  path=<binary> curated_version_change=<json>  library, old, new (LLVM, ncurses)
  shared_file=<json>      a file claimed by a curated match and an
                          installed-library record: curated, file, records,
                          verdict (merge | version-disagrees | name-unrelated |
                          ambiguous)
  cpe_form_change=<json>  purl, old, new (ncurses X.Y.YYYYMMDD)
"""

import collections
import json
import re
import sys

ANSI = re.compile(r"\x1b\[[0-9;]*m")
EVENT = re.compile(r"path=(.*?) (hit|anchored|unanchored|curated_version_change)=(\{.*\})\s*$")
PATHLESS = re.compile(r" (shared_file|cpe_form_change)=(\{.*\})\s*$")
NAMES = {"bzip2", "gmp", "liblzma", "xz", "lzma"}


def events(log_path):
    out = {"hit": [], "anchored": [], "unanchored": [], "curated_version_change": [],
           "shared_file": [], "cpe_form_change": []}
    with open(log_path, encoding="utf-8", errors="replace") as f:
        for line in f:
            line = ANSI.sub("", line)
            if "waybill::version_census" not in line:
                continue
            m = EVENT.search(line)
            if not m:
                pm = PATHLESS.search(line)
                if not pm:
                    raise SystemExit(f"unparsed census line: {line[:300]}")
                out[pm.group(1)].append(json.loads(pm.group(2)))
                continue
            ev = json.loads(m.group(3))
            ev["path"] = m.group(1)
            out[m.group(2)].append(ev)
    return out


def existing(cdx_path):
    """Components the scan names bzip2/gmp/liblzma/xz/lzma, nested included."""
    with open(cdx_path, encoding="utf-8") as f:
        doc = json.load(f)
    stack = list(doc.get("components", []))
    found = []
    while stack:
        c = stack.pop()
        stack.extend(c.get("components", []))
        if c.get("name", "").lower() in NAMES:
            props = {p.get("name"): p.get("value") for p in c.get("properties", [])}
            found.append({
                "name": c.get("name"),
                "purl": c.get("purl"),
                "evidence_kind": props.get("waybill:evidence-kind"),
                "source_files": props.get("waybill:source-files"),
            })
    return sorted(found, key=lambda c: (c["name"], c["purl"] or ""))


def printable(hexstr):
    b = bytes.fromhex(hexstr)
    return "".join(chr(c) if 32 <= c < 127 else f"\\x{c:02x}" for c in b)


def main():
    target, log_path, out_path = sys.argv[1:4]
    cdx_path = sys.argv[4] if len(sys.argv) > 4 else None
    evs = events(log_path)
    hits = evs["hit"]
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
        "anchored": evs["anchored"],
        "unanchored": evs["unanchored"],
        "existing_components": existing(cdx_path) if cdx_path else None,
        "curated_version_change": evs["curated_version_change"],
        "shared_file": evs["shared_file"],
        "cpe_form_change": evs["cpe_form_change"],
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

    # Spec 1644: anchored whole-string libraries.
    anch = evs["anchored"]
    verdicts = collections.Counter((a["library"], a["verdict"]) for a in anch)
    print(f"\n### Anchored libraries (spec 1644)\n\n{len(anch)} anchored events in "
          f"{len({a['path'] for a in anch})} binaries.\n")
    print("| library | versioned | ambiguous | ambiguous-shared | no-candidate |")
    print("|---|---|---|---|---|")
    for lib in sorted({a["library"] for a in anch}):
        print(f"| {lib} | " + " | ".join(str(verdicts[(lib, v)]) for v in
              ["versioned", "ambiguous", "ambiguous-shared", "no-candidate"]) + " |")
    for a in sorted(anch, key=lambda a: (a["library"], a["path"])):
        anchors = ", ".join(f"{x['kind']}:{x['value']}" for x in a["anchors"])
        cands = ", ".join(c["value"] for c in a["candidates"]) or "-"
        shared = ", ".join(f"{c['value']} (with {c['with']})" for c in a["shared"]) or "-"
        print(f"- `{a['library']}` **{a['verdict']}** {a.get('version', '')} `{a['path']}`; "
              f"anchors: {anchors}; candidates: {cands}; shared: {shared}")
    un = evs["unanchored"]
    print(f"\n**bzip2 date form without the anchor (FR-006):** {len(un)} binaries")
    for u in sorted(un, key=lambda u: u["path"]):
        print(f"- `{u['path']}`: " + ", ".join(c["value"] for c in u["candidates"]))
    if cdx_path:
        ex = report["existing_components"]
        print(f"\n**Components this scan already names bzip2/gmp/liblzma/xz/lzma:** {len(ex)}")
        for c in ex:
            print(f"- `{c['purl']}` evidence={c['evidence_kind']} files={c['source_files']}")

    # Spec 1645: shared files, stated versions, ncurses CPE form.
    sf = evs["shared_file"]
    print(f"\n### Shared files (spec 1645)\n\n{len(sf)} files claimed by a curated match and a record.\n")
    for s in sorted(sf, key=lambda s: (s["verdict"], s["file"])):
        recs = "; ".join(f"{r['mechanism']} {r['name']}@{r['version']} name={r['name_qualifies']} "
                         f"version={r['version_agrees']}" for r in s["records"])
        print(f"- **{s['verdict']}** `{s['curated']['library']}@{s['curated']['version']}` `{s['file']}`: {recs}")
    vc = evs["curated_version_change"]
    print(f"\n**Curated version changes (FR-002, FR-013):** {len(vc)}")
    for c in sorted(vc, key=lambda c: (c["library"], c["path"])):
        print(f"- `{c['library']}` {c['old']} -> {c['new']} `{c['path']}`")
    cf = evs["cpe_form_change"]
    print(f"\n**ncurses CPE form changes (FR-008):** {len(cf)}")
    for c in sorted(cf, key=lambda c: c["purl"]):
        print(f"- `{c['purl']}`: `{c['old']}` -> `{c['new']}`")


if __name__ == "__main__":
    main()
