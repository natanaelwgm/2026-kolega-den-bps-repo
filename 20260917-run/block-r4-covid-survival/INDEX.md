# R4 — COVID: which firms left the file, came back, shrank or grew: exhibit index

Development data — obscured values, fictional firm panel. Not BPS findings.

Run all: open `00_run.do`, check the two paths at the top, press Do. Each file below also runs on its own.
Item-by-item coverage of Bu Deasy's row and the review record: [TRACKER.md](TRACKER.md).

<!-- tables-start -->
Tables that go with the charts: every chart has a table PDF with each plotted point and its number (`_table.pdf`); charts built from regressions also have the full regression table (`_regression.pdf`).

- 01: `tables/01_cohort_states_flow_table.pdf`
- 02: `tables/02_states_normal_vs_covid_table.pdf`
- 03: `tables/03_composition_before_after_table.pdf`
- 04: `tables/04_leaving_hazard_regression.pdf`, `tables/04_leaving_hazard_table.pdf`
- 05: `tables/05_outcomes_multinomial_regression.pdf`, `tables/05_outcomes_multinomial_table.pdf`
- 06: `tables/06_survivors_shrink_grow_recovery_table.pdf`
<!-- tables-end -->


| File | What it shows | Bu Deasy's words it answers | Status |
|---|---|---|---|
| `01_cohort_states_flow.do` → `figures/01_cohort_states_flow.png`, `tables/01_cohort_states_flow.csv`, `tables/01_cohort_states_flow_table.pdf` | The 3,007 firms of the 2019 file, looked up in the 2020, 2021 and 2022 files: how many stayed in all three (split by whether workers grew, stayed within 10% or shrank), came back after a gap, or left; plus the firms that first appear in 2020–22. Counts that add up to the 2019 firms. | "Impact covid: Survival analysis??", "Which firms survived"; "multinomial outcomes: exit, temporary disappearance, survive-shrink, survive-grow"; "Melihat firms yg bertahan, mati dan hidup selama shock covid" | done (read on the real files) |
| `02_states_normal_vs_covid.do` → `figures/02_states_normal_vs_covid.png`, `tables/02_states_normal_vs_covid.csv`, `tables/02_states_normal_vs_covid_table.pdf` | For the firms of every annual file 2012–2019, the share still in all of the next three files, back after a gap, gone later, or gone at once; the 2019 firms (followed through 2020–22) against earlier files, for all firms and for firms also in one of the two files before. | "Impact covid: Survival analysis??", "Which firms survived"; "Melihat firms yg bertahan, mati dan hidup selama shock covid" | done (read on the real files) |
| `03_composition_before_after.do` → `figures/03_composition_before_after.png`, `tables/03_composition_before_after.csv`, `tables/03_composition_before_after_pairs.csv`, `tables/03_composition_before_after_table.pdf` | Change in the share of firms and of workers by size, importer, foreign-owned and sector between the 2019 and 2022 files, against the 2012→2015 change and the range over normal years; panel (c) splits each change in the share of firms into firms that left, firms that came in, and change within firms in both files. | "Did COVID change the composition of Indonesian manufacturing?"; "Melihat firms yg bertahan, mati dan hidup selama shock covid" | done, reviewed (panels a–b read on these files; panel c only on the real files) |
| `04_leaving_hazard.do` → `figures/04_leaving_hazard.png`, `tables/04_leaving_hazard.csv`, `tables/04_leaving_hazard_table.pdf`, `tables/04_leaving_hazard_regression.pdf` | For the firms of the 2019 file (followed 2020–22) and of the 2012 file (followed 2013–15), how much more or less likely a firm with each trait known by the starting file was to be missing from the next file: size, value added per worker, exporter, importer, foreign-owned, new to the files. One logit per starting file (pooled), dots in percentage points with 95% intervals; odds ratios, model checks and calibration in the tables. | "Survival analysis??", "Which firms survived"; strategy "Survival/hazard model menggunakan pre-COVID characteristics" | done, reviewed (read on the real files) |
| `05_outcomes_multinomial.do` → `figures/05_outcomes_multinomial.png`, `tables/05_outcomes_multinomial.csv`, `tables/05_outcomes_multinomial_table.pdf`, `tables/05_outcomes_multinomial_regression.pdf` | For the firms of the 2019 file (followed to 2022) and of the 2012 file (followed to 2015): how much more or less likely a firm with each trait known by the starting file was to leave the files, come back after a gap, stay and shrink, stay about the same size, or stay and grow (workers ±10%). One multinomial logit per starting file; dots in percentage points with 95% intervals, one panel per outcome; output version, model checks and calibration in the tables. | "Which firms survived and recovered?"; strategy "Alternative: multinomial outcomes: exit, temporary disappearance, survive-shrink, survive-grow", "menggunakan pre-COVID characteristics" | done, reviewed (read on the real files) |
| `06_survivors_shrink_grow_recovery.do` → `figures/06_survivors_shrink_grow_recovery.png`, `tables/06_survivors_shrink_grow_recovery.csv`, `tables/06_survivors_shrink_grow_recovery_table.pdf` | The 2019 firms still in every file 2020–2022 against the 2012 firms still in every file 2013–2015 (normal years). For each group: the middle firm's workers and output in each later file against its own starting level (= 100), the share down more than 10%, within 10% either way or up more than 10% by the third later file, and, of those more than 10% down in the first later file, the share back within 10% or above. Output in current prices on this file. | "Which firms survived and recovered?"; strategy "multinomial outcomes: ... survive-shrink, survive-grow" | done, reviewed (read on the real files; output in current prices here) |

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

