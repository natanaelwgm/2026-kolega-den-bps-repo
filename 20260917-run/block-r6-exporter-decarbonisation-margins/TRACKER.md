# R6 tracker — how exporters decarbonise (adjustment margins)

Development data — obscured values, fictional firm panel. Not BPS findings.

Bu Deasy's row R6 (PIC Schalke), verbatim: "How do exporters decarbonise? What adjustment margins explain the
energy/carbon productivity gains?" — Strategy: "Event study untuk melihat perubahan energy use" — Notes: (empty).
Items in brackets are what an event study of adjustment margins needs to answer that row.

Status words: **done** = an exhibit here answers the item on this dataset · **partial** = answered in part (says what is
missing) · **unavailable** = the dataset cannot answer it (says why) · **planned** = not built yet.
"Earlier" = earlier work on this row: none was built (paper-repo packet `requests/estimation/06-exporter-adjustment-margins/`,
status `planning_only`; no Codex/Devin report covers R6).

## Every item in Bu Deasy's row

| ID | Bu Deasy's item (verbatim) | Our exhibit(s) | Status | Earlier Codex/Devin report | Note |
|---|---|---|---|---|---|
| R6.Q1 | How do exporters decarbonise? | R6-01 (R6-02 to R6-06 planned) | partial (R6-01: starters vs never-exporters; value added per tonne of CO2 +10%, not clear; the parts that move clearly are value added +19% and output +14%) | not done — planning note only | Exporters = firms that start exporting (R2's start years), against firms never seen exporting. |
| R6.Q2 | What adjustment margins explain the energy/carbon productivity gains? | R6-01 (all parts, exact accounting), R6-02 to R6-04 planned | partial (R6-01: change split exactly into value added, energy used and CO2 per GJ; fuels vs electricity, fuel mix and own electricity follow; association only) | not done — planning note only | R2 found no clear gain after the export start (VA per GJ +9%, VA per CO2 +10%, both unclear); the margins are shown either way. Association only, not cause. |
| R6.S1 | Event study untuk melihat perubahan energy use | R6-01, R6-02 and R6-06 planned | partial (R6-01: event study of energy used +9%, before-start p = 0.027, year by year in the CSV) | not done — event-study product was status-only (K003) | R2-03's model: firm and year fixed effects, years −5 to +5 around the start, outer years grouped. |
| R6.T1 | (exporter =) firm starting to export; comparison = never seen exporting | R6-01 | done (R2's rule A, comparison group and window reproduced exactly; cross-checked against R2's tables) | not done | R2's start rule A and window, copied; 743 starters, 4,945 never-exporters. |
| R6.O1 | (energy productivity) value added per GJ | R6-01 | done (= Figure R2-03: value added per GJ +9%, not clear; nominal) | not done | Equals Figure R2-03 (cross-checked). Nominal value added. |
| R6.O2 | (carbon productivity) value added per tonne of CO2 | R6-01, R6-05 planned | done (R6-01 = Figure R2-04: value added per tonne of CO2 +10%, not clear) | not done | Equals Figure R2-04 (cross-checked). |
| R6.M1 | (margin) scale: value added and output | R6-01 | done (value added +19%, output +14%, both clear; nominal) | not done |  |
| R6.M2 | (margin) energy used, GJ | R6-01, R6-02 planned | partial (R6-01: energy used +9%, not clear, already differed before the start) | not done |  |
| R6.M3 | (margin) fuels burned vs bought electricity (scope-1 vs scope-2 energy) | R6-02, R6-03 | planned | not done | Same rows for both (fuel and bought electricity both above zero). |
| R6.M4 | (margin) fuel mix: oil products, coal, gas | R6-03 | planned | not done | Fuels asked change by year; a version with the four fuels asked every year. |
| R6.M5 | (margin) carbon content: CO2 per GJ of energy and of fuels | R6-01, R6-03 planned | partial (R6-01: CO2 per GJ of all energy −1%, not clear; per GJ of fuels in R6-03) | not done | CO2 is energy × standard factors: it moves only when the mix changes. |
| R6.M6 | (margin) own electricity: share of firms making it, own share of electricity used, amount | R6-04 | planned | not done | 2014–15 recorded for about half of firms: left out of the main version. |
| R6.M7 | (margin) scope 1 and scope 2 CO2: amounts and scope-2 share | R6-02, R6-03, R6-05 | planned | not done | Scope-2 CO2 moves exactly with bought electricity (one national factor a year). |
| R6.C1 | (check) ratios equal their parts on the same rows | R6-01 | done (parts = whole asserted at every marker in all 7 versions; independent check max gap 4e−15) | not done | Asserted marker by marker to 1e-6. |
| R6.C2 | (check) each firm counting equally vs big energy users counting more | R6-01 (energy-weighted version, CSV only), R6-03 planned | partial (R6-01: energy-weighted version unusable, weights act like about 19 starters and 2 never-exporters; kept in the CSV, left out of the notes) | not done | File totals are dominated by a few firms; never drawn. |
| R6.C3 | (check) firms with no energy, no fuel or no bought electricity reported separately | R6-02 | planned | not done | Zero rows cannot enter a log; their share is its own event study. |
| R6.C4 | (check) own electricity never added to energy | R6-04 | planned | not done | Fuel burned in generators is already counted in fuels. |
| R6.C5 | (check) CO2 with the grid factor held fixed; second set of emission factors | R6-05 | planned | not done | Grid factor annual 2010–14 only, then carried. |
| R6.C6 | (check) before-start differences and firm counts for each margin | R6-01, R6-06 planned | partial (R6-01: before-start p per row on the chart; energy used fails, p = 0.027) | not done | Energy and CO2 already fail the before-start check in R2-05. |
| R6.C7 | (check) R2's four staggered methods on the key margins | R6-06 | planned | not done |  |
| R6.C8 | (check) no mechanism or cause claimed from the margins | all | partial (R6-01 notes: "Shows timing, not which part caused what"; later exhibits to follow) | not done | Wording rule in every note. |
| R6.X1 | (extension) same margins for import starts, the one clear gain in R2 | R6-01 (table) | done (import starts: value added per tonne of CO2 +24%, energy −13%, both clear; = R2-08's panel, cross-checked) | not done | R2-08's repairs: 2017 import starts and doubtful energy records left out; years −4 to +4. |
| R6.U1 | (needed) real, price-adjusted value added | — | unavailable | — | The file has no price index (real value added and deflators are empty); nominal used, year effects remove the all-industry price change only. |
| R6.U2 | (needed) product-scope margin (changing products after exporting) | — | unavailable | — | No product-level data in the file. |

## How each exhibit was made

Each exhibit: one planning subagent → built and run here → one review subagent (numbers re-computed independently,
house style, Tufte, and "would a non-economist understand it?") → fixes → next exhibit.

| Exhibit | Plan | Built and run | Review | Non-economist check | Fixes | Status |
|---|---|---|---|---|---|---|
| R6-02 fuels burned vs bought electricity | planned | planned | planned | planned | planned | planned |
| R6-03 energy mix and carbon content | planned | planned | planned | planned | planned | planned |
| R6-04 own electricity around the export start | planned | planned | planned | planned | planned | planned |
| R6-05 CO2 under other emission factors | planned | planned | planned | planned | planned | planned |
| R6-06 support, before-start checks and R2's four methods per margin | planned | planned | planned | planned | planned | planned |
| R6-01 where the change in carbon productivity comes from | done (planner draft adopted) | done (GUI, 20 s; all R2 cross-checks pass) | FIX: 4 MUST (tables rounded twice, hollow dots undefined, energy-weighted counted in notes, tables too long); re-check PASS | No before fix; Yes after | 4 MUST applied from the reviewer's tested file; re-run verified byte-identical | done, reviewed |
