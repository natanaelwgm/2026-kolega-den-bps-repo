# B1-12 — SOE vs private firms

Row 12 of Deasy's list *List do file yang perlu dibuat* (PIC Toar), on the shared [block 0 dataset](../../20260917-run/block-0-data-preparation/README.md), in the layout of the 20260917-run b1 blocks. Rows 7–16 each have a block in `20261005-run/`; rows 17–21 are in `20260917-run/`.

> **This block cannot produce tables yet.** Block 0 has no central- or local-government ownership share, so an SOE flag cannot be built. `01a_prep_si.do` builds `soe` automatically if `central_govt_pct` and `local_govt_pct` appear in block 0; every other file then runs unchanged. Until then each file prints a message and stops.

## How to run

Same as every other block:

```stata
global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo"   // once per Stata session
do "$B12_REPO/20261005-run/block-b1-12-soe-status/00_run.do"            // all files
do "$B12_REPO/20261005-run/block-b1-12-soe-status/00_run.do" "" 05      // only file 05
do "$B12_REPO/20261005-run/block-b1-12-soe-status/00_run.do" "" paths   // only set paths, then run any file by hand
```

This block uses only the SI panel (block 0), so there is no path to edit. All files need `01a_prep_si.do` to have run once.

Results:
- `output/b1_12_tables.xlsx`: every table, 1 sheet = 1 table. Sheet names start with the line number (`t05_...` = line 5).
- `output/fig*.png`: charts. The exact points of each chart, and the printed labels, are in the sheet `figNN_data`.
- `data/b12_si.dta`: the working dataset, ready to `browse` (not committed).

Close the Excel file before running.

## Reading the row

Line 1 asks to compare SOE vs private, in level and ln, pooled and by year. Every bullet after it is a set of variables to compare across the groups, so each of files 02–09 writes n, mean, sd, p10–p90, min and max of that set by group, pooled and by year (`_sumstats.do`), or the % of firm-years per category within each group (`_shares.do`). For 0/1 variables the mean × 100 is the % of firm-years. Line 01 gives the size of each group and its profile (% exporting, importing, FDI, large, R&D, Java).

## One file per line (file number = line number)

| # | Line | File | Sheets | Status |
|---|---|---|---|---|
| 1 | Elaborate SOE firms vs private firms: dicek original value dan ln, dicek pool dan jg by year | `01a_prep_si.do`, `01_overview.do` | t01_group_share, t01_profile | ❌ no SOE variable in block 0 |
| 2 | TFP (semua) | `02_tfp.do` | t02_tfp | ❌ no SOE variable in block 0 |
| 3 | Value added per worker, value added, output, output per worker, capital, capital per worker, | `03_va_output_capital.do` | t03_va_output_capital | ❌ no SOE variable in block 0 |
| 4 | number of worker, medium vs large firms (>100) | `04_workers_and_size.do` | t04_workers, t04_large_rate, t04_size_class_share | ❌ no SOE variable in block 0 |
| 5 | By sector 2 digit and 5 digit | `05_sector.do` | t05_kbli2_share, t05_kbli5_share, t05_group_by_kbli2 | ❌ no SOE variable in block 0 |
| 6 | Energi use scope 1, 2, total | `06_energy_use.do` | t06_energy, t06_main_src_share | ❌ no SOE variable in block 0 |
| 7 | Emisi 1, 2, total | `07_emissions.do` | t07_emissions | ❌ no SOE variable in block 0 |
| 8 | Location (province, kab kota dan kecamatan kalau ada), dalam Kawasan industry or not | `08_location.do` | t08_java_share, t08_prov_share, t08_group_by_java, t08_kab_share | ❌ no SOE variable in block 0 |
| 9 | RnD | `09_rnd.do` | t09_rnd_rate | ❌ no SOE variable in block 0 |
| 10 | Elaborate bs dengan output stats/stylish facts dalam bentuk table atau dengan graph, atau table yg ready untuk dibuat graph | `10_figures.do` (runs last) | fig01a_group_share, fig01b_profile, fig02_tfp, fig03_va_pw, fig06_energy, fig07_emissions (PNG) + figNN_data sheets | ❌ no SOE variable in block 0 |

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
