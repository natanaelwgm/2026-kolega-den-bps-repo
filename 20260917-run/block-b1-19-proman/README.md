# B1-19: Elaborate data Proman (production and exports)

This is the mirror image of B1-18, looking at exports where B1-18 looks at imports.

## How to run

```stata
global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo"   // once per Stata session
do "$B12_REPO/20260917-run/block-b1-19-proman/00_run.do"            // all files
do "$B12_REPO/20260917-run/block-b1-19-proman/00_run.do" "" 05      // only file 05
do "$B12_REPO/20260917-run/block-b1-19-proman/00_run.do" "" paths   // only set paths, then run any file by hand
```

The one path to edit is `global ROSTER` in `00_run.do`. It is the folder that holds the Proman2021/2022 xlsx files.
Files 02-12 need 01a and 01b to have run once. Close the Excel file before running.

Results:
- `output/b1_19_tables.xlsx`: every table, 1 sheet = 1 table. Each sheet name starts with its to-do line number.
- `output/fig*.png`: the charts. The exact points of each chart are in the sheet `figNN_data`.
- `data/b19_si.dta`, `b19_pm_rows.dta`, `b19_pm_firm.dta`: the working datasets, ready to `browse`.

## One file per to-do line (file number = line number)

| # | To-do line | File | Sheets | Status |
|---|---|---|---|---|
| 1 | Elaborate data Proman | `01a_prep_si.do`, `01b_prep_proman.do` | data prep → `data/` | ✅ |
| 2 | Desc stats by firms (domestic oriented vs export), pool dan yearly | `02_desc_domestic_vs_export.do` | t02_totals, t02_firm_stats, t02_by_orient | ⚠️ roster: "firm" = cell while Kipb is masked |
| 3 | siapa yg export?, dan exportnya berapa banyak compared to kebutuhan keseluruhan produksi | `03_who_exports.do` | t03_si_by_year, t03_pm_by_year | ⚠️ SI export share is often missing (see below) |
| 4 | karakteristik firms yang export: | `04_exporter_profile.do` | t04_profile (non-exporter / low / high intensity / share not reported) | ⚠️ most exporters have no reported share |
| 5 | apakah mereka fdi firms | `05_fdi.do` | t05_fdi_share, t05_by_fdi | ✅ (no 2020, 2022) |
| 6 | apakah mereka importing firms | `06_importer.do` | t06_importer_share, t06_by_importer | ✅ (no 2022) |
| 7 | medium vs large | `07_medium_vs_large.do` | t07_large_share, t07_by_size | ✅ (no 2022) |
| 8 | sector | `08_sector.do` | t08_sector_mix, t08_by_kbli2, t08_by_kbli5, t08_pm_by_kbli2 | ✅ |
| 9 | Lokasi | `09_location.do` | t09_java_share, t09_by_java, t09_by_province, t09_pm_by_java, t09_pm_by_prov | ⚠️ province / Java only |
| 10 | Firms characteristics: tfp, va, capital dll | `10_firm_characteristics.do` | t10_char_exporter | ✅ (no 2022) |
| 11 | Export kemana | `11_export_destination.do` | t11_coverage, t11_destination, t11_dest_by_sector | ⚠️ one main destination per product |
| 12 | Elaborate bs ... dalam bentuk table atau dengan graph | `12_figures.do` (runs last) | fig03, fig04, fig08, fig10, fig11 (PNG) + figNN_data | ✅ |

`_sumstats.do` is a small helper. It writes an n / mean / sd / p10-p90 / min / max table, pooled and by year, optionally by group.

## Gaps against the to-do list

- **SI exporter 2022:** the 2022 form asks only about direct exports, so it records no "no" answers. The exporter flag is therefore set missing for 2022, and the SI tables cover 2010-2021. The Proman roster (`t03_pm_by_year`, `t08_pm_*`, `t09_pm_*`) covers 2022.
- **SI export share (lines 3, 4):** `export_share_pct` is valid and positive for only 1,097 records. There are none in 2015, 2017 and 2022, and only 22 in 2013. Read `n_share` before reading a median. Line 4 therefore has a fourth group, "Exporter, share not reported".
- **Line 9:** province and Java/outside Java only. District, sub-district and industrial estate are not in block 0, and Kab is masked in the roster.
- **Line 11:** the roster names one (main) destination per product, so all of a product's exported value goes to that country. 95-96% of exported rows name a destination. "LAINNYA" and "EROPA BARAT LAINNYA" are residual regions.

## Roster cleaning (01b)

- A blank export share means the product is not exported. 2021 also marks non-exporters with `Namaneg == "NO"`.
- A product counts as exported if it has a positive share or a named foreign destination.
- 28 rows from 2021 have `Namaneg == "NO"` but a positive share. They are counted as exported, with destination "(not reported)".
- Shares above 100 (4 rows) are set missing. "INDONESIA" as a destination is blanked. 111 rows from 2021 that give only a country code get their name from other rows with the same code.
- 63 exported rows have no usable share, so their exported value is missing. A firm with such a row has no export share or orientation (`n_share_unknown`).
- **Kipb is masked**, so a roster "firm" is a cell (year × province × KBLI5) until the real data arrive. 01b switches to Kipb automatically.

## Notes

- Export orientation (line 2, roster) and export intensity (line 4, SI) both use a **50% cut-off**. To change it, edit 01b or 01a.
- Corrections in 01a: 2017 coal is divided by 1000, 2020 FDI and the 2022 export flag are set missing, and the 30 energy-outlier records (`clean = 0`) are left out.
- All values are nominal and, in the development data, masked. Read the direction and pattern, not the levels.
- The count of exporters with a reported share leaves out 10 records that have a positive share but no answer on the export question.
