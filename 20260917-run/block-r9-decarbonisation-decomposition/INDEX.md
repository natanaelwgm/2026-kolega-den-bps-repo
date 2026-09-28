# R9 — who decarbonised: within, reallocation, entry, exit: exhibit index

Development data — obscured values, fictional firm panel. Not BPS findings.

Run all: open `00_run.do`, check the two paths at the top, press Do. Each file below also runs on its own.
Item-by-item coverage of Bu Deasy's row and the review record: [TRACKER.md](TRACKER.md).

| File | What it shows | Bu Deasy's words it answers | Status |
|---|---|---|---|
| `01_aggregate_intensity_path.do` → `figures/01_aggregate_intensity_path.png/.pdf`, `tables/01_aggregate_intensity_path.csv`, `tables/01_aggregate_intensity_path_intervals.csv`, `tables/01_aggregate_intensity_path_table.pdf` | CO2 and energy per unit of value added for all manufacturing firms taken together, each year. Main line (extreme energy records set aside) and as-filed line, on a log scale. The three periods split up in R9-02 to R9-07. Table R9-01b: what the rule sets aside each year, and the line at other cut-offs. | "Who decarbonised Indonesian manufacturing …?" (the change to be explained); planning-note check "weights sum to one; aggregate = weighted firm ratio" | done, reviewed |

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