**03 — the mix of firms, 2019 vs 2022 files, against normal years.**
- Shares are taken over each whole annual file, so panels (a) and (b) use no firm links. Normal years = every starting file whose next three files are consecutive and end before 2019 (here 2010, 2011, 2012; the main one is 2012→2015). On this file all three lie before the missing 2016 file, so the gray range is thin.
- Dev data, share of firms: under 20 workers +7.91 points (10.4% → 18.3%; 2012→2015 −1.13, normal range −1.53 to −0.19); 20–99 workers −6.04; 100 or more −1.87. Foreign-owned (10% or more) +1.29 (normal range −0.47 to 0.73). Sector shares mostly move within about ±2 points, as in normal years (food +1.93, textiles −2.12, clothing −1.83).
- Importer share −17.54 (53.1% → 35.5%) is drawn gray: the recorded importer share jumps in 2017 and falls in 2022. Most of the fall (−15.20) is firms in both files that are no longer recorded as importers, which points to a recording change.
- Share of workers: tobacco −9.15 (14.4% → 5.2%) rests on one very large 2019 firm. Worker shares can turn on a single firm.
- Panel (c) (Melitz–Polanec rule, the same one R9 uses): firms that left are compared with the firms in both files in 2019, firms that came in with the firms in both files in 2022, so a shift shared by all firms is not credited to newcomers. Under 20 workers: left −0.34, came in −0.81, within firms in both files +9.06. Food: left +6.99, came in −5.06, within 0.00. Sector never changes within a firm in the fictional panel, so the sector "within" part is 0 here; on the real files it counts firms re-coded to another sector.
- No sampling intervals: these are whole annual files, not samples; the gray range is the yardstick for normal movement.
- Exporters are not shown: the 2022 file records no non-exporters (row kept in the CSV and table).
- Firm links are fictional in the development data, so who stays, leaves or comes back (panel c) means nothing here; read these results on the real BPS files. Left the files is not proof of closure.

