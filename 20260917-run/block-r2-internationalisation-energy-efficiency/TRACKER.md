# R2 tracker — internationalisation and energy efficiency (staggered start years)

Development data — obscured values, fictional firm panel. Not BPS findings.

Deasy's row R2 (PIC Toar), verbatim: "Intertionalized and energy efficiency" — Strategy: "Stagged did" — Notes: "Mirip dengan paper kita sebelumnya hanya Ganti tahun…". Items in brackets are what a staggered design needs to answer that row.

Status words: **done** = an exhibit here answers the item on this dataset · **partial** = answered in part (says what is
missing) · **unavailable** = the dataset cannot answer it (says why) · **planned** = not built yet.
"Earlier" = the Codex/Devin long report of 15 September 2026 (`Deasy-Imed-R123-20260915/outputs/R2/R2.pdf`).

## Every item in Deasy's row

| ID | Deasy's item (verbatim) | Our exhibit(s) | Status | Earlier Codex/Devin report | Note |
|---|---|---|---|---|---|
| R2.Q1 | Intertionalized and energy efficiency | R2-03 to R2-08 | partial (R2-03 done: energy efficiency around the export start, +9% on average after, interval −8% to +28%) | not done — no estimate anywhere |  |
| R2.T1 | (internationalised =) starting to export | R2-01 (start years), R2-02 to R2-07 | partial (R2-01 done: start years) | partial — rule and counts, no estimate | Main rule: first year seen exporting after a year seen not exporting. |
| R2.T2 | (internationalised =) starting to import | R2-01 (table), R2-08 | partial (R2-01 done: start years, table only) | partial — counts, no estimate | 2017 import starts inflated by the 2015→2017 jump in import share. |
| R2.T3 | (internationalised =) gaining a foreign owner (10%+) | R2-01 (table), R2-08 | partial (R2-01 done: start years, table only) | partial — 66% of starts dated 2020 (data error, not flagged) | 2020 foreign-ownership anomaly flagged. |
| R2.O1 | Energy efficiency (as in the previous paper: VA/GJ, VA/CO2; also output/GJ, output/CO2, VA per electricity GJ, VA per fuel GJ) | R2-03, R2-04, R2-05, R2-07 | partial (R2-03 done: VA/GJ and its mirror) | partial — only VA/GJ and VA/CO2 defined, no values | Nominal value added only (no price index in this file). |
| R2.S1 | Stagged did | R2-03 to R2-07 | partial (R2-03 done: event study with firm and year fixed effects) | not done — equations with invented numbers |  |
| R2.S2 | Mirip dengan paper kita sebelumnya (its estimators: imputation, Sun–Abraham, de Chaisemartin–D'Haultfœuille, Callaway–Sant'Anna) | R2-06, R2-07 | planned | not done — none run |  |
| R2.S3 | hanya Ganti tahun (2010–2022 window) | R2-01 (both entry rules side by side) and all R2 files | partial (R2-01 done: previous rule rebuilt on 2010–2022) | partial — window handled, rest redesigned | Previous paper's entry rule kept as named rule B (29 export starters). |
| R2.S4 | (needed for staggered DID) firms per start year and per year-from-start | R2-01, R2-02 | done (R2-01 per start year; R2-02 per year since the start, window −5..+5) | partial — counts only in a CSV |  |
| R2.S5 | (needed for staggered DID) no difference before the start | R2-03, R2-04, R2-07 | partial (R2-03: passes for all starters, fails for exact-dated starters) | not done — theory only |  |

## How each exhibit was made

Each exhibit: one planning subagent → built and run here → one review subagent (numbers re-computed independently,
house style, Tufte, and "would a non-economist understand it?") → fixes → next exhibit.

| Exhibit | Plan | Built and run | Review | Non-economist check | Fixes | Status |
|---|---|---|---|---|---|---|
| R2-01 export start years | done | done | FIX → fixed → re-check FIX (PDF clipped the notes) → fixed → PASS (numbers matched an independent recount) | passed after notes were shortened and jargon removed | shorter notes; y-axis step scales with the counts (works on real data); PDF checked | done |
| R2-02 support by years since the start | done (planner also drafted the file; executor read and adopted it) | done | FIX → fixed → PASS on re-check (all counts matched an independent recount) | failed first (did not say why it matters or why outer years are grouped) → fixed | notes explain the later charts, the grouping and the previous rule; consistent 2016 key | done |
| R2-03 energy efficiency before/after the export start | done (planner also drafted the file; executor read and adopted it) | done | FIX → fixed → PASS on re-check (event study re-estimated independently; all versions matched) | failed first (did not name the comparison; no overall answer; before-start check one-sided) → fixed | subtitle names the comparison; average after the start and both before-start checks in the notes; year window computed in the file | done |
