# B2-01 — Has Indonesian manufacturing actually decarbonised?

## How to run

Same as every other block:

```stata
global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo"   // once per Stata session
do "$B12_REPO/20260917-run/block-b2-01-has-decarbonised/00_run.do"            // all files
do "$B12_REPO/20260917-run/block-b2-01-has-decarbonised/00_run.do" "" 05      // only file 05
do "$B12_REPO/20260917-run/block-b2-01-has-decarbonised/00_run.do" "" paths   // only set paths, then run any file by hand
```

This block uses only the SI panel, so there is no roster path to edit. A full run takes about 10 seconds.
Files 02-13 need `01a_prep_si.do` to have run once.

Results:
- `output/b2_01_tables.xlsx`: every table, 1 sheet = 1 table. Sheet names start with the to-do line number (`t05_...` = line 5).
- `output/fig*.png`: charts. The exact points of each chart are in the sheet `figNN_data` (`fig05s_data` and `fig10_12s_data` for the per-sector charts), ready to redraw in Excel or PowerPoint.
- `data/b201_si.dta`: the working dataset (1 row = firm x year), ready to `browse`.

Close the Excel file before running.

## One file per to-do line (file number = line number)

| # | To-do line | File | Sheets | Status |
|---|---|---|---|---|
| 1 | Has Indonesian manufacturing actually decarbonised? | `01a_prep_si.do` | data prep → `data/b201_si.dta` | ✅ |
| 2 | Elaborate perubahan 2010-2022 untuk: | `02_overview.do` | t02_overview, t02_by_kbli2 | ✅ |
| 3 | Total output dan VA | `03_output_va.do` | t03_total, t03_by_kbli2 | ⚠️ nominal (no deflator) |
| 4 | Total energy use | `04_energy_use.do` | t04_total, t04_by_kbli2 | ⚠️ headline = 4 fuels + purchased electricity; the 2020-form fuels (mostly natural gas) are a variant column only |
| 5 | Scope 1, 2 and total emissions | `05_emissions.do` | t05_total, t05_by_kbli2 | ⚠️ as line 4; scope 2 grid factor held at the 2014 value (sourced variant in the table) |
| 6 | Energy intensity (GJ/VA) dan (GJ/output) | `06_energy_intensity.do` | t06_total, t06_by_kbli2, t06_firm_stats | ⚠️ nominal denominators |
| 7 | Carbon intensity (CO2/VA) dan (CO2/output) | `07_carbon_intensity.do` | t07_total, t07_by_kbli2, t07_firm_stats | ⚠️ nominal denominators |
| 8 | Energy productivity (VA/GJ) | `08_energy_productivity.do` | t08_total, t08_by_kbli2, t08_firm_stats | ⚠️ nominal numerator |
| 9 | Carbon productivity (VA/CO2) | `09_carbon_productivity.do` | t09_total, t09_by_kbli2, t09_firm_stats | ⚠️ nominal numerator |
| 10-12 | Pisahkan perubahan emisi menjadi: / Scale effect: manufacturing menjadi lebih besar / Intensity effect: produksi menjadi lebih clean | `10-12_scale_intensity.do` | t10_12_total, t10_12_by_kbli2 | ⚠️ nominal VA: inflation sits in the scale effect |
| 13 | Output: table dan graph, untuk total dan per sektor | `13_figures.do` (runs last) | fig03 ... fig10_12 (PNG) + figNN_data | ✅ |

`_sumstats.do` is a small helper that writes an n / mean / sd / p10–p90 / min / max table, pooled + by year.

Every table in 03-12 has a total version (`_total`) and a per-sector version (`_by_kbli2`, KBLI 2-digit with English
sector names). Totals and ratios are **aggregates**: sums over firms, and ratios of sums (total GJ / total VA). Files
06-09 also give the distribution across firms (`_firm_stats`, level and ln, pooled + by year).

## Headline (development data, so read direction only)

- 2010 → 2022 (all manufacturing): VA +261% (nominal), total CO2 +281%, CO2/VA +6%, GJ/VA −9%.
- Decomposition, change in ln CO2 2010-2022 = 1.339 = scale 1.283 + intensity 0.056. Within each questionnaire
  period: 2010-2015 intensity +0.327, 2017-2022 intensity +0.655. With nominal VA, even this is an upper bound on "cleaner".
- On these numbers manufacturing has **not** decarbonised: emissions grew at least as fast as nominal VA.

## Gaps and caveats

- **Nominal values.** No deflator has been accepted yet. A fall in GJ/VA or CO2/VA can be price inflation. This limits lines 3 and 6-12.
- **Coverage break 2015 → 2017.** The number of firms and the energy reporting jump (questionnaire change), and there is no 2016 survey.
  Sums over firms move with coverage. `t02_overview` and `t10_12_total` also show the 2010-2015 and 2017-2022 windows.
- **2020 spike.** 2020 scope 1 is 5-7x the 2019 and 2021 values. One plant (KBLI 23) carries 32% of the 2020 clean scope 1 and five plants carry 79%.
  It is in the clean sample (below the 100x-p99 rule), so it stays in, but it drives the 2020 point in every chart.
- **Fuel coverage.** The headline scope 1 is the 4 fuels asked in every year. Block 0's nine fuels and the 2020-form fuels
  (diesel oil, fuel oil, natural gas, with IPCC 2006 default factors, Vol 2 Ch 1) are variant columns in t04/t05.
  They add 61% (2020), 44% (2021) and 22% (2022) to total energy.
- **Corrections in 01a**: 2017 coal divided by 1000; 30 energy-outlier records (`clean = 0`) excluded.
