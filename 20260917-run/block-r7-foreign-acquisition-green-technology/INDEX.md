# R7 — foreign acquisition and greener technology: exhibit index

Development data — obscured values, fictional firm panel. Not BPS findings.

Run all: open `00_run.do`, check the two paths at the top, press Do. Each file below also runs on its own.
Item-by-item coverage of Bu Deasy's row and the review record: [TRACKER.md](TRACKER.md).

| File | What it shows | Bu Deasy's words it answers | Status |
|---|---|---|---|
| `01_acquisition_registry.do` → `figures/01_acquisition_registry.png`, `tables/01_acquisition_registry.csv`, `tables/01_acquisition_registry_table.pdf` | How many firms are first seen with 10%+ foreign ownership in each year after an earlier year below 10% (the "acquisition" every later R7 file uses), split majority (50%+) / minority (10–49%), how many are back below 10% at their next answer, and which firms cannot be dated | "Event study around foreign acquisition" (defines the acquisition event); "Does FDI transmit greener technologies" (the firms it is about) | done, reviewed |

## Details kept out of the figures

**01 — acquisition registry.** An acquisition here is a reported foreign share crossing 10% (the first 10%+ answer after an earlier answer below 10%). It uses the same rule and dates as R2-08, and it is not a verified purchase. All 2020 ownership answers are treated as unknown, because 47% of firms report 10%+ in 2020 against about 9% in other years. As filed, 854 firms would start in 2020; with the repair, 56 get a later year and 798 count as never foreign-owned. Starts in 2017 (no 2016 file) and 2021 (2020 unknown) are dated approximately. There are 844 acquirers: 372 up to 2015 and 472 after. The 8,011 firms never seen 10%+ foreign-owned are the comparison firms. Left out: 1,213 firms that are foreign-owned when first seen and 395 with no usable answer. Shares are almost all 0% or 100%, so the 50% and above-0% rules pick nearly the same firms (772 and 850 starters; CSV). Only 112 of the 559 acquirers with a later answer are still 10%+ at that answer, and 447 are back below. In this file that comes from the fictional firm links. There are two design choices. First, the "back below 10%" counts are light-gray bars next to each year's acquisitions, because dots inside the dark bars were unreadable. Second, 2020 is a dashed box with the as-filed count written in, because an 854 bar would shrink every other bar to about one eighth. Firm identity across mergers cannot be checked here (fictional links).
