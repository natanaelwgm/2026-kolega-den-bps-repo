# R2 — internationalisation and energy efficiency (staggered start years): exhibit index

Development data — obscured values, fictional firm panel. Not BPS findings.

Run all: open `00_run.do`, check the two paths at the top, press Do. Each file below also runs on its own.
Item-by-item coverage of Deasy's row and the review record: [TRACKER.md](TRACKER.md).

**Stata add-ons this block needs** (install once; no file installs or updates anything; on a computer without internet, copy the
add-on folder from one that has them): `ssc install reghdfe`, `ssc install ftools`, `ssc install require` (all files from R2-03 on);
for R2-07 also `ssc install csdid`, `ssc install drdid`, `ssc install eventstudyinteract`, `ssc install avar`,
`ssc install did_imputation`, `ssc install did_multiplegt_dyn`, `ssc install gtools`. R2-08 uses `eventstudyinteract` and `avar` for its Sun–Abraham row only. If one of the R2-07 or
R2-08 method add-ons is missing, that method gets an "unavailable" row and the file still finishes.

| File | What it shows | Deasy's words it answers | Status |
|---|---|---|---|
| `01_export_entry_cohorts.do` → `figures/01_export_entry_cohorts.png`, `tables/01_export_entry_cohorts.csv` | How many firms start exporting in each year (and which firms cannot be dated), under the simple rule and the previous paper's stricter rule; the table repeats both for importing and 10%+ foreign ownership | "Stagged did" (start year per firm); "Mirip dengan paper kita sebelumnya hanya Ganti tahun" (previous paper's rule kept as rule B) | done, reviewed |
| `02_event_time_support.do` → `figures/02_event_time_support.png`, `tables/02_event_time_support.csv` | How many export starters are seen in each year before and after their start year (by start year), and how many comparison firms (never seen exporting) exist each calendar year; sets the year window (−5 to +5, outer years grouped) that the later before/after charts use | "Stagged did" (the firm counts the design stands on) | done, reviewed |
| `03_energy_efficiency_export_start.do` → `figures/03_energy_efficiency_export_start.png`, `tables/03_energy_efficiency_export_start.csv` | Value added per GJ of energy before and after firms start exporting, as % change since the year before the start, starters minus firms never seen exporting (firm and year fixed effects); average after the start; before-start checks | "Intertionalized and energy efficiency"; "Stagged did"; "Mirip dengan paper kita sebelumnya" (same outcome as the previous paper, ln VA per GJ) | done, reviewed |
| `04_co2_efficiency_export_start.do` → `figures/04_co2_efficiency_export_start.png`, `tables/04_co2_efficiency_export_start.csv` | Same event study for value added per tonne of CO2 (CO2 per unit of value added in the table) | "Intertionalized and energy efficiency" (emissions side; the previous paper's ln VA per CO2); "Stagged did" | done, reviewed |
| `05_energy_co2_va_export_start.do` → `figures/05_energy_co2_va_export_start.png`, `tables/05_energy_co2_va_export_start.csv` | The same before/after comparison for energy use, CO2 and value added separately (three panels, one scale): what moves when firms start exporting | "Intertionalized and energy efficiency" (where an efficiency change comes from); "Stagged did" | done, reviewed |
| `06_efficiency_by_start_year.do` → `figures/06_efficiency_by_start_year.png`, `tables/06_efficiency_by_start_year.csv` | Each start year compared only with never-exporters (never with earlier starters): value added per GJ after vs before the start, per start year, with averages for all, before-Paris and after-Paris starters; a version without doubtful energy records | "Stagged did" (the clean building block of a staggered design); "Mirip dengan paper kita sebelumnya" | done, reviewed |
| `07_efficiency_by_method.do` → `figures/07_efficiency_by_method.png`, `tables/07_efficiency_by_method.csv` | Value added per GJ after the export start under the previous paper's four methods (Callaway–Sant'Anna, Sun–Abraham, Borusyak–Jaravel–Spiess, de Chaisemartin–D'Haultfœuille) next to Figure R2-03's single regression, with Figure R2-06's average and the previous paper's stricter start rule as reference rows; each method's before-start check; each method's year-by-year path in the table | "Stagged did"; "Mirip dengan paper kita sebelumnya hanya Ganti tahun" (its four methods and its start rule on 2010–2022) | done, reviewed |
| `08_efficiency_import_foreign_start.do` → `figures/08_efficiency_import_foreign_start.png`, `tables/08_efficiency_import_foreign_start.csv` | Value added per GJ before and after firms start importing (a) or get a foreign owner with 10%+ of the capital (b), as % change since the year before the start, starters minus firms that never start (R2-03's model); each panel's average after the start and before-start check, for the repaired records (black) and for every start and record as filed (gray); value added per CO2, energy use and value added in the table | "Intertionalized and energy efficiency" (internationalisation beyond exporting); "Stagged did"; "Mirip dengan paper kita sebelumnya hanya Ganti tahun" (its import-start and foreign-owner-start treatments, ln VA per GJ) | done, reviewed |
| `09_other_efficiency_measures.do` → `figures/09_other_efficiency_measures.png`, `tables/09_other_efficiency_measures.csv` | The previous paper's six efficiency measures after the export start, one row each on one scale: value added and output per GJ of energy, value added and output per tonne of CO2, value added per GJ of bought electricity and per GJ of fuels; average of years 0 to +5 in R2-03's model, with and without doubtful energy records; firms per row; each row's before-start check; year-by-year paths, six more versions, an average against all years before the start, and three helper series in the table | "Intertionalized and energy efficiency"; "Stagged did"; "Mirip dengan paper kita sebelumnya hanya Ganti tahun" (its six outcomes: ln VA per GJ, ln output per GJ, ln VA per CO2, ln output per CO2, ln VA per electricity GJ, ln VA per fuel GJ) | done, reviewed |

## Details kept out of the figures

**01 — start years.** Rule A (main, "simple"): a firm starts in the first year it is seen participating after a
year it was seen not participating. Rule B (variant, "sustained"): the previous paper's rule — participating in
year t, not in both t−1 and t−2, and again in t+1, in exact calendar years (so with no 2016 file it can only date
starts in 2012–2014 and 2019–2021). The comparison group for both rules is firms never seen participating; firms
already participating when first seen are left out (the previous paper's code wrongly kept always-exporters as
comparisons). Mapping to the previous paper: export rule B = its `exp_imbr` (dated at the first export year; its
`exp_imbrc` dates the same pattern one year later); foreign-ownership rule A (10%+, after an observed year below
10%) is the closest match to its headline `fdi10`, and the foreign-ownership "sustained" columns match `fdi10_imbr`.
Import starts in 2017 are inflated by the jump in import share between 2015 and 2017 (likely a change in how imports
were recorded); foreign-ownership starts in 2020 are inflated by the 2020 anomaly (48% of firms foreign-owned).

**02 — support by years since the start.** A year since the start gets its own point in R2-03 to R2-05 only when
at least 30 starters with usable energy, CO2 and value added are seen in it AND starters from both before and after
the missing 2016 file are among them; further out only early (≤2015) or only late (≥2017) starters are seen, so
those years are pooled (≤ −6, ≥ +6). The window (−5 to +5) is written into every row of the CSV
(`window_first`, `window_last`, `min_firms`) so the later files read it. At −5 the only early starters are the 56
firms that started in 2015; at +5 the only late starters are the 19 firms that started in 2017. Comparison firms =
all rows of firms never seen exporting (2022 records direct exporters only, so no firm is "seen not exporting"
that year); 2,832 of 4,945 have two or more usable years, which firm fixed effects need. The previous paper's rule
(29 starters) never reaches 30 firms in any column: it supports one pooled comparison only (R2-07).

**03 — energy efficiency before and after the export start.** Model: log value added per GJ on one marker per
year since the start (−5 to +5; ≤ −6 and ≥ +6 pooled; −1 = reference), firm and year fixed effects (reghdfe),
standard errors clustered by firm; starters (simple rule) and firms never seen exporting (all their rows); 20,070
rows, 3,574 firms (742 starters); 2,017 firms with a single usable year drop out. Result on this file: average of
years 0 to +5 = +9% (95% interval −8% to +28%); only +5 is clearly above zero (+45%), and it rests on 169 starters
from before 2016 and just 19 from 2017. Before-start check: all starters p = 0.245, but starters seen not exporting
the year just before fail it (p < 0.001) — the two groups pull in opposite directions (−5 = +1.10 vs −0.48 log
points), so read the after-start dots with care. In 193 of the 700 reference-year rows export status is unknown,
and 42 starters have no −1 row. "Never seen exporting" can include firms that exported in years with unknown
status. The table also has energy per unit of value added (exactly the same result, other way up), and three
variants: the previous paper's age² control (age = years since the firm first appears in the file, as no founding
year exists), without the 2017 starters, and exact-dated starters only. Starters from different years are averaged
together; if the change differs by start year a dot can mix in other years. A method that keeps start years apart
(Sun–Abraham) moves each dot by at most 0.05 log points here; R2-07 checks this. The year window is computed in the
file with R2-02's rule and cross-checked against R2-02's table when present.

**04 — CO2 efficiency before and after the export start.** The R2-03 template with only the outcome changed;
same sample (20,070 rows, 3,574 firms, 742 starters). Average of years 0 to +5: +10% (95% interval −6% to +30%);
before-start check p = 0.276 for all starters, p < 0.001 for exact-dated starters. CO2 here is calculated from
fuel and electricity use at standard rates (not measured), so each dot equals R2-03's dot minus the change in CO2
per GJ (exact at all 12 dots): the chart can differ from R2-03 only when firms switch fuels. Bought electricity
uses one national factor per year (rising 2010–2014, fixed after); holding it fixed (`co2_variant_static_grid`)
moves each dot by at most 0.016 log points.

**05 — energy use, CO2 and value added separately.** Same sample, window and model as 03 and 04. Average of years
0 to +5: energy use +9% (95% interval −7% to +28%), CO2 +8% (−8% to +26%), value added +19% (+7% to +31%). So the
rise in value added per GJ in 03 comes from value added growing faster than energy use, not from firms using less
energy. Warning: before the start, starters' energy use (p = 0.027) and CO2 (p = 0.022) already changed differently
from never-exporters', while value added did not (p = 0.599), so the later energy and CO2 dots may partly continue a
pre-existing difference. Identities checked in the file: value added minus energy use equals 03's dot and value added
minus CO2 equals 04's (to 1e-15); when 03's and 04's tables are present the file cross-checks them and stops on any
mismatch. The note is wrapped by estimated printed width, so real-data numbers cannot run off the page.

**06 — one start year at a time.** For each start year g with 30+ starters seen before and after: calendar years
g−5 to g+5, starters of year g plus never-exporters, firm and year fixed effects (each start year its own), one
after-start marker; one stacked regression gives all start years at once (each equals its separate estimate,
asserted) and an interval that allows for never-exporters being reused across start years (firm clustering; about
5% wider than treating them as new firms). Average weighted by starters (Callaway–Sant'Anna's size weights):
−4% (95% interval −16% to +10%); equal weights −6.2%, weights by after-start rows +1.4%. Started before Paris +1%,
after −10%: no clear difference (p = 0.436). The only clear start year is 2022 (−53%): one year after the start, and
its file asks only about direct exports; without it the average is +2%. Before-start check: all starters p = 0.116,
starters seen not exporting the year just before p < 0.001 (a warning sign). Without doubtful energy records
(importers of unknown export status in years their energy records jump or drop; same definition as the R1 reviews):
+1% (−11% to +15%). Stricter group (seen not exporting the year just before): after-Paris −38.6%, Paris gap
p = 0.006, but it fails the before-start check and without doubtful records it is −15.7%, p = 0.326. Pretend starts
1/2/3 years early: −6% / −21% / −15% (p = 0.48 / 0.02 / 0.13); without doubtful records none is clear.
Why this average (−4%) differs from Figure R2-03's (+9%): R2-03 gives each year since the start the same weight,
while here each start year's 'after' is the average of its rows, so the start year itself (735 firms, −7%) counts
most and year +5 (188 firms, +41%) little; with the same comparisons as here and equal weights per year since the
start the average is +6%, combining start years as R2-03 does adds about 3 points, and the choice of base year almost
nothing. Both averages cross 0.

**07 — the previous paper's four methods.** Same starters (simple rule) and never-exporters as R2-03, log value added per GJ, no
control variables. Main number = average of years 0 to +5, each year counting equally. Averages: R2-03's model +9% (95% interval
−8% to +28%); Callaway–Sant'Anna +8% (−10% to +30%); Sun–Abraham +5% (−11% to +24%); Borusyak–Jaravel–Spiess +4% (−11% to +22%);
de Chaisemartin–D'Haultfœuille +8% (−10% to +30%). None is clearly different from zero. Before-start checks: p = 0.245 / 0.159 /
0.238 / 0.190 / 0.326; but Callaway–Sant'Anna's check over all years before the start (not only the five shown) gives p = 0.009,
a warning sign. The previous paper's single summary numbers: its two-way model with one on/off marker +1.0% (−11.8% to +15.7%),
Callaway–Sant'Anna +6.4%, Borusyak–Jaravel–Spiess +4.4%, de Chaisemartin–D'Haultfœuille +4.0%. The one-marker model is the one
number far from the others, which is what mixing start years does. Keeping start years apart (Sun–Abraham) moves each of R2-03's
dots by at most 0.047 log points.

