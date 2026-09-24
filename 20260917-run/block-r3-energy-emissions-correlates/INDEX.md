# R3 — who reduces energy use and emissions: exhibit index

Development data — obscured values, fictional firm panel. Not BPS findings.

Run all: open `00_run.do`, check the two paths at the top, press Do. Each file below also runs on its own.
Item-by-item coverage of Deasy's row and the review record: [TRACKER.md](TRACKER.md).

| File | What it shows | Deasy's words it answers | Status |
|---|---|---|---|
| `01_reducer_shares_by_year.do` → `figures/01_reducer_shares_by_year.png`, `tables/01_reducer_shares_by_year.csv`, `tables/01_reducer_firms.csv` | Share of firms whose energy use and CO2 (total, and per unit of value added) fell from the year before, each year; defines the firm-level "reducer" flag used by the later R3 files | "Siapa yang reduce energy use and emisi?" | done, reviewed |

## Details kept out of the figures

**01 — reducer shares.** A change is counted only between a firm's records exactly one year apart, with energy,
CO2 and value added above zero in both years (a zero may be an unanswered question). The 2,049 firms seen in 2015
and 2017 are left out (that change covers two years, because there is no 2016 file); 368 one-year pairs are dropped
for zeros. Counting only falls of more than 5% lowers any yearly share by at most 2.4 points (columns `pct_down5_*`).
**Main firm flag for R3-02 onward: `reducer_adj_energy_va`** (`pct_reducer_adj_firms` in `01_reducer_firms.csv`):
a firm with at least two one-year changes is a reducer when its changes in energy per unit of value added are, on
average, below the typical (median) change of all firms in the same years. The raw flag (`reducer_*`,
`pct_reducer_firms`) is kept for comparison only: the masked data jump and fall back between years, so the raw flag
mostly records which years a firm was observed in.
