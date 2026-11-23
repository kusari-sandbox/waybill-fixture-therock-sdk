"""Positive control for waybill spec 1644's census (waybill #1641).

Writes a synthetic tree of minimal ELF64 shared libraries, the shape of
waybill's `tests/common/installed_lib.rs::elf_shared_lib_with_dynsym`:

  libwaybill-fixture-bz2.so.1    bzip2's anchor + one date-form version
  libwaybill-fixture-gmp.so.10   GMP's anchor + one version
  libwaybill-fixture-lzma.so.5   defines lzma_version_string + one version
  libwaybill-fixture-plain.so.1  versions with no anchor

A census run over it must report three `versioned` anchored events and
nothing for the plain library. Otherwise a corpus target's zero means a
broken probe, not an absence.

Spec 1645 (waybill #1662): with a second argument, also writes an
installed-library tree there, the shape of waybill's
`tests/library_identity.rs`:

  lib/libncursesw.so.6 + lib/pkgconfig/ncursesw.pc      shared file, `merge`
  lib/libLLVM.so + lib/cmake/llvm/LLVMConfigVersion.cmake
                                     shared file, `version-disagrees` until
                                     the LLVM suffix is kept (FR-002)
  lib/libncurses.so.6 (no banner) + lib/pkgconfig/ncurses.pc 6.4.20221231
                                     an ncurses CPE whose form changes
  lib/libwaybill-fixture-z.so.1      zlib's exported symbols alone, a
                                     fingerprint match (spec 1646)

usage: anchored_control.py OUT_DIR [IDENTITY_DIR]
"""

import os
import struct
import sys


def elf(rodata, defined=(), undefined=()):
    shstr = bytearray(b"\0")

    def name(n):
        off = len(shstr)
        shstr.extend(n.encode() + b"\0")
        return off

    n_ro, n_sym, n_str, n_sh = name(".rodata"), name(".dynsym"), name(".dynstr"), name(".shstrtab")
    dynstr = bytearray(b"\0")
    dynsym = bytearray(24)
    for names, shndx in ((defined, 1), (undefined, 0)):
        for n in names:
            st_name = len(dynstr)
            dynstr.extend(n.encode() + b"\0")
            dynsym.extend(struct.pack("<IBBHQQ", st_name, 0x12, 0, shndx, 0, 0))

    def a8(v):
        return (v + 7) & ~7

    ro_off = 64
    sym_off = a8(ro_off + max(len(rodata), 1024))
    str_off = sym_off + len(dynsym)
    sh_off = str_off + len(dynstr)
    shoff = a8(sh_off + len(shstr))
    f = bytearray(b"\x7fELF" + bytes([2, 1, 1, 0]) + bytes(8))
    f += struct.pack("<HHIQQQIHHHHHH", 3, 62, 1, 0, 0, shoff, 0, 64, 0, 0, 64, 5, 4)
    f += rodata
    f += bytes(sym_off - len(f))
    f += dynsym + dynstr + shstr
    f += bytes(shoff - len(f))

    def sh(nm, ty, flags, off, size, link=0, info=0, ent=0):
        return struct.pack("<IIQQQQIIQQ", nm, ty, flags, 0, off, size, link, info, 8, ent)

    f += sh(0, 0, 0, 0, 0)
    f += sh(n_ro, 1, 2, ro_off, len(rodata))
    f += sh(n_sym, 11, 2, sym_off, len(dynsym), 3, 1, 24)
    f += sh(n_str, 3, 2, str_off, len(dynstr))
    f += sh(n_sh, 3, 0, sh_off, len(shstr))
    return bytes(f)


def main():
    out = sys.argv[1]
    os.makedirs(out, exist_ok=True)
    lead = b"waybill-fixture-leading\0"
    files = {
        "libwaybill-fixture-bz2.so.1": elf(lead + b"\n\nbzip2/libbzip2: internal error number %d.\n\0"
                                           b"1.0.8, 13-Jul-2019\0"),
        "libwaybill-fixture-gmp.so.10": elf(lead + b"GNU MP: Cannot allocate memory (size=%lu)\n\0" b"6.3.0\0"),
        "libwaybill-fixture-lzma.so.5": elf(lead + b"5.8.1\0", defined=["lzma_version_string"]),
        "libwaybill-fixture-plain.so.1": elf(lead + b"6.3.0\0" b"5.8.1\0"),
    }
    for n, b in files.items():
        with open(os.path.join(out, n), "wb") as fh:
            fh.write(b)
    if len(sys.argv) > 2:
        identity(sys.argv[2], lead)


def identity(out, lead):
    files = {
        "lib/libncursesw.so.6": elf(lead + b"ncurses 6.6.20251230\0"),
        "lib/pkgconfig/ncursesw.pc": b"Version: 6.6.20251230\n",
        "lib/libLLVM.so": elf(lead + b"LLVM version 23.0.0git\0"),
        "lib/cmake/llvm/LLVMConfigVersion.cmake": b'set(PACKAGE_VERSION "23.0.0git")\n',
        "lib/libncurses.so.6": elf(lead),
        "lib/pkgconfig/ncurses.pc": b"Version: 6.4.20221231\n",
        # Spec 1646 (waybill #1665): a symbol fingerprint alone (zlib's
        # bundled fingerprint, 8 of 10 required).
        "lib/libwaybill-fixture-z.so.1": elf(lead, defined=[
            "deflate", "inflate", "deflateInit_", "inflateInit_", "deflateEnd",
            "inflateEnd", "crc32", "adler32", "compress", "uncompress"]),
    }
    for n, b in files.items():
        p = os.path.join(out, n)
        os.makedirs(os.path.dirname(p), exist_ok=True)
        with open(p, "wb") as fh:
            fh.write(b)


if __name__ == "__main__":
    main()
