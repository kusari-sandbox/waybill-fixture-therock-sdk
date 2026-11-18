"""Census of the static archives in an installed tree (waybill spec 1612, #1534).

Usage: python3 -I -B archives.py <extracted-root> <therock_manifest.json> <out.json>

For every `.a` (a regular file, not a symlink) under the root, records:
- its format: BSD or GNU `!<arch>`, thin `!<thin>`, or not an archive;
- its member count, the largest member, and whether it carries a symbol index
  (`/`, `/SYM64/`, `__.SYMDEF`) or long-name table (`//`, BSD `#1/N`);
- per member type (ELF object, LLVM bitcode, other), with counts;
- the source paths in each member's printable strings, classified exactly as
  `embedded-paths.py` classifies them (submodule / fetchcontent / vendored /
  TheRock build tree / other).

It does the same string classification over every regular non-archive ELF file
in the tree. It then reports which classes occur only inside archives, and
which also occur in a shared library or executable.

Members are read by parsing the archive here, not with `ar x`, because archives
routinely hold several members with the same name, which `ar x` overwrites.

A measuring script, not a model of a reader. Uses only the standard library.
"""

import collections
import json
import os
import re
import statistics
import sys

root, manifest_path, out_path = sys.argv[1:4]
manifest = json.load(open(manifest_path))
subs = sorted(((s["submodule_path"], s["submodule_name"]) for s in manifest["submodules"]), key=lambda x: -len(x[0]))

SRC = re.compile(rb"(/[A-Za-z0-9._+@~-]+(?:/[A-Za-z0-9._+@~-]+)+\.(?:c|cc|cpp|cxx|c\+\+|h|hh|hpp|hxx|hip|cu|cuh|inc|def|cl|s|S))(?::\d+)?$")
VENDOR = re.compile(r"/(?:third_party|third-party|thirdparty|3rdparty|external|extern|vendor)/([A-Za-z0-9._+-]+)/")
FETCH = re.compile(r"/_deps/([A-Za-z0-9._+-]+?)-(?:src|build|subbuild)/")
THEROCK = re.compile(r"/TheRock/TheRock/(.*)$")
PRINTABLE = re.compile(rb"[\x20-\x7e]{8,}")


def classify(p):
    m = FETCH.search(p)
    if m:
        return f"fetchcontent:{m.group(1)}"
    m = VENDOR.search(p)
    if m:
        return f"vendored:{m.group(1)}"
    m = THEROCK.search(p)
    if m:
        rest = m.group(1)
        if rest.startswith("output/build/"):
            parts = rest.split("/")
            return "build:" + "/".join(parts[2:4])
        for sp, name in subs:
            if rest == sp or rest.startswith(sp + "/"):
                sub = rest[len(sp) + 1:].split("/")
                proj = "/".join(sub[:2]) if sub and sub[0] == "projects" else ""
                return f"submodule:{name}" + (f":{proj}" if proj else "")
        return "therock:" + rest.split("/")[0]
    return "other:" + "/".join(p.split("/")[1:4])


def classes_in(data):
    out = collections.Counter()
    for m in PRINTABLE.finditer(data):
        s = SRC.search(m.group(0).strip())
        if s:
            out[classify(s.group(1).decode("ascii", "replace"))] += 1
    return out


def members(data):
    """Yield (name, offset, size, kind, style) for each member of a `!<arch>` archive.

    kind is 'symtab', 'longnames' or 'member'; style is 'gnu', 'bsd' or None,
    from how the entry is named. Raises ValueError on a malformed
    header. GNU long names (/N) are resolved through the // table; BSD #1/N
    names are read inline (their bytes are part of the member's size).
    """
    pos, longnames = 8, b""
    while pos + 60 <= len(data):
        hdr = data[pos:pos + 60]
        if hdr[58:60] != b"`\n":
            raise ValueError(f"bad member header at {pos}")
        raw = hdr[0:16].rstrip(b" ")
        size = int(hdr[48:58].strip() or b"0")
        body = pos + 60
        if body + size > len(data):
            raise ValueError(f"member at {pos} runs past end of file")
        kind, name, off, n, style = "member", raw, body, size, None
        if raw in (b"/", b"/SYM64/", b"/SYM64"):
            kind, style = "symtab", "gnu"
        elif raw.startswith(b"__.SYMDEF"):
            kind, style = "symtab", "bsd"
        elif raw == b"//":
            kind, style, longnames = "longnames", "gnu", data[body:body + size]
        elif raw.startswith(b"#1/"):
            ln = int(raw[3:])
            name, off, n, style = data[body:body + ln].rstrip(b"\0"), body + ln, size - ln, "bsd"
            if name.startswith(b"__.SYMDEF"):
                kind = "symtab"
        elif raw.startswith(b"/") and raw[1:].isdigit():
            i = int(raw[1:])
            end = longnames.find(b"/\n", i)
            name, style = longnames[i:end if end >= 0 else len(longnames)], "gnu"
        else:
            if raw.endswith(b"/"):
                style = "gnu"
            name = raw.rstrip(b"/")
        yield name.decode("utf-8", "replace"), off, n, kind, style
        pos = body + size + (size & 1)