**04 — chance of leaving the files, by traits known before COVID: 2019 firms against 2012 firms.**
- Each firm of the starting file is followed until the first later file it is missing from (one row per firm and later file while it is still in the files). Traits come only from the starting file and the two files before it. Model: a logit with later-file, sector and province dummies, every term specific to its starting file, standard errors clustered by firm; dots = average change in the chance of leaving at a file when the trait is switched on, in percentage points.
- Dev data: 2019 firms 3,007 (7,118 rows, 1,329 leave); 2012 firms 2,359 (5,659 rows, 1,013 leave). Leaving at each next file: 2020 26.9%, 2021 13.1%, 2022 12.2% against 2013 24.3%, 2014 15.1%, 2015 11.2%.
- Dots, 2019 / 2012 (points): fewer than 20 workers 2.3 / 2.9; 100 or more 2.1 / 3.5; value added per worker above its sector's median 1.4 / 2.7; exporter 0.6 / 0.1; no export answer −1.7 / 0.5; importer −0.6 / −0.3; foreign-owned 10%+ 0.8 / 3.6; not in the two files before 14.5 / 13.5. Size bands and export answers compare each group with 20–99 workers and with known non-exporters (the other marker of the pair switched off; changed after the R4-05 review, same rule as R4-05).
- No trait differs clearly between the 2019 and the 2012 firms (all traits together p = 0.56). Firms not in the two files before leave far more in both, partly because of how the fictional links were drawn.
- Productivity is split yes/no at the sector median so every row reads "with against without". The regression table (page 2) also gives a check with value added per worker measured continuously, per standard deviation above its sector's median: 2019 +2.11 points (SE 0.53), 2012 +1.46 (SE 0.54). The continuous measure is clear in both years; the yes/no split is coarser (clear only for 2012).
- Checks: 0 rows dropped for perfect prediction; 30.2 / 24.7 leaving events per coefficient; area under the ROC curve 0.766 / 0.788; Hosmer–Lemeshow p 0.083 / 0.030 (largest gap 2.9 / 3.3 points). One pooled model so the difference can use the 946 firms in both files; its point estimates equal two separate logits.
- Importers are not like for like: 21% of the 2012 firms, 53% of the 2019 firms (the recorded share jumps in 2017).
- Association, not the effect of COVID. Leaving is not proof of closure. Firm links are fictional in the development data, so who stays, leaves or comes back means nothing here; read these results on the real BPS files.

**06 — firms still in every file after 2019: shrank, grew or came back up, against 2012.**
- Stayers are firms of the starting file that are in all three later files: 1,678 of the 3,007 firms of the 2019 file and 1,346 of the 2,359 firms of the 2012 file. None came back after a gap (the fictional panel never skips a file).
- Each stayer is set against its own level in the starting file (= 100). Dots show the middle firm (median) with an exact 95% interval.
  - Workers, dev data: 96.2 in 2020, 89.6 in 2021, 81.8 in 2022 (95%: 78.9–85.7), against 103.3, 104.8 and 100.0 for the 2012 firms in 2013–15.
  - Output (current prices): 76.0, 78.9 and 76.0, against 116.9, 148.6 and 169.1.
- By the third later file, down more than 10% / within 10% / up more than 10%:
  - Workers: 55.7 / 12.0 / 32.2% (935 / 202 / 541 firms, as in 01), against 38.9 / 19.2 / 41.9% for the 2012 firms.
  - Output: 57.6 / 7.9 / 34.4%, against 25.1 / 7.2 / 67.7%.
- Came back up, meaning more than 10% down in the first later file and within 10% or above by the third:
  - Workers: 29.3% (215 of 734), against 37.6% (173 of 460).
  - Output: 29.7% (295 of 993), against 53.3% (257 of 482).
- Prices: the file has no price index, and every deflator and constant-price variable is empty. Output is therefore in current prices: it rises when prices rise even if a firm makes the same amount, and prices rose by different amounts in 2013–15 and 2020–22.
  - On this file the middle output of all firms in each file moves almost the same way as the stayers': 2012 file = 100 gives 120.1, 164.7, 174.0; 2019 file = 100 gives 79.9, 92.8, 78.5 (table, Check 2).
  - So the output line mostly shows how the masked files' money levels move, not the firms.
  - Workers are not affected by prices and are the main measure.
  - On the real files, use constant-price output if BPS has it (the file switches automatically). Otherwise read (b) together with Check 2.
