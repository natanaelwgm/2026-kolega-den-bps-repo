# GPT Pro — Deasy–Imed development input

Start with the repository README, `docs/DATA-MODES.md`, your exact original request contract, its latest row plan, and `work-items/G0.5/README.md`.

Use `from harness.data_source import load_data` and call `load_data()` for development. Use the G0.5 package in this directory; do not fetch the retired actual Parquet files from Git history or substitute older synthetic/actual packages. Select columns and years when that reduces memory needs. Verify the package manifest and report the data mode/version in every output.

G0.5 contains 33,049 perturbed records, 4,376 base projection fields and three ID columns. `obs_id` is observation identity; `psid` remains missing because no verified longitudinal company crosswalk is available. Never infer firm identity from row order or use `obs_id` as a firm panel key. Fail explicitly when a module needs an unavailable prerequisite. Treatment categories and timing are not randomly changed.

Implement the analysis body against the shared names/types. Finalisation on the owner's machine switches only the input configuration to the exact accepted local actual parent, reruns all transforms/sample selection/estimation, and validates final results. Development results and fitted models cannot simply be relabelled or translated into actual findings.

This data is actual-derived and not guaranteed anonymous. Its small perturbations are a development convention, not permission to publish it publicly. No credentials, private key or reverse map are needed in a GPT prompt. The work item's requirements for source definitions, genuine panel IDs, prices and specific external inputs still apply.
