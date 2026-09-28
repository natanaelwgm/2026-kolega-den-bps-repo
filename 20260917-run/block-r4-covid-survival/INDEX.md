# R4 — COVID: which firms left the file, came back, shrank or grew: exhibit index

Development data — obscured values, fictional firm panel. Not BPS findings.

Run all: open `00_run.do`, check the two paths at the top, press Do. Each file below also runs on its own.
Item-by-item coverage of Bu Deasy's row and the review record: [TRACKER.md](TRACKER.md).

| File | What it shows | Bu Deasy's words it answers | Status |
|---|---|---|---|
| `01_cohort_states_flow.do` → `figures/01_cohort_states_flow.png`, `tables/01_cohort_states_flow.csv`, `tables/01_cohort_states_flow_table.pdf` | The 3,007 firms of the 2019 file, looked up in the 2020, 2021 and 2022 files: how many stayed in all three (split by whether workers grew, stayed within 10% or shrank), came back after a gap, or left; plus the firms that first appear in 2020–22. Counts that add up to the 2019 firms. | "Impact covid: Survival analysis??", "Which firms survived"; "multinomial outcomes: exit, temporary disappearance, survive-shrink, survive-grow"; "Melihat firms yg bertahan, mati dan hidup selama shock covid" | done (read on the real files) |
| `02_states_normal_vs_covid.do` → `figures/02_states_normal_vs_covid.png`, `tables/02_states_normal_vs_covid.csv`, `tables/02_states_normal_vs_covid_table.pdf` | For the firms of every annual file 2012–2019, the share still in all of the next three files, back after a gap, gone later, or gone at once; the 2019 firms (followed through 2020–22) against earlier files, for all firms and for firms also in one of the two files before. | "Impact covid: Survival analysis??", "Which firms survived"; "Melihat firms yg bertahan, mati dan hidup selama shock covid" | done (read on the real files) |

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

**02 — the 2019 firms against earlier files.**
- The same states as 01 for every file with two files before it and three after it (2012–2019 here), each followed in its next three
  files. Upper bars: all firms of the file. Lower bars: only firms also in one of the two files before, because firms new to the files
  leave far more and their share differs by year (2017 file: 50.1% stayed among all firms, 60.6% in the lower group).
- Dev data, stayed in all three later files: 2012 57.1%, 2013 58.0%, 2014 55.3%, 2015 54.7%, 2017 50.1%, 2018 55.4%, **2019 55.8%**
  (1,678 of 3,007). Lower group: 67.5, 68.0, 65.4, 63.8, 60.6, 63.6, **65.5%** (1,484 of 2,266).
- Reading: the 2019 share lies inside the range of the files followed only before 2020 (54.7–58.0%; lower group 63.8–68.0%).
  With fictional firm links this says nothing about COVID either way; read it on the real BPS files.
- Status beside each bar: 2012 "Normal years"; 2013–2015 "Skips 2016 (no file)" (followed across the missing 2016 file, so over more
  calendar years); 2017–2018 "Partly COVID years" (follow-up includes 2020 or later); 2019 "COVID years".
- 2010 and 2011 are left out: the lower group needs two earlier files. Among all firms they would show 57.5% and 57.3% stayed
  (reviewer's recount), inside the same range.
- Absent then back is 0 in every bar (no firm skips a file in the fictional panel); the category stays for the real files.
- The table and CSV give each share with a 95% interval (Wilson; bars share firms, so intervals are not independent), the stayers
  split by workers and by output (±10%, current prices on this file), and the firms first seen in each later file.
- Left the files is not proof of closure. Shares only, not the effect of COVID. Uses the shared "COVID COHORT AND STATES" block
  (version 2) unchanged, once per starting file.