Missing 2016 file: Callaway–Sant'Anna and de Chaisemartin–D'Haultfœuille count calendar years, so starters of 2017 (their year
before the start has no file) get no after-start estimate. Sun–Abraham and Borusyak–Jaravel–Spiess keep them. For de
Chaisemartin–D'Haultfœuille every missing year inside a firm's span gets an empty row with the export-start status filled in.
Without that, the package treats 2015→2017 as one year, and firms whose status is missing in their switch year become comparison
firms. With it, only never-exporters are comparisons. Its yearly results then equal Callaway–Sant'Anna's, as they should with
never-exporters as the only comparison and no control variables. Year labels: the package's Effect_1 = the start year,
Placebo_1 = the year before that.

The previous paper's stricter start rule dates 29 starters (2–11 per start year). Methods that estimate each start year alone give
meaningless numbers there, so this row uses Borusyak–Jaravel–Spiess over all start years at once, with its leave-out interval for
small groups: −21% (−59% to +53%), before-start p = 0.342. With each year counting equally: −27% (−62% to +40%). Without the 6 firms
that exported before their 0-0-1-1 pattern: −16% (−64% to +97%). Too few firms to say anything.

Differences from the previous paper: never-exporters are the only comparison (it also used firms not yet started for
Callaway–Sant'Anna and de Chaisemartin–D'Haultfœuille), no age² control, and Sun–Abraham's outer years are grouped (its code put
them into the reference year).

