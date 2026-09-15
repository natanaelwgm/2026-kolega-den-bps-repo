# Supplementary N08–N13 diagnostic exhibit mapping

G0.5 DEVELOPMENT — perturbed data; not final empirical findings

This registry adds six supplementary diagnostic families, G1-X25–G1-X30. It does not replace or rewrite the original 24 families in `exhibits.csv` and `exhibits.json`. The exact per-method LaTeX table IDs use the final `g1:tab:` namespace supplied by method audit. A native table is marked pending until its source exists. Output receipts, table placements, figure IDs, files, and hashes are recorded in [deep-exhibits.json](deep-exhibits.json).

The 12 aggregate CSVs are screened in `deep-release/outputs/`; the external run keeps record-level intermediates private. Output validation is independent of the nominal fit receipts and does not establish real-primary admission or OP/common estimator support. The appendix also contains explicitly cross-referenced tables from the existing N01/N04/N05 branch; those tables are not relabeled as outputs of N08–N13.

| Supplementary family | Stage | Table IDs | Figure IDs | Status |
|---|---|---|---|---|
| G1-X25 | N08 | g1:tab:deep-input-availability, g1:tab:deep-input-states, g1:tab:deep-input-levels, g1:tab:deep-lp-input-states, g1:tab:deep-op-input-states, g1:tab:deep-acf-input-states, g1:tab:deep-wrdg-input-states | deep_input_availability_core, deep_input_availability_proxy | deep_aggregate_and_publication_artifacts_hash_verified |
| G1-X26 | N09 | g1:tab:deep-funnel, g1:tab:deep-lp-sample, g1:tab:deep-op-sample, g1:tab:deep-acf-sample, g1:tab:deep-wrdg-sample | deep_op_support | deep_aggregate_and_publication_artifacts_hash_verified |
| G1-X27 | N10 | g1:tab:deep-op-scopes, g1:tab:deep-op-quantiles, g1:tab:deep-op-tails, g1:tab:deep-op-annual, g1:tab:deep-lp-scopes, g1:tab:deep-lp-quantiles, g1:tab:deep-lp-tails, g1:tab:deep-lp-annual, g1:tab:deep-acf-scopes, g1:tab:deep-acf-quantiles, g1:tab:deep-acf-tails, g1:tab:deep-acf-annual, g1:tab:deep-wrdg-scopes, g1:tab:deep-wrdg-quantiles, g1:tab:deep-wrdg-tails, g1:tab:deep-wrdg-annual | deep_op_histogram, deep_op_year_sector, deep_lp_histogram, deep_lp_year_sector, deep_lp_year_sector_p2, deep_lp_year_sector_p3, deep_acf_histogram, deep_acf_year_sector, deep_acf_year_sector_p2, deep_acf_year_sector_p3, deep_wrdg_histogram, deep_wrdg_year_sector, deep_wrdg_year_sector_p2, deep_wrdg_year_sector_p3, deep_common_distribution | deep_aggregate_and_publication_artifacts_hash_verified |
| G1-X28 | N11 | g1:tab:deep-op-paired, g1:tab:deep-op-pair-coverage, g1:tab:deep-lp-paired, g1:tab:deep-lp-pair-coverage, g1:tab:deep-acf-paired, g1:tab:deep-acf-pair-coverage, g1:tab:deep-wrdg-paired, g1:tab:deep-wrdg-pair-coverage | deep_op_paired_change, deep_op_paired_change_p2, deep_lp_paired_change, deep_lp_paired_change_p2, deep_lp_paired_change_p3, deep_lp_paired_change_p4, deep_acf_paired_change, deep_acf_paired_change_p2, deep_acf_paired_change_p3, deep_acf_paired_change_p4, deep_wrdg_paired_change, deep_wrdg_paired_change_p2, deep_wrdg_paired_change_p3, deep_wrdg_paired_change_p4 | deep_aggregate_and_publication_artifacts_hash_verified |
| G1-X29 | N12 | g1:tab:deep-op-worked, g1:tab:deep-lp-worked, g1:tab:deep-acf-worked, g1:tab:deep-wrdg-worked | — | deep_aggregate_and_publication_artifacts_hash_verified |
| G1-X30 | N13 | g1:tab:deep-op-bootstrap, g1:tab:deep-lp-bootstrap, g1:tab:deep-acf-bootstrap, g1:tab:deep-wrdg-bootstrap, g1:tab:sensitivity | deep_op_coefficients, deep_op_sensitivity, deep_lp_coefficients, deep_lp_sensitivity, deep_lp_sensitivity_p2, deep_acf_coefficients, deep_acf_sensitivity, deep_acf_sensitivity_p2, deep_wrdg_coefficients, deep_wrdg_sensitivity, deep_wrdg_sensitivity_p2 | deep_aggregate_and_publication_artifacts_hash_verified |

