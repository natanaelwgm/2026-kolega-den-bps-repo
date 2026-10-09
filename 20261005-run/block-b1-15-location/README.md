# B1-15 — Location by province and Java vs outside Java

Row 15 of Deasy's list *List do file yang perlu dibuat* (PIC Toar), on the shared [block 0 dataset](../../20260917-run/block-0-data-preparation/README.md), in the layout of the 20260917-run b1 blocks. Rows 7–16 each have a block in `20261005-run/`; rows 17–21 are in `20260917-run/`.

## How to run

Same as every other block:

```stata
global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo"   // once per Stata session
do "$B12_REPO/20261005-run/block-b1-15-location/00_run.do"            // all files
do "$B12_REPO/20261005-run/block-b1-15-location/00_run.do" "" 05      // only file 05
do "$B12_REPO/20261005-run/block-b1-15-location/00_run.do" "" paths   // only set paths, then run any file by hand
```

This block uses only the SI panel (block 0), so there is no path to edit. All files need `01a_prep_si.do` to have run once.

Results:
- `output/b1_15_tables.xlsx`: every table, 1 sheet = 1 table. Sheet names start with the line number (`t05_...` = line 5).
- `output/fig*.png`: charts. The exact points of each chart, and the printed labels, are in the sheet `figNN_data`.
- `data/b15_si.dta`: the working dataset, ready to `browse` (not committed).

Close the Excel file before running.

## Reading the row

Line 1 asks to compare Java vs outside Java and province, in level and ln, pooled and by year. Every bullet after it is a set of variables to compare across the groups, so each of files 02–10 writes n, mean, sd, p10–p90, min and max of that set by group, pooled and by year (`_sumstats.do`), or the % of firm-years per category within each group (`_shares.do`). For 0/1 variables the mean × 100 is the % of firm-years. Line 01 gives the size of each group and its profile (% exporting, importing, FDI, large, R&D, Java).

## One file per line (file number = line number)

| # | Line | File | Sheets | Status |
|---|---|---|---|---|
| 1 | Elaborate location by province and by java non java: dicek original value dan ln, dicek pool dan jg by year | `01a_prep_si.do`, `01_overview.do` | t01_group_share_java, t01_profile_java, t01_group_share_prov, t01_profile_prov | ✅ |
| 2 | Sectors disic 2 dan disic 5 | `02_sector.do` | t02_kbli2_share_java, t02_kbli5_share_java, t02_group_by_kbli2_java, t02_kbli2_share_prov, t02_kbli5_share_prov, t02_group_by_kbli2_prov | ✅ |
| 3 | TFP (semua) | `03_tfp.do` | t03_tfp_java, t03_tfp_prov | ✅ (nominal development residuals; OP 672 firm-years) |
| 4 | Value added per worker, value added, output, output per worker, capital, capital per worker, | `04_va_output_capital.do` | t04_va_output_capital_java, t04_va_output_capital_prov | ✅ |
| 5 | number of worker | `05_workers.do` | t05_workers_java, t05_size_class_share_java, t05_workers_prov, t05_size_class_share_prov | ✅ |
| 6 | FDI or not | `06_fdi.do` | t06_fdi_rate_java, t06_foreign_share_java, t06_fdi_rate_prov, t06_foreign_share_prov | ✅ (2020 excluded) |
| 7 | Export or not, import or not | `07_export_import.do` | t07_trade_rate_java, t07_trade_profile_share_java, t07_import_value_java, t07_export_share_java, t07_trade_rate_prov, t07_trade_profile_share_prov, t07_import_value_prov, t07_export_share_prov | ✅ (exporter 2022 excluded) |
| 8 | Energi use scope 1, 2, total | `08_energy_use.do` | t08_energy_java, t08_main_src_share_java, t08_energy_prov, t08_main_src_share_prov | ✅ |
| 9 | Emisi 1, 2, total | `09_emissions.do` | t09_emissions_java, t09_emissions_prov | ✅ |
| 10 | RnD | `10_rnd.do` | t10_rnd_rate_java, t10_rnd_rate_prov | ⚠️ 2017-2022 only, and many records leave the question blank |
| 11 | Elaborate bs dengan output stats/stylish facts dalam bentuk table atau dengan graph, atau table yg ready untuk dibuat graph | `11_figures.do` (runs last) | fig01a_group_share_java, fig01b_profile_java, fig03_tfp_java, fig04_va_pw_java, fig08_energy_java, fig09_emissions_java, fig01_group_share_prov, fig03_tfp_prov, fig04_va_pw_prov, fig08_energy_prov, fig09_emissions_prov (PNG) + figNN_data sheets | ✅ |

Helpers: `_sumstats.do` (b1-17's helper: n / mean / sd / p10–p90 / min / max, pooled + by year, optionally by group; a variable is never summarised by itself), `_shares.do` (% of firm-years per category, pooled + by year, optionally within a group) and `_charts.do` (chart programs used by the figures file).

## Definitions

`01a_prep_si.do` is the same file in blocks b1-07 to b1-16 and copies b1-17's, so rows 7–21 use the same numbers:

- **Corrections**: 2017 coal divided by 1000 (block 0 treats it as tonnes; the unit price shows kg); 2020 FDI (and foreign ownership %) and the 2022 exporter flag set missing; the 30 energy-outlier records (`clean = 0`) are left out of every table.
- **Scope 1** = CO2 / GJ of the 4 fuels asked in every year (diesel, petrol, coal, LPG). **Scope 2** = purchased electricity (PLN + non-PLN) with the block 0 grid factor. Own generation is not scope 2.
- **Main energy source** = the source with the largest GJ (12 fuels + purchased electricity; biomass left out).
- **Medium / large**: at most / more than 100 workers. The survey covers firms with 20+ workers.
- **Importer** only where the import question can be evaluated; **FDI** = foreign ownership ≥ 10% (`fdi_any` = any foreign share); **trade profile** needs both an export and an import answer.
- **R&D**: 2017–2022 only (as b1-17).
- **TFP** = block 0's nominal development residuals (OP 672 firm-years, the others about 10,300); the four methods are on different scales.

## Notes

- **Development data.** Values are masked (±20–30%) and nominal, firm links are fictional, TFP is a nominal development residual: read direction and pattern, not levels.
- **2016 has no survey file.** Charts break their lines at 2016 and mark it with a gray **No annual file** band.
- **Energy and importer reporting jump between 2015 and 2017** (questionnaire change, not a trend).
- District (kab/kota) is blank in block 0; kecamatan and kawasan industri are not in block 0.
- Rows 7–16 rebuild an earlier local version (`06-descriptives`, not in the repo) on block 0. That version built its own base from the analytical-DAG staged waves; TFP is now included, while its SOE flag and its two raw capital variables are not in block 0.
