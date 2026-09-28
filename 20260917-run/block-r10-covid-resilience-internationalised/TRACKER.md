# R10 tracker — internationalised firms and COVID resilience

Development data — obscured values, fictional firm panel. Not BPS findings.

Bu Deasy's row R10 (PIC Schalke), verbatim: "Were internationally integrated firms more resilient during COVID?"
Strategy: "Pre-2019 exporter/importer/FDI × Post2020. Outcomes: survival, output, employment, productivity, export
participation. Event study 2017–22 jika memungkinkan". Notes: none.

Status words: **done** = an exhibit here answers the item on this dataset · **partial** = answered in part (says what is
missing) · **unavailable** = the dataset cannot answer it (says why) · **planned** = not built yet.
"Earlier" = the paper repo's row packet `requests/estimation/10-covid-resilience/` (planning only; 8 September audit:
"No pre-2019 export/import/FDI × Post2020 design or event study 2017–2022 is implemented"). No earlier Codex/Devin report
covers R10.

Firm links across years are fictional on the development data: survival, leaving the files and survivor-only results
are computed correctly but mean nothing here; every such exhibit says so and runs unchanged on the real BPS panel.

## Every item in Bu Deasy's row

| ID | Bu Deasy's item (verbatim) | Our exhibit(s) | Status | Earlier | Note |
|---|---|---|---|---|---|
| R10.Q1 | Were internationally integrated firms more resilient during COVID? | R10-02 to R10-06 | planned | not done — planning only | Association only: COVID hit every firm at once. |
| R10.O1 | Outcomes: survival | R10-02 (R10-04 counts leavers as closed; R10-01 counts) | planned | not done | "Left the survey files", not closure; fictional links make it meaningless here. Cohort and states shared with R4. |
| R10.O2 | … output | R10-03 (survivors), R10-04 (all firms, leavers as closed), R10-06 | planned | not done | Nominal gross output: the file has no deflators or real values. |
| R10.O3 | … employment | R10-03, R10-04, R10-06 | planned | not done | Workers (persons). |
| R10.O4 | … productivity | R10-03, R10-06 | planned | not done | Value added per worker (main); productivity residual (LP) in the table, 2018–22 only (none in 2017). Not defined for leavers. |
| R10.O5 | … export participation | R10-05, R10-06 | planned | not done | 2022 asks direct exports only: drawn separately; 2012 benchmark shows the fall-back of firms chosen for exporting. |
| R10.G1 | Pre-2019 exporter | R10-01 (groups; used by R10-02 to R10-06) | done (R10-01: 402 exporters / 1,202 other / 662 unknown answer, among 2019 firms also in 2017–18; yes in at least half of the known 2017–19 answers; 59 of the other firms exported in one of three files; stricter rule kept as a named check) | not done | 402 exporters / 1,202 others / 662 unknown answer (incumbents, 2017–19 rule). |
| R10.G2 | Pre-2019 importer | R10-01 (groups; used by R10-02 to R10-06) | done (R10-01: 1,329 importers / 937 other; 377 of the other firms imported in one of three files; the 2017–19 window lies after the 2017 import-coding jump, so 59% count as importers) | not done | 1,329 / 937; window lies after the 2017 import coding jump. |
| R10.G3 | Pre-2019 FDI | R10-01 (groups; used by R10-02 to R10-06) | done (R10-01: 10%+ foreign-owned 127 / 2,139, from 2017–19 answers only, 2020 answers never used; stricter rule 22 firms, too few for estimates) | not done | 10%+ foreign-owned: 127 / 2,139; 2020 foreign-ownership answers unusable, never used. |
| R10.S1 | Pre-2019 exporter/importer/FDI × Post2020 | R10-01 (groups), R10-03 to R10-05 (pooled × Post2020 term), R10-06 (versions, reweighting) | partial (R10-01: groups built and counted; the × Post2020 comparison comes in R10-03 to R10-05) | not done | Groups frozen once from 2017–19 records; firm + industry×year + province×year averages. |
| R10.S2 | Event study 2017–22 jika memungkinkan | R10-03, R10-04, R10-05 | planned | not done | Possible: 2019 = reference, 2017–18 before, 2020–22 after; only two pre-COVID years (no 2016 file). |

## How each exhibit was made

Each exhibit: one planning subagent → built and run here → one review subagent (numbers re-computed independently,
house style, Tufte, and "would a non-economist understand it?") → fixes → next exhibit.

| Exhibit | Plan | Built and run | Review | Non-economist check | Fixes | Status |
|---|---|---|---|---|---|---|
| R10-02 stayed in the survey files, by group | planned | planned | planned | planned | planned | planned |
| R10-03 output, workers, output per worker — firms still surveyed in 2022 (year by year) | planned | planned | planned | planned | planned | planned |
| R10-04 output and workers — all firms, leavers counted as closed | planned | planned | planned | planned | planned | planned |
| R10-05 export participation, by group | planned | planned | planned | planned | planned | planned |
| R10-06 checks: reweighted other firms, other group rules, 2012 benchmark | planned | planned | planned | planned | planned | planned |
| R10-01 COVID cohort: groups fixed before COVID, sizes and counts | done | done (planner draft; cohort block copied from R4-01 Version 2) | done: FIX, 4 MUST ("other firms" wording, panel (d) moved to the table, labels inside bars, notes wording) + 4 NICE; numbers re-computed independently, all match | No → Yes after fixes | reviewer's tested file adopted; re-check PASS | done |
