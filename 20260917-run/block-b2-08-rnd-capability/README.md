# B2-08: R&D, innovation and environmental capability

## How to run

Same as every other block:

```stata
global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo"   // once per Stata session
do "$B12_REPO/20260917-run/block-b2-08-rnd-capability/00_run.do"            // all files
do "$B12_REPO/20260917-run/block-b2-08-rnd-capability/00_run.do" "" 05      // only file 05
do "$B12_REPO/20260917-run/block-b2-08-rnd-capability/00_run.do" "" paths   // only set paths, then run any file by hand
```

This block uses only the SI panel (block 0), so there is no path to edit. Files 02-09 need `01a` to have run once.

Results:
- `output/b2_08_tables.xlsx`: every table, 1 sheet = 1 table. Sheet names start with the to-do line number (`t05_...` = line 5).
- `output/fig*.png`: charts. The exact points of each chart are in the sheet `figNN_data`.
- `data/b208_si.dta`: working dataset, ready to `browse`.

Close the Excel file before running.

## One file per to-do line (file number = line number)

| # | To-do line | File | Sheets | Status |
|---|---|---|---|---|
| 1 | R&D, innovation and environmental capability | `01a_prep_si.do` | data prep → `data/b208_si.dta` | ✅ |
| 2 | Untuk tahun Ketika tersedia: | `02_availability.do` | t02_availability, t02_matrix | ✅ |
| 3 | Incidence R&D | `03_rnd_incidence.do` | t03_rnd_by_year, t03_rnd_workers | ⚠️ 2011 + 2017-2022 only; ~45% blank |
| 4 | R&D expenditure/VA | `04_rnd_intensity.do` | t04_coverage, t04_ratio_spenders, t04_cost_vs_flag | ⚠️ 2017-2022; 2018-19 not comparable; unit unverified |
| 5 | Innovation | `05_innovation.do` | t05_innov_by_year, t05_innov_types | ⚠️ 2011, 2017-18, 2020-22; types 2017-18 only; form break after 2018 |
| 6 | AMDAL/environmental management | `06_amdal.do` | t06_env_by_year, t06_env_combo | ⚠️ 2020-2022 only; ~45% blank |
| 7 | Waste management. | `07_waste.do` | t07_waste_by_year | ⚠️ treatment 2020-22; waste types 2022 only, 26% answer |
| 8 | Cross tab dengan export/import/FDI, size, sector dan carbon/energy productivity | `08_crosstabs.do` | t08_by_exporter, t08_by_importer, t08_by_fdi, t08_by_large, t08_by_kbli2, t08_by_q_cprod, t08_by_q_eprod, t08_prod_by_cap | ✅ (no exporter split for waste, see below) |
| — | (no figures line; added) | `09_figures.do` (runs last) | fig02-fig08b (PNG) + fig02_data ... fig08b_data | ✅ |

Helpers: `_sumstats.do` (n / mean / sd / p10-p90 / min / max, pooled + by year, copied from B1-18) and
`_incidence.do` (yes / no / blank table by year + pooled; used by lines 2, 3, 5, 6, 7).

## When each question is asked (line 2)

| Variable | Years | % answering in those years |
|---|---|---|
| R&D activity (`rnd`) | 2011, 2017-2022 | 100% (2011), 46-69% |
| External R&D funding (`rnd_ext`) | 2017-2022 | 38-69% |
| R&D expense (`rnd_cost`) | 2017-2022 | always filled; 0 = none or blank |
| Any innovation (`innov`) | 2011, 2017, 2018, 2020-2022 | 46-68% |
| Product / process / marketing / organisational innovation | 2017-2018 | 46-53% |
| AMDAL, UKL/UPL, SPPL, waste treatment | 2020-2022 | 52-67% |
| Solid / liquid / hazardous waste | 2022 | 25% |

## Gaps against the to-do list

- **Blank ≠ no.** Every `pct_*` / `pct_yes` is "% yes among firms that answered". `pct_yes_all` (yes / all firms) is the lower bound if every blank were a "no".
- **Line 4:** block 0 writes 0 when no R&D expense is reported, so only a positive amount is informative. In 2018 and 2019 about 47% of firms report a positive expense (3-5% in other years), most of them with a blank or "no" R&D answer (`t04_cost_vs_flag`). This is probably a change in the field, not in behaviour. Block 0 also labels the expense unit a "Rp000 candidate", so read R&D/VA as a comparison, not a level.
- **Line 5:** innovation is ~50% in 2017-2018 and ~20% in 2020-2022. The 2017-18 form asks about four innovation types, so this is a questionnaire break, not a trend.
- **Line 7:** the waste-type flags say whether a firm *reports* solid / liquid / hazardous waste. That describes what it produces, not how it manages it. The closest measure of management is the waste installation / treatment question (2020-2022).
- **Line 8:** the 2022 export flag and 2020 FDI are set to missing (see `01a`), so waste (2022 only) has no exporter split, and 2020 is not in the FDI split.

## Notes

- **Corrections in 01a**: 2017 coal divided by 1000; 2020 FDI and 2022 export flag set missing; 30 energy-outlier records (`clean = 0`) excluded.
- `env_doc` = holds AMDAL, UKL/UPL or SPPL (1 if any is yes, missing only if all three are blank). `waste_any` works the same way for the three waste types.
- Productivity quintiles (`q_cprod` = VA/tCO2, `q_eprod` = VA/GJ) are computed within each year on clean records, because values are nominal and the sample changes by year.
- All values are **nominal** (not deflated). In the development data they are also masked, so read direction and pattern, not levels. The cross-tabs are associations: they hold nothing fixed (size, sector, ...).