def pct(xs, q):
    if not xs:
        return 0
    xs = sorted(xs)
    return xs[min(len(xs) - 1, int(q * len(xs)))]


archives, binary_classes, skipped_links = [], collections.defaultdict(set), 0
for dirpath, dirnames, filenames in os.walk(root):
    dirnames.sort()
    for fn in sorted(filenames):
        path = os.path.join(dirpath, fn)
        rel = os.path.relpath(path, root)
        if os.path.islink(path):
            skipped_links += fn.endswith(".a")
            continue
        try:
            with open(path, "rb") as f:
                head = f.read(8)
        except OSError:
            continue
        if fn.endswith(".a"):
            rec = {"path": rel, "size": os.path.getsize(path)}
            if head == b"!<thin>\n":
                rec["format"] = "thin"
                archives.append(rec)
                continue
            if head != b"!<arch>\n":
                rec["format"] = "not-archive"
                archives.append(rec)
                continue
            data = open(path, "rb").read()
            kinds, mtypes, msizes, cls, styles = collections.Counter(), collections.Counter(), [], collections.Counter(), set()
            try:
                for name, off, n, kind, style in members(data):
                    kinds[kind] += 1
                    if style:
                        styles.add(style)
                    if kind != "member":
                        continue
                    blob = data[off:off + n]
                    msizes.append(n)
                    mt = "elf" if blob[:4] == b"\x7fELF" else "bitcode" if blob[:4] in (b"BC\xc0\xde", b"\xde\xc0\x17\x0b") else "other"
                    mtypes[mt] += 1
                    if mt == "elf":
                        for c in classes_in(blob):
                            cls[c] += 1
                rec["format"] = "mixed" if len(styles) > 1 else (styles.pop() if styles else "plain")
            except ValueError as e:
                rec["format"] = "malformed"
                rec["error"] = str(e)
            rec.update({
                "members": sum(mtypes.values()),
                "member_types": dict(mtypes),
                "has_symtab": kinds["symtab"] > 0,
                "has_longnames": kinds["longnames"] > 0,
                "max_member": max(msizes, default=0),
                "classes": dict(cls),
            })
            archives.append(rec)
            continue
        if head[:4] == b"\x7fELF":
            data = open(path, "rb").read()
            for c in classes_in(data):
                binary_classes[c].add(rel)

summary = collections.Counter(a["format"] for a in archives)
opened = [a for a in archives if "members" in a]
by_class = collections.defaultdict(lambda: {"archives": 0, "archive_bytes": 0, "members": 0})
for a in opened:
    for c, n in a["classes"].items():
        by_class[c]["archives"] += 1
        by_class[c]["archive_bytes"] += a["size"]
        by_class[c]["members"] += n
for c in by_class:
    by_class[c]["binaries"] = len(binary_classes.get(c, ()))
archive_only = {c: v for c, v in by_class.items() if v["binaries"] == 0}

result = {
    "archives": archives,
    "symlinked_archives": skipped_links,
    "formats": dict(summary),
    "distribution": {
        "archive_bytes": {q: pct([a["size"] for a in opened], v) for q, v in (("p50", .5), ("p90", .9), ("p99", .99), ("max", 1))},
        "members": {q: pct([a["members"] for a in opened], v) for q, v in (("p50", .5), ("p90", .9), ("p99", .99), ("max", 1))},
        "max_member_bytes": {q: pct([a["max_member"] for a in opened], v) for q, v in (("p50", .5), ("p90", .9), ("p99", .99), ("max", 1))},
    },
    "member_types": dict(sum((collections.Counter(a["member_types"]) for a in opened), collections.Counter())),
    "classes": dict(by_class),
    "archive_only": sorted(archive_only),
}
json.dump(result, open(out_path, "w"), indent=1, sort_keys=True)

print("## Static archive census\n")
print(f"- archives: {len(archives)} regular files, {skipped_links} symlinked; formats {dict(summary)}")
print(f"- members by type: {result['member_types']}")
print(f"- with any classified source path in a member: {sum(1 for a in opened if a['classes'])} of {len(opened)}")
for k, v in result["distribution"].items():
    print(f"- {k}: {v}")
third = lambda c: c.startswith(("vendored:", "fetchcontent:"))
print("\n### Third-party classes (vendored / fetchcontent)\n")
print("| class | archives | archive bytes (MB) | members | non-archive binaries |")
print("|---|---|---|---|---|")
for c, v in sorted(by_class.items(), key=lambda kv: -kv[1]["members"]):
    if third(c):
        print(f"| {c} | {v['archives']} | {v['archive_bytes'] / 1e6:.0f} | {v['members']} | {v['binaries']} |")
print("\n### Classes found only inside archives\n")
for c in sorted(archive_only, key=lambda c: -by_class[c]["members"]):
    v = by_class[c]
    print(f"- {c}: {v['archives']} archives, {v['members']} members")
