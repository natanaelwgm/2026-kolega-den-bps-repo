# Validation — 14 October 2026

The exporter was checked against the native Stata ZIP delivered to the owner that day. All 733 execution, input, add-on and guide files match byte-for-byte: 466 analysis source files, the native master, 262 unique add-on files plus their source description, the ready dataset, module list and short guide. The two provenance manifests differ only to record the exported version, input hash and portable add-on source description. Both archives contain the same 735 paths. Two repeated exports also produce byte-identical ZIP files. The new ZIP passes CRC checks and extracts successfully.

The native master SHA-256 is `0ed78bfefef8b4a60ea6e7d1c1ab7c2e10b16ef5e47bc83d290498486a6bf7d2`; the included development DTA SHA-256 is `975f7d2a4087ea5ee95ba1f59acbfe52f68cb25eea1a9f21ba23e64d3bba0c7c`.

Five focused Python tests cover PDF continuation comments, conditional exports, retained PNG/CSV output, program boundaries, out-of-repository source rejection and preservation of an existing export.

The identical native entry previously passed a Stata SE 17 startup check with the real development input, all source copies, status creation and isolated bundled add-ons, including reghdfe and gcollapse. The underlying analyses have successful numerical runs producing 21 descriptive workbooks and 80 estimation CSV files. This export validation does not claim a new complete run of all analyses. Windows execution has not been tested directly. Five groups still require government-ownership or detailed product/raw-material inputs.

Run the focused checks from the repository root with `python3 scripts/test_ready_stata_export.py`. Exporting a ZIP performs no estimation and uploads nothing.
