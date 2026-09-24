# R3 tracker — who reduces energy use and emissions, and with what traits

Development data — obscured values, fictional firm panel. Not BPS findings.

Deasy's row R3 (PIC Toar), verbatim: "Siapa yang reduce energy use and emisi? Lebih ke determinan motivasi apa yg membuat firms respond to climate commitment.. Tambahan: Siapa yang impor lebih banyak (EGs) environment goods list (termasuk solar panel, dll)" — Strategy: "FE" — Notes: "Bukan kausal, tp mengetahui firms mana yg respond thd climate and motivasinya apa".

Status words: **done** = an exhibit here answers the item on this dataset · **partial** = answered in part (says what is
missing) · **unavailable** = the dataset cannot answer it (says why) · **planned** = not built yet.
"Earlier" = the Codex/Devin long report of 15 September 2026 (`Deasy-Imed-R123-20260915/outputs/R3/R3.pdf`).

## Every item in Deasy's row

| ID | Deasy's item (verbatim) | Our exhibit(s) | Status | Earlier Codex/Devin report | Note |
|---|---|---|---|---|---|
| R3.Q1 | Siapa yang reduce energy use | R3-01 (definition, yearly shares), R3-02, R3-03, R3-04 | partial (R3-01 to R3-03 done: how many; which size/trade/ownership groups; which sectors) | partial — traits only, no share of firms, no groups or sectors |  |
| R3.Q2 | … and emisi | R3-01, R3-02, R3-03, R3-04 | partial (R3-01 to R3-03 done; total CO2 included) | partial — same; no scope split |  |
| R3.Q3 | Lebih ke determinan motivasi apa yg membuat firms respond to climate commitment | R3-02 to R3-07 | partial (R3-02 to R3-05 done: traits and stand-ins; motives themselves not asked) | partial — associations with a few traits |  |
| R3.Q3a | … size | R3-02, R3-04 | done (R3-02 shares; R3-04 FE: no clear size gap per unit of VA) | fulfilled |  |
| R3.Q3b | … export status | R3-02, R3-04 | done (R3-02, R3-04: no clear exporter gap) | fulfilled |  |
| R3.Q3c | … import status | R3-02, R3-04 | done, with caveat (R3-04: importer gap rests on 2017 changes and flips without them) | partial — 2017 jump not flagged |  |
| R3.Q3d | … foreign ownership | R3-02, R3-04 | done (2020 status not used; no clear gap per unit of VA) | partial — 2020 spike not flagged |  |
| R3.Q3e | … productivity | R3-07 | planned | partial — labour productivity only |  |
| R3.Q3f | … R&D / innovation | R3-05 | done (R3-05: no clear gap per unit of VA) | partial — add-on model only | Only some years carry these questions. |
| R3.Q3g | … environmental documents / regulation (AMDAL, UKL-UPL, SPPL, waste treatment) | R3-05 | done (2020–22 only; no clear gap per unit of VA; totals mostly fall-back) | not done | Only 2020–2022 carry these questions. |
| R3.Q3h | … sector | R3-03, R3-04 | done (R3-03: sectors differ; R3-04 holds sector fixed) | not done |  |
| R3.Q3i | … province | R3-04 | partial (R3-04 holds province fixed; no province-by-province chart) | not done |  |
| R3.Q3m | … self-generation of electricity | R3-04, R3-06 | done (R3-06: reducers make own electricity more often, but mostly from the 2017 recording change; without it no robust difference either way) | partial — one add-on trait |  |
| R3.Q3n | … starting energy level (high users fall back) | R3-01 (notes), R3-04 | done (R3-04 separate model; partly automatic) | fulfilled |  |
| R3.Q3o | … direct motivation (climate commitment, buyer pressure, parent policy) | — | unavailable | blocked | No survey question measures motivation. |
| R3.Q4 | Tambahan: Siapa yang impor lebih banyak (EGs) environment goods list (termasuk solar panel, dll) | R3-08 (unavailable exhibit) | planned | blocked | No firm-by-product import records in this file. |
| R3.S1 | FE | R3-04 | done (year+sector+province, firm+year, sector×year+province×year) | fulfilled |  |
| R3.N1 | Bukan kausal, tp mengetahui firms mana yg respond thd climate and motivasinya apa | All R3 files (association wording); R3-01 to R3-03 answer 'which firms' | partial (R3-01 to R3-03 done) | fulfilled for framing; 'which firms' not answered |  |

## How each exhibit was made

Each exhibit: one planning subagent → built and run here → one review subagent (numbers re-computed independently,
house style, Tufte, and "would a non-economist understand it?") → fixes → next exhibit.

| Exhibit | Plan | Built and run | Review | Non-economist check | Fixes | Status |
|---|---|---|---|---|---|---|
| R3-01 reduction definition and yearly shares | done | done | FIX → fixed → PASS on re-check (numbers matched an independent recompute) | failed first (terms undefined, jumps unexplained) → fixed | shorter notes defining value added and 50%; units in panel titles; year-adjusted firm flag made the main flag | done |
| R3-02 who reduces, by size, exports, imports, foreign ownership | done | done | FIX → fixed → PASS on re-check (numbers matched an independent console recompute) | failed first (wording too technical; total CO2 missing) → fixed | plain title/axis; reading rule in notes; total CO2 panel added; yearly median kept in full precision (also fixed in R3-01, outputs unchanged) | done |
| R3-03 who reduces, by sector | done | done | FIX → fixed → PASS on re-check (all numbers matched an independent console recompute) | failed first (energy shares in labels misleading on masked data; price caveat backwards) → fixed | shares moved to the table; notes give the typical change of all firms and a chance benchmark built from the data | done |
| R3-04 fixed-effects associations (traits, other traits held fixed) | done (planner also drafted the file; executor read and adopted it) | done | FIX → fixed → PASS on re-check (all numbers reproduced with plain regress/xtreg) | failed first (too dense; did not name the year that drives the result) → fixed | only (A) and (B) drawn; notes name the driving year from the data; safe on real data (break year, zero workers) | done |
| R3-05 motivation stand-ins (permits, waste treatment, R&D, innovation) | done (planner also drafted the file; executor read and adopted it) | done | FIX → fixed → PASS on re-check (all 60 shares and FE rows matched independently) | failed first ("not recorded" rows read like results; total gaps partly automatic fall-back) → fixed; R3-02 notes got the same fall-back sentence (re-checked, PASS) | notes say blank rows are not a result and give the fall-back from the data | done |
| R3-06 own electricity: reducers vs non-reducers | done (planner also drafted the file; executor read and adopted it) | done | FIX → fixed → PASS on re-check (all numbers reproduced independently) | failed first (2017 effect and start-size fall-back not said; gray rows unlabelled) → fixed | notes explain the 2017 recording change, the fall-back, and why switching to own power does not fake a cut | done |
