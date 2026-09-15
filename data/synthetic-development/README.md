**10 September — G0 WPI extension:** [current synthetic pipeline and authoritative DTA](g0-pipeline/README.md). 1,200 rows ×3,837 columns (all3,793 old names +44 explicit additions); actual output WPI integrated, VA single-deflator approximation, unsupported input/capital/wage deflators remain missing. Prior dated states below are preserved as historical context.

**Executed G0 pipeline:** [g0-pipeline/README.md](g0-pipeline/README.md) builds the calculated synthetic DTA/Excel from the initial workbooks. The original schema-example files described below remain unchanged and are never pipeline inputs.

# Excel files you can use now

This directory contains fictional Excel work files so a reviewer or coding agent can inspect the complete input/output interfaces without access to company observations. The original company records were not copied, sampled, perturbed, or used to fit a generator.

**Start with [the G0 Excel](output-excel/G0_analysis_ready_SYNTHETIC_SCHEMA.xlsx), [the original-input Excel directory](input-excel/), and [the latest aggregate G0 report](reports/G0_latest_aggregate_report.xlsx).**

| Files | Actual contents |
|---|---|
| 12 `input-excel/SYNTHETIC_sampel_mfgYYYY_aman.xlsx` files | Original annual headers, 100 invented rows each, 2010–2015 and 2017–2022. No2016 is invented. |
| `input-excel/SYNTHETIC_si2010.xlsx` | Original full2010 reference headers with 200 invented comparison records. |
| `output-excel/G0_analysis_ready_SYNTHETIC_SCHEMA.xlsx` | All 3,793 current G0 column names, 1,200 fictional records, and a full Dictionary sheet. |
| Four `reference-excel/` files | Two original classification XLSX files and two DBF-to-XLSX conversions. Classification codes are retained as strings. These are reference mappings, not fictional company observations. |
| `reports/G0_latest_aggregate_report.xlsx` | Existing latest 13-sheet aggregate G0 report, copied unchanged. Its aggregate counts describe the local source sample, unlike the fictional records in the input/output folders. It does not contain the complete company-level dataset. |

The original company observation files remain local. The current local G0 is 33,049 × 3,793; the downloadable G0 workbook is deliberately a smaller schema fixture. Its 100 companies, locations and economic values are fabricated, with artificial missing and zero cases. Matching values such as calendar years, legitimate code values, and zero are interface/domain constants, not copied company records.

## What this allows you to do

Read all input headers, inspect annual schema changes, write import/merge/export code, explore the full G0 field dictionary, draft Stata do-files, and design checks and report layouts. The first worksheet in every generated data workbook is `Sheet1`, with the original headers on row1. Workbook titles, filenames and first-header comments identify the fixture.

The G0 example reuses the generated annual raw values and explicit field mappings, plus a small set of illustrative accounting/log/worker-ratio values. **It is not the output of an executed full G0 Stata pipeline.** Unconstructed derived quantities stay missing. Unknown source fields contain syntactic placeholders and are not asserted to satisfy all source questionnaire domains. Do not treat populated status/identity fields as evidence that all pipeline checks passed.

Do not infer empirical means, variances, correlations, national totals, TFP or causal coefficients from these fictional records. Do not say that this package validates the real data, WPI, geographic revisions, actual longitudinal IDs, every semantic definition, or the complete DAG. The original G0 caveats remain relevant when moving code into the permitted real-data environment.

## Build and validation

From the repository root:

```sh
python3 harness/build_synthetic_excel.py
```

Normal builds read only the committed header/schema contract and generate new fictional records. The one-time `--capture-contract` option reads the first header row of each original observation workbook, copies published field metadata and the aggregate report, and reads classification reference tables. It never reads observation rows from the original company files. It requires the original local workspace and is not needed by a reviewer cloning this repository.

[release-manifest.json](release-manifest.json) records generated-file hashes, exact reopened rows/columns, unique fixture keys, absence of 2016, formula checks and source-observation/estimator exclusions. It distinguishes file/interface validation from an end-to-end Stata run. [The full schema](schema/G0_analysis_ready_schema.csv) comes from the complete latest local G0 handoff; [the metadata receipt](schema/original_G0_metadata_receipt.json) identifies that original version without including its observations. Stata storage types/formats in the dictionary describe the original interface; Excel does not enforce Stata storage widths.

To run a future isolated Stata test, explicitly map the `SYNTHETIC_` filenames to the expected original input names in a disposable directory, adapt sample-size assertions to the fixture counts, and keep original local data/output paths separate. Never fall back to original company files when a fixture is missing. Record which edges run and verify actual derived outputs before claiming input-to-output equivalence.
