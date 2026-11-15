# waybill-fixture-therock-sdk

The install-time metadata from one TheRock ("ROCm SDK") nightly dist tarball.
It holds pkg-config files (`*.pc`), CMake package version files
(`*ConfigVersion.cmake`, `*-config-version.cmake`), and a listing of the
tarball's library files. It is a scan target for
[waybill](https://github.com/kusari-oss/waybill)'s installed-library reader
(kusari-oss/waybill#1531). That reader reads these files to give an installed
C/C++ SDK's libraries their exact versions.

Nothing here is built, run or modified. Everything under `sdk/` is copied
byte for byte from the tarball named in `MANIFEST.json`, by the `capture`
workflow running in GitHub Actions. `MANIFEST.json` records:
- the source URL and the S3 object version it was fetched at;
- the tarball's SHA-256 and size;
- the count of each kind of file extracted.

The files remain under the licences of the projects that ship them.

## Workflows

- **`capture`** (manual): downloads one tarball, verifies its size,
  extracts only the files above, writes `MANIFEST.json`,
  `listing/library-files.txt` and `listing/all-files.txt` (every member's
  type, size and path, with no content), and commits them.
- **`measure`** (manual): builds waybill at two refs, scans `sdk/` with
  each, and reports in the run summary:
  - the number of versioned components;
  - the reader's `waybill:installed-library-coverage` record;
  - the scan time.

  The SBOMs are uploaded as an artifact.

Nothing from the tarball is downloaded or unpacked outside GitHub Actions.
