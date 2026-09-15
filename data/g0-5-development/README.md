# G0.5 v3 — development data with fictional company panels

**G0.5 v3 — 13 September 2026:** 33.049 observasi × **4.396 kolom**, 12 wave, dengan **10.395 perusahaan fiktif** dan **22.654 sambungan antar-wave**. `psid` terisi pada semua observasi; statusnya `synthetic_development`. Provinsi × sektor menjadi batas wajib, dengan sembilan variabel kontinu untuk cluster dan pencocokan satu-ke-satu.

**Development panel is usable now:** `load_data(require_panel=True)` accepts the declared fictional IDs. This repairs v1, which supplied only observation IDs and incorrectly left development `psid` missing. Actual firm linkage remains unverified; actual mode does not inherit fictional IDs. No TFP or other downstream estimator has been run by this repair.

## Workflow outside G0

The identity stage can run **directly from the original Excel files before G0 runs**. If a complete declared G0 company ID is already available, reuse its company associations and privately pseudonymize the source numbers. If none is usable, generate fictional IDs with the nine-variable rule. The accepted current G0 has identity mode `off` and zero populated selected/dummy firm IDs, so this release uses the generation branch.

Keep the identity spine outside G0. After G0 produces its normal output, port the spine by verified source year/row and check province, sector and all nine original features. Then attach only the screened surrogate metadata to G0.5. **G0 code, its output and original Excel files are unchanged.** The workflow never executes G0.

The package stores a private-keyed `dev_identity_key` token and nine normalized `dev_rank_*` fields. These let GPT Pro exactly replay the Excel-stage matching without original Excel values or the private row map. Economic level fields retain the existing 0.1–0.5% disturbances. [Full workflow and commands](../../harness/g05/EXTERNAL-WORKFLOW.md).

## What is in this package

- All 33,049 supplied observations and 4,376 original G0 projection columns, plus twenty observation/panel metadata columns.
- 28 Parquet parts in 12 year folders: 2010–2015 and 2017–2022. There is no 2016.
- 12 smaller, ready-to-open Excel views containing the nine matching variables, province, sector, year, observation ID, fictional firm ID and matching diagnostics. The complete wide data are in Parquet.
- Reproducible generator, source Excel field audit, full linkage checks, replay proof and Stata check.

The existing 0.1–0.5% coherent perturbations are retained exactly. This update changes identity metadata, not the economic measurements again. G0.5 remains actual-derived and private; small perturbations do not guarantee anonymity.

## IDs and the matching rule

| Field | Meaning |
|---|---|
| `obs_id` | Frozen observation ID, unchanged from v1 and shared with the exact actual parent. |
| `psid` | Positive numeric **fictional firm** ID, stable across its simulated trajectory. |
| `psid_status` | `synthetic_development`; never a claim of real entity resolution. |
| `dev_cluster_id` | Cluster within one year and province × sector. It is not a firm ID. |
| `dev_panel_stratum` | Compulsory province × two-digit manufacturing sector. |
| `dev_prev_obs_id`, `dev_prev_year` | Previous supplied observation/year in the simulated trajectory. |
| `dev_link_distance` | Weighted distance between ranked features; at most .25 for accepted links. It is not a probability of real identity. |
| `dev_link_status` | Matched, new, malformed-code isolated, or insufficient-feature isolated. |
| `dev_n_features` | Number of finite nonnegative matching features. |
| `dev_identity_key` | Keyed source-observation token prepared independently of G0; not a raw firm ID. |
| `dev_rank_*` | Nine frozen within-year/sector normalized ranks, used for exact standalone-stage replay. |

All nine selected fields are observed throughout the 12 waves. Their five families each receive 20% total weight, so correlated breakdowns do not dominate merely by being numerous.

| Field | Source-mapping interpretation | Family | Weight |
|---|---|---|---:|
| `workers` | Total workers | employment | 20.00% |
| `gross_output_nominal` | Gross output | scale | 6.67% |
| `value_added_nominal` | Reported value added | scale | 6.67% |
| `intermediate_inputs_nominal` | Intermediate inputs | scale | 6.67% |
| `val_rtlvcu` | Raw materials used | materials | 20.00% |
| `val_efuvcu` | Reported fuel/lubricant expenditure | energy | 10.00% |
| `elec_pln_kwh` | Purchased PLN electricity, kWh | energy | 10.00% |
| `val_zpdvcu` | Production payroll field ZPDVCU (source proxy) | payroll | 10.00% |
| `val_zndvcu` | Nonproduction payroll field ZNDVCU (source proxy) | payroll | 10.00% |

Payroll names remain source proxies; their substantive definitions are not newly certified. Production-worker counts were excluded because one wave has only about 53% coverage.

Rank each feature within year × sector, cluster similar records within the compulsory block, and solve optional one-to-one assignment between adjacent supplied waves. Keep unmatched records as new fictional firms. Two malformed four-digit industry codes receive isolated IDs rather than an invented sector correction. All district codes are masked/missing, so district is not a constraint. Literal province/sector matching does not establish historical boundary or code-vintage equivalence.

