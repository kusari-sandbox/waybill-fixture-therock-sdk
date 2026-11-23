# Static liblzma probe (waybill spec 1647, #1664)

Copied from waybill's `specs/1647-static-liblzma-anchor/measurements/probe/`.

- `a.c` calls only `lzma_easy_buffer_encode`. The control job links it with `gcc -static -llzma`, keeps one copy unstripped and one stripped, and scans both. This is a real static liblzma, not a synthetic file.
- `b.c` also calls `lzma_version_string`. It is run once, only to learn the runner's xz version. It is not scanned.

The built programs are never committed.
