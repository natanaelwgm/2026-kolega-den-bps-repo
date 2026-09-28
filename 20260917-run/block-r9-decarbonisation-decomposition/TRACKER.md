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
| R9.Q1 | Who decarbonised Indonesian manufacturing | R9-01 (level to be explained), R9-02 to R9-07 | partial (R9-01: yearly level and cut-off sensitivity; R9-02: FHK split of the three periods, CO2 and energy; R9-03: Melitz–Polanec split of the same three periods, CO2 and energy; R9-04: the FHK split added up by 2-digit sector, three periods, plus sectors as the units (not a ranking: on this file firms appearing and disappearing outweigh staying firms in 61 of 72 sector bars); R9-05 groups pending) | not done — no output |  |
| R9.Q1a | … firms becoming cleaner | R9-02 (within), R9-03 (stayers' plain average), R9-04 (within by sector), R9-05 | partial (R9-02: staying firms' own change drawn for three periods; positive in all, driven by firms whose value added fell; R9-03: staying firms' plain average −80 / −22 / +17 (CO2), opposite sign to R9-02 in 2010–15 and 2015–18 (big staying firms dirtier, typical staying firm cleaner), stated on the page; staying firms together +75 / −26 / +2; R9-04: staying firms' own change by sector, three periods; large in a few sectors and cancelled by reallocation there; R9-05 pending) | not done |  |
| R9.Q1b | … or production reallocating toward cleaner firms? | R9-02 (between, cross, reallocation = between + cross), R9-03 (reallocation among staying firms = covariance change), R9-04 (reallocation by sector; sector mix = value added moving between sectors) | partial (R9-02: between, cross and their sum drawn; they mostly cancel with within on this file; R9-03: covariance change +155 / −4 / −16 (CO2), mostly big and small staying firms changing differently, not value added moving; R9-04: sector mix (sectors as the units, no firm links needed) −70 / −7 / −13% of the start level against +109 / −38 / −6% inside sectors (CO2); cancels in 2010–15) | not done | Cross term also shown on its own. |
| R9.S1 | Accounting decomposition, bukan causal regression. | All R9 files | partial (R9-01, R9-02, R9-03, R9-04: bookkeeping, not cause, stated on the page; R9-04 also "not a ranking of sectors" under its title; R9-05 to R9-07 pending) | not done | Every note says bookkeeping, not cause. |
| R9.S2 | FHK decomposition | R9-02, R9-04, R9-05; program `r9_fhk` tested in R9-06 | done (R9-02: FHK split of three periods, whole span and every year pair, five measures, main and as filed; R9-04: FHK parts added up by sector, same periods and pairs, CO2 and energy, main and as filed; groups in R9-05 pending) | not done |  |
| R9.S3 | Melitz–Polanec dynamic decomposition | R9-03; program `r9_mp` tested in R9-06 | done (R9-03: Melitz–Polanec split of three periods, whole span and every year pair, five measures, main and as filed; Table R9-03b: firms, share, plain average, weighted level, covariance term per group and year) | not done | Not split by group: its terms do not add up firm by firm. |
| R9.S4 | Within | R9-02, R9-03 | done (R9-02: FHK within, value-added-weighted; R9-03: Melitz–Polanec within, plain average; the R9-03 page says the two can differ, even in sign) | not done |  |
| R9.S5 | … + reallocation | R9-02, R9-03, R9-04 | partial (R9-02: reallocation = between + cross, cross also on its own; R9-03: reallocation among staying firms (covariance) and staying firms together; R9-04: reallocation among staying firms by sector, and value added moving between sectors (sector mix, Table R9-04c)) | not done |  |
| R9.S6 | … + entry | R9-02, R9-03, R9-04 (by sector) | partial (R9-02, R9-03, R9-04: computed and drawn gray; fictional firm links, so sample rotation, no meaning on this file) | not done | Fictional firm links: computed correctly, means nothing on this file. |
| R9.S7 | … + exit | R9-02, R9-03, R9-04 (by sector) | partial (R9-02, R9-03, R9-04: as R9.S6) | not done | As R9.S6. |

## Checklist from the paper-repo planning note (reference only, not Bu Deasy's words)

