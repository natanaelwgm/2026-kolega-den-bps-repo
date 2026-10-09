# B1-16 — Elaborate energy use

Row 16 of Deasy's list *List do file yang perlu dibuat* (PIC Toar), on the shared [block 0 dataset](../../20260917-run/block-0-data-preparation/README.md), in the layout of the 20260917-run b1 blocks. Rows 7–16 each have a block in `20261005-run/`; rows 17–21 are in `20260917-run/`.

## How to run

Same as every other block:

```stata
global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo"   // once per Stata session
do "$B12_REPO/20261005-run/block-b1-16-energy-use/00_run.do"            // all files
do "$B12_REPO/20261005-run/block-b1-16-energy-use/00_run.do" "" 05      // only file 05
do "$B12_REPO/20261005-run/block-b1-16-energy-use/00_run.do" "" paths   // only set paths, then run any file by hand
```

This block uses only the SI panel (block 0), so there is no path to edit. All files need `01a_prep_si.do` to have run once.

Results:
- `output/b1_16_tables.xlsx`: every table, 1 sheet = 1 table. Sheet names start with the line number (`t05_...` = line 5).
- `output/fig*.png`: charts. The exact points of each chart, and the printed labels, are in the sheet `figNN_data`.
- `data/b16_si.dta`: the working dataset, ready to `browse` (not committed).

Close the Excel file before running.

## Reading the row

Row 16 has the same shape as row 17 (b1-17, emissions): line 1 asks for energy use scope 1, scope 2 and total, in level and ln, pooled and by year, and every bullet after it (lines 2–11) is a variable to break energy use down by. So each of files 02–11 writes the same statistics (n, mean, sd, p10–p90, min, max of `gj_s1 gj_s2 gj_total ln_gj_s1 ln_gj_s2 ln_gj_total gj_per_va gj_pw`), pooled + by year, by the groups of that line. Continuous variables (TFP, VA, output, capital, CO2) are cut into quintiles **within each year**. The files mirror b1-17 line by line.

## One file per line (file number = line number)

| # | Line | File | Sheets | Status |
|---|---|---|---|---|
| 1 | Elaborate energy use scope 1, scope 2, dan total: dicek original value dan ln, dicek pool dan jg by year | `01a_prep_si.do`, `01_energy_overview.do` | t01_totals, t01_stats, t01_fuel_qty | ✅ |
| 2 | Sumber energi utama | `02_by_main_energy_source.do` | t02_energy_mix, t02_main_src_share, t02_by_main_src | ⚠️ biomass left out (unit kg vs tonne not settled); several fuels are asked only in some years |
| 3 | Sectors disic 2 dan disic 5 | `03_by_sector.do` | t03_kbli2_share, t03_by_kbli2, t03_by_kbli5 (pooled only) | ✅ |
| 4 | TFP (semua) | `04_by_tfp.do` | t04_by_tfp_{op,lp,acf,wrdg}_q | ✅ (tfp_op only 672 firm-years) |
| 5 | Value added per worker, value added, output, output per worker, capital, capital per worker, | `05_by_productivity_and_scale.do` | t05_by_{va_pw,va,output,out_pw,capital,cap_pw}_q | ✅ |
| 6 | number of worker | `06_by_workers.do` | t06_by_size_class, t06_by_large | ✅ |
| 7 | FDI or not | `07_by_fdi.do` | t07_by_fdi | ✅ (2020 excluded) |
| 8 | Export or not, import or not | `08_by_trade.do` | t08_by_exporter, t08_by_importer, t08_by_trade | ✅ (2022 export excluded) |
| 9 | Emisi 1, 2, total | `09_by_emissions.do` | t09_emissions_stats, t09_by_co2_{s1,s2,total}_q | ✅ |
| 10 | Location (province, kab kota dan kecamatan kalau ada), dalam Kawasan industry or not | `10_by_location.do` | t10_by_java, t10_by_province (t10_by_kab only if the district code is filled) | ⚠️ province and Java only: district is blank in block 0; kecamatan and kawasan industri are not in block 0 |
| 11 | RnD | `11_by_rnd.do` | t11_by_rnd | ⚠️ 2017-2022 only, and many records leave the question blank |
| 12 | Elaborate bs dengan output stats/stylish facts dalam bentuk table atau dengan graph, atau table yg ready untuk dibuat graph | `12_figures.do` (runs last) | fig01, fig02, fig03, fig04, fig05, fig06_11, fig09 (PNG) + figNN_data sheets | ✅ |

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
