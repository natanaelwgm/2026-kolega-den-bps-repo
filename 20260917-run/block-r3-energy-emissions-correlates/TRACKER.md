# R3 tracker — who reduces energy use and emissions, and with what traits

Development data — obscured values, fictional firm panel. Not BPS findings.

Deasy's row R3 (PIC Toar), verbatim: "Siapa yang reduce energy use and emisi? Lebih ke determinan motivasi apa yg membuat firms respond to climate commitment.. Tambahan: Siapa yang impor lebih banyak (EGs) environment goods list (termasuk solar panel, dll)" — Strategy: "FE" — Notes: "Bukan kausal, tp mengetahui firms mana yg respond thd climate and motivasinya apa".

Status words: **done** = an exhibit here answers the item on this dataset · **partial** = answered in part (says what is
missing) · **unavailable** = the dataset cannot answer it (says why) · **planned** = not built yet.
"Earlier" = the Codex/Devin long report of 15 September 2026 (`Deasy-Imed-R123-20260915/outputs/R3/R3.pdf`).

## Every item in Deasy's row

| ID | Deasy's item (verbatim) | Our exhibit(s) | Status | Earlier Codex/Devin report | Note |
|---|---|---|---|---|---|
| R3.Q1 | Siapa yang reduce energy use | R3-01 to R3-04, R3-06, R3-07, R3-09 | done (R3-01 how many firms cut energy use each year; R3-02 which size, trade and ownership groups; R3-03 which sectors; R3-09 which provinces; R3-04 traits held together; R3-06 own electricity; R3-07 productivity) | partial — traits only, no share of firms, no groups or sectors |  |
| R3.Q2 | … and emisi | R3-01 to R3-04, R3-06, R3-07, R3-09 | done (as R3.Q1, for CO2: total CO2 in every R3 file) | partial — same; no scope split |  |
| R3.Q3 | Lebih ke determinan motivasi apa yg membuat firms respond to climate commitment | R3-02 to R3-07, R3-09 | partial (R3-02 to R3-05 and R3-09 done: traits, place and stand-ins; motives themselves not asked) | partial — associations with a few traits |  |
| R3.Q3a | … size | R3-02, R3-04 | done (R3-02 shares; R3-04 FE: no clear size gap per unit of VA) | fulfilled |  |
| R3.Q3b | … export status | R3-02, R3-04 | done (R3-02, R3-04: no clear exporter gap) | fulfilled |  |
| R3.Q3c | … import status | R3-02, R3-04 | done, with caveat (R3-04: importer gap rests on 2017 changes and flips without them) | partial — 2017 jump not flagged |  |
| R3.Q3d | … foreign ownership | R3-02, R3-04 | done (2020 status not used; no clear gap per unit of VA) | partial — 2020 spike not flagged |  |
| R3.Q3e | … productivity | R3-07 | done (R3-07: reducers look more productive mostly because of 2017 and because value added is in both numbers; productive firms do not go on to cut energy use more often) | partial — labour productivity only |  |
| R3.Q3f | … R&D / innovation | R3-05 | done (R3-05: no clear gap per unit of VA) | partial — add-on model only | Only some years carry these questions. |
| R3.Q3g | … environmental documents / regulation (AMDAL, UKL-UPL, SPPL, waste treatment) | R3-05 | done (2020–22 only; no clear gap per unit of VA; totals mostly fall-back) | not done | Only 2020–2022 carry these questions. |
| R3.Q3h | … sector | R3-03, R3-04 | done (R3-03: sectors differ; R3-04 holds sector fixed) | not done |  |
| R3.Q3i | … province | R3-09, R3-04 | done (R3-09: per unit of value added no province or island group differs from the typical firm; gaps in total energy and CO2 are mostly start size; R3-04 holds province fixed) | not done | The file has province codes only, no names. |
| R3.Q3m | … self-generation of electricity | R3-04, R3-06 | done (R3-06: reducers make own electricity more often, but mostly from the 2017 recording change; without it no robust difference either way) | partial — one add-on trait |  |
| R3.Q3n | … starting energy level (high users fall back) | R3-01 (notes), R3-04 | done (R3-04 separate model; partly automatic) | fulfilled |  |
| R3.Q3o | … direct motivation (climate commitment, buyer pressure, parent policy) | — | unavailable | blocked | No survey question measures motivation. |
| R3.Q4 | Tambahan: Siapa yang impor lebih banyak (EGs) environment goods list (termasuk solar panel, dll) | R3-08 (unavailable exhibit) | unavailable (exhibit built, reviewed): total imports are imported raw materials only; not used as a stand-in. R1-01, R3-02, R3-04 show importers of any raw material, not environmental goods | blocked | No firm-by-product import records in this file. |
| R3.S1 | FE | R3-04 | done (year+sector+province, firm+year, sector×year+province×year) | fulfilled |  |
| R3.N1 | Bukan kausal, tp mengetahui firms mana yg respond thd climate and motivasinya apa | All R3 files | done (every R3 file says association, not cause; 'which firms' answered by R3-01 to R3-04, R3-06, R3-07, R3-09; motives only through stand-ins in R3-05) | fulfilled for framing; 'which firms' not answered |  |

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
| R3-07 productivity of reducers vs non-reducers | done (planner also drafted the file; executor read and adopted it) | done | FIX → fixed → PASS on re-check (all numbers reproduced independently) | failed first (2017 cause and coverage not said; productivity defined loosely) → fixed | notes explain 2017, coverage, that value added sits in both numbers; plain definition | done |
| R3-08 environmental-goods imports (unavailable) | done (planner also drafted the file; executor read and adopted it) | done | FIX → fixed (reviewer's tested patch) → PASS on re-check | failed first (answer text did not follow the status; jargon) → fixed | answer follows the status; plain wording; pointer cannot be read as an answer; Indonesian labels also searched | done |
| R3-09 who reduces, by province (added: closes R3.Q3i) | done (planner also drafted the file; executor read and adopted it) | done | FIX → fixed (reviewer's tested file) → PASS on re-check (all numbers matched an independent console recompute without panel lags) | failed first (the one visible total-energy gap was not tied to start size; the smaller-provinces marker looked solid in the PDF) → fixed | notes say provinces whose firms start high look better partly automatically; plain chance-count wording; hollow marker kept hollow in the PDF; shorter title | done |
