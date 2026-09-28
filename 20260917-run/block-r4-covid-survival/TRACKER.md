# R4 tracker — COVID: which firms stayed, left the file, came back, shrank or grew

Development data — obscured values, fictional firm panel. Not BPS findings.

Bu Deasy's row R4 (PIC Toar), verbatim: "Impact covid: Survival analysis?? Did COVID change the composition of Indonesian manufacturing? Which firms survived and recovered?" — Strategy: "Survival analysis. Survival/hazard model menggunakan pre-COVID characteristics. Alternative: multinomial outcomes: exit, temporary disappearance, survive-shrink, survive-grow." — Notes: "Melihat firms yg bertahan, mati dan hidup selama shock covid". Items in brackets are what a survival design needs to answer that row.

Firm links are fictional in the development data, so who stays, leaves or comes back means nothing here; every R4 exhibit is
built to be read on the real BPS files. "Left the file" is not proof of closure.

Status words: **done** = an exhibit here answers the item on this dataset · **partial** = answered in part (says what is
missing) · **unavailable** = the dataset cannot answer it (says why) · **planned** = not built yet.
"Earlier" = earlier work on this row: none — the paper-repo row packet (10 September 2026) is planning only, no result.

## Every item in Bu Deasy's row

| ID | Bu Deasy's item (verbatim) | Our exhibit(s) | Status | Earlier | Note |
|---|---|---|---|---|---|
| R4.Q1 | Impact covid | R4-01 (R4-02 planned) | partial (Counts for the 2019 firms; comparison with normal years comes in R4-02. Not a measured effect of COVID.) | none | Compared with normal years (R4-02), not a measured effect of COVID. |
| R4.Q2 | Survival analysis?? | R4-01 (R4-02, R4-04 planned) | partial (Survival = still in the survey files, not proven operation.) | none | Survival = still in the survey files, not proven operation. |
| R4.Q3 | Did COVID change the composition of Indonesian manufacturing? | R4-03 | planned | none | File mix 2019 vs 2022, against 2012 vs 2015; exporter mix not comparable (2022 direct exports only). |
| R4.Q4 | Which firms survived | R4-04, R4-05 | planned | none | Traits known by 2019 only. |
| R4.Q5 | … and recovered? | R4-06 | planned | none | Stayers back at or above their 2019 level by 2022. |
| R4.S1 | Survival analysis | R4-04 | planned | none | Year-by-year chance of first leaving the file. |
| R4.S2 | Survival/hazard model menggunakan pre-COVID characteristics | R4-04 | planned | none | 2019 cohort vs 2012 cohort; association only. |
| R4.S3 | Alternative: multinomial outcomes | R4-05 | planned | none | Workers main; output in the table. |
| R4.S3a | … exit | R4-01 | done (counts) (Named "left the files" (not in the 2022 file). Not proof of closure. Bounded by 2022.) | none | Named "left the file" (not in 2022 file); bounded by 2022. |
| R4.S3b | … temporary disappearance | R4-01 | done (counts) (0 cases on the fictional panel (no firm skips a file). Category kept for the real files.) | none | Zero cases in the fictional panel (no firm skips a file); category kept for the real files. |
| R4.S3c | … survive-shrink | R4-01 (R4-05, R4-06 planned) | partial (Counts by workers at ±10% (output in the table). Traits come in R4-05, recovery in R4-06.) | none | Below 2019 level by more than the ±10% band. |
| R4.S3d | … survive-grow | R4-01 (R4-05, R4-06 planned) | partial (Counts by workers at ±10% (output in the table). Traits come in R4-05, recovery in R4-06.) | none | Above 2019 level by more than the ±10% band. |
| R4.N1 | Melihat firms yg bertahan, mati dan hidup selama shock covid | R4-01 | done (counts) (bertahan = stayed, mati = left the files, hidup = first in the 2020–22 files.) | none | bertahan = stayed; mati = left the file; hidup = firms new in the 2020–22 files. |
| R4.M1 | (needed) a fixed pre-COVID cohort: 2019 firms, new-in-2019 firms kept apart | R4-01 | done (2019 file; firms not in 2017 or 2018 kept apart (white). Shared block v2.) | none | Shared cohort block, copied by R10. |
| R4.M2 | (needed) states bounded by the 2022 horizon; "left the file" kept apart from closure | R4-01 | done (Every R4 file carries the sentence.) | none | |
| R4.M3 | (needed) the same states in normal years, so ordinary churn is not called COVID | R4-02, R4-04, R4-05, R4-06 | planned | none | Main comparison cohort 2012 (followed 2013–15). |
| R4.M4 | (needed) no information from 2020–22 in the traits | R4-04, R4-05 | planned | none | Traits from 2019 and the two files before it. |
| R4.M5 | (needed) shrink/grow with a neutral band; real vs nominal output said | R4-01 | partial (±10% band, set in one place; output in current prices on this file, switch to constant prices built in. R4-06 adds ±5% and ±20%.) | none | Band ±10% (±5%, ±20% in the table). |
| R4.M6 | (needed) stayers and the whole cohort reported separately | R4-05, R4-06 | planned | none | |
| R4.M7 | (needed) model checks: rare outcomes, perfect prediction, calibration | R4-04, R4-05 | planned | none | Outcomes with fewer than 30 firms not estimated. |
| R4.U1 | (needed) proven closure | — | unavailable (No closure or reason-for-absence field.) | none | No closure or reason-for-absence field in the file. |
| R4.U2 | (useful) firm age | — | unavailable | none | No founding-year field; "new to the file" used instead. |
| R4.U3 | (needed) real output | R4-05, R4-06 | unavailable on this file | none | Deflators and real values empty; nominal output used; files switch to real values when present. |

## How each exhibit was made

Each exhibit: one planning subagent → built and run here → one review subagent (numbers re-computed independently,
house style, Tufte, and "would a non-economist understand it?") → fixes → next exhibit.

| Exhibit | Plan | Built and run | Review | Non-economist check | Fixes | Status |
|---|---|---|---|---|---|---|
| R4-02 the same states in normal years vs COVID | planned | planned | planned | planned | — | planned |
| R4-03 mix of firms before and after COVID | planned | planned | planned | planned | — | planned |
| R4-04 chance of leaving the file by pre-COVID traits | planned | planned | planned | planned | — | planned |
| R4-05 five outcomes by pre-COVID traits | planned | planned | planned | planned | — | planned |
| R4-06 stayers: shrank, stable, grew, recovered | planned | planned | planned | planned | — | planned |
| R4-01 2019 firms: stayed, left the file, came back | done (block tested on cohorts 2010–2019 and on data with holes) | done (GUI and console) | FIX: 5 MUST (band words vs rule, white-piece label, output split missing from the table, notes order and length, block header), 4 NICE | No → Yes after fixes (warnings now lead the notes) | reviewer's tested file adopted → PASS on re-check | done |