| ID | Planning-note item | Our exhibit(s) | Status | Earlier Codex/Devin report | Note |
|---|---|---|---|---|---|
| R9.P1 | Weights sum to one on the exact universe; aggregate ratio = weighted firm ratio | R9-01, R9-06 | done (R9-06: shares add to 1 and level = weighted average of firms in all 150 decompositions, gaps ≤ 4.4e-15) | not done |  |
| R9.P2 | CO2/output with output weights; energy (GJ) versions | R9-02, R9-07 | partial (R9-02: CO2 per output with output weights, energy, scope 1 and scope 2 versions in Table R9-02b; R9-07 pending) | not done |  |
| R9.P3 | FHK cross term kept explicit | R9-02 | done (R9-02: cross term drawn on its own row and in every table) | not done |  |
| R9.P4 | Melitz–Polanec covariance scaling explicit | R9-03, R9-06 | done (R9-06: covariance written out as Σ(s_i/S − 1/n)(a_i − ā) = n × covariance; tested; R9-03: Table R9-03b prints covariance term = weighted level − plain average per group and year) | not done |  |
| R9.P5 | All terms add to the aggregate change at machine precision, every interval and group | R9-06 | done (R9-06: parts = change in every period, measure, sample and group; largest gap 3.6e-13 of the level) | not done |  |
| R9.P6 | Toy cases: no change, within-only, pure reallocation, entry-only, exit-only | R9-06 | done (R9-06: the five requested cases plus "all at once" and a set-aside test; 98 checks, 0 failed) | not done |  |
| R9.P7 | By sector; by exporter / importer / foreign-owned, firms switching status reported separately | R9-04, R9-05 | partial (R9-04: by sector, every period and year pair, firms changing sector counted (none in this file); R9-05 by exporter / importer / foreign-owned pending) | not done |  |
| R9.P8 | True entry/exit vs sample rotation, size-threshold crossing, non-response | — | planned as unavailable | not done | No firm start year, age or frame variable in the file. |

## How each exhibit was made

Each exhibit: one planning subagent → built and run here → one review subagent (numbers re-computed independently,
house style, Tufte, and "would a non-economist understand it?") → fixes → next exhibit.

| Exhibit | Plan | Built and run | Review | Non-economist check | Fixes | Status |
|---|---|---|---|---|---|---|
| R9-05 by exporter, importer, foreign-owned | planned | planned | planned | planned | — | planned |
| R9-07 sensitivity to doubtful and extreme energy records | planned | planned | planned | planned | — | planned |
| R9-01 aggregate CO2 and energy per value added, by year | done | done (GUI + console) | done: FIX, 5 MUST (fake entry/exit from energy-0 stayers in the shared block; rule weight and cut-off sensitivity in notes and Table R9-01b; as-filed end labels; intervals CSV columns; instructions for 02–07), re-check PASS | No → Yes after fixes | applied from tested file | done |
| R9-06 exact reconciliation and toy test cases | done (planner wrote and tested the draft) | done (runs in 18 s) | done (formulas checked against FHK 2001 and Melitz–Polanec 2015; independent code on examples and data matches to 6 decimals); re-check PASS | yes, after adding what a minus sign means | universe now from the R9-01 block (was its own copy, 24–31 firm-years per period treated differently); sign note; per-row pass; CSV names | done |
| R9-02 FHK decomposition | done (planner wrote and tested the draft) | done (GUI + console, 9 s) | done: FIX, 2 MUST (data-driven "mostly cancel" note with the net and why; "Reallocation (between + cross)" row label); numbers re-computed independently to 3 decimals; re-check PASS | No → Yes after fixes | applied from tested file | done |
| R9-03 Melitz–Polanec decomposition | done (planner wrote and tested the draft) | done (GUI + console + real-data mode) | done: FIX, 6 MUST (note wrongly called the total meaningless; no warning that its plain-average within has the opposite sign to R9-02's weighted within in two periods; covariance row mislabelled as value added shifting; "staying firms together" row for the cancelling −80/+155; notes-only table page; R9-02 formatting); numbers re-computed independently to 2 decimals; re-check PASS | No → Yes after fixes | applied from tested file | done |
| R9-04 by sector | done (planner wrote and tested the draft) | done (GUI + console) | done: FIX, 7 MUST (title and sort order read as a ranking of sectors; no "not a ranking" line with the data-built count; 2010–15 left out, so panel letters clashed with R9-02/03; wording not R9-02's, value added undefined; Table R9-04c formulas, not readable; "0.0 drawn" for sectors with no staying firms); numbers re-computed independently to CSV rounding and equal to R9-02's CSV; fixed file tested in GUI, console and real-data mode; re-check PASS | No → Yes after fixes | applied from tested file | done |
