# The active data input is now G0.5

Use [G0.5 development data](../../../data/g0-5-development/README.md): 33,049 rows, 4,379 columns and 12 wave folders. Its [shared loader and actual-mode guide](../../../docs/DATA-MODES.md) replace the previous unchanged-actual default. The `load_data.py` entry point in this folder also delegates to the development default.

This directory retains the original G0 projection metadata and historical receipts. Its 17 actual Parquet parts were retired from the current tree after an exact local backup. [Retirement receipt](retirement.json) lists the retired checksums. The original `manifest.json` remains byte-exact for binding the local actual parent; its part paths refer to that retired release.

The previous actual package and original publication manifest remain in Git at commit `2d5e190f4aa23ae9598a70f9053d7cb3961c0aaf`. No history rewrite occurred. Historical actual aggregate tables remain in the parent release; they are not G0.5 outputs or fallback development inputs.

Development data remain actual-derived and private. `obs_id` is a record surrogate; `psid` is entirely missing until verified company linkage exists. See [ID treatment](../../../docs/DATA-IDENTIFIERS.md).
