# B2-07 — Internationalisation gradient

## How to run

Same as every other block:

```stata
global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo"   // once per Stata session
do "$B12_REPO/20260917-run/block-b2-07-gradient/00_run.do"            // all files
do "$B12_REPO/20260917-run/block-b2-07-gradient/00_run.do" "" 09      // only file 09
do "$B12_REPO/20260917-run/block-b2-07-gradient/00_run.do" "" paths   // only set paths, then run any file by hand
```

This block uses only the SI panel, so there is no roster path to edit. A full run takes a few seconds.
Files 09-11 need 01a and 02-08 to have run once.

Results:
- `output/b2_07_tables.xlsx`: every table, 1 sheet = 1 table. Sheet names start with the to-do line number.
- `output/fig*.png`: charts. The exact points of each chart are in the sheet `figNN_data`.
- `data/b207_si.dta` (prepared SI) and `data/b207_groups.dta` (SI + `group7`): ready to `browse`.

Close the Excel file before running.

## One file per to-do line (file number = line number)

| # | To-do line | File | Sheets | Status |
|---|---|---|---|---|
| 1 | Internationalisation gradient: kelompokkan firms berdasarkan: | `01a_prep_si.do` | data prep → `data/b207_si.dta` | ✅ |
| 2-8 | Domestic only • Exporter only • Importer only • Exporter + importer • Fdi, dan domestic market oriented • Fdi, dan exporter • Fdi, dan exporter + importer | `02-08_gradient_groups.do` | t02_definition, t02_counts, t02_not_classified | ⚠️ 2020 and 2022 cannot be classified; in the other years 29-57% of firms have no export answer |
| 9 | Untuk setiap group, hitung share thd: firms, employment, VA, output, energy, emissions. | `09_group_shares.do` | t09_shares | ⚠️ same coverage gap; shares are of the classified firms |
| 10 | Compare productivity tfp, energy productivity dan carbon productivity | `10_compare_productivity.do` | t10_tfp, t10_energy_prod, t10_carbon_prod, t10_medians | ⚠️ same coverage gap; TFP is a nominal development residual |
| 11 | (no figures line; added) | `11_figures.do` (runs last) | fig02, fig09, fig10 (PNG) + fig02_data, fig09_data, fig10_data | ✅ |

`_sumstats.do` is a small helper that writes an n / mean / sd / p10–p90 / min / max table, pooled + by year, by group.

## The 7 groups (decided 9 Oct, follows the docx)

| Group | FDI | Export | Import |
|---|---|---|---|
| 1 Domestic only | no | no | no |
| 2 Exporter only | no | yes | no |
| 3 Importer only | no | no | yes |
| 4 Exporter + importer | no | yes | yes |
| 5 FDI, domestic market | yes | no | yes or no |
| 6 FDI, exporter | yes | yes | no |
| 7 FDI, exporter + importer | yes | yes | yes |
| Not classified | a flag the group needs is missing | | |

"Fdi, dan domestic market oriented" = FDI that does not export, whether it imports or not. So
FDI firms that import but do not export are in group 5 (FDI, domestic market oriented), as the docx
defines it.

## Gaps against the to-do list

- **2020 and 2022 cannot be classified.** 2020 FDI is set missing (47% FDI is not credible) and the
  2022 export flag is set missing (the form only asks about direct exports). "Pool" therefore means
  2010-2015, 2017-2019 and 2021.
- **The export question is unanswered for many firms in the other years** (29% in 2010, 57% in 2017),
  so only about half of the clean firm-years are classified (see `t02_not_classified`). These firms are
  probably not a random set, so read group shares with care.

## Notes

- Corrections in 01a (copied from b1-18): 2017 coal divided by 1000;
  2020 FDI and 2022 export flag set missing; 30 energy-outlier records (`clean = 0`) excluded.
- Energy productivity = VA / GJ (`va_per_gj`), carbon productivity = VA / tCO2 (`va_per_co2`).
- All values are **nominal**; in the development data they are also masked, so read direction and
  pattern, not levels. TFP = development residuals; `tfp_op` has far fewer observations than the other three.
- The importer rate jumps between 2015 and 2017 (questionnaire change), which moves firms between
  groups 1/2 and 3/4.
