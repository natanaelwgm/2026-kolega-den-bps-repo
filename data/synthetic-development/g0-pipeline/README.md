# G0: synthetic Excel → Stata preparation with actual WPI → DTA

**The primary downstream output is [G0_analysis_ready_SYNTHETIC_CALCULATED.dta](results/G0_analysis_ready_SYNTHETIC_CALCULATED.dta).** The [Excel workbook](results/G0_analysis_ready_SYNTHETIC_CALCULATED.xlsx) is a readable companion exported from actual Stata calculations. The original `../output-excel/G0_analysis_ready_SYNTHETIC_SCHEMA.xlsx` is still an illustration and is never a pipeline input.

The current contract is **1,200 fictional records, 100 supplied companies, 12 observed years, 3,837 columns**: all **3,793 prior names preserved in order plus 44 documented additions**. Company IDs 800001–800100 remain unchanged across 2010–2015 and2017–2022, with `identity_is_dummy=1`, `identity_real_link_verified=0`. No2016 company observations are created. Actual macro WPI references do not turn these synthetic values into empirical BPS findings.

## Start here for downstream analysis

- [Status of every original Word Data0 component and annual availability](results/ROW0-STATUS.md).
- [Full dictionary](results/actual_schema.csv), [coverage/missing/zero/negative for every variable×year](results/coverage_by_variable_year.csv), [44 new fields](contracts/schema-additions.csv), [storage differences](results/SCHEMA-DIFFERENCES.md).
- [WPI provenance, definitions, classification bridge, splice and exact source gaps](WPI-INTEGRATION.md), [48-cell matched/unmatched audit](results/wpi_merge_audit.csv).
- [Input contract](contracts/INPUT-CONTRACT.md), [output contract](contracts/OUTPUT-CONTRACT.md), [DAG](DAG.md), [process registry](results/process_registry.csv), [run manifest and hashes](results/RUN-MANIFEST.json).

Use `capital_stock_nominal` and `capital_stock_per_worker` for capital-stock candidates, and separate `capital_additions_nominal`/`capital_additions_per_worker` for additions. Legacy `capital_nominal` and `capital_per_worker_nominal` are explicitly labelled mixed aliases. Real output uses the actual output index. `value_added_real` is an explicitly labelled **single-output-deflator approximation**; no input/capital/wage deflator is manufactured.

```stata
use "data/synthetic-development/g0-pipeline/results/G0_analysis_ready_SYNTHETIC_CALCULATED.dta", clear
isid source_year source_row
assert identity_is_dummy==1 & identity_real_link_verified==0
xtset selected_firm_id source_year
```

This is a technical synthetic panel. A successful `xtset` is not proof of real company continuity or an instruction to run estimators.

## Reproduce from the starting Excel files

Requirements: Stata SE/MP17 or newer supporting at least3,837 variables; Python3 with openpyxl and Pillow. From repository root:

```sh
python3 data/synthetic-development/g0-pipeline/run.py
```

There is one primary Stata do-file: [G0_build_synthetic_dataset.do](G0_build_synthetic_dataset.do). The wrapper inspects reference metadata, prepares isolated copies of existing G0 code, runs that primary, validates/publishes actual calculated data with openpyxl and renders bounded workbook previews. Stata computes the analytical variables; Python handles contracts, independent validation and presentation. The primary stops at any failed assertion. Require `G0_SYNTHETIC_FULL_PIPELINE_SUCCESS` in its complete transcript, plus separate WPI application, preparation-case and final-audit receipts. OS exit code alone is insufficient.

Inputs are the12 annual synthetic workbooks and separate200-row `SYNTHETIC_si2010.xlsx`, four classification workbooks, schema contracts and the separately retained [Toar WPI package](references/toar-wpi-20260910/README.md). The separate2010 reference is imported but not appended to the panel. [17 Excel input hashes](contracts/input-manifest.csv), [exact raw header/position map](contracts/excel-field-map.csv), [18 WPI package hashes/provenance](contracts/wpi-source-manifest.json), and [code reuse manifest](contracts/reuse-manifest.csv) make these boundaries explicit. No original company observation file or illustrative output workbook is used as fallback.

The primary reuses annual preservation, mapping, source states, energy, logs and ratios; executes2,796 variable/year nodes and108 working-value nodes; applies WPI after verified annual mapping; refreshes preparation and sensitivity fields; exercises controlled outlier/domain/duplicate-key cases; preserves supplied IDs; enforces the expanded schema; then reopens the final DTA for validation. Each high-level process and annual node has triage/decision and a grain contract. The WPI index is unique on sector/year; firm merges are m:1, never m:m.

## Actual computations and source limitations

Output deflation is `nominal / (WPI/100)` at2000 Rp000, with retained nominal values. Four explicit synthetic activity mappings connect the fixtures to the old WPI classification. All1,200 rows across48 sector/year cells match. 2020–2022 have explicit source-splice flags. VA uses the output deflator as an approximation, not double deflation. Appropriate input/capital/wage price indices remain unavailable.

Logs exclude nonpositive/missing domains. Worker ratios require positive observed counts. The cleaning program preserves all source values and rows; `clean_*` companions form a separate sensitivity sample excluding negative/extreme values. Controlled fixtures actually trigger the inherited annual10×p99 rule, missing/zero/negative handling and duplicate-index rejection. Missing is never quietly set to zero. Capital stock and additions remain distinct, with source-definition caveats.

Energy/CO2 retains the inherited nine-fuel specification, purchased electricity and explicit partial coverage. Self-generated electricity is not added to fuel energy already counted. Full-source completeness remains false: extra fuels/heat, some2018/19 units, post2014 grid carry and additional factors remain open. Labels distinguish nine-component subtotals, reference heat content, CO2 versus full greenhouse-gas CO2e, and sensitivities. Binary directions/definitions that were already provisional remain so. See [component status](results/ROW0-STATUS.md) for exact open cells.

WPI arithmetic checks establish what the delivered references support, not a fresh verification of all source publications.438 monthly rows were recomputed;12 rows lack monthly cells and21 additional newer-subsector monthly rows were not supplied.147 splice cells were reconciled at displayed precision. Source extraction/link-factor uncertainty is retained. No claims about year-FE immunity to sector-specific splice errors are made.

## Outputs, history and prior release

DTA is primary. The12-sheet openpyxl companion includes all columns, a compact analysis view, dictionary, annual coverage, WPI merge/metadata/source gaps, Data0 component status and four Stata charts. Every complete-data workbook cell is independently reopened/compared to the calculated export. [Run manifest](results/RUN-MANIFEST.json) records exact counts/hashes; successful column creation alone is not a source-coverage PASS.

Reruns update only this synthetic pipeline's active outputs. The prior [pre-WPI final files](releases/20260910-pre-wpi/README.md) are retained separately; the entire previous pipeline/intermediates/logs remain at [immutable release7d0d42d8](https://github.com/natanaelwgm/deasy-imed-si-research-2026/tree/7d0d42d82de4d1f6a7af3b3eb3568c1b92587387/data/synthetic-development/g0-pipeline). Failed-run logs stay under `dag/logs/attempts/`. [Current agent history](../../../agent-history/20260910-1400-g0-wpi-preparation.md) records decisions and publication receipts. Historical `research/1014/` and other agents' changes are preserved.

Completion here means **the synthetic G0 pipeline with a usable output WPI branch has run and its remaining source limitations are explicit**. It does not mean every original-company data requirement, source index, annual definition or downstream analysis has been completed. No TFP or substantive regression was run.
