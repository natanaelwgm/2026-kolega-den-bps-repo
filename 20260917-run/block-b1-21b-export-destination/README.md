# B1-21b — Export destination structure

## How to run

Same as every other block:

```stata
global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo"   // once per Stata session
do "$B12_REPO/20260917-run/block-b1-21b-export-destination/00_run.do"            // all files
do "$B12_REPO/20260917-run/block-b1-21b-export-destination/00_run.do" "" 03      // only file 03
do "$B12_REPO/20260917-run/block-b1-21b-export-destination/00_run.do" "" paths   // only set paths, then run any file by hand
```

The one path to edit is `global ROSTER` in `00_run.do` (the folder with the Proman xlsx files).
Files 02-05 need 01a and 01b to have run once (04 also uses `data/b21b_firm_conc.dta` from 03).

Results:
- `output/b1_21b_tables.xlsx`: every table, 1 sheet = 1 table. Sheet names start with the to-do line number (`t03_...` = line 3).
- `output/fig*.png`: charts. The exact points of each chart are in the sheet `figNN_data`, ready to redraw in Excel or PowerPoint.
- `data/b21b_si.dta`, `b21b_pm_rows.dta`, `b21b_firm_conc.dta`, `b21b_cells.dta`, `b21b_si_matched.dta`: working datasets, ready to `browse`.

Close the Excel file before running.

## One file per to-do line (file number = line number)

| # | To-do line | File | Sheets | Status |
|---|---|---|---|---|
| 1 | Export destination structure: | `01a_prep_si.do`, `01b_prep_proman.do` (+ country → region map) | data prep → `data/`; t01_country_map | ✅ |
| 2 | Tujuan utama ekspor by firms/sektor: EU, US, China, ASEAN, Japan, India, others? | `02_main_destination.do` | t02_coverage, t02_region_share, t02_firm_main_region, t02_firm_any_region, t02_region_by_kbli2 | ⚠️ |
| 3 | Export concentration index/ diversification of destinations | `03_destination_concentration.do` | t03_firm_conc, t03_ndest_dist, t03_sector_conc, t03_national_conc | ⚠️ |
| 4 | Compare characteristics firms exporting ke advanced/high environmental standard market vs to other market à untuk mengetahuin foreign climate pressure. | `04_high_standard_markets.do` | t04_groups, t04_roster_char, t04_si_match, t04_si_char, t04_si_char_exp, t04_si_shares | ⚠️ |
| — | (no figures line; added) | `05_figures.do` (runs last) | fig02, fig02b, fig03, fig04 (PNG) + fig02_data, fig02b_data, fig03_data, fig04_data | ✅ |

`_sumstats.do` is a small helper that writes an n / mean / sd / p10–p90 / min / max table, pooled + by year, optionally by group.

## Definitions

- **Exported product**: a destination country is named, or the export share is > 0. Export value = production value × export share / 100. Export shares above 100 (4 rows in 2021) are set missing. 2021 marks non-exporters with `NO`; `INDONESIA` as destination is treated as not exported.
- **Regions** (`01b`, editable `replace region = ... if inlist(...)` lines): EU = EU-27; US (incl. Guam and US minor islands); China (Hong Kong and Taiwan in Others); ASEAN = the 9 members other than Indonesia (Timor-Leste in Others); Japan; India; Others.
- **High-standard market** = EU-27 + EFTA (Iceland, Liechtenstein, Norway, Switzerland), decided 9 Oct 2026. The UK is not included.
- **Line 4 groups**: `hs_market` = 1 if the firm has at least one product whose main destination is EU+EFTA, 0 if it exports only elsewhere. `mkt3` also splits off firms that export to both.
- **Merge rule, line 4**: roster → SI on the cell (year × province × KBLI5). Every SI firm (clean == 1) in an exporting cell gets that cell's group. 70% of EU+EFTA cells and 63% of other cells contain at least one SI firm (`t04_si_match`).

## Gaps against the to-do list

- **Line 2, 3, 4: one destination per product.** Proman records only the *main* destination of each product, so a firm's number of destinations is a lower bound and a product sold to both the EU and ASEAN counts only for its main market.
- **Kipb is masked**, so a "firm" is a cell (year × province × KBLI5). The by-firm tables become firm-level automatically once Kipb is present (`firm_key`, `key_type`). For line 4, the SI characteristics then belong to every SI firm in the cell, not only the exporter. `t04_si_char_exp` repeats the comparison for SI firms that report exporting themselves (2021 only, because the 2022 SI export flag is missing).
- **Coverage**: 96% of exported products name a destination (`t02_coverage`).
- **BPS aggregate destinations cannot be placed in a region** and are in Others / not high-standard: `EROPA BARAT LAINNYA` (43 rows; could partly be EU/EFTA), `LAINNYA` (31), `ASIA SELATAN DAN TENGGARA LAINNYA` (6, could partly be ASEAN), `ASIA UTARA LAINNYA` (4), `AFRIKA LAINNYA` (2), `AMERIKA TENGAH DAN SELATAN LAINNYA`, `AMERIKA UTARA LAINNYA`, `ASIA BARAT LAINNYA`, `ANTARTIKA` (1 each). Every name and its region is in `t01_country_map`.
- No environmental-stringency index is used; "high standard" is a grouping by market.

## Notes

- 2021 rows flagged `N` (`Flg21`) carry a country code but no name; the name is filled from rows with the same code (118 rows). No code was left unnamed.
- Values are **nominal** and, in the development data, masked. A few large products drive the value shares (e.g. China at 43% of 2021 export value). Product and firm counts (`share_products_pct`, `t02_firm_*`) are more stable.
- **Corrections in 01a** are the same as in block-b1-18: 2017 coal divided by 1000; 2020 FDI and 2022 export flag set missing; 30 energy-outlier records (`clean = 0`) excluded.