**08 — importing and foreign owners.**

Setup:
- Same start rule (simple rule A), model and year-window rule as R2-03. Comparison firms are firms never seen importing (a), or never
  seen with 10%+ foreign ownership (b). A firm stays a starter if it stops later, and many do: 30–69% of import starters are seen
  importing the next year.
- Both panels use years −4 to +4 (outer years grouped):
  - imports allow only −4 to +4, because with the 2017 starts left out no starter after the missing 2016 file reaches +5;
  - foreign owners allow −5 to +5.
- The average after the start is years 0 to +4, not 0 to +5 as in R2-03.

Three repairs of known recording problems. Each is re-checked in the file, with a WARNING if the data no longer show it:
1. **Import starts dated 2017 (459 firms) are left out completely.** Importers rise from 26% of firms in 2015 to 56% in 2017 and
   stay near 50%. Among firms not importing in both 2015 and 2018, 32% are recorded as importing in 2017, against 9–12% for such
   one-year blips in 2012–2014. Every other import start is seen not importing the year just before.
2. **All 2020 foreign-ownership answers are treated as unknown.** 47% of firms are marked foreign-owned in 2020, about 9% in other
   years. The 2020 answer says nothing about the firm: among firms not foreign-owned in both 2019 and 2021, 52% are marked
   foreign-owned in 2020, and among firms foreign-owned in both years only 50% are. Of the 854 starts dated 2020 as filed, 798
   become never foreign-owned (678 of them answer "no" after 2020) and 56 get a later start year (27 in 2021, 29 in 2022). That
   leaves 844 starters, 760 of them in the estimate.
