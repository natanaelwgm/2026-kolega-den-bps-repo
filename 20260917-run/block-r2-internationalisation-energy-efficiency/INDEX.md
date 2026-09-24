# R2 — internationalisation and energy efficiency (staggered start years): exhibit index

Development data — obscured values, fictional firm panel. Not BPS findings.

Run all: open `00_run.do`, check the two paths at the top, press Do. Each file below also runs on its own.
Item-by-item coverage of Deasy's row and the review record: [TRACKER.md](TRACKER.md).

| File | What it shows | Deasy's words it answers | Status |
|---|---|---|---|
| `01_export_entry_cohorts.do` → `figures/01_export_entry_cohorts.png`, `tables/01_export_entry_cohorts.csv` | How many firms start exporting in each year (and which firms cannot be dated), under the simple rule and the previous paper's stricter rule; the table repeats both for importing and 10%+ foreign ownership | "Stagged did" (start year per firm); "Mirip dengan paper kita sebelumnya hanya Ganti tahun" (previous paper's rule kept as rule B) | done, reviewed |

| `02_event_time_support.do` → `figures/02_event_time_support.png`, `tables/02_event_time_support.csv` | How many export starters are seen in each year before and after their start year (by start year), and how many comparison firms (never seen exporting) exist each calendar year; sets the year window (−5 to +5, outer years grouped) that the later before/after charts use | "Stagged did" (the firm counts the design stands on) | done, reviewed |
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