## Related existing-branch tables

| Table ID | Existing source node(s) | Source artifacts | Status |
|---|---|---|---|
| g1:tab:deep-lp-mapping | G1_N01 | nominal/N01_source.dta, nominal-specification.json, stata/methods/METHOD-CONTRACT.md | present |
| g1:tab:deep-op-mapping | G1_N01 | nominal/N01_source.dta, nominal-specification.json, stata/methods/METHOD-CONTRACT.md | present |
| g1:tab:deep-acf-mapping | G1_N01 | nominal/N01_source.dta, nominal-specification.json, stata/methods/METHOD-CONTRACT.md | present |
| g1:tab:deep-wrdg-mapping | G1_N01 | nominal/N01_source.dta, nominal-specification.json, stata/methods/METHOD-CONTRACT.md | present |
| g1:tab:deep-op-regression-common | G1_N04, G1_N05 | release/outputs/nominal_coefficients.csv, release/outputs/nominal_bootstrap_summary.csv | present |
| g1:tab:deep-op-regression | G1_N04, G1_N05 | release/outputs/nominal_coefficients.csv, release/outputs/nominal_bootstrap_summary.csv | present |
| g1:tab:deep-op-attempts | G1_N04 | release/outputs/nominal_coefficients.csv | present |
| g1:tab:deep-op-numerics | G1_N04 | release/outputs/nominal_coefficients.csv | present |
| g1:tab:deep-lp-regression-2 | G1_N04, G1_N05 | release/outputs/nominal_coefficients.csv, release/outputs/nominal_bootstrap_summary.csv | present |
| g1:tab:deep-lp-regression-3 | G1_N04, G1_N05 | release/outputs/nominal_coefficients.csv, release/outputs/nominal_bootstrap_summary.csv | present |
| g1:tab:deep-lp-regression-common | G1_N04, G1_N05 | release/outputs/nominal_coefficients.csv, release/outputs/nominal_bootstrap_summary.csv | present |
| g1:tab:deep-lp-regression | G1_N04, G1_N05 | release/outputs/nominal_coefficients.csv, release/outputs/nominal_bootstrap_summary.csv | present |
| g1:tab:deep-lp-attempts | G1_N04 | release/outputs/nominal_coefficients.csv | present |
| g1:tab:deep-lp-numerics | G1_N04 | release/outputs/nominal_coefficients.csv | present |
| g1:tab:deep-acf-regression-2 | G1_N04, G1_N05 | release/outputs/nominal_coefficients.csv, release/outputs/nominal_bootstrap_summary.csv | present |
| g1:tab:deep-acf-regression-3 | G1_N04, G1_N05 | release/outputs/nominal_coefficients.csv, release/outputs/nominal_bootstrap_summary.csv | present |
| g1:tab:deep-acf-regression-common | G1_N04, G1_N05 | release/outputs/nominal_coefficients.csv, release/outputs/nominal_bootstrap_summary.csv | present |
| g1:tab:deep-acf-regression | G1_N04, G1_N05 | release/outputs/nominal_coefficients.csv, release/outputs/nominal_bootstrap_summary.csv | present |
| g1:tab:deep-acf-attempts | G1_N04 | release/outputs/nominal_coefficients.csv | present |
| g1:tab:deep-acf-numerics | G1_N04 | release/outputs/nominal_coefficients.csv | present |
| g1:tab:deep-wrdg-regression-2 | G1_N04, G1_N05 | release/outputs/nominal_coefficients.csv, release/outputs/nominal_bootstrap_summary.csv | present |
| g1:tab:deep-wrdg-regression-3 | G1_N04, G1_N05 | release/outputs/nominal_coefficients.csv, release/outputs/nominal_bootstrap_summary.csv | present |
| g1:tab:deep-wrdg-regression-common | G1_N04, G1_N05 | release/outputs/nominal_coefficients.csv, release/outputs/nominal_bootstrap_summary.csv | present |
| g1:tab:deep-wrdg-regression | G1_N04, G1_N05 | release/outputs/nominal_coefficients.csv, release/outputs/nominal_bootstrap_summary.csv | present |
| g1:tab:deep-wrdg-attempts | G1_N04 | release/outputs/nominal_coefficients.csv | present |
| g1:tab:deep-wrdg-numerics | G1_N04 | release/outputs/nominal_coefficients.csv | present |
| g1:tab:deep-op-all-support | G1_N04 | release/outputs/nominal_coefficients.csv | present |
