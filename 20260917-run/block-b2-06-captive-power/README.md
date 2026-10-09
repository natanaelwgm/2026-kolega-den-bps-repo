# B2-06 — Captive power / self generation

## How to run

Same as every other block:

```stata
global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo"   // once per Stata session
do "$B12_REPO/20260917-run/block-b2-06-captive-power/00_run.do"            // all files
do "$B12_REPO/20260917-run/block-b2-06-captive-power/00_run.do" "" 05      // only file 05
do "$B12_REPO/20260917-run/block-b2-06-captive-power/00_run.do" "" paths   // only set paths, then run any file by hand
```

This block needs no roster files. A full run takes about 15 seconds. Files 02-11 need `01a_prep_si.do` to have run once.

Results:
- `output/b2_06_tables.xlsx`: every table, 1 sheet = 1 table. Sheet names start with the to-do line number (`t05_...` = line 5).
- `output/fig*.png`: charts. The exact points of each chart are in the sheet `figNN_data`, ready to redraw in Excel or PowerPoint.
- `data/b206_si.dta`: working dataset, ready to `browse`.

Close the Excel file before running.

## One file per to-do line (file number = line number)

| # | To-do line | File | Sheets | Status |
|---|---|---|---|---|
| 1 | Captive power/self generation in Indonesian manufacturing | `01a_prep_si.do` | data prep → `data/b206_si.dta` | ✅ |
| 2 | Elaborate berapa % firms punya: | `02_overview.do` | t02_overview (% of firms with each of lines 3-7, by year) | ⚠️ the columns for lines 4 and 7 are empty (not in block 0) |
| 3 | own generation | `03_own_generation.do` | t03_by_year | ✅ own generation = own-generated kWh > 0 |
| 4 | besarnya generation capacity | `04_generation_capacity.do` | t04_capacity_stats, t04_capacity_owngen (only when the data exist) | ❌ generator kW / count are not in block 0 |
| 5 | own generated electricity | `05_own_generated_kwh.do` | t05_kwh_stats, t05_totals | ✅ |
| 6 | share own electricity thd total electricity | `06_own_share.do` | t06_share_stats, t06_share_bands | ✅ |
| 7 | fuel yg digunakan untuk generator | `07_generator_fuel.do` | t07_genfuel_use (only when the data exist) | ❌ generator fuel is not in block 0 |
| 8 | by sector, sixe, fdi, exporter, importer, province | `08_by_group.do` | t08_by_kbli2, t08_by_size, t08_by_fdi, t08_by_exporter, t08_by_importer, t08_by_province | ⚠️ lines 3, 5 and 6 only (4 and 7 have no data) |
| 9 | pertanyaan: aapakah self generation terutama merupakan resilience strategy? | `09_resilience.do` | t09a_by_java, t09a_by_province, t09b_output_change | ⚠️ descriptive only; (b) needs real firm links |
| 10 | Apakah firms yg selef generate mempunyai scope 1 emissions yg lebih tinggi? | `10_owngen_vs_scope1.do` | t10_s1_by_owngen, t10_regression | ✅ (the generator's own fuel cannot be split out) |
| 11 | (no figures line in the docx; added) | `11_figures.do` (runs last) | fig03, fig06, fig08a, fig08b, fig09a, fig09b, fig09c, fig10 (PNG) + figNN_data | ✅ |

`_sumstats.do` is a small helper that writes an n / mean / sd / p10–p90 / min / max table, pooled + by year, optionally by group.

## Line 9: how the resilience question is answered

Two simple, descriptive tests (decided 9 Oct; nothing in the data records *why* a firm generates):
- **(a) Grid reliability.** Outside Java the grid is weaker. Pooled, 43% of firms outside Java generate their own power against 29% in Java (`t09a_by_java`). Own-generators outside Java also make more of their own power (median share 27% vs 5%). By province, the rate is highest in Riau, Kalimantan, Maluku and Papua (`t09a_by_province`). This fits a resilience/backup motive.
- **(b) Shock performance.** Output change 2019→2020 for firms that generated in 2019 vs firms that did not, with 2018→2019 as a normal-year benchmark (`t09b_output_change`). **The firm links are fictional in the development data**, so this test only means something on the real BPS data.
- Also read `t06_share_bands`: since 2017, 55-80% of own-generators make less than 10% of their electricity themselves (standby-like use).

## Gaps against the to-do list

- **Line 4 (generator capacity):** not in block 0. The raw SI asks generator capacity (kW) and the number of generators in every year (raw variable `mgekwu`). Once block 0 carries `genset_kw` and `genset_n`, `04_` runs as written. Capacity is blank for about half the firms in 2018-2021, so use only firms with a value in the denominator.
- **Line 7 (generator fuel):** not in block 0. The raw SI has fuel-for-electricity columns in every wave (`raw_esolie*`/`raw_esdlie*` diesel, `raw_eclkge*` coal, `raw_elpkge*` LPG, `raw_engkge*` gas 2022). The expected names are `gen_diesel_ltr gen_petrol_ltr gen_coal_kg gen_lpg_kg gen_natgas_m3`.
- **Line 8, province:** only province and Java/outside Java. District is blank in block 0.

## Notes

- **Not asked in 2014-2015:** own generation was not asked for about 1,060 firms per year (block 0 leaves `elec_owngen_kwh` missing). These firms are left out of the denominator, not counted as "no". `t03_by_year` also shows the wrong all-firm rate for comparison.
- **Reporting jump 2015→2017** (own generation ~20% → ~50%, non-PLN purchases too): a questionnaire change, not a trend. Charts mark 2016 with a dashed line.
- **Line 10:** scope 1 = diesel, petrol, coal and LPG (the 4 fuels asked in every year). The generator's fuel is inside these quantities and cannot be separated, so the gap is the whole difference in on-site fuel use. Pooled median scope 1 per worker is 0.44 t for own-generators vs 0.16 t for the rest; the regression gives +84-88% with sector (and size) controls. This is descriptive, not causal.
- **Corrections in 01a**: 2017 coal divided by 1000; 2020 FDI and 2022 export flag set missing; 30 energy-outlier records (`clean = 0`) excluded.
- All kWh, emission and money values are masked in the development data (output is also nominal), so read the direction and pattern, not the levels.
