# Native Stata ready-data ZIP exporter

Timestamp: 14 October 2026, 18:10 WIB (Asia/Jakarta). Agent/runtime: si-astra-max, Codex GPT-6 Astra max. Repository root/cwd: 2026-kolega-den-bps-repo, isolated worktree kolega-ready-publish. Branch: feat/native-ready-zip-20261014. Parent source commit: 096894f64fb843007e432d7fa3789a9ebdf11b17 (Toar PR 13); prior main: b0b536b1266eb6a84dc639056b148c32cf530eea.

The owner approved the small native Stata ZIP, asked to reproduce it from the repository, explicitly authorized publication to main, and made this the first priority. The earlier discussion-only hold is superseded for this change. The existing development DTA on main is identical to the ZIP input; no new dataset is added.

Changes: integrate the existing Toar descriptive branch; retain twelve tested master-entry path/argument fixes; add a standard-library Python exporter, native-master generator, 34-module recipe and pinned SSC add-ons with source attribution. Export filters to top-level analysis source files and the declared add-ons/data. It omits PDF presentation statements only in exported copies. The original model calculations, samples, seeds and repetitions are unchanged. The package runs directly through 00_JALANKAN_SEMUA.do with SI_ROOT and READY_DATA; no Python is needed after export.

Validation: all 466 exported analysis sources and the native entry are byte-identical to the owner's delivered ZIP; all 733 runtime/input/guide files match, with only two provenance manifests changing. Same 735 archive paths, CRC pass, fresh extraction pass; five focused tests pass. See distribution/ready-stata/VALIDATION.md. No new full analytical rerun was required for identical runtime bytes. Windows remains untested directly.

Publication plan: reviewed branch/PR into main, then publish the generated ZIP as a private repository release and verify the downloaded asset. No workflow or required check is introduced. No raw input, private seed, credentials, chat history or local configuration is staged.

Pinned third-party add-ons retain their original upstream whitespace. A narrow .gitattributes rule preserves their bytes across Git line-ending conversion and marks them as vendored; authored-code whitespace checks pass. Repeated exports are byte-identical, and the optional data-free export contains no DTA and accurately describes its input requirement.
