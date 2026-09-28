# R9 — who decarbonised: within, reallocation, entry, exit: exhibit index

Development data — obscured values, fictional firm panel. Not BPS findings.

Run all: open `00_run.do`, check the two paths at the top, press Do. Each file below also runs on its own.
Item-by-item coverage of Bu Deasy's row and the review record: [TRACKER.md](TRACKER.md).

<!-- tables-start -->
Tables that go with the charts: every chart has a table PDF with each plotted point and its number (`_table.pdf`); charts built from regressions also have the full regression table (`_regression.pdf`).

- 01: `tables/01_aggregate_intensity_path_table.pdf`
- 02: `tables/02_fhk_decomposition_table.pdf`
- 03: `tables/03_melitz_polanec_decomposition_table.pdf`
- 06: `tables/06_reconciliation_toy_tests_table.pdf`
<!-- tables-end -->


| File | What it shows | Bu Deasy's words it answers | Status |
|---|---|---|---|
| `01_aggregate_intensity_path.do` → `figures/01_aggregate_intensity_path.png/.pdf`, `tables/01_aggregate_intensity_path.csv`, `tables/01_aggregate_intensity_path_intervals.csv`, `tables/01_aggregate_intensity_path_table.pdf` | CO2 and energy per unit of value added for all manufacturing firms taken together, each year. Main line (extreme energy records set aside) and as-filed line, on a log scale. The three periods split up in R9-02 to R9-07. Table R9-01b: what the rule sets aside each year, and the line at other cut-offs. | "Who decarbonised Indonesian manufacturing …?" (the change to be explained); planning-note check "weights sum to one; aggregate = weighted firm ratio" | done, reviewed |
| `02_fhk_decomposition.do` → `figures/02_fhk_decomposition.png/.pdf`, `tables/02_fhk_decomposition.csv`, `tables/02_fhk_decomposition_table.pdf` | Each period's change in CO2 and energy per unit of value added (all firms together), split with the FHK method into staying firms' own change (within), value added shifting among them (between, cross, and reallocation = between + cross), firms appearing (entry) and firms disappearing (exit), as % of the start level. Periods 2010→15, 2015→18, 2018→22. Tables add CO2 per output, scope 1 and scope 2, the as-filed version, the whole span and the year-to-year chain. | "Who decarbonised Indonesian manufacturing: firms becoming cleaner or production reallocating toward cleaner firms?"; "Accounting decomposition, bukan causal regression. FHK decomposition … Within + reallocation + entry + exit." | done, reviewed |
| `03_melitz_polanec_decomposition.do` → `figures/03_melitz_polanec_decomposition.png/.pdf`, `tables/03_melitz_polanec_decomposition.csv`, `tables/03_melitz_polanec_decomposition_table.pdf` | The changes of R9-02 split the Melitz–Polanec way, for three periods (before, across and after Paris), CO2 and energy per unit of value added: staying firms' plain average (within), reallocation among them (covariance), the two together, firms appearing (entry), firms disappearing (exit), total. Table R9-03: every plotted point; Table R9-03b: each firm group's number, share of value added, plain average, weighted level and covariance term | "Who decarbonised Indonesian manufacturing: firms becoming cleaner or production reallocating toward cleaner firms?"; "Melitz–Polanec dynamic decomposition. Within + reallocation + entry + exit." | done, reviewed |
| `06_reconciliation_toy_tests.do` → `figures/06_reconciliation_toy_tests.png`, `tables/06_reconciliation_toy_tests_cases.csv`, `tables/06_reconciliation_toy_tests_data.csv`, `tables/06_reconciliation_toy_tests_table.pdf` | Table: do the two bookkeeping methods (FHK and Melitz–Polanec) split a change correctly? (a) six made-up examples with hand-worked answers; (b) on the data, the parts add up to the actual change in every period, measure, sample and group | "Accounting decomposition … FHK decomposition + Melitz–Polanec dynamic decomposition. Within + reallocation + entry + exit." | done, reviewed |

