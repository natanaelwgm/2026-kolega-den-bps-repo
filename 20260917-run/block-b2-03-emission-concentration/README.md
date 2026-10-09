# B2-03 — How concentrated are industrial emissions?

## How to run

Same as every other block:

```stata
global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo"   // once per Stata session
do "$B12_REPO/20260917-run/block-b2-03-emission-concentration/00_run.do"            // all files
do "$B12_REPO/20260917-run/block-b2-03-emission-concentration/00_run.do" "" 09      // only file 09
do "$B12_REPO/20260917-run/block-b2-03-emission-concentration/00_run.do" "" paths   // only set paths, then run any file by hand
```

This block uses only the SI panel (block 0), so there is no roster folder to edit.
A full run takes about 15 seconds. Files 02-11 need 01a to have run once; 07 and 10 also need 02-06.

Results:
- `output/b2_03_tables.xlsx`: every table, 1 sheet = 1 table. Sheet names start with the to-do line number (`t09_...` = line 9).
- `output/fig*.png`: charts. The exact points of each chart are in the sheet `figNN_data`, ready to redraw in Excel or PowerPoint.
- `data/b203_si.dta` (plant-year panel), `b203_ranked.dta` (emission rank and top-group flags), `b203_kbli5_pct.dta`, `b203_lorenz_rows.dta`: working datasets, ready to `browse`.

Close the Excel file before running.

## One file per to-do line (file number = line number)

| # | To-do line | File | Sheets | Status |
|---|---|---|---|---|
| 1 | How concentrated are industrial emissions? | `01a_prep_si.do` | data prep → `data/b203_si.dta` | ✅ |
| 2-6 | Hitung share total emissions dari: / Top 1% firms / Top 5% firms / Top 10% firms / Top 20% firms | `02-06_top_emitter_shares.do` | t02_06_top_shares, t02_06_all_records | ✅ |
| 7 | Bandingkan share mereka thd output, VA, employment dan export. | `07_top_emitter_other_shares.do` | t07_other_shares, t07_exporter_rate | ⚠️ export |
| 8 | Within KBLI 5 digit, hitung distribusi dari carbon intensity dan energy intensity (P10, P25, median, P75, P90, P95) | `08_within_kbli5_distribution.do` | t08_kbli5_pool, t08_kbli5_year, t08_spread_summary, t08_all_firms | ✅ |
| 9 | Create gini/Lorenz curve untuk emission | `09_gini_lorenz.do` | t09_gini, t09_lorenz | ✅ |
| 10 | Question: Apakah Indonesia sebenernya hanya perlu menarget relatively small number of highly polluting plants? | `10_synthesis.do` | t10_plants_needed, t10_evidence | ✅ |
| — | (no figures line; added) | `11_figures.do` (runs last) | fig02_06, fig07, fig08, fig09_lorenz, fig09_gini, fig10 (PNG) + fig02_06_data ... fig10_data | ✅ |

`_sumstats.do` is a small helper that writes an n / mean / sd / p10–p90 / min / max table, pooled + by year, optionally by group (used for `t08_all_firms`).

## Headline results (development data)

- The top 1% of emitters (31 plants) hold 70.7% of CO2 in 2022; 67.4% pooled. Top 10%: 92.8% (2022).
- The same top 1% hold 25.6% of output, 20.7% of value added and 6.2% of workers in 2022.
- Gini of plant CO2: 0.92 (2010) to 0.95 (2022), between 0.89 and 0.97 in every year.
- Fewer than 1% of emitting plants hold half of the CO2 in every year except 2010 and 2017 (about 1%).

## Gaps against the to-do list

- **Line 7, export:** block 0 has no export value column. Two proxies are given: (a) the share of the year's
  exporters (count) that are top emitters, with no 2022 (the 2022 form only asks about direct exports, so the
  flag is set missing); (b) an estimated export value = reported export share × output, available on only ~6%
  of records and on none in 2015, 2017 and 2022. Read both as indicative. A real answer needs export value per plant.
- **"Firms" = plants:** the unit is the plant-year. Firm links in the development data are fictional.

## Notes

- **Corrections in 01a**: 2017 coal divided by 1000; 2022 export flag set missing;
  30 energy-outlier records (`clean = 0`) excluded. `t02_06_all_records` shows the shares without the outlier
  filter: in 2015 and 2021 a single outlier record pushes the top-1% share to 93% and 99.5%.
- CO2 = scope 1 (diesel, petrol, coal, LPG: the four fuels asked in every year) + scope 2 (purchased electricity).
- Line 7 shares use a denominator that includes clean plants with no CO2 (they hold output and jobs too).
  Line 8 covers 249 sectors (n ≥ 20) with a median P90/P10 of CO2/VA of 68.3; it does not require workers > 0.
- The energy reporting rate changes between 2015 and 2017 (questionnaire change), so time charts mark 2016
  with a dashed line; there is no 2016 survey.
- All money values are **nominal** and masked: intensities per VA/output show pattern, not levels. Masking adds
  noise per plant, which tends to push the Gini up slightly.
- Thresholds chosen here: top p% = the first ceil(n × p / 100) emitters of the year;
  KBLI5 cells with n < 20 are flagged `few_obs = 1` and left out of `t08_spread_summary`.
