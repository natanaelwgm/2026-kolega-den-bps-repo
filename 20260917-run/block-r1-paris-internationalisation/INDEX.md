# R1 — Paris Agreement and internationalised firms: exhibit index

Development data — obscured values, fictional firm panel. Not BPS findings.

Run all: open `00_run.do`, check the two paths at the top, press Do. Each file below also runs on its own.
Item-by-item coverage of Deasy's row and the review record: [TRACKER.md](TRACKER.md).

| File | What it shows | Deasy's words it answers | Status |
|---|---|---|---|
| `01_group_shares_support.do` → `figures/01_group_shares_support.png`, `tables/01_group_shares_support.csv`, `tables/01_group_support_cells.csv` | Each year, the share of firms that export, import or have 10%+ foreign ownership, with the number of firms in, not in, and of unknown status; the support table behind every later R1 comparison | "… dan juga internationalization strategy-nya?"; "Matching per year: export vs non export, import vs non import, fdi vs non fdi" (the groups) | done, reviewed |

## Details kept out of the figures

**01 — group shares.** Foreign ownership is drawn at 10% or more (`fdi_10_flag`), the usual foreign-investment
threshold and the previous paper's rule; the tables also carry "any foreign ownership" (`fdi_any_flag`). The 2022
direct-export question (344 yes, 1,988 no, 845 unknown) is in the tables only. `01_group_support_cells.csv` gives,
for each group, year and status, how many firms have value added, energy (total, scope 1 = nine fuels, scope 2 =
purchased electricity), CO2 (same three) and self-generation above zero — later exhibits divide by these. Whether a
firm generates its own electricity is unknown for many firms, so self-generation shares divide by `n_selfgen_known`.