3. **Doubtful energy records are left out: R2-06's definition, used differently.** The definition is importers with unknown export
   status in 2017 and 2019–2022, whose middle energy per unit of value added is 13× (2017) or 0.13–0.22× (2019–2022) the other rows'.
   - R2-03 to R2-07 keep them, because for export starts they fall on both sides of the comparison.
   - Here, in (a) they can only be starters' rows after the start (1,712 rows, 29% of those), so keeping them would put distorted
     records on one side only.
   - In (b) they are 25% of starters' rows and 18% of comparison rows.

Results (average of years 0 to +4, 95% interval, before-start check):

| Version | (a) Import | (b) Foreign owner |
|---|---|---|
| Main (black dots) | +29% (+14 to +46), p = 0.395 | +4% (−12 to +22), p = 0.409 |
| As filed (gray triangles) | +27% (+13 to +44), p = 0.202 | +12% (−2 to +28), p < 0.001, a warning sign |
| Doubtful records kept | +25% (+10 to +42) | +19% (+1 to +40), p = 0.078 |
| Starts and years before the missing file only (no known recording problem) | +33% (+10 to +59), 773 starters | −1% (−21 to +25), 368 starters |
| Start years kept apart (Sun–Abraham) | +35% (+19 to +54) | +4% (−13 to +24) |

- The import answer holds in every version.
- The foreign-owner answer is clear only when doubtful records are kept. Kept but given their own yearly average (review check), it
  is +10% (−6 to +28). So that +19% comes from the distorted records.
