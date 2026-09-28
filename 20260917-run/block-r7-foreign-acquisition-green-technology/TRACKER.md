# R7 tracker — foreign acquisition and greener technology, before and after Paris

Development data — obscured values, fictional firm panel. Not BPS findings.

Bu Deasy's row R7 (PIC Schalke), verbatim: "Does FDI transmit greener technologies, and did this become stronger after
Paris?" — Strategy: "Event study around foreign acquisition" — Notes: "Brucal, Javorcik & Love menggunakan older SI dan
menemukan foreign acquisition menurunkan energy intensity sekitar 30%, meski total energy meningkat karena scale
expansion." Items in brackets are what an event study around foreign acquisition needs to answer that row.

Status words: **done** = an exhibit here answers the item on this dataset · **partial** = answered in part (says what is
missing) · **unavailable** = the dataset cannot answer it (says why) · **planned** = not built yet.
"Earlier" = the paper-repo row packet `requests/estimation/07-foreign-acquisition/` (planning only, 10 September 2026; no
Codex/Devin long report covered R7).

## Every item in Bu Deasy's row

| ID | Bu Deasy's item (verbatim) | Our exhibit(s) | Status | Earlier | Note |
|---|---|---|---|---|---|
| R7.Q1 | Does FDI transmit greener technologies | R7-04, R7-05, R7-07 | planned | not done — planning only | No equipment or process data: answered through energy and CO2 per unit of value added and fuel mix only. |
| R7.Q2 | and did this become stronger after Paris? | R7-06 | planned | not done — planning only | Acquired 2011–2015 vs 2017–2022, same years since acquisition; a gap would not prove Paris caused it. |
| R7.S1 | Event study around foreign acquisition | R7-04 (R7-05, R7-06, R7-07 build on it) | planned | not done — older FDI event-study code only | Same start rule and repairs as R2-08 (b). |
| R7.N1 | foreign acquisition menurunkan energy intensity sekitar 30% | R7-04 | planned | not done | Our own number reported; the cited 30% is not a target. |
| R7.N2 | meski total energy meningkat karena scale expansion | R7-05 | planned | not done | Energy used, value added, output and workers on one scale. |
| R7.N3 | Brucal, Javorcik & Love menggunakan older SI | — | unavailable | not done | The older SI years are not in this dataset (2010–2022 only). |
| R7.T1 | (acquisition =) a firm already seen domestic that becomes foreign-owned (10%+) | R7-01 | done (R7-01: first 10%+ answer after an earlier answer below 10%; firms foreign when first seen never counted; same dates as R2-08 (b); fictional links) | not done — no event definition | Firms foreign when first seen are never counted as acquisitions. |
| R7.T2 | (acquisition =) threshold crossings: minority (10–49%) vs majority (50%+); 10% vs other thresholds | R7-01, R7-07 | partial (R7-01: 744 majority / 100 minority at the start; 50% and above-0% rules give 772 and 850 starters (CSV); estimates by threshold planned in R7-07) | not done | Shares are almost all 0% or 100%, so thresholds pick nearly the same firms; minority starts too few for their own estimate. |
| R7.T3 | (acquisition =) reversals and one-year blips | R7-01, R7-07 | partial (R7-01: 447 of 559 back below 10% at the next answer, 508 of 844 ever, 341 one-year blips; mostly fictional links; estimate for firms still foreign planned in R7-07) | not done | 508 of 844 acquirers later revert in the fictional panel. |
| R7.T4 | (acquisition =) the 2020 foreign-ownership recording spike | R7-01, R7-07 | partial (R7-01: 2020 answers treated as unknown; as filed 854 starts, 56 re-dated later, 798 never foreign-owned; as-filed estimate planned in R7-07) | not done | All 2020 answers treated as unknown (R2-08 repair); as filed shown as a check. |
| R7.T5 | (acquisition =) stable firm identity across mergers and reorganisations | — | unavailable | not done | Firm links are fictional in this file; needs the real BPS files. |
| R7.O1 | (energy intensity =) energy used per unit of value added | R7-04, R7-06, R7-07 | planned | not done | Nominal value added (no price index in the file). |
| R7.O2 | (emissions side) CO2 per unit of value added | R7-04 | planned | not done | CO2 = energy × standard factors; differs from energy only through fuel mix. |
| R7.O3 | (total energy) energy used: total, fuels, bought electricity | R7-05 | planned | not done |  |
| R7.O4 | (scale expansion) value added, output, workers | R7-05 | planned | not done |  |
| R7.O5 | (emissions) CO2 total | R7-05 | planned | not done |  |
| R7.O6 | (greener technology, proxies) bought electricity share of energy, CO2 per GJ | R7-05 | planned | not done | Fuel mix, not technology. |
| R7.S2 | (needed for the event study) acquirers per year since acquisition; common years before and after Paris | R7-02 | done (R7-02: acquirers with usable data per year since acquisition, −12 to +11, by Paris period and by acquisition year; window −4 to +4 = ≥30 acquirers from both periods; 367 / 315 acquirers with usable years before and from the acquisition; 8,011 comparison firms, 3,397 with 2+ usable years; fictional links) | not done |  |
| R7.S3 | (needed) who gets acquired: acquirers before acquisition vs never-foreign firms | R7-03 | planned | not done | Acquirers are chosen, so a comparison cannot rule out target selection. |
| R7.S4 | (needed) no difference before the acquisition | R7-03, R7-04, R7-06, R7-07 | planned | not done |  |
| R7.S5 | (needed) other changes in the acquisition year (starting to export or import) | R7-01, R7-03, R7-07 | partial (R7-01 CSV: 125 export and 202 import starts in the acquisition year; 2017 import starts fall in the import recording jump; comparison in R7-03, estimate in R7-07) | not done | 15% start exporting and 24% start importing in the acquisition year. |
| R7.S6 | (needed) staggered methods (Callaway–Sant'Anna, Sun–Abraham, Borusyak–Jaravel–Spiess, de Chaisemartin–D'Haultfœuille) | R7-07 | planned | not done | R2-10 code. |
| R7.S7 | (needed) constant grid factor | R7-07 (R7-04 table) | planned | not done | `co2_variant_static_grid`. |
| R7.S8 | (needed) before vs after Paris at the same years since acquisition | R7-02, R7-06 | partial (R7-02: common years −4 to +4 set by ≥30 acquirers from both periods, shared by every R7 file; leaving out records in doubt removes 38% of after-Paris vs 6% of before-Paris acquirers' usable years; before-vs-after-Paris estimate planned in R7-06) | not done | Window −4 to +4 on this file (computed in each file). |

## How each exhibit was made

Each exhibit: one planning subagent → built and run here → one review subagent (numbers re-computed independently,
house style, Tufte, and "would a non-economist understand it?") → fixes → next exhibit.

| Exhibit | Plan | Built and run | Review | Non-economist check | Fixes | Status |
|---|---|---|---|---|---|---|
| R7-03 who gets acquired | planned | planned | planned | planned | — | planned |
| R7-04 energy and CO2 per unit of value added around acquisition | planned | planned | planned | planned | — | planned |
| R7-05 scale vs energy per unit of value added | planned | planned | planned | planned | — | planned |
| R7-06 before vs after Paris | planned | planned | planned | planned | — | planned |
| R7-07 robustness (methods, thresholds, repairs, constant grid factor) | planned | planned | planned | planned | — | planned |
| R7-01 acquisition registry by year | done (planner draft, tested in GUI and console Stata) | done (draft adopted; re-run after fixes, FINISHED) | done — FIX (3 MUST: unknown recorded as 0 in the registry block and in 7 CSV cells; title and notes now say "reported share crossing 10%, not a verified purchase"), re-check PASS | yes after the title and notes fix | reviewer's tested file adopted; registry block synced into R7-02 and R7-03 | done |
| R7-02 acquirers per year since acquisition, before vs after Paris | done (planner draft, tested in GUI and console Stata; independent recounts) | done (draft adopted; registry block re-synced after the R7-01 fixes, FINISHED) | done — FIX (3 MUST: note says "reported share, not a verified purchase" and why no acquisition is dated in 2016 or 2020; "never seen 10%+ foreign-owned"; shared window block says to run on all rows and stops with a plain message), all numbers recomputed and equal; re-check PASS | yes after the two note fixes | reviewer's tested file adopted (CSV byte-identical); window block synced into R7-03 | done |
