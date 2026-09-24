# R2 — internationalisation and energy efficiency (staggered start years): exhibit index

Development data — obscured values, fictional firm panel. Not BPS findings.

Run all: open `00_run.do`, check the two paths at the top, press Do. Each file below also runs on its own.
Item-by-item coverage of Deasy's row and the review record: [TRACKER.md](TRACKER.md).

| File | What it shows | Deasy's words it answers | Status |
|---|---|---|---|
| `01_export_entry_cohorts.do` → `figures/01_export_entry_cohorts.png`, `tables/01_export_entry_cohorts.csv` | How many firms start exporting in each year (and which firms cannot be dated), under the simple rule and the previous paper's stricter rule; the table repeats both for importing and 10%+ foreign ownership | "Stagged did" (start year per firm); "Mirip dengan paper kita sebelumnya hanya Ganti tahun" (previous paper's rule kept as rule B) | done, reviewed |

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