## Details kept out of the figures

**01 — CO2 and energy per unit of value added, all firms together.**
- **Definition.** Level = total CO2 (or GJ) divided by total value added (nominal, masked money units).
- **Checks.** Asserted to equal the value-added-weighted average of firm ratios, with weights summing to one, every year
  and in every period sample.
- **Main line.** Sets aside a firm-year whose energy per unit of value added is over 100 times its 2-digit sector's
  median that year: 280 firm-years (160 in 2017, 3–27 in other years).
  - These records are extreme because of their energy, not their value added.
  - They are at most 4.8% of a year's firm-years but hold up to 99% of a year's CO2 (82% in 2015, 80% in 2017, 99% in
    2021).
- **Cut-off sensitivity.** The cut-off has no natural break and the main line moves with it: at 300× the 2018→2022
  change is +38% instead of −19% (Table R9-01b; R9-07). The 2013 main value (62.6) rests on one record at 50–100× its
  sector median, which holds 58% of that year's CO2.
- **Periods and firm groups** (used verbatim by R9-02 to R9-07):
  - Stayers, entrants and leavers are defined on each period's two years.
  - A stayer with an extreme record, or outside the universe (energy 0), in either year is set aside in both years, so
    it does not become a fake entrant or leaver.
  - Period start and end levels are therefore computed on the period sample and differ slightly from the yearly line:
    2010 27.33 vs 27.50; at most 0.6% for the three periods; about 4% for the 2015→2017 pair. Both are in
    `_intervals.csv`.
  - Main periods, CO2 per million of value added: 2010→2015 +39%, 2015→2018 −45%, 2018→2022 −19%.
- **Limits.** Nominal value added only (no deflators), so price rises alone lower the level. The 2017 recording jump and
  the doubtful 2019–22 records are drawn hollow gray. Firm links are fictional, so entry and exit here are sample
  rotation.

**06 — Do the two methods add up? Made-up examples and checks on the data.** This file holds and tests the two programs every later R9 file copies: `r9_fhk` (FHK: within, between, cross, entry, exit, all measured against the start-year level) and `r9_mp` (Melitz–Polanec: staying firms' plain average, staying firms' shift of value added, entry against staying firms in the end year, exit against staying firms in the start year). Formulas checked against the published definitions and by an independent reviewer script. (a) Six made-up examples (no change; firms get cleaner; value added moves to the cleaner firm; a cleaner firm appears; a dirtier firm disappears; all at once) plus a set-aside test: the programs return the hand answer to 12 decimals in all 98 checks. Example 5 shows why the two methods give different entry/exit parts (FHK exit −1.5 plus between −1.5; Melitz–Polanec exit −3) while both add to the same change. (b) On the data, samples built with the R9-01 rule (`r9_interval_sample`): 150 decompositions per method (3 periods, 11 consecutive pairs, 2010→2022; CO2 and energy per value added, CO2 per output, scope 1 and scope 2; as filed and main) plus 1,810 sector / export / import / foreign-owned group runs; the largest gap between the parts and the actual change is 3.6e-13 of the level (computer rounding); shares add to 1; scope 1 + scope 2 parts = total parts. The period levels equal R9-01's period table; they differ slightly from R9-01's yearly line (2015: 38.059 at the end of 2010→2015, 38.055 at the start of 2015→2018, 38.053 on the yearly line) because a firm set aside in one year of a period is set aside in both. Checks the arithmetic only; entry and exit on this file are rotation of fictional firm links.

**02 — FHK split: staying firms' own change, reallocation, firms appearing and disappearing.**
- **Method.** FHK (Foster, Haltiwanger, Krizan) on the R9-01 period samples. Program `r9_fhk`, tested in R9-06. The
  parts add up to the change within 1e-9 of the level (asserted in all 150 runs). Parts are shown as % of the period
  sample's start level, which differs slightly from Figure R9-01's yearly line.
