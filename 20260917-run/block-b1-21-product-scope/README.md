# B1-21 — Product scope and product restructuring

## How to run

Same as every other block:

```stata
global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo"   // once per Stata session
do "$B12_REPO/20260917-run/block-b1-21-product-scope/00_run.do"            // all files
do "$B12_REPO/20260917-run/block-b1-21-product-scope/00_run.do" "" 05      // only file 05
do "$B12_REPO/20260917-run/block-b1-21-product-scope/00_run.do" "" paths   // only set paths, then run any file by hand
```

The one path to edit is `global ROSTER` in `00_run.do` (the folder with the Proman2021/2022 xlsx files).
A full run takes about 15 seconds. Files 02-09 need 01a and 01b to have run once; 08 also needs 04.

Results:
- `output/b1_21_tables.xlsx`: every table, 1 sheet = 1 table. Sheet names start with the to-do line number (`t05_...` = line 5).
- `output/fig*.png`: charts. The exact points of each chart are in the sheet `figNN_data`.
- `data/b21_si.dta`, `b21_pm_rows.dta` (1 row = product line), `b21_pm_firm.dta` (1 row = firm-year), `b21_entry_exit.dta` (1 row = continuing firm): working datasets, ready to `browse`.

Close the Excel file before running.

## One file per to-do line (file number = line number)

| # | To-do line | File | Sheets | Status |
|---|---|---|---|---|
| 1 | Product scope and product restructuring: | `01a_prep_si.do`, `01b_prep_proman.do` | data prep → `data/` | ✅ |
| 2 | Construct n-number of product per firms | `02_n_products.do` | t02_n_products, t02_dist | ⚠️ firm = cell until Kipb |
| 3 | Product concentration/HHI | `03_product_hhi.do` | t03_hhi, t03_single | ⚠️ firm = cell until Kipb |
| 4 | Product entry and exit | `04_product_entry_exit.do` | t04_coverage, t04_entry_exit, t04_status | ⚠️ needs Kipb; with cells it mixes product switching with plant turnover |
| 5 | Main/core product share | `05_core_product_share.do` | t05_core_share, t05_core_bins | ⚠️ firm = cell until Kipb |
| 6 | Export share per product | `06_export_share_per_product.do` | t06_exported, t06_share_stats, t06_share_bins, t06_firm, t06_top_products | ✅ (product-line level is unaffected by Kipb) |
| 7 | Export destination. | `07_export_destination.do` | t07_coverage, t07_dest, t07_n_dest, t07_dest_kbli2 | ⚠️ main destination only; 96% of exported lines report one |
| 8 | Compare exporter vs non exporters, importers/non importers, domestic/fdi. | `08_compare_groups.do` | t08_coverage, t08_by_exporter, t08_by_importer, t08_by_fdi, t08_entry_exit, t08_si_prod_innov | ⚠️ importer/FDI only for the ~49% of roster cells that have an SI plant |
| 9 | Questions: apakah internationalisation mengubah what firms produce? | `09_synthesis.do` | t09_synthesis | ⚠️ mostly between-firm evidence; the within-firm part (line 4) needs Kipb |
| — | (no figures line; added) | `10_figures.do` (runs last) | fig02, fig04, fig05, fig06, fig07, fig08 (PNG) + figNN_data |  |

`_sumstats.do` is a small helper that writes an n / mean / sd / p10–p90 / min / max table, pooled + by year, optionally by group.

## Definitions and decisions

- **Product** = 10-digit KBKI code; if blank (~10% of rows), the upper-case product name. Line 4 uses KBKI-coded products only, because names are spelled differently across years.
- **Firm key.** Kipb is masked in the sample files, so `firm_key` = province × KBLI5 cell (`key_type = "cell"`). Unlike b1-18 the year is *not* part of the key, so a cell can be followed from 2021 to 2022. A cell is a weak stand-in for a firm: it pools all plants of that province and KBLI5, so product counts are too high and "entry/exit" also picks up plants entering or leaving the cell/sample. With the real data `01b` switches to Kipb automatically.
- **Exports.** 2021 `Prprex`/`Namaneg` ("NO" = not exported), 2022 `Ekspor`/`Negara`. Blank export share = not exported; 4 shares above 100 capped at 100. 59 lines name a destination but have no export share; they are counted as not exported.
- **Line 8 splits.** Exporter = firm exports at least one product (roster; the SI export flag is missing in 2022). Importer and FDI come from SI 2021-2022 (clean plants), merged on the cell year × province × KBLI5. **Rule: a roster firm is an importer (FDI) if at least half of the SI plants in its cell import (are FDI).** Cells without an SI plant get no status. SI has no Kipb, so this stays a cell merge even on the real data unless BPS provides a Kipb–PSID crosswalk.
- **Extra evidence:** `t08_si_prod_innov` adds block 0's product-innovation question (2017-2018 only) by exporter/importer/FDI, because it is the only product question in SI.

## Gaps against the to-do list

- **Lines 2-5, 9:** true firm-level only with the real Kipb (see above).
- **Line 7:** only one (main) destination per product line is recorded; the firm's number of destinations is a lower bound. Destination structure is block B1-21b.
- **Line 9:** the roster has only 2021-2022, so "does internationalisation *change* what firms produce" can only be read as (a) between-firm differences and (b) one year of entry/exit by 2021 status.

## Notes

- All values are **nominal** and masked in the development data: read patterns, not levels.
- Corrections in 01a: 2017 coal divided by 1000 (for the outlier flag), 2020 FDI and 2022 export flag set missing, 30 energy-outlier records (`clean = 0`) excluded.
- Some destination names are regions ("EROPA BARAT LAINNYA", "LAINNYA") as coded in the roster.
