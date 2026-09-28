# R9 tracker — who decarbonised Indonesian manufacturing (accounting decomposition)

Development data — obscured values, fictional firm panel. Not BPS findings.

Bu Deasy's row R9 (PIC Schalke), verbatim: "Who decarbonised Indonesian manufacturing: firms becoming cleaner or
production reallocating toward cleaner firms?" Strategy: "Accounting decomposition, bukan causal regression. FHK
decomposition + Melitz–Polanec dynamic decomposition. Within + reallocation + entry + exit." Notes: (empty).

Status words: **done** = an exhibit here answers the item on this dataset · **partial** = answered in part (says what is
missing) · **unavailable** = the dataset cannot answer it (says why) · **planned** = not built yet.
"Earlier" = earlier Codex/Devin work. For R9 none exists: the paper-repo row packet
(`requests/estimation/09-decarbonisation-decomposition/`) is `planning_only`, and its 8 September audit found no FHK or
Melitz–Polanec code or output.

## Every item in Bu Deasy's row

| ID | Bu Deasy's item (verbatim) | Our exhibit(s) | Status | Earlier Codex/Devin report | Note |
|---|---|---|---|---|---|
| R9.Q1 | Who decarbonised Indonesian manufacturing | R9-01 (level to be explained), R9-02 to R9-07 | partial (R9-01: yearly level, as filed and with extreme records set aside, plus the rule's weight and cut-off sensitivity; the split is in R9-02 to R9-07) | not done — no output |  |
| R9.Q1a | … firms becoming cleaner | R9-02 (within), R9-03 (stayers' average firm), R9-04, R9-05 | planned | not done |  |
| R9.Q1b | … or production reallocating toward cleaner firms? | R9-02 (between + cross), R9-03 (stayers' reallocation), R9-04 (between sectors) | planned | not done | Cross term also shown on its own. |
| R9.S1 | Accounting decomposition, bukan causal regression. | All R9 files | partial (R9-01: level path only, bookkeeping, no cause; decomposition files pending) | not done | Every note says bookkeeping, not cause. |
| R9.S2 | FHK decomposition | R9-02, R9-04, R9-05; program `r9_fhk` tested in R9-06 | partial (R9-06: FHK program tested on hand-worked examples and on the data; R9-02 not built yet) | not done |  |
| R9.S3 | Melitz–Polanec dynamic decomposition | R9-03; program `r9_mp` tested in R9-06 | partial (R9-06: Melitz–Polanec program tested on hand-worked examples and on the data; R9-03 not built yet) | not done | Not split by group: its terms do not add up firm by firm. |
| R9.S4 | Within | R9-02, R9-03 | planned | not done |  |
| R9.S5 | … + reallocation | R9-02, R9-03, R9-04 | planned | not done |  |
| R9.S6 | … + entry | R9-02, R9-03 | planned | not done | Fictional firm links: computed correctly, means nothing on this file. |
| R9.S7 | … + exit | R9-02, R9-03 | planned | not done | As R9.S6. |

## Checklist from the paper-repo planning note (reference only, not Bu Deasy's words)

| ID | Planning-note item | Our exhibit(s) | Status | Earlier Codex/Devin report | Note |
|---|---|---|---|---|---|
| R9.P1 | Weights sum to one on the exact universe; aggregate ratio = weighted firm ratio | R9-01, R9-06 | done (R9-06: shares add to 1 and level = weighted average of firms in all 150 decompositions, gaps ≤ 4.4e-15) | not done |  |
| R9.P2 | CO2/output with output weights; energy (GJ) versions | R9-02, R9-07 | planned | not done |  |
| R9.P3 | FHK cross term kept explicit | R9-02 | planned | not done |  |
| R9.P4 | Melitz–Polanec covariance scaling explicit | R9-03, R9-06 | done (R9-06: covariance written out as Σ(s_i/S − 1/n)(a_i − ā) = n × covariance; tested) | not done |  |
| R9.P5 | All terms add to the aggregate change at machine precision, every interval and group | R9-06 | done (R9-06: parts = change in every period, measure, sample and group; largest gap 3.6e-13 of the level) | not done |  |
| R9.P6 | Toy cases: no change, within-only, pure reallocation, entry-only, exit-only | R9-06 | done (R9-06: the five requested cases plus "all at once" and a set-aside test; 98 checks, 0 failed) | not done |  |
| R9.P7 | By sector; by exporter / importer / foreign-owned, firms switching status reported separately | R9-04, R9-05 | planned | not done |  |
| R9.P8 | True entry/exit vs sample rotation, size-threshold crossing, non-response | — | planned as unavailable | not done | No firm start year, age or frame variable in the file. |

## How each exhibit was made

Each exhibit: one planning subagent → built and run here → one review subagent (numbers re-computed independently,
house style, Tufte, and "would a non-economist understand it?") → fixes → next exhibit.

| Exhibit | Plan | Built and run | Review | Non-economist check | Fixes | Status |
|---|---|---|---|---|---|---|
| R9-02 FHK decomposition | planned | planned | planned | planned | — | planned |
| R9-03 Melitz–Polanec decomposition | planned | planned | planned | planned | — | planned |
| R9-04 by sector | planned | planned | planned | planned | — | planned |
| R9-05 by exporter, importer, foreign-owned | planned | planned | planned | planned | — | planned |
| R9-07 sensitivity to doubtful and extreme energy records | planned | planned | planned | planned | — | planned |
| R9-01 aggregate CO2 and energy per value added, by year | done | done (GUI + console) | done: FIX, 5 MUST (fake entry/exit from energy-0 stayers in the shared block; rule weight and cut-off sensitivity in notes and Table R9-01b; as-filed end labels; intervals CSV columns; instructions for 02–07), re-check PASS | No → Yes after fixes | applied from tested file | done |
| R9-06 exact reconciliation and toy test cases | done (planner wrote and tested the draft) | done (runs in 18 s) | done (formulas checked against FHK 2001 and Melitz–Polanec 2015; independent code on examples and data matches to 6 decimals); re-check PASS | yes, after adding what a minus sign means | universe now from the R9-01 block (was its own copy, 24–31 firm-years per period treated differently); sign note; per-row pass; CSV names | done |
