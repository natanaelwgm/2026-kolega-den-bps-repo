## 2026-09-17 11:48 WIB - Publish one final obscured dataset

- Agent/runtime: Codex desktop; gh CLI and Python 3.14, sequential bounded upload/download.
- Root/cwd: /Users/natanaelmassie/Downloads/2026-kolega-den-bps-repo.
- Branch/commit: feat/raw-overall-master; publication preparation follows 42228f7.
- User intent: "ok push aja dia ke main"; corrected "2 dta" because there is one final dataset.
- Interpretation: merge accepted preparation source and dated block documentation to main; publish only analysis_ready_data.dta as the final artifact. Optional pre-G1 DTA stays local.
- Decisions: retain repository convention of Git source plus private Release data. Repository privacy verified true; no collaborators added. Existing PR #1 will carry the accepted source history and publication documentation. Historical raw-to-G1 work remains qualified; this release traces from accepted G0, without claiming a fresh raw Excel reconstruction.
- Actions/files: narrowed published catalogue and PACKAGE manifest to one DTA; added RELEASE.json, exact download command and checksum; preserved intermediate provenance under local_only_intermediates. Updated DAG node scope and guidance. No DTA bytes, Stata labels, values, model results or seed changed.
- Results: draft release 20260917-block-0-data-preparation contains exactly one uploaded asset, id 569469854, 86,734,218 bytes. GitHub SHA256 and an authenticated streamed download both match 975f7d2a4087ea5ee95ba1f59acbfe52f68cb25eea1a9f21ba23e64d3bba0c7c. Package hashes and README local links pass. No new key, encrypted recovery or actual DTA is in this publication.
- Resource use: internal disk about 540 MiB free; stream verification retained no second dataset copy. No worker remains after upload/download completion.
- Preserved unrelated dirty files: agent-history/20260915-2055-overall-raw-rebuild.md, agent-history/20260917-0920-mask-before-g1.md, docs/release-assets.json. They are not staged in this publication commit.
- Blockers: none. At this preparation checkpoint release is still draft and main is not yet updated.
- Next actions: push branch, update/merge PR #1, publish draft targeting merged main commit, verify remote source and release asset access, record final receipt.
