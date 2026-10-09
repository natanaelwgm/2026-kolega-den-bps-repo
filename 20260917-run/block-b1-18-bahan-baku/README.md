# B1-18 — Elaborate data bahan baku (raw materials)

## How to run

Same as every other block:

```stata
global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo"   // once per Stata session
do "$B12_REPO/20260917-run/block-b1-18-bahan-baku/00_run.do"            // all files
do "$B12_REPO/20260917-run/block-b1-18-bahan-baku/00_run.do" "" 05      // only file 05
do "$B12_REPO/20260917-run/block-b1-18-bahan-baku/00_run.do" "" paths   // only set paths, then run any file by hand
```

The one path to edit is `global ROSTER` in `00_run.do` (the folder with the Bahanbaku/Proman xlsx files).
A full run takes about 10 seconds. Files 02-19 need 01a-01c and 13 to have run once.

Results:
- `output/b1_18_tables.xlsx`: every table, 1 sheet = 1 table. Sheet names start with the to-do line number (`t05_...` = line 5).
- `output/fig*.png`: charts. The exact points of each chart are in the sheet `figNN_data`, ready to redraw in Excel or PowerPoint.
- `data/b18_si.dta`, `b18_bb_rows.dta`, `b18_bb_firm.dta`, `b18_pm_firm.dta`: working datasets, ready to `browse`

Close the Excel file before running.

## One file per to-do line (file number = line number)

| # | To-do line | File | Sheets |
|---|---|---|---|
| 1 | Elaborate data bahan baku | `01a_prep_si.do`, `01b_prep_bahanbaku.do`, `01c_prep_proman.do` | data prep → `data/` |
| 2 | Desc stats by firms (domestic sourcing vs imports), pool dan yearly | `02_desc_domestic_vs_import.do` | t02_totals, t02_firm_stats, t02_by_importer |
| 3 | siapa yg impor?, dan impornya berapa banyak compared to kebutuhan keseluruhan bahan baku | `03_who_imports.do` | t03_si_by_year, t03_bb_by_year |
| 4 | karakteristik firms yang rely on import: | `04_import_reliance_profile.do` | t04_profile (non-importer / low / high reliance) |
| 5 | apakah mereka fdi firms | `05_fdi.do` | t05_fdi_share, t05_by_fdi |
| 6 | apakah mereka exporting firms | `06_exporter.do` | t06_exporter_share, t06_by_exporter |
| 7 | medium vs large | `07_medium_vs_large.do` | t07_large_share, t07_by_size |
| 8 | sector | `08_sector.do` | t08_sector_mix, t08_by_kbli2, t08_by_kbli5 |
| 9 | Lokasi | `09_location.do` | t09_java_share, t09_by_java, t09_by_province |
| 10 | Firms characteristics: tfp, va, capital dll | `10_firm_characteristics.do` | t10_char_importer |
| 11 | Impor dari mana | `11_import_origin.do` | t11_coverage, t11_origin, t11_origin_by_sector |
| 12 | Elaborate ... dalam bentuk table atau dengan graph | `12_figures.do` (runs last) | fig03, fig04, fig11, fig18, fig19 (PNG) + fig03_data ... fig19_data (the plotted points) |
| 13 | Construct: | `13_construct.do` | builds `data/b18_bb_firm.dta` for lines 14-18 |
| 14 | imported input share/total input | `14_imported_input_share.do` | t14_si_share, t14_bb_share |
| 15 | number/variety of imported inputs | `15_import_variety.do` | t15_variety_stats, t15_variety_dist |
| 16 | domestic/import mix | `16_domestic_import_mix.do` | t16_mix, t16_mix_sector |
| 17 | concentration of imported sourcing | `17_sourcing_concentration.do` | t17_firm_hhi, t17_national_conc |
| 18 | industry dependence on imported materials | `18_industry_dependence.do` | t18_si_sector, t18_bb_sector |
| 19 | compare import/not import: productivity, product scope, export participation, energy/carbon | `19_compare_import_vs_not.do` | t19_productivity, t19_export, t19_energy_carbon, t19_product_scope, t19_premium |

`_sumstats.do` is a small helper that writes an n / mean / sd / p10–p90 / min / max table, pooled + by year, optionally by group.

## Gaps against the to-do list

- **Line 9:** province and Java/outside Java only. District, sub-district and industrial-estate membership are not in the block 0 data.
- **Lines 11 and 17:** the origin country is reported on only 12% (2021) / 32% (2022) of imported rows. Check `t11_coverage` first.

## Notes

- **Kipb is masked in the sample roster files**, so a roster "firm" is currently a cell (year × province × KBLI5). With the real BPS data (Kipb present), `01b`/`01c` switch to Kipb automatically. Roster tables "by firm" (lines 2, 13–17, product scope in 19) are only truly firm-level on the real data.
- **Importer rate jumps between 2015 and 2017** (~25% → ~56%). This is likely a questionnaire change, not a trend.
- **Corrections in 01a**: 2017 coal divided by 1000; 2020 FDI and 2022 export flag set missing; 30 energy-outlier records (`clean = 0`) excluded.
- All values are **nominal** (not deflated). In the development data they are also masked, so read direction and pattern, not levels.
- Some 2022 country codes have no name (e.g. "CODE 146"). This needs the BPS country code list.
