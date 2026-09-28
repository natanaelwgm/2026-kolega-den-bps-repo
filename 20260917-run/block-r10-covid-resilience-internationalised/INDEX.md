# R10 — were internationally integrated firms more resilient during COVID: exhibit index

Development data — obscured values, fictional firm panel. Not BPS findings.

Run all: open `00_run.do`, check the two paths at the top, press Do. Each file below also runs on its own.
Item-by-item coverage of Bu Deasy's row and the review record: [TRACKER.md](TRACKER.md).

| File | What it shows | Bu Deasy's words it answers | Status |
|---|---|---|---|
| `01_covid_cohort_groups.do` → `figures/01_covid_cohort_groups.png`, `tables/01_covid_cohort_groups.csv`, `tables/01_covid_cohort_groups_support.csv`, `tables/01_covid_cohort_groups_profile.csv`, `tables/01_covid_cohort_groups_table.pdf` | Who counts as exporter, importer and foreign-owned (10%+ of capital) just before COVID: each firm in the 2019 file that was also in 2017 or 2018 is grouped once from its own 2017–2019 answers. Shows the firms in each group, the firms left out (no known answer), how four other rules change the groups, and (table only) how the three groups overlap. | "Pre-2019 exporter/importer/FDI × Post2020" (the groups), for "Were internationally integrated firms more resilient during COVID?" | done, reviewed |

## Details kept out of the figures

**01 — the groups, fixed before COVID.**
- **Cohort.** The cohort and its later states come from the block "COVID COHORT AND STATES", copied unchanged from R4-01 (`block-r4-covid-survival/01_cohort_states_flow.do`, Version 2). Of the 3,007 firms in the 2019 file, 2,266 were also in the 2017 or 2018 file. They are R10's main sample. The 741 firms first seen in 2019 appear only in the row "Main rule + firms new in 2019".
- **Groups.** They are formed once from the 2017, 2018 and 2019 answers, and later answers never change them. The unusable 2020 foreign-ownership answers are never read. Main rule: in the group if yes in at least half of the known answers, otherwise "other firms". A firm with no known answer is left out, never counted as "no".
- **Main-rule counts.** Exporters 402 / other 1,202 / unknown 662 (29%). Importers 1,329 / 937. Foreign-owned 127 / 2,139.
- **"Other" firms that said yes at least once.** 59 other exporters, 377 other importers and 297 other foreign-owned firms said yes in one of the three files (CSV column `n_other_some_yes`). The stricter rule (always yes vs never yes) leaves them out and is a named check in R10-06. Its foreign-owned group has only 22 firms, too few for estimates.
- **Other rules.** "2017–2018 answers only" (Bu Deasy's literal "pre-2019") gives 346 exporters and 283 foreign-owned firms. "2019 answer only" gives 227 exporters, but the 2019 export answer is unknown for 1,159 firms (51%).
- **Overlap** (table only, not drawn). 65% of exporters and 79% of foreign-owned firms also import. From 2017 the files record far more importers than before (likely a recording change), so 59% of these firms count as importers.
- **Support table** (`_support.csv`). For each group and file 2017–2022 it counts the firms usable for each outcome. There is no productivity residual in 2017. In 2022 the export answer is known only from the direct-export question (1,013 firms; `export_flag` is known for 125, all yes). The smallest main group-file cell is 63 (foreign-owned, 2022).
- **Real files needed.** Firm links are fictional in the development data, so which 2017–18 answers belong to a 2019 firm, and every count of firms leaving the files, means nothing here.
