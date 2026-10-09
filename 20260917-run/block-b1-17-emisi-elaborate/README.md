# B1-17 — Elaborate emisi (emissions)

## How to run

Same as every other block:

```stata
global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo"   // once per Stata session
do "$B12_REPO/20260917-run/block-b1-17-emisi-elaborate/00_run.do"            // all files
do "$B12_REPO/20260917-run/block-b1-17-emisi-elaborate/00_run.do" "" 05      // only file 05
do "$B12_REPO/20260917-run/block-b1-17-emisi-elaborate/00_run.do" "" paths   // only set paths, then run any file by hand
```

This block uses only the SI panel (block 0), so there is no path to edit. A full run takes about 15 seconds.
Files 01-12 need `01a_prep_si.do` to have run once.

Results:
- `output/b1_17_tables.xlsx`: every table, 1 sheet = 1 table. Sheet names start with the to-do line number (`t05_...` = line 5).
- `output/fig*.png`: charts. The exact points of each chart are in the sheet `figNN_data`, ready to redraw in Excel or PowerPoint.
- `data/b17_si.dta`: the working dataset, ready to `browse`.

Close the Excel file before running.

## Reading the row

Line 1 asks for emissions scope 1, scope 2 and total, in level and ln, pooled and by year. Every bullet after it
(lines 2-11) is a variable to break those emissions down by. So each of files 02-11 writes the same statistics
(n, mean, sd, p10-p90, min, max of `co2_s1 co2_s2 co2_total ln_co2_s1 ln_co2_s2 ln_co2_total co2_per_va co2_pw`),
pooled + by year, by the groups of that line. Continuous variables are cut into quintiles **within each year**.

## One file per to-do line (file number = line number)

| # | To-do line | File | Sheets | Status |
|---|---|---|---|---|
| 1 | Elaborate emisi scope 1, scope 2, dan total: dicek original value dan ln, dicek pool dan jg by year | `01a_prep_si.do`, `01_emissions_overview.do` | t01_totals, t01_stats | ✅ |
| 2 | Sumber energi utama | `02_by_main_energy_source.do` | t02_energy_mix, t02_main_src_share, t02_by_main_src | ⚠️ biomass left out (unit kg vs tonne not settled); several fuels are asked only in some years |
| 3 | Sectors disic 2 dan disic 5 | `03_by_sector.do` | t03_kbli2_share, t03_by_kbli2, t03_by_kbli5 (pooled only) | ✅ |
| 4 | TFP (semua) | `04_by_tfp.do` | t04_by_tfp_{op,lp,acf,wrdg}_q | ✅ (tfp_op only 672 firm-years) |
| 5 | Value added per worker, value added, output, output per worker, capital, capital per worker, | `05_by_productivity_and_scale.do` | t05_by_{va_pw,va,output,out_pw,capital,cap_pw}_q | ✅ |
| 6 | number of worker | `06_by_workers.do` | t06_by_size_class, t06_by_large | ✅ |
| 7 | FDI or not | `07_by_fdi.do` | t07_by_fdi | ✅ (2020 excluded) |
| 8 | Export or not, import or not | `08_by_trade.do` | t08_by_exporter, t08_by_importer, t08_by_trade | ✅ (2022 export excluded) |
| 9 | Energy use 1, 2, total | `09_by_energy_use.do` | t09_energy_stats, t09_by_gj_{s1,s2,total}_q | ✅ |
| 10 | Location (province, kab kota dan kecamatan kalau ada), dalam Kawasan industry or not | `10_by_location.do` | t10_by_java, t10_by_province (t10_by_kab only if the district code is filled) | ⚠️ province and Java only: district is blank in block 0, sub-district and industrial estate are not in block 0 |
| 11 | RnD | `11_by_rnd.do` | t11_by_rnd | ⚠️ 2017-2022 only, and about half of records leave the question blank |
| 12 | Elaborate bs dengan output stats/stylish facts dalam bentuk table atau dengan graph, atau table yg ready untuk dibuat graph | `12_figures.do` (runs last) | fig01, fig02, fig03, fig04, fig05, fig06_11, fig09 (PNG) + figNN_data sheets | ✅ |

`_sumstats.do` is a small helper that writes an n / mean / sd / p10–p90 / min / max table, pooled + by year, optionally by group.

## Definitions

- **Scope 1** = CO2 of the 4 fuels asked in every year (diesel, petrol, coal, LPG). **Scope 2** = purchased electricity
  (block 0 grid factor). Own generation is not scope 2.
- **Main energy source** (line 2) = the source with the largest GJ of the firm, out of 12 fuels + purchased electricity.
  The 2020+ fuels (diesel oil, fuel oil, natural gas, biodiesel) get GJ per unit from the IPCC 2006 default net calorific values (Vol 2 Ch 1, Table 1.2).
- **Quintiles** (lines 4, 5, 9) are within each year. For lines 5 and 9 they are among firms with a positive value;
  zero/negative values are a separate group.
- **Size classes** (line 6): <20, 20-49, 50-99, 100-499, 500+ workers; medium/large at 100 workers (as b1-18).

## Checks done (Oct 2026)

- Full run, single file (`"" 12`) and `paths` + a file by hand: no errors.
- `clean` gives 33,019 records (30 outliers).
- Main energy source leaves biomass out: its unit is not settled, and with the kg column read as tonnes (1000x too
  much GJ) biomass would "win" for 1,458 firm-years. Without biomass those firms move to their next source.

## Notes

- **Energy and importer reporting jump between 2015 and 2017** (questionnaire change, not a trend). Time charts mark 2016.
- **2016 has no survey file.** FDI 2020 and exporter 2022 are set missing (see `01a`).
- All values are **nominal** and masked in the development data: read direction and pattern, not levels.
  "CO2 per VA" in the charts is multiplied by 1,000,000.
- TFP = block 0's nominal development residuals; the four methods are on different scales.
- Firm links across years are fictional in the development data (not used in this block).
- The district (kabupaten) code is blank in this release.
