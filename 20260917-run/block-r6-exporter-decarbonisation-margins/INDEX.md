# R6 — how exporters decarbonise: which margins move: exhibit index

Development data — obscured values, fictional firm panel. Not BPS findings.

Run all: open `00_run.do`, check the two paths at the top, press Do. Each file below also runs on its own.
Item-by-item coverage of Bu Deasy's row and the review record: [TRACKER.md](TRACKER.md).

<!-- tables-start -->
Tables that go with the charts: every chart has a table PDF with each plotted point and its number (`_table.pdf`); charts built from regressions also have the full regression table (`_regression.pdf`).

- 01: `tables/01_margins_export_start_regression.pdf`, `tables/01_margins_export_start_table.pdf`
- 02: `tables/02_fuels_vs_electricity_regression.pdf`, `tables/02_fuels_vs_electricity_table.pdf`
- 03: `tables/03_energy_mix_shares_regression.pdf`, `tables/03_energy_mix_shares_table.pdf`
- 04: `tables/04_own_electricity_regression.pdf`, `tables/04_own_electricity_table.pdf`
<!-- tables-end -->


| File | What it shows | Bu Deasy's words it answers | Status |
|---|---|---|---|
| `01_margins_export_start.do` → `figures/01_margins_export_start.png` (+ .pdf), `tables/01_margins_export_start.csv`, `tables/01_margins_export_start_table.pdf`, `tables/01_margins_export_start_regression.pdf` | After a firm starts exporting: the change in value added per tonne of CO2 and per GJ against firms never seen exporting, and the parts that make it up (value added, energy used, CO2 per GJ = energy mix, output). One dot per part = average of years 0 to +5. Every row uses the same firm-years, so the parts combine exactly. | "How do exporters decarbonise? What adjustment margins explain the energy/carbon productivity gains?"; "Event study untuk melihat perubahan energy use" | done, reviewed |
| `02_fuels_vs_electricity.do` → `figures/02_fuels_vs_electricity.png` (+ .pdf), `tables/02_fuels_vs_electricity.csv`, `tables/02_fuels_vs_electricity_table.pdf`, `tables/02_fuels_vs_electricity_regression.pdf` | After a firm starts exporting: fuels burned on site (source of scope-1 CO2) and electricity bought from PLN and other suppliers (source of scope-2 CO2), year by year, starters minus never-exporters, on the same firm-years (both above 0); plus the share of firm-years burning no fuel or buying no electricity. | "How do exporters decarbonise? What adjustment margins explain the energy/carbon productivity gains?"; "Event study untuk melihat perubahan energy use" | done, reviewed |

## Details kept out of the figures

**01 — Carbon productivity after an export start, and its parts.**
- Sample and model are R2's, reproduced exactly: the file stops if R2-02/03/04/05/08/09's tables differ. 742 starters and 2,832 never-exporters in the estimate, 20,070 firm-years; firm and year fixed effects; standard errors clustered by firm.
- Value added per tonne of CO2: +10% after the start (95% interval −6% to +29%), not clearly different from 0. Value added per GJ: +9%, not clear either.
- The parts: value added +19% (clear); energy used +9% (not clear, and it already differed before the start, p = 0.027); CO2 per GJ −1% (not clear); output +14% (clear).
- In logs the rows add up exactly, marker by marker (asserted in all 7 versions): (1) = (3) − (4) − (5) and (2) = (3) − (4).
- The CSV (623 rows) holds every year-by-year coefficient for 7 outcomes × 7 versions:
  - main;
  - without doubtful energy records (hollow gray; moves no answer);
  - without 2017 starters;
  - exact starters (output loses clarity; before-start check fails for value added per CO2, per GJ and energy, p < 0.001);
  - without 2018–19;
  - energy-weighted: **unstable, not used** — its weights act like about 19 starters and 2 never-exporters;
  - import starts (R2-08's repairs, years −4 to +4): value added per tonne of CO2 +24% and energy −13%, both clear; value added +12%, but its before-start check fails (p < 0.001).
- Companion tables: every plotted point (1 page) and the 12 regressions behind the dots (2 pages, coefficient over standard error, no stars).
- CO2 = energy × standard rates, so CO2 per GJ moves only with the fuel and electricity mix. Value added and output are nominal (no price index in the file).
- Shows timing, not which part caused what. Firm links are fictional: this tests the method, not a finding. Add-ons: reghdfe, ftools, require.

**02 — Fuels burned vs bought electricity after an export start.**
- Same sample block and model as R6-01, copied unchanged (block checked byte-identical). Energy used on all usable rows reproduces R6-01 row (4) in 4 versions (52 values; the file stops otherwise).
- Drawn: firm-years with both fuel and bought electricity above 0 (17,088; 703 starters, 2,491 never-exporters), so both panels follow the same firms.
- Average of years 0 to +5: fuels burned +17% (95% interval −4% to +42%), bought electricity −3% (−17% to +14%); neither clear. Before the start neither differed clearly (p = 0.292, 0.215). Value added on the same rows +20% (clear), energy used +14% (not clear).
- Single years whose interval excludes 0: fuels +2 (+38%, clear in 3 of 5 versions); bought electricity −3 (−18%, 4 of 5) and the start year (+30%, 5 of 5). Of 24 dots about 1 would be clear by chance, so the averages are the answer. In (b) the year before the start and the start year both sit above the other years, so bought electricity rises around the start and then returns to its earlier level.
- Five versions (CSV): all; without doubtful energy records; without 2017 starters; without 2017 rows (coal recorded for far more firms that year); only starters seen not exporting the year before. Fuels burned runs +13% to +31% and is clear only in the last (+31%, 95% interval +4% to +65%, 479 starters, before-start p = 0.306); bought electricity runs −6% to −1% and is never clear.
- Each on its own rows: fuels +19% (18,001 firm-years), bought electricity −5% (19,146); neither clear.
- Firms that use none of one are counted, not hidden: 2,168 usable firm-years burn no fuel, 1,011 buy no electricity, 345 more record no energy at all. After the start the share burning no fuel moves +0.6 points and buying none +1.1 points (both unclear; 20,362 firm-years).
- CO2 from bought electricity moves exactly with bought electricity (one national rate a year, removed by the year effects; asserted at every point), so it is not drawn. CO2 from fuels = fuels + CO2 per GJ of fuels (−0.4%, not clear) = +16%.
- Bought electricity excludes power the firm makes itself (its fuel is already in fuels burned; own generation is R6-04).
- Companion tables: every plotted point (26 rows, 1 page) and the 10 regressions (2 pages: years, then model rows with fixed effects, weights and clustering; coefficient over standard error, no stars).
- Shows timing, not cause. Firm links are fictional: this tests the method, not a finding. Add-ons: reghdfe, ftools, require.
