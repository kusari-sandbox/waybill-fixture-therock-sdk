"""Where a literal sits in an ELF file: every occurrence, the section that
holds it, and the bytes around it (waybill spec 1644, #1641).

It reports raw bytes only. It does not judge what waybill would accept
(that would be a second model of waybill's rules).

usage: inspect_bytes.py NEEDLE FILE...
"""

import struct
import sys


def sections(data):
    if data[:4] != b"\x7fELF" or data[4] != 2 or data[5] != 1:
        return []
    shoff, = struct.unpack_from("<Q", data, 0x28)
    shentsize, shnum, shstrndx = struct.unpack_from("<HHH", data, 0x3A)
    raw = []
    for i in range(shnum):
        name, ty, flags, _addr, off, size = struct.unpack_from("<IIQQQQ", data, shoff + i * shentsize)
        raw.append((name, ty, flags, off, size))
    strtab_off, strtab_size = raw[shstrndx][3], raw[shstrndx][4]
    names = data[strtab_off:strtab_off + strtab_size]
    out = []
    for name, ty, flags, off, size in raw:
        end = names.find(b"\0", name)
        out.append((names[name:end].decode(errors="replace"), ty, flags, off, size))
    return out


def show(b):
    return "".join(chr(c) if 32 <= c < 127 else f"\\x{c:02x}" for c in b)


def main():
    needle = sys.argv[1].encode()
    for path in sys.argv[2:]:
        data = open(path, "rb").read()
        secs = sections(data)
        print(f"== {path} ({len(data)} bytes)")
        for n, ty, flags, off, size in secs:
            if size and ty != 8:  # SHT_NOBITS has no file bytes
                print(f"   section {n:24} type={ty:<3} flags={flags:#x} off={off:#x} size={size:#x}")
        pos = data.find(needle)
        count = 0
        while pos != -1:
            count += 1
            sec = next((n for n, ty, _f, off, size in secs if ty != 8 and off <= pos < off + size), "?")
            print(f"   at {pos:#x} in {sec}: before='{show(data[max(0, pos - 48):pos])}'")
            print(f"   {'':>{len(hex(pos)) + 4}}  from  ='{show(data[pos:pos + 48])}'")
            pos = data.find(needle, pos + 1)
        print(f"   occurrences: {count}")


if __name__ == "__main__":
    main()
