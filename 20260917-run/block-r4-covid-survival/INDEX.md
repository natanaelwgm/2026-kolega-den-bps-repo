# R4 — COVID: which firms left the file, came back, shrank or grew: exhibit index

Development data — obscured values, fictional firm panel. Not BPS findings.

Run all: open `00_run.do`, check the two paths at the top, press Do. Each file below also runs on its own.
Item-by-item coverage of Bu Deasy's row and the review record: [TRACKER.md](TRACKER.md).

| File | What it shows | Bu Deasy's words it answers | Status |
|---|---|---|---|
| `01_cohort_states_flow.do` → `figures/01_cohort_states_flow.png`, `tables/01_cohort_states_flow.csv`, `tables/01_cohort_states_flow_table.pdf` | The 3,007 firms of the 2019 file, looked up in the 2020, 2021 and 2022 files: how many stayed in all three (split by whether workers grew, stayed within 10% or shrank), came back after a gap, or left; plus the firms that first appear in 2020–22. Counts that add up to the 2019 firms. | "Impact covid: Survival analysis??", "Which firms survived"; "multinomial outcomes: exit, temporary disappearance, survive-shrink, survive-grow"; "Melihat firms yg bertahan, mati dan hidup selama shock covid" | done (read on the real files) |

## Details kept out of the figures

**01 — the 2019 firms.**
- Every firm in the 2019 file, the last before COVID, is followed through the next three files.
- Dev data: 1,678 (55.8%) were in all three. Of these, 541 had more workers in 2022 than in 2019 by over 10%, 202 were
  within 10%, and 935 had fewer by over 10%. For output (current prices; no deflator in this file) the split is
  578 / 133 / 967, shown in the table.
- None came back after a gap. 808 (26.9%) were in none of the three later files, and 521 (17.3%) left later.
- 737, 789 and 812 firms first appear in 2020, 2021 and 2022.
- "Left" means not in the 2022 file. It is not proof of closure: the files record no closures, and a firm may have
  closed, fallen out of the survey, stopped answering, or return after 2022.
- Firm links are fictional in the development data, so who stays, leaves or comes back means nothing here. For example,
  no firm ever skips a file, so "absent then back" is 0. Firms new in 2019 leave far more (55.7% gone from 2020 on vs
  17.4%) only because of how the fictional links were drawn. Read these results on the real BPS files.
- The file holds the shared "COVID COHORT AND STATES" block, version 2: cohort file as a parameter, three later files,
  neutral band ±10% as a parameter, and constant-price output used automatically when present. R4-02..06 and the R10
  files copy it exactly.
- Firm traits are not in the block; they belong to R4-04 and R4-05.
