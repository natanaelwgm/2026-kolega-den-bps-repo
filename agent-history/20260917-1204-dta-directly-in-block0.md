## 2026-09-17 12:04 WIB - Correct final DTA location

- Agent/runtime: Codex desktop; git, gh, Python 3.14.
- Root/cwd: /Users/natanaelmassie/Downloads/2026-kolega-den-bps-repo.
- Branch/base: fix/block0-dta-in-folder, origin/main 7cacb8a.
- User intent: "dta nya kok gak di block 0 folder ?" after authorizing publication to main.
- Interpretation/decision: the final DTA must be a real tracked file in the requested GitHub folder. Prior Release-only publication did not satisfy that location. Preserve the existing release as an identical mirror; publish exactly one final dataset.
- Actions: add exact .gitignore exception for 20260917-run/block-0-data-preparation/analysis_ready_data.dta; update README, dataset catalogue, release/package manifests and DAG scope to say clone includes the DTA. Intermediate, actual data and private recovery/seed files remain excluded.
- Validation: DTA remains 86,734,218 bytes with accepted SHA256 975f7d2a4087ea5ee95ba1f59acbfe52f68cb25eea1a9f21ba23e64d3bba0c7c; package hashes and local README links pass. No model rerun, data mutation or Stata change needed.
- Resources: 533 MiB free before staging; one bounded git job, avoid extra DTA copies.
- Preserved unrelated local changes: three earlier agent-history files and docs/release-assets.json.
- Next: stage this exact DTA and related documentation, push/merge correction, verify remote main file path, byte size and git blob identity.
