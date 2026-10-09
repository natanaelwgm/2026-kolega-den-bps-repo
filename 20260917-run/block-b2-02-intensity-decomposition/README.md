# B2-02 — Decompose carbon intensity (CO2/VA = GJ/VA × CO2/GJ)

## How to run

Same as every other block:

```stata
global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo"   // once per Stata session
do "$B12_REPO/20260917-run/block-b2-02-intensity-decomposition/00_run.do"            // all files
do "$B12_REPO/20260917-run/block-b2-02-intensity-decomposition/00_run.do" "" 04      // only file 04
do "$B12_REPO/20260917-run/block-b2-02-intensity-decomposition/00_run.do" "" paths   // only set paths, then run any file by hand
```

This block uses only the SI panel, so there is no roster path to edit. A full run takes a few seconds.
Files 01-06 need `01a_prep_si.do` to have run once.

Results:
- `output/b2_02_tables.xlsx`: every table, 1 sheet = 1 table. Sheet names start with the to-do line number.
- `output/fig*.png`: the charts. The exact points of each chart are in the sheet `figNN_data`.
- `data/b202_si.dta`: the working dataset (1 row = firm × year), ready to `browse`.

Close the Excel file before running.

## One file per to-do line (file number = line number)

| # | To-do line (verbatim) | File | Sheets | Status |
|---|---|---|---|---|
| 1 | Decompose carbon intensity (CO2/VA = GJ/VA x CO2/GJ) | `01a_prep_si.do`, `01_decomposition.do` | t01_total, t01_by_kbli2, t01_firm_stats | ✅ |
| 2 | Untuk melihat apakah carbon performance membaik karena: | `02_overview.do` | t02_cumulative, t02_change_split, t02_split_by_kbli2 | ✅ |
| 3 | Firms menggunakan energi lebih sedikit | `03_energy_term.do` | t03_by_year, t03_by_kbli2, t03_firm_stats, t03_by_size | ⚠️ VA is nominal |
| 4 | Energy menjadi lebih clean: compare scope 1 dan scope 2, dan total | `04_clean_energy_term.do` | t04_by_scope, t04_cumulative, t04_by_kbli2, t04_firm_stats | ⚠️ scope 2 = grid factor, flat after 2014 |
| 5 | Untuk melihat apakah manufacturing mengalami efficiency improvement without full decarbonisation | `05_synthesis.do` | t05_synthesis | ⚠️ VA is nominal |
| — | (no figures line; added) | `06_figures.do` (runs last) | fig02, fig03, fig04, fig05a, fig05b (PNG) + figNN_data | ✅ |

`_sumstats.do` is a small helper that writes an n / mean / sd / p10–p90 / min / max table, pooled and by year.

## Main results (development data, so read the pattern, not the levels)

All values are aggregate ratios (total CO2 of all firms / total VA of all firms), clean records, change 2010→2022 in log points:
- CO2/VA +5.6 = GJ/VA −9.5 (less energy per VA) + CO2/GJ +15.1 (energy got dirtier).
- Per worker (no prices): GJ/worker +96, so the "less energy" reading holds only on nominal VA.
- CO2/GJ: scope 1 +13.6, scope 2 +42.3 (grid factor), total +15.1. With the grid factor held constant the total is −5.6.
- Total CO2 +133.9 = scale +128.3 + energy intensity −9.5 + carbon content +15.1. So energy intensity fell
  while emissions rose: "efficiency without decarbonisation". On carbon intensity (CO2/VA) the reading is "neither",
  because CO2/VA rose.
- Sectors (24, 2010→2022, energy intensity vs CO2): 15 efficiency without decarbonisation, 5 decarbonising, 4 neither.

## Gaps against the to-do list

- **Lines 3 and 5:** VA is **nominal** (there is no deflator) and masked. Inflation lowers GJ/VA and raises scale
  by the same amount, so "energy intensity fell" may be partly prices. The per-worker columns (physical) are next
  to the VA ones for this reason.
- **Line 4:** scope 2 CO2/GJ is just the grid factor. Block 0's factor rises 2010-2014 and is **held flat from 2014**,
  so scope 2 after 2014 is an assumption. `t04_by_scope` also gives the total with a static factor (grid held
  constant) and with the sourced annual factor. The sign of "did energy get cleaner" depends on this choice.
- **Reporting break 2015→2017:** energy reporting jumps (questionnaire change). The tables give the windows
  2010-2015 and 2017-2022 separately, and charts mark 2016 with a dashed line.

## Notes

- **Scope 1 = the 4 fuels asked in every year** (diesel, petrol, coal, LPG), with the GJ of the same 4 fuels.
  Scope 2 = purchased electricity. Own generation is in neither, because its CO2 is already in the fuel.
- **Corrections in 01a**: 2017 coal divided by 1000; 30 energy-outlier records
  (`clean = 0`) left out.
- **Added to the b1-18 copy of 01a:** `co2_s2_static`, `co2_s2_sourced`, `co2_total_static`, `co2_total_sourced`,
  `grid_sourced`, `co2_per_gj`, `co2_per_gj_s1`, `co2_per_gj_s2`, `gj_share_s1`, the KBLI 2-digit labels.
- `00_run.do` sets `set type double`, so the identity check columns (`check_identity`, `check_wavg`, `check`) are 0
  to rounding error.