- Where the import rise comes from: less energy (−13%, −23 to −1; before-start p = 0.424) and more value added (+12%, +4 to +22).
  Value added was already changing differently before the start (p < 0.001), so that part may continue an earlier difference.
- Value added per CO2: +24% (import), +3% (foreign owner).

Review checks (not in the table):
- Non-importers with unknown export status in 2019–2021 show the same low energy records (0.14–0.30×) but are few (181 rows in (a),
  240 in (b)). Leaving them out too gives +29% / +6%. Leaving out every unknown-export row in 2017 and 2019–2022 gives +31% / +9%.
- Other 2020 repairs:
  - only "yes" answers unknown: +3%;
  - a 2020 "yes" counts when 2019 or 2021 agrees: +6%;
  - start years as filed with doubtful records out: +10%, but it fails the before-start check (p < 0.001).

Differences from the previous paper:
- simple start rule. Its stricter 0-0-1-1 rule dates 262 import and 105 foreign-owner starters (R2-01);
- never-starters are the only comparison;
- of its four methods, only Sun–Abraham is run here;
- its "any trade" start is not built.

**09 — the previous paper's six efficiency measures.**

Setup:
- Same starters (simple rule), never-exporters, rows, year window (−5 to +5) and model as R2-03. Rows 1 and 3 are exactly R2-03 and
  R2-04 (the file checks all 52 + 52 coefficients when their tables are present).
- The measures are the previous paper's (its `_s1` = the first set of conversion and emission factors, not "scope 1"). Energy =
  nine fuels + bought electricity. CO2 = both, at standard rates. Bought electricity = PLN + other suppliers, own generation
  excluded. Output = value added + inputs bought + an accounting gap, never below value added.
- The previous paper divided value added and output by a sector wholesale price index. This file has none, so current prices are
  used; year effects remove only the all-industry price change.
- The electricity and fuel rows leave out years with none recorded (5% and 10% of rows): 19,146 rows, 719 starters, 2,703
  never-exporters (electricity); 18,001 rows, 725 starters, 2,621 never-exporters (fuel). Mostly comparison firms drop.

Results (average of years 0 to +5, 95% interval, before-start p):

| Measure | Main | Without doubtful records | Firm-years with all six | Against the 5 years before the start |
|---|---|---|---|---|
| Value added per GJ | +9% (−8 to +28), p = 0.245 | +9% | +5% | +3% (−14 to +22) |
| Output per GJ | +4% (−11 to +22), p = 0.228 | +4% | −1% | 0% (−15 to +19) |
| Value added per CO2 | +10% (−6 to +30), p = 0.276 | +10% | +7% | +2% (−14 to +20) |
| Output per CO2 | +6% (−9 to +23), p = 0.307 | +5% | +1% | −1% (−16 to +17) |
| Value added per GJ of bought electricity | **+27% (+7 to +50)**, p = 0.788 | +24% (+4 to +48) | +24% (+4 to +47) | +17% (−2 to +41), p = 0.083 |
| Value added per GJ of fuels | −1% (−18 to +21), p = 0.333 | 0% | +3% | +5% (−14 to +27) |

- Output rows sit about 4 points below value-added rows: value added's share of output rises a little after the start (−4%,
  −10 to +1).
- **Bought electricity: borderline.**
  - The rise comes from value added growing (+20%) while bought electricity use does not clearly change (−5%, −19 to +11).
  - Starters' bought electricity is high in the year before the start and in the start year (+27%), then falls back. So the
    answer depends on the base: +27% against the year just before, +17% (not clear, p = 0.083) against the average of the 5
    years before. With the previous paper's imputation method (Borusyak–Jaravel–Spiess, review check) it is +19% (+1 to +40).
  - Without the 2017 starters: +29% (and +22% against the years before, clear).
  - Exact-dated starters: +36%, but they fail the before-start check (p = 0.002), and against the years before only 0%.
- Fuels: value added per GJ of fuels is flat because fuel burned rises with value added (+19%, −1 to +44).
- Before-start checks pass for all six (p = 0.228 to 0.788). Starters seen not exporting in the year just before fail in 5 of 6
  (p < 0.001 rows 1–4, 0.002 electricity; fuel 0.076).
- Also in the table: the previous paper's age² control and without the 2017 starters change no answer. Without every 2017 record
  (the year own-generation firms report far more fuel, mostly doubtful rows), value added per GJ of bought electricity is +29%.
- Identities checked in the file: output rows = value-added rows + output per unit of value added, marker by marker.
