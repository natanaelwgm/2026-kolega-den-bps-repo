# R3 — who reduces energy use and emissions: exhibit index

Development data — obscured values, fictional firm panel. Not BPS findings.

Run all: open `00_run.do`, check the two paths at the top, press Do. Each file below also runs on its own.
Item-by-item coverage of Deasy's row and the review record: [TRACKER.md](TRACKER.md).

| File | What it shows | Deasy's words it answers | Status |
|---|---|---|---|
| `01_reducer_shares_by_year.do` → `figures/01_reducer_shares_by_year.png`, `tables/01_reducer_shares_by_year.csv`, `tables/01_reducer_firms.csv` | Share of firms whose energy use and CO2 (total, and per unit of value added) fell from the year before, each year; defines the firm-level "reducer" flag used by the later R3 files | "Siapa yang reduce energy use and emisi?" | done, reviewed |
| `02_who_reduces_by_group.do` → `figures/02_who_reduces_by_group.png`, `tables/02_who_reduces_by_group.csv`, `tables/02_who_reduces_firm_flag.csv` | For firm size, exporters, importers and foreign-owned firms: the share of their one-year changes in which energy and CO2 (per unit of value added and in total) fell more, or rose less, than at the typical firm that year | "Siapa yang reduce energy use and emisi?"; "determinan motivasi" (who, not why); "Bukan kausal" | done, reviewed |

| `03_who_reduces_by_sector.do` → `figures/03_who_reduces_by_sector.png`, `tables/03_who_reduces_by_sector.csv`, `tables/03_who_reduces_by_sector_firm_flag.csv` | For each of the 24 manufacturing sectors: the share of one-year changes in which energy and CO2 (per unit of value added and in total) fell more, or rose less, than at the typical firm that year | "Siapa yang reduce energy use and emisi?"; "determinan motivasi" (which sectors, not why) | done, reviewed |
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

**02 — who reduces, by group.** Main unit = the one-year change (same 20,169 changes as 01); main column
`pct_energy_va`. Each change is compared with the typical (median) change of all firms in the same year, so the
jump in the importer share from 2017 (likely a recording change) and the years a firm happens to be observed
cannot create a gap by themselves. Group = status in the first year of each change; blank export or ownership
status is its own "Not recorded" row, never counted as non-exporter or domestic. Foreign ownership = 10% or more;
status measured in 2020 is not used (the foreign-owned share that year is more than twice the usual). Intervals
are 95% and allow for the same firm appearing in several years (clustered by firm). Reading: per unit of value
added no group differs clearly from 50%; in total energy use, importers and the largest third cut more often,
and in total CO2 foreign-owned firms do (52.6%, interval 50.1–55.2). There is no stable pattern: the importer and
foreign-owned gaps flip between the years before and after 2016 (columns `pct_energy_va_early` / `_late`). The
companion `02_who_reduces_firm_flag.csv` uses the firm-level flag from 01; it depends on which years a firm is
observed, and 259 firms whose first change starts in 2020 are left out of its foreign-ownership rows.
Both 01 and 02 compute the yearly median with `egen … pctile(), p(50)` and `set type double`, because Stata's
`egen median()` ignores the requested double precision in GUI Stata.

**03 — who reduces, by sector.** Same unit, measure and intervals as 02. Sectors differ: a joint test gives
F(23, 5278) = 4.56 (energy per unit of value added), 5.11 (CO2 per VA), 5.93 (energy use) and 7.04 (CO2); in panel
(a) 9 of 22 intervals miss 50%, against about 1 by chance. Textiles and paper beat the typical firm more often;
furniture, beverages, electronics and electrical equipment less often; cement, glass and ceramics cut total energy
and CO2 slightly less often. Sectors with fewer than 100 changes (refined petroleum and coke, 27; machine repair,
48) are named under the plot, not drawn. Each sector's share of all energy and CO2 is in the table only: on this
masked file single rows dominate (one 2021 cement row holds 38.4% of all energy across all years; without the 10
largest rows cement falls from 62.7% to 13.4%), so do not call a sector "the biggest energy user" from it. No firm
changes sector in this file (the fictional firm link is drawn within sector); whether codes are consistent across
years is not verified. Firm-level companion: it depends on which years a firm is observed (clothing flips: 55.7%
by firm, 48.2% by change). Before/after-2016 columns show which sector results hold in both periods (furniture and
textiles hold; steel and motor vehicles flip).
