# B1-20: What happened during covid

> **Firm links are FICTIONAL in the development data.** Lines 4-7 and 9-16 follow firms across years on
> `firm_id` × `year`. Block 0 simulated these links, so in the development data those results are
> counts on a simulated panel and mean nothing about Indonesian firms. The code is written for the real
> BPS data and only means something there. Lines 2 and 3 use no links.

## How to run

Same as every other block:

```stata
global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo"   // once per Stata session
do "$B12_REPO/20260917-run/block-b1-20-covid/00_run.do"            // all files
do "$B12_REPO/20260917-run/block-b1-20-covid/00_run.do" "" 07      // only file 07
do "$B12_REPO/20260917-run/block-b1-20-covid/00_run.do" "" paths   // only set paths, then run any file by hand
```

No roster is needed. A full run takes a few seconds. Files 02-16 need 01a and 01b; 07 needs 04-06; 15 and 16 need 09-14.

Results:
- `output/b1_20_tables.xlsx`: every table, 1 sheet = 1 table. Sheet names start with the to-do line number (`t07_...` = line 7).
- `output/fig*.png`: charts. The exact points of each chart are in the sheet `figNN_data`.
- `data/b20_si.dta` (firm × year), `b20_firm.dta` (1 row per firm, years present), `b20_flows.dta` (new / survivor / exit per firm × year), `b20_traj.dta` (trajectory of each 2019 firm).

Close the Excel file before running.

## One file per to-do line (file number = line number)

| # | To-do line | File | Sheets | Status |
|---|---|---|---|---|
| 1 | What happened during covid: | `01a_prep_si.do`, `01b_firm_panel.do` | t01_firm_panel; data prep → `data/` | ✅ |
| 2 | Cek data before after covid… compared stats. | `02_before_after.do` | t02_by_period, t02_stats | ✅ |
| 3 | Number of firms by sectors | `03_firms_by_sector.do` | t03_by_sector_year, t03_covid_change | ✅ |
| 4-6 | Siapa yg baru?? / Siapa yg mati?? / Siapa yg bertahan? | `04-06_entry_exit_survival.do` | t04_flows_by_year | ⚠️ fictional links |
| 7 | Cek karakteristiknya: fdi, import, export, medium vs large, Lokasi, all firms characteristics | `07_characteristics.do` | t07_profile, t07_province, t07_stats | ⚠️ fictional links; province only |
| 8 | Elaborate bs dengan output stats/stylish facts dalam bentuk table atau dengan graph, atau table yg ready untuk dibuat graph | `08_figures.do` (runs last) | fig02, fig03, fig04, fig07, fig09, fig15, fig16 (PNG) + figNN_data | ✅ |
| 9-14 | Resilience and recovery trajectories: / Classify firms menjadi: / Disappear in 2020 and never return / Disappear temporarily then return / Survive but shrink / Survive and grow | `09-14_recovery_trajectories.do` | t09_trajectories, t09_traj_by_measure, t09_cohort_presence | ⚠️ fictional links; "temporarily" is empty in dev data |
| 15 | Compare pre covid characteristics: TFP, export import, fdi size, energy intensity, self generation, location | `15_pre_covid_characteristics.do` | t15_profile, t15_stats, t15_province | ⚠️ fictional links |
| 16 | Follow recovery sampai 2022 | `16_follow_recovery.do` | t16_index | ⚠️ fictional links |

`_sumstats.do` is a small helper that writes an n / mean / sd / p10–p90 / min / max table, pooled + by year, optionally by group.

## Definitions (all on `firm_id` × survey year)

There is no 2016 wave, so "previous / next year" means the previous / next **survey** year: 2015 and 2017 count as consecutive.
Presence is counted on all records; characteristics use `clean == 1`.

Lines 4-6, for a firm present in year Y:
- **New (baru):** not present in the previous survey year (split into first time seen / returning after a gap).
- **Survivor (bertahan):** also present in the previous survey year. Every firm in Y is either New or Survivor.
- **Exit (mati):** never present again after Y. **Temporary exit:** absent next survey year, back later.
- Not defined at the window edges: New/Survivor in 2010, Exit in 2022.

Lines 9-14, cohort = firms present in 2019:
1. **Disappear in 2020, never return:** absent in 2020, 2021 and 2022.
2. **Disappear temporarily, return:** absent in 2020, back in 2021 or 2022.
3. **Survive but shrink:** present in 2020 and 2022, workers 2022 < 2019.
4. **Survive and grow:** present in 2020 and 2022, workers 2022 ≥ 2019.
5. Survived 2020, gone by 2022 (present 2020, absent 2022). 6. Survived, size not comparable (workers missing).

Groups 5-6 are needed so every firm is counted. The same split using value added and output is in `t09_traj_by_measure`.

## Gaps against the to-do list

- **Firm links (lines 4-7, 9-16):** fictional in the development data, so these results only mean something on the real BPS data.
- **"Disappear temporarily then return" (line 12):** 0 firms in the development data. Block 0 simulated every firm as present in an unbroken run of years, so no firm has a gap (`t01_firm_panel`, column `with_gap` = 0). This is not a finding. On the real data the same code counts real gaps.
- The simulated links were matched within province × industry cells, so location and sector differences between groups (lines 7, 15) reflect the simulation in the development data.
- **Location (lines 7, 15):** province and Java/outside Java only. District, sub-district and industrial estate are not in block 0.
- "fdi size" in line 15 is read as FDI and firm size (both are in `t15_profile`).

## Notes

- **Corrections in 01a**: 2017 coal divided by 1000; 2020 FDI and 2022 export flag set missing; 30 energy-outlier records (`clean = 0`) excluded from the characteristics.
- Periods: Pre 2017-19, Covid 2020, Recovery 2021-22.
- Line 3 counts all records (not only `clean == 1`).
- All money values are **nominal** (not deflated). In the development data they are also masked, so read direction and pattern, not levels.
- TFP = development residuals; `tfp_op` has far fewer observations than the other three.
