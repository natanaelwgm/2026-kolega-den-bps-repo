# R6 — how exporters decarbonise: which margins move: exhibit index

Development data — obscured values, fictional firm panel. Not BPS findings.

Run all: open `00_run.do`, check the two paths at the top, press Do. Each file below also runs on its own.
Item-by-item coverage of Bu Deasy's row and the review record: [TRACKER.md](TRACKER.md).

| File | What it shows | Bu Deasy's words it answers | Status |
|---|---|---|---|
| `01_margins_export_start.do` → `figures/01_margins_export_start.png` (+ .pdf), `tables/01_margins_export_start.csv`, `tables/01_margins_export_start_table.pdf`, `tables/01_margins_export_start_regression.pdf` | After a firm starts exporting: the change in value added per tonne of CO2 and per GJ against firms never seen exporting, and the parts that make it up (value added, energy used, CO2 per GJ = energy mix, output). One dot per part = average of years 0 to +5. Every row uses the same firm-years, so the parts combine exactly. | "How do exporters decarbonise? What adjustment margins explain the energy/carbon productivity gains?"; "Event study untuk melihat perubahan energy use" | done, reviewed |

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
