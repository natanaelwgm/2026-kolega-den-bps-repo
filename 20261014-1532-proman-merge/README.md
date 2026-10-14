# 20261014-1532-proman-merge — production rosters into the ready-to-use file

> **Built and tested on sample / synthetic data only.** Everything here was developed on the sample rosters
> (`Proman2021/2022_sampel.xlsx`, `Bahanbaku2021/2022_sampel.xlsx`, Kipb and district masked) and on test files
> generated from them for 2010–2022, merged into block 0 (obscured values, fictional firm links). The results
> in `output/` describe that development run only.
>
> **At the workshop with the real data, realign the data directories first:** in `00_run.do` → SETTINGS,
> set `PM_RAW` to the folder where the real Proman / Bahan Baku files are given (or copy them into
> `Data Roster Produksi/`), set `PM_MAIN` to the real ready-to-use file (it must carry Kipb for a firm-level
> merge) and check its variable names. Then follow the checklist below, starting with `check`.

This folder merges the two production rosters of the annual manufacturing survey, **Proman** (products:
production value, export share, main destination) and **Bahan Baku** (raw materials: local and imported
value, main origin), into the ready-to-use SI file, for every year that has roster files (2010–2022 except
2016). It is kept apart from the main pipeline: every script and output lives here, and the ready-to-use file
of [block 0](../20260917-run/block-0-data-preparation/README.md) is read, never changed.

The scripts are pure Stata 17 (no Python). They are written for files whose format is not known in advance:
columns are found by their header, never by position or letter case; every change is counted; and the run
stops with a clear message, rather than guessing, when something essential is missing.

## In the data room: checklist

1. Realign the data directory: set `PM_RAW` in `00_run.do` → SETTINGS to the folder of the real roster
   files, or copy them into `Data Roster Produksi/` (sub-folders are fine). Any of `.xlsx`, `.xls`, `.csv`,
   `.dta`; any number of files per year. The name must contain *Proman* / *produksi* or *Bahan Baku*, and the
   year (`Proman2015.xlsx`, `proman_15.csv`), unless the file has a year column.
2. In `00_run.do`, under **SETTINGS**, point `PM_MAIN` at the real ready-to-use file and check the variable
   names (`PM_KIPB`, `PM_MAIN_YEAR`, `PM_MAIN_PROV`, `PM_MAIN_KAB`, `PM_MAIN_KBLI`).
3. Read and map only:
   ```stata
   global B12_REPO "/path/to/2026-kolega-den-bps-repo"
   do "$B12_REPO/20261014-1532-proman-merge/00_run.do" "" check
   ```
   Open `output/intake_report.csv`. For every file check: the sheet and header row found, the rows read, the
   years, and the `mapping` column (item = the header used). If a column is missed or wrong, add its
   normalised header (column `headers`) to the right list in `_column_map.do` and run `check` again.
4. Run everything: `do "$B12_REPO/20261014-1532-proman-merge/00_run.do"`.
5. Read, in this order:
   - `key_by_year.csv`: the merge key of each year and why.
   - `merge_report.csv`: share of firm-years that got roster values; with Kipb `pct_main_one_firm` equals
     `pct_main_matched`.
   - `units_check.csv`: median roster value / SI value per year. A `CHECK UNITS` flag (median below 0.1 or
     above 10) usually means Rp vs Rp 000 in that year.
   - `cleaning_report.csv`: every count of what was changed or dropped, per roster and year.
6. The result is `output/analysis_ready_with_roster.dta`.

## Files

| File | Does | Output (`output/`) |
|---|---|---|
| `00_run.do` | settings; runs everything, `check`, one file (`"" 04`) or `paths` | `proman_merge_log.log` |
| `_column_map.do` | **which header means what** (edit in the room) | |
| `_helpers.do` | programs: reading, header-row detection, column mapping, number and code parsing, notes | |
| `01_intake.do` | finds every file, the best sheet, the header row and the columns; stacks all files as text | `proman_std.dta`, `bahanbaku_std.dta`, `intake_report.csv` |
| `02_clean_proman.do` | codes, numbers, export rules, destination regions | `proman_rows.dta` |
| `03_clean_bahanbaku.do` | codes, numbers, local/imported/total values, origins | `bahanbaku_rows.dta` |
| `04_firm_year.do` | merge key per year; one row per firm (or cell) and year | `key_by_year.csv`, `roster_firm_year.dta` |
| `05_merge.do` | ready-to-use file + roster columns | `analysis_ready_with_roster.dta` |
| `06_checks.do` | match rates, units check, cleaning report | `merge_report.csv`, `units_check.csv`, `cleaning_report.csv` |

## What is handled without editing

- **Files:** Proman or Bahan Baku told apart by the file name; year from the name (`2015`, `15`) or a year
  column (a file may hold several years); several files per year; sub-folders; Excel lock files (`~$...`) and
  other files skipped and listed.
