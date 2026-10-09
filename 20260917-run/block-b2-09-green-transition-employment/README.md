# B2-09 — Green transition and employment

## How to run

Same as every other block:

```stata
global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo"   // once per Stata session
do "$B12_REPO/20260917-run/block-b2-09-green-transition-employment/00_run.do"            // all files
do "$B12_REPO/20260917-run/block-b2-09-green-transition-employment/00_run.do" "" 04      // only file 04
do "$B12_REPO/20260917-run/block-b2-09-green-transition-employment/00_run.do" "" paths   // only set paths, then run any file by hand
```

No roster is needed: this block uses only the SI panel (block 0). A full run takes about 10 seconds.
Files 03-12 need 01a and 02 to have run once.

Results:
- `output/b2_09_tables.xlsx`: every table, 1 sheet = 1 table. Sheet names start with the to-do line number (`t04_...` = line 4).
- `output/fig*.png`: charts. The exact points of each chart are in the sheet `figNN_data`, ready to redraw in Excel or PowerPoint.
- `data/b209_si.dta` (firm-years), `data/b209_firm.dta` (1 row per classified firm, first/last values and changes), `data/b209_panel.dta` (firm-years of the classified firms, with their group): ready to `browse`.

Close the Excel file before running.

## The comparison groups (line 2)

Carbon intensity = CO2 (scope 1 + 2, t) / nominal value added. For each firm, take the first and the last year in which
it can be computed, and the change `ln(CO2/VA)_last - ln(CO2/VA)_first`. A firm needs **at least 2 years** with a carbon
intensity. Terciles of that change:

| Group | Rule | Firms (dev data) |
|---|---|---|
| Rapidly falling | bottom third | 1,801 |
| Stable | middle third | 1,800 |
| Rapidly rising | top third | 1,800 |

5,401 of 10,444 firms (52%) can be classified (`t02_coverage`). Every outcome (lines 4-10) is compared between the
**same two years** the firm was classified on: level change `d_*` and ln change `dln_*` (x100 ≈ % change).

## One file per to-do line (file number = line number)

| # | To-do line | File | Sheets | Status |
|---|---|---|---|---|
| 1 | Green transition and employment | `01a_prep_si.do` | data prep → `data/b209_si.dta` | ✅ |
| 2 | Compare firms dengan rapidly falling vs rising carbon intensity | `02_classify_carbon_trend.do` | t02_coverage, t02_groups, t02_ci_by_year | ⚠️ firm links fictional in the dev data |
| 3 | Lihat perubahan: | `03_overview.do` | t03_overview (every outcome × group) | ✅ |
| 4 | Employment | `04_employment.do` | t04_change, t04_levels | ✅ |
| 5 | Production workers | `05_production_workers.do` | t05_change, t05_levels | ⚠️ missing for ~40-47% of firms in 2020 and 2021 |
| 6 | Non production workers | `06_nonproduction_workers.do` | t06_change, t06_levels | ⚠️ = total − production; same 2020/2021 gap |
| 7 | Male/female | `07_male_female.do` | (t07_change, t07_levels when the data exist) | ❌ not in block 0 |
| 8 | Wages | `08_wages.do` | (t08_change, t08_levels when the data exist) | ❌ not in block 0 |
| 9 | VA/workers | `09_va_per_worker.do` | t09_change, t09_levels | ✅ (nominal) |
| 10 | Capital/workers | `10_capital_per_worker.do` | t10_change, t10_levels | ⚠️ many zero-capital records |
| 11 | Question: apakah decarbonisasi berasosiasi dengan employment constraction ayau justru productivity/job expansion | `11_synthesis.do` | t11_synthesis (from 4, 9, 10) | ✅ as an association |
| — | (no figures line; added) | `12_figures.do` (runs last) | fig02, fig03, fig04, fig09, fig10 (PNG) + fig02_data … fig10_data | ✅ |

Helpers: `_sumstats.do` (n / mean / sd / p10–p90 / min / max, pooled + by year, by group; copied from B1-18) and
`_changestats.do` (the same statistics for a firm's change, by group, plus `pct_rose`).

## Gaps against the to-do list

- **Line 2 (and so 3-11):** `firm_id` links across years are **fictional** in the development data. The code is right
  for the real BPS panel, but on the dev data a "firm's change" compares unrelated records, so the groups and every
  change mean nothing yet.
- **Lines 5-6:** `production_workers` **is** in block 0 (the assignment list expected ❌). It is missing for 1,240
  firms in 2020 and 1,441 in 2021; firms whose first or last year falls there without the split drop out of
  `t05_change`/`t06_change`. One record with more production than total workers is set missing.
- **Line 7:** no male/female worker count in block 0. `07_male_female.do` checks for `workers_male` and
  `workers_female`, prints what is missing and writes no table. Needs a gender breakdown from BPS.
- **Line 8:** no wage amount in block 0 (`deflator_wages` is a price index). `08_wages.do` checks for `wage_total`
  (and `wage_prod`, `wage_nonprod`), prints what is missing and writes no table. Needs a wage bill from BPS.
- **Line 10:** capital stock is 0 for many records (the yearly median is 0 in 2017 and 2021), so the ln change only
  covers firms with capital > 0 in both years (≈ 1,900 of 5,401 firms).

## Notes

- **Line 11 is an association, not a causal effect.** VA is in both CO2/VA (the grouping) and VA/worker, so a VA rise
  by itself moves a firm towards "Rapidly falling": the VA/worker gap is partly mechanical. Workers and capital/worker
  are not part of CO2/VA. Workers are whole numbers, so the median change is often 0; read the mean and `pct_rose` too.
- **Energy reporting changes between 2015 and 2017** (dashed line at 2016 in the charts). Changes that span 2016 partly
  reflect the questionnaire.
- **Corrections in 01a**: 2017 coal divided by 1000; 2020 FDI and 2022 export flag set
  missing; 30 energy-outlier records (`clean = 0`) excluded.
- All values are **nominal** (not deflated). In the development data they are also masked, so read direction and
  pattern, not levels.
