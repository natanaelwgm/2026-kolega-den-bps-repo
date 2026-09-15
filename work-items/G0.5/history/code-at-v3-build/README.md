# Code at the full v3 identity/package run

These exact source snapshots match the SHA256 values in the active
`data/g0-5-development/panel-generation.json`. They are execution provenance, not
entry points: relative imports/paths require their original harness location.
Use `harness/g05/EXTERNAL-WORKFLOW.md` and the active scripts for future work.

Subsequent changes closed the G0 reader with a context manager, corrected stale
builder descriptions and explicitly set Excel automatic/full recalculation.
The annual workbooks were regenerated from the unchanged active Parquet values;
`excel-view-rebuild-verification.json` records that roundtrip and active builder
hash. Matching algorithm and panel assignments did not change. Later reused-ID
validation checks input continuity instead of falsely claiming matching replay.