- **Layout:** the sheet with the best header row is chosen; title rows above the header are skipped; empty
  rows dropped; column order and extra columns do not matter.
- **Headers:** upper or lower case, spaces, punctuation and a trailing year (`Nilpro22`, `Volok21`,
  `Kbli522`, `NILAI PRODUKSI`, `B3R307_K5_lokal (Nilai BB Lokal)`) are matched against the lists in
  `_column_map.do`.
- **Numbers:** `1.234.567,89`, `1,234,567`, `12,5`, `45%`, `Rp`, `***`, `-`, `NA`; negative values set
  missing. Export shares written as fractions (0–1) are detected per year (at least 90% of positive shares
  ≤ 1) and multiplied by 100.
- **Codes:** applied identically to the rosters and to the ready-to-use file: Kipb `"000123"`,
  `"123.0"` and `123` are the same firm; province `3`/`03`/`3301` → `03`/`33`; district `3301` → `01`;
  KBLI `10101.0` → `10101`. A province or KBLI written as a name (no digits) is blanked and counted.
- **Text:** upper case and single spaces; `NO`, `INDONESIA`, `DOMESTIK` are not foreign destinations; a
  country name is filled from its code; destination regions accept Indonesian and English names.
- **Missing items:** an optional column that is absent is created empty and listed in the intake report.
  Bahan Baku with only a total value keeps the total; its import share stays unknown.

## The merge key, year by year

`04_firm_year.do` chooses the key of each year (setting `PM_KEY = auto`); a part counts as available when at
least `PM_MIN_FILL` (50%) of the rows have it:

| Key | When | Meaning of the roster values |
|---|---|---|
| `kipb` | Kipb in the ready-to-use file and in every roster of that year | the firm's own values |
| `cell_kab` | otherwise, district on both sides | total of the cell province × district × KBLI5, shared by its firms |
| `cell` | otherwise | total of the cell province × KBLI5, shared by its firms |

`roster_n_main` tells how many firm-years share the values (1 = one firm). In a Kipb year Kipb must be unique
within the year in the ready-to-use file; if not, the run stops and lists the duplicates in
`main_kipb_duplicates.csv`. `PM_KEY = kipb | cell_kab | cell` forces one key for all years.

## What the merged file adds

All rows and columns of the ready-to-use file stay as they are, in the same order; 29 columns are added
(roster values only in years that have roster files; `roster_match` is missing in other years):

| Columns | Content |
|---|---|
| `roster_key`, `roster_key_type`, `roster_match`, `roster_n_main`, `in_proman`, `in_bahanbaku` | merge bookkeeping |
| `pm_n_products`, `pm_n_kbki`, `pm_val_prod`, `pm_core_share`, `pm_hhi` | products, production value, product concentration |
| `pm_exporter`, `pm_n_exported`, `pm_val_export`, `pm_export_share` | exports (value missing if an exported product has no usable share) |
| `pm_n_dest`, `pm_main_dest`, `pm_main_region`, `pm_high_std_share` | destinations; region EU / US / China / ASEAN / Japan / India / Others; EU-27 + EFTA share |
| `bb_n_materials`, `bb_val_local`, `bb_val_import`, `bb_val_total`, `bb_n_only_total`, `bb_import_share` | raw materials, local vs imported |
| `bb_importer`, `bb_n_imported`, `bb_n_origin`, `bb_main_origin` | imported materials and their main origin |

Every added column carries a Stata note with its source.

## Tests (October 2026)

- **Sample files** (2021, 2022; Kipb and district masked): key `cell`; 91–95% of the firm-years get roster
  values, about 15% alone in their cell; units check medians 0.6–0.8.
- **Stress test** on 16 files built from the samples for 2010–2022: title rows and a second sheet, lowercase
  and spaced headers, a semicolon CSV with Indonesian numbers and fraction shares, a `.dta` with numeric codes,
  a sub-folder with a 2-digit year, two years in one file with a year column, Kipb with leading zeros, a Bahan
  Baku file with only totals, a lock file and an unrelated file. All read and mapped correctly; the key came
  out as designed (district cells 2010–15, Kipb 2017–20, cells 2012 and 2021–22).
- **Failure tests:** an unknown value header stops `01` with the headers of the file; a duplicated Kipb stops
  `05` and lists it.

## Notes

- **Values are as reported in the rosters, not masked.** Block 0 holds obscured values (±20–30%) and
  fictional firm links, so the merged development file mixes the two; agree with the data owner before
  sharing results.
- Proman gives one main destination per product, so `pm_n_dest` is a lower bound. Quantities are kept in the
  row files but never summed (units differ by product).
- The roster flag (`Flg21` / `Flagpr22`, R or N) is kept in the row files; its meaning is not documented.
- The cleaning follows the rules of 20260917-run block-b1-19 (Proman), block-b1-18 (Bahan Baku) and
  block-b1-21b (destination regions).
