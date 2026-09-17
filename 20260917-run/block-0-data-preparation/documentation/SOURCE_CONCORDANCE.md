# Source concordance

The public entry points use descriptive names. The underlying calculations
retain their original source files, execution order and validation checks.

| Current entry point | Original stage | Source within this repository |
|---|---|---|
| `01_clean_data.do` | G0 + analytical projection | `overall/` and `downstream/code/` |
| `02_obscure_values.do` | G0.25 | `downstream/obscure/strong/` |
| `03_construct_panel.do` | G0.5 | `harness/g05/panel_generator.py` and the identity stage in masking |
| `04_estimate_productivity.do` | G1 + variable metadata | `work-items/G1/stata/`, `downstream/g025_to_g1/`, `downstream/metadata/` |

[source_concordance.csv](source_concordance.csv) records the current step,
original stage, repository source path, original local path, source hash and
base commit. It also records the original local file hash and whether the local
and repository versions are identical. The source hash identifies the exact file contents, including
changes made after the base commit. Paths are provenance records; coauthors do
not need to reproduce the owner's absolute folder paths.

The four entry points coordinate the retained scientific source code. They do
not duplicate or replace all underlying calculations in a second implementation.
For example, the 2013 `vtlvcu` mapping is in
[`val_vtlvcu_2013.do`](../../../overall/g0-source/code/leaves/mapped/val_vtlvcu_2013.do).

Raw Excel files are imported before the clean dataset is constructed. Numeric
obscuring precedes fictional panel construction. Productivity is re-estimated
on that same panel, then labels and definitions are applied without changing
values. No second obscuring pass is applied after estimation.

The original local research checkout is
`/Users/natanaelmassie/Downloads/1014-github-completeness-20260913/repo`,
at source commit `f021c1912d0c80b8c168ca0f23ec575ba036a7d0`. The original
cleaning foundation is under
`/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2`.
Later obscuring and metadata code was developed in this coauthor repository.