- **Main periods, CO2 per unit of value added** (total = within + between + cross + entry + exit):
  - 2010→2015: +39% = +26 + 28 − 41 + 27 − 0.
  - 2015→2018: −45% = +21 + 22 − 50 − 33 − 4.
  - 2018→2022: −19% = +50 + 34 − 86 − 6 − 12.
  - Energy is similar: +28%, −53% and −25%.
- **Reading.** Within, between and cross are large but mostly cancel: together they come to +12, −7 and −1% for CO2.
  - The cause is staying firms whose value added fell: 245, 513 and 772 firms holding 75–83% of staying firms' start
    value added.
  - These firms look dirtier at the end (within +) and hold a smaller share (cross −).
  - This is masked-data noise in value added. With output weights (CO2 per output, Table R9-02b) the cross term is much
    smaller.
  - So on this file "reallocation lowered CO2" and "staying firms got dirtier" are not findings.
- **Entry and exit.** Firms seen in only one year hold 57–83% of value added, but firm links are fictional, so these
  parts are sample rotation and mean nothing here. They will mean something on the real BPS files.
- **Limits.**
  - Nominal value added, so price rises alone lower the ratios.
  - The 2015→2018 period spans the missing 2016 file.
  - 2018→2022 uses partly doubtful energy records.
  - CO2 = energy × standard factors, so CO2 and energy differ only through the fuel mix.
  - Energy covers only some fuels.
  - Bookkeeping, not cause.
- **As filed** (extreme records kept), the split is dominated by a few records: 2010→2015 CO2 +669%, of which entry
  +644% (Table R9-02b).

**03 — Melitz–Polanec split.**
- **What it splits.** Each period's change in CO2 (or energy) per unit of value added, all firms together, split into
  four parts that add up exactly:
  - within = change in the staying firms' plain average (each firm counts once);
  - reallocation = change in how far their value-added-weighted level sits from that plain average (the Olley–Pakes
    covariance × number of firms);
  - entry = appearing firms' share × their gap to staying firms in the end year;
  - exit = disappearing firms' share × staying firms' gap to them in the start year.
- **Checks.** The period levels are R9-01's period-sample levels. The four parts add up to 1e-14 of the level in all
  150 runs (3 periods, whole span, 11 year pairs × 5 measures × main and as filed).
- **Main, CO2 / energy, % of the start level:**
  - Before Paris (2010–15): within −80 / −128; reallocation +155 / +173; staying firms together +75 / +46; entry
    −35 / −16; exit 0 / −2; total +39 / +28.
  - Across Paris (2015–18): −22 / −35; −4 / +6; −26 / −30; −9 / −2; −10 / −21; total −45 / −53.
  - After Paris (2018–22): +17 / +7; −16 / −1; +2 / +5; +12 / +8; −33 / −38; total −19 / −25.
- **Not R9-02's within.** R9-02 weights each staying firm by its value added: CO2 +26 / +21 / +50. This file's plain
  average is −80 / −22 / +17. So in 2010–15 and 2015–18 big staying firms got dirtier while the typical staying firm got
  cleaner. Both are correct; they answer different questions.
- **Reallocation is not only value added moving.** It also moves when big firms change differently from small ones.
  In 2010–15 almost all of the +155 is that (+165); value added moving between staying firms is −9.5 (split with
  start-year shares).
- **Huge cancelling parts before Paris.** The −80 comes mostly from a few small firms with very high ratios: the 1% of
  staying firms with the highest 2010 ratios carry −53 points, and the median staying firm moved −14%. Read the two
  staying-firm parts together (the "staying firms together" row).
- **Limits.**
  - Firm links are fictional, so entry and exit (57–83% of value added) are sample rotation and mean nothing. The total
    is the real change of Figure R9-01.
  - Melitz–Polanec parts do not add up firm by firm, so there are no group versions: R9-04 and R9-05 use FHK.
  - CSV only: as filed, CO2 per output, scope 1 and scope 2, whole span, year pairs with running sums.
  - Nominal value added; bookkeeping, not cause.
