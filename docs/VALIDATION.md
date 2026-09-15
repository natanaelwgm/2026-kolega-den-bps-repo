# Verification status

The source demo was run by clicking Do in the macOS Stata 17 Do-file Editor on 15 September 2026. The Results panel completed with `DEMO_DONE`, and its completion receipt passed: 33,049 rows; 41 primary fits; original selected input values and row order preserved; independently reconstructed own/common residual checks; workbook and figure checks. No bootstrap repetitions were requested in that run.

The new coauthor repository relocates the entry points and packages retained data. Packaging validation and remote asset checks are recorded in `agent-history/`. Do not interpret archive integrity checks as a fresh re-estimation or a full 17-stage G0 raw rebuild.

The retained raw G0 workspace contains sealed original code and frozen input hashes. Historical manifests intentionally retain original absolute paths. The separate replay helper resolves those frozen paths under the downloaded `g0-original/` directory before checking hashes and copying code to a new run folder.
