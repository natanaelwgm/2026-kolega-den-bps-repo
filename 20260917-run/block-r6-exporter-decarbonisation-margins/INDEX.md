# R6 — how exporters decarbonise: which margins move: exhibit index

Development data — obscured values, fictional firm panel. Not BPS findings.

Run all: open `00_run.do`, check the two paths at the top, press Do. Each file below also runs on its own.
Item-by-item coverage of Bu Deasy's row and the review record: [TRACKER.md](TRACKER.md).

<!-- tables-start -->
Tables that go with the charts: every chart has a table PDF with each plotted point and its number (`_table.pdf`); charts built from regressions also have the full regression table (`_regression.pdf`).

- 01: `tables/01_margins_export_start_regression.pdf`, `tables/01_margins_export_start_table.pdf`
- 02: `tables/02_fuels_vs_electricity_regression.pdf`, `tables/02_fuels_vs_electricity_table.pdf`
- 03: `tables/03_energy_mix_shares_regression.pdf`, `tables/03_energy_mix_shares_table.pdf`
<!-- tables-end -->


| File | What it shows | Bu Deasy's words it answers | Status |
|---|---|---|---|
| `01_margins_export_start.do` → `figures/01_margins_export_start.png` (+ .pdf), `tables/01_margins_export_start.csv`, `tables/01_margins_export_start_table.pdf`, `tables/01_margins_export_start_regression.pdf` | After a firm starts exporting: the change in value added per tonne of CO2 and per GJ against firms never seen exporting, and the parts that make it up (value added, energy used, CO2 per GJ = energy mix, output). One dot per part = average of years 0 to +5. Every row uses the same firm-years, so the parts combine exactly. | "How do exporters decarbonise? What adjustment margins explain the energy/carbon productivity gains?"; "Event study untuk melihat perubahan energy use" | done, reviewed |
| `02_fuels_vs_electricity.do` → `figures/02_fuels_vs_electricity.png` (+ .pdf), `tables/02_fuels_vs_electricity.csv`, `tables/02_fuels_vs_electricity_table.pdf`, `tables/02_fuels_vs_electricity_regression.pdf` | After a firm starts exporting: fuels burned on site (source of scope-1 CO2) and electricity bought from PLN and other suppliers (source of scope-2 CO2), year by year, starters minus never-exporters, on the same firm-years (both above 0); plus the share of firm-years burning no fuel or buying no electricity. | "How do exporters decarbonise? What adjustment margins explain the energy/carbon productivity gains?"; "Event study untuk melihat perubahan energy use" | done, reviewed |
| `03_energy_mix_shares.do` → `figures/03_energy_mix_shares.png` (+ .pdf), `tables/03_energy_mix_shares.csv`, `tables/03_energy_mix_shares_table.pdf`, `tables/03_energy_mix_shares_regression.pdf` | After a firm starts exporting, against firms never seen exporting: does its energy mix change (bought electricity's share of energy and of CO2; oil, coal and gas shares of fuel) and does CO2 per GJ change? One dot per row = average of years 0 to +5; beside each, the same row counted with only the four fuels asked in every file. | "What adjustment margins explain the energy/carbon productivity gains?"; "Event study untuk melihat perubahan energy use" | done, reviewed |

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

**03 — Energy mix and CO2 per GJ after an export start.**
- Same starters, never-exporters and model as R6-01 (shared sample block copied exactly; the CO2-per-GJ row reproduces R6-01's row (5), the file stops otherwise). 742 starters and 2,832 never-exporters; 20,070 firm-years, 18,001 of them with some fuel (fuel shares use only those).
- Main (all fuels in the file): oil products' share of fuel −4.3 points (95% interval −7.5 to −1.1) and gas's share +2.8 (0.3 to 5.3) are clearly different from 0; bought electricity's share of energy −1.3, electricity's share of CO2 −1.9, coal +1.5, CO2 per GJ −1.3% and CO2 per GJ of fuels −0.3% are not.
- **Not a clear fuel switch.** Counting only the four fuels asked in every file (diesel, petrol, coal, LPG), oil is −1.9 (−5.0 to 1.2) and gas +0.7 (−1.6 to 2.9), both not clear: part of the shift comes from fuels added to or dropped from the questions (kerosene asked 2010–2015, city gas 2010–2019, other gas 2012–2014 and 2017–2019, coal briquettes 2012–2014 and 2017–2022). The reviewer's check puts the whole clear gas rise in city gas and other gas (+2.1 points); LPG +0.7 is not clear; gas's share 2 to 5 years before the start was already about as high (+0.5 against those years).
- Coal's share already differed before the start (p = 0.035; 0.018 with the four fuels). It is clear only for starters seen not exporting the year before (+3.5), where the before-start check fails (p < 0.001).
- 2017: coal is 37% of the average firm's fuel (4–7% before, 13–20% after); leaving every 2017 row out keeps oil −4.8 and gas +3.3. The share of firms burning some coal stays high 2017–2019 (36–38%), which the year effects absorb only where starters and never-exporters are alike.
- Each firm's own shares count equally; the file's summed fuel is never used (a few firms make coal up to 99.9% of it in a year). Natural gas, biomass and fuel oils (2020–2022 only) are outside the energy total, so gas is under-counted then.
- CSV (728 rows): 8 rows (the 7 drawn + "burns some coal") × 7 versions (main, four every-year fuels, without 2017 rows, without doubtful records, without 2017 starters, exact starters, without 2018–19) × every year since the start. Oil stays clear in 4 of the 5 other versions and gas in 2 of 5 (the exact-starter version fails the before-start check for oil). Companion tables: every plotted point (1 page) and the regressions (2 pages; Panels B and C averages only, year by year in the CSV).
- CO2 = GJ × standard rates, so CO2 per GJ moves only with the mix. Shows timing, not cause; firm links are fictional: this tests the method, not a finding. Add-ons: reghdfe, ftools, require.