See the [complete generator specification](../../harness/g05/PANEL-GENERATOR.md) and [identifier contract](../../docs/DATA-IDENTIFIERS.md).

## Actual generated coverage

5,437 fictional firms span at least two waves; 4,958 occur once; 615 span all 12 supplied waves. Those are properties of this simulation, not estimates of real company survival.

![Aggregate fictional panel diagnostics](panel-diagnostics.svg)

| Transition | Matched pairs | New IDs in receiving wave | Unmatched prior records |
|---|---:|---:|---:|
| 2010 → 2011 | 1,794 | 543 | 540 |
| 2011 → 2012 | 1,810 | 549 | 527 |
| 2012 → 2013 | 1,790 | 579 | 569 |
| 2013 → 2014 | 1,795 | 657 | 574 |
| 2014 → 2015 | 1,885 | 747 | 567 |
| 2015 → 2017 | 2,075 | 1,282 | 557 |
| 2017 → 2018 | 2,378 | 633 | 979 |
| 2018 → 2019 | 2,264 | 743 | 747 |
| 2019 → 2020 | 2,206 | 730 | 801 |
| 2020 → 2021 | 2,284 | 794 | 652 |
| 2021 → 2022 | 2,373 | 804 | 705 |

Unmatched does not mean actual closure. A 2015→2017 link is two calendar years, not an annual lag. Matching on economic variables deliberately creates continuity in them; derived estimates and pretrends are development results only.

## Annual files

| Wave | Rows | Smaller Excel view |
|---|---:|---|
| 2010 | 2,334 | [Excel development](waves/2010/G05-development-panel-2010.xlsx) |
| 2011 | 2,337 | [Excel development](waves/2011/G05-development-panel-2011.xlsx) |
| 2012 | 2,359 | [Excel development](waves/2012/G05-development-panel-2012.xlsx) |
| 2013 | 2,369 | [Excel development](waves/2013/G05-development-panel-2013.xlsx) |
| 2014 | 2,452 | [Excel development](waves/2014/G05-development-panel-2014.xlsx) |
| 2015 | 2,632 | [Excel development](waves/2015/G05-development-panel-2015.xlsx) |
| 2017 | 3,357 | [Excel development](waves/2017/G05-development-panel-2017.xlsx) |
| 2018 | 3,011 | [Excel development](waves/2018/G05-development-panel-2018.xlsx) |
| 2019 | 3,007 | [Excel development](waves/2019/G05-development-panel-2019.xlsx) |
| 2020 | 2,936 | [Excel development](waves/2020/G05-development-panel-2020.xlsx) |
| 2021 | 3,078 | [Excel development](waves/2021/G05-development-panel-2021.xlsx) |
| 2022 | 3,177 | [Excel development](waves/2022/G05-development-panel-2022.xlsx) |

Each year folder also contains its full-width Parquet parts. [Manifest](manifest.json), [schema](schema.json), [dictionary](dictionary.csv) and [all 52,752 variable-year coverage rows](variable-year-coverage.csv) document the complete payload.

## Use and reproduce

```python
from harness.data_source import load_data
panel = load_data(require_panel=True, columns=[
    'obs_id', 'psid', 'psid_status', 'source_year',
    'province_code', 'industry_code', 'workers', 'gross_output_nominal'
])
```

```sh
python3 harness/g05/replay_panel.py --output /local/new-replay-receipt.json
python3 harness/data_source.py --require-panel --columns source_year,psid,psid_status,workers --export /local/G05-development.dta
```

The replay uses only active GitHub data; no original Excel or private key is required. Stata exports use version 118 for this column count, compatible with Stata SE. [Mode selection](../../docs/DATA-MODES.md) uses the same column names and downstream code, while actual mode clears fictional linkage metadata and requires accepted real linkage for actual panel estimates.

## Evidence and boundaries

- [External workflow: cached identity reused; G0 never executed](external-workflow-verification.json).
- [Existing G0 ID inspection](g0-existing-identity-inspection.json).
- [Original Excel field coverage; 12 files unchanged](source-selected-fields.json).
- [Generation, parameters, feature weights and full reorder replay](panel-generation.json).
- [All parts, IDs, links, strata, years and Excel hashes](package-verification.json).
- [Active-package exact assignment replay](panel-replay-verification.json).
- [Actual/development adapter: no fictional IDs copied to actual](adapter-verification.json).
- [Stata: 33,049 observations, 20,579 annual lags and 2,075 two-year gap links](stata-panel-verification.json).
- [Original measurement perturbation receipt](pre-panel-verification.json).

Files named `pre-panel-*` preserve **v1 historical receipts**. Their old part hashes describe the preserved v1, not the current v3 parts. Current consumers use `manifest.json`. Other input requirements—prices, capital concepts, treatment definitions, source coverage—remain module-specific. This package completes the fictional-ID correction; it does not complete the 44 original research requests or resume paused G1.

The [Excel rebuild receipt](excel-view-rebuild-verification.json) verifies the same data values after explicit automatic/full recalculation settings. [Executed source snapshots](../../work-items/G0.5/history/code-at-v3-build/README.md) preserve exact full-build provenance.
