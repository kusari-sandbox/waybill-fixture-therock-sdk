"""Report for measure-source.yml (waybill spec 1537, research R10).

For each side (base, branch) and mode (nosub, sub):
  * PyPI components declared by the super-project's OWN requirements files
    (waybill#1538's rule: a source file that is a top-level requirements*.txt,
    or any path under build_tools/ or external-builds/), and of those, how
    many have an incoming dependency edge, how many are reachable from the
    root, and how many are unreachable with no waybill:orphan-reason;
  * the root's direct targets in each of the three formats, and whether the
    three sets are equal;
  * the waybill:graph-completeness verdict.
Reads the emitted documents only. Usage: source_report.py <out-dir>
"""
import fnmatch
import json
import pathlib
import sys

OUT = pathlib.Path(sys.argv[1])


def strip(purl):
    return purl.split("?")[0] if purl else purl


def cdx_components(doc):
    out, stack = [], list(doc.get("components", []))
    while stack:
        c = stack.pop()
        out.append(c)
        stack.extend(c.get("components", []))
    return out


def prop(c, name):
    for p in c.get("properties", []):
        if p.get("name") == name:
            return p.get("value")
    return None


def own_declared(paths):
    for p in paths:
        top = "/" not in p and fnmatch.fnmatch(p, "requirements*.txt")
        if top or p.startswith("build_tools/") or p.startswith("external-builds/"):
            return True
    return False


def cdx_facts(doc):
    root = doc["metadata"]["component"]["bom-ref"]
    comps = cdx_components(doc)
    purl_of = {c["bom-ref"]: c.get("purl") for c in comps if "bom-ref" in c}
    adj = {}
    for d in doc.get("dependencies", []):
        adj.setdefault(d["ref"], []).extend(d.get("dependsOn", []))
    incoming = {t for ts in adj.values() for t in ts}
    seen, stack = {root}, [root]
    while stack:
        for t in adj.get(stack.pop(), []):
            if t not in seen:
                seen.add(t)
                stack.append(t)
    own = []
    for c in comps:
        if not c.get("purl", "").startswith("pkg:pypi/"):
            continue
        raw = prop(c, "waybill:source-files")
        paths = json.loads(raw) if raw else []
        if own_declared(paths):
            own.append(c)
    stats = {
        "own": len(own),
        "incoming": sum(1 for c in own if c["bom-ref"] in incoming),
        "reachable": sum(1 for c in own if c["bom-ref"] in seen),
        "reason": sum(1 for c in own if prop(c, "waybill:orphan-reason")),
        "unexplained": sum(
            1 for c in own if c["bom-ref"] not in seen and not prop(c, "waybill:orphan-reason")
        ),
    }
    # A target with no PURL (a file-tier entry) is counted, not compared:
    # SPDX 2.3 names it by SPDXID and SPDX 3 by IRI, so it cannot match
    # across formats by name. waybill's root_targets.py (spec 1537 I-1)
    # compares those by content hash.
    targets = {strip(purl_of[t]) for t in adj.get(root, []) if purl_of.get(t)}
    stats["purlless_targets"] = sum(1 for t in adj.get(root, []) if not purl_of.get(t))
    verdict = prop(doc["metadata"], "waybill:graph-completeness")
    return stats, targets, verdict


def spdx23_targets(doc):
    root = next(
        r["relatedSpdxElement"]
        for r in doc["relationships"]
        if r["relationshipType"] == "DESCRIBES" and r["spdxElementId"] == "SPDXRef-DOCUMENT"
    )
    purl_of = {}
    for p in doc.get("packages", []):
        refs = [e["referenceLocator"] for e in p.get("externalRefs", []) if e.get("referenceType") == "purl"]
        if refs:
            purl_of[p["SPDXID"]] = refs[0]
    out = set()
    for r in doc["relationships"]:
        if r["spdxElementId"] == root and r["relationshipType"] == "DEPENDS_ON":
            t = r["relatedSpdxElement"]
        elif r["relatedSpdxElement"] == root and r["relationshipType"].endswith("_DEPENDENCY_OF"):
            t = r["spdxElementId"]
        else:
            continue
        if t in purl_of:
            out.add(strip(purl_of[t]))
    return out


def spdx3_targets(doc):
    g = doc["@graph"]
    root = next(e for e in g if e.get("type") == "SpdxDocument")["rootElement"][0]
    purl_of = {e["spdxId"]: e["software_packageUrl"] for e in g if e.get("spdxId") and e.get("software_packageUrl")}
    out = set()
    for e in g:
        if e.get("type") == "Relationship" and e.get("relationshipType") == "dependsOn" and e.get("from") == root:
            out.update(strip(purl_of.get(t, t)) for t in e.get("to", []))
    return out


print("## measure-source\n")
print("```\n" + (OUT / "refs.txt").read_text() + "```\n")
print("| side | mode | own-declared PyPI | with incoming edge | reachable from root | with orphan reason | unreachable, no reason | root targets with a PURL, cdx / spdx-2.3 / spdx-3 | formats agree | cdx root targets without a PURL | verdict |")
print("|---|---|---|---|---|---|---|---|---|---|---|")
for side in ["base", "branch"]:
    for mode in ["nosub", "sub"]:
        stem = f"{side}.{mode}"
        cdx = json.loads((OUT / f"{stem}.cdx.json").read_text())
        s23 = json.loads((OUT / f"{stem}.spdx23.json").read_text())
        s3 = json.loads((OUT / f"{stem}.spdx3.json").read_text())
        stats, t_cdx, verdict = cdx_facts(cdx)
        t23, t3 = spdx23_targets(s23), spdx3_targets(s3)
        agree = "yes" if t_cdx == t23 == t3 else "**no**"
        print(
            f"| {side} | {mode} | {stats['own']} | {stats['incoming']} | {stats['reachable']} | "
            f"{stats['reason']} | {stats['unexplained']} | {len(t_cdx)} / {len(t23)} / {len(t3)} | {agree} | {stats['purlless_targets']} | {verdict} |"
        )
        (OUT / f"{side}.{mode}.root-targets.txt").write_text(
            "".join(f"{fmt}\t{t}\n" for fmt, ts in (("cdx", t_cdx), ("spdx23", t23), ("spdx3", t3)) for t in sorted(ts))
        )
print(
    "\n`formats agree` compares root targets by PURL. SPDX 3 gives a file-tier"
    " package a PURL and CycloneDX does not, so a scan with file-tier root targets"
    " can disagree here by naming alone. The cross-format check that counts is"
    " waybill's `specs/1537-requirements-root-attach/measurements/root_targets.py`,"
    " which keys file-tier entries by content hash."
)
print("\nTimes and disk:\n```\n" + (OUT / "times.txt").read_text() + "```")