- Bands: within 5% holds 6.3% (workers) and 3.9% (output) of the 2019 stayers; within 20% holds 23.6% and 16.5% (CSV). The masked values are noisy, so few firms stay "about the same".
- Other normal-years starting files (CSV): the middle firm's workers in the third later file are 105.3 (2010) and 106.4 (2011); output is 155.7 and 180.3.
- How this differs from R10-03. Both use the same stayers, output rule and workers. R10-03:
  - keeps only stayers also in 2017 or 2018 (1,484);
  - compares exporters, importers and foreign-owned stayers with similar stayers of the same industry and province, in regressions on logs;
  - drops firms with 0 workers later.
  - R4-06 instead shows every stayer against its own starting level, with no model, and counts 0 workers as down 100%.
  - R10-03's firms give nearly the same numbers here (Check 1 in the table): 2022 workers 81.8, output 75.5; came back up 28.7% (workers) and 29.2% (output).
- What happened to the stayers, not the effect of COVID. Firms that left the files are in 01 (left is not proof of closure). Firm links are fictional in the development data, so who stays, leaves or comes back means nothing here; read these results on the real BPS files.

**05 — what became of the firms by the third later file, by traits known before COVID: 2019 firms against 2012 firms.**
- Every firm of the starting file ends in one of five outcomes by the third later file: left the files (not in it; not proof of closure), absent then back (missed a later file, in the third), or in all three and then shrank, stayed within 10% or grew (workers; output in current prices in the tables). Traits come only from the starting file and the two files before it, with the same code as 04.
- Model: one multinomial logit per starting file with sector and province groups (fewer than 30 firms pooled into "other"), standard errors clustered by firm. Dots = average change in the chance of each outcome when the trait is switched on, in percentage points. Size bands and export answers compare each group with 20–99 workers / known non-exporters, as in 04. A pooled model of both files (every term its own per file) gives the 2019 − 2012 differences; its effects equal the separate models' (largest gap 7e-06).
- Dev data, workers: 2019 (3,007 firms) left 1,329 (44%), back 0, shrank 935 (31%), same size 202 (7%), grew 541 (18%); 2012 (2,359) 1,013 (43%), 0, 523 (22%), 259 (11%), 564 (24%). Output: 2019 shrank 967 / same 133 / grew 578; 2012 338 / 97 / 911.
- "Absent, then back" has 0 firms in both files (the fictional panel never skips a file), so it is not estimated; it keeps its panel and is modelled on the real files once it has 30 or more firms.
- Largest 2019-vs-2012 gaps (points, 2019 / 2012): exporters grew more +9.8 / +0.4 (p = 0.005); firms under 20 workers shrank less −8.2 / −17.2 (p = 0.002); 100+ workers stayed the same size less −3.0 / −8.3 (p < 0.001). Firms not in the two files before left far more in both (+22.8 / +22.8), partly because of how the fictional links were drawn. All traits together, 2019 = 2012: left p = 0.20, shrank p < 0.001, same size p = 0.019, grew p = 0.010.
- Productivity is split yes/no at the sector median on the chart. Regression table check with value added per worker measured continuously (per standard deviation above its sector's median), 2019 / 2012: left +4.4 / +2.7, shrank −8.4 / −5.1, same size −0.7 / −1.6, grew +4.7 / +4.0 points — same direction as the yes/no dots.
- Checks: pseudo R² 0.139 / 0.179; coefficients above 10 (near perfect prediction; all sector or province groups) 0 / 3 (workers), 4 / 12 (output); area under the ROC curve 0.70–0.81; largest calibration gap 7.5 points (2019, left).
- Importers are not like for like: 21% of the 2012 firms, 53% of the 2019 firms (the recorded share jumps in 2017).
- Association, not the effect of COVID. Left the files is not proof of closure. Firm links are fictional in the development data, so who stays, leaves or comes back means nothing here; read these results on the real BPS files.
