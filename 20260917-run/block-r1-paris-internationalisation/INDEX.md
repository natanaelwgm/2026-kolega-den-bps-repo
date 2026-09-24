# R1 — Paris Agreement and internationalised firms: exhibit index

Development data — obscured values, fictional firm panel. Not BPS findings.

Run all: open `00_run.do`, check the two paths at the top, press Do. Each file below also runs on its own.
Item-by-item coverage of Deasy's row and the review record: [TRACKER.md](TRACKER.md).

| File | What it shows | Deasy's words it answers | Status |
|---|---|---|---|
| `01_group_shares_support.do` → `figures/01_group_shares_support.png`, `tables/01_group_shares_support.csv`, `tables/01_group_support_cells.csv` | Each year, the share of firms that export, import or have 10%+ foreign ownership, with the number of firms in, not in, and of unknown status; the support table behind every later R1 comparison | "… dan juga internationalization strategy-nya?"; "Matching per year: export vs non export, import vs non import, fdi vs non fdi" (the groups) | done, reviewed |

| `02_exporters_energy_co2_per_va.do` → `figures/02_exporters_energy_co2_per_va.png`, `tables/02_exporters_energy_co2_per_va.csv` | Each year, the typical (median) exporter's and non-exporter's energy and CO2 per million of value added, and exporters as % of non-exporters with a 95% range; Paris date marked | "Did internationally engaged firms change their environmental behaviour more strongly after the Paris Agreement?"; "Gj/va", "Co2/va" (drawn); "VA/energy use … total", "VA/emisi … total" (reciprocals, table only); "matching yearly" (unmatched yearly comparison) | done, reviewed |
| `03_importers_energy_co2_per_va.do` → `figures/03_importers_energy_co2_per_va.png`, `tables/03_importers_energy_co2_per_va.csv` | Same chart for importers vs non-importers; 2017 kept in the table only; 2019–2022 drawn hollow gray because importers' energy records are in doubt | "import vs non import"; "Gj/va", "Co2/va"; "VA/energy use … total", "VA/emisi … total" (table); "Did internationally engaged firms change … after the Paris Agreement?" | done, reviewed |
| `04_foreign_owned_energy_co2_per_va.do` → `figures/04_foreign_owned_energy_co2_per_va.png`, `tables/04_foreign_owned_energy_co2_per_va.csv` | Same chart for firms with 10%+ foreign ownership vs other firms; 2020 kept in the table only; 2017, 2019, 2021, 2022 drawn light gray in both groups because many firms' energy records are in doubt | "fdi vs non fdi"; "Gj/va", "Co2/va"; "VA/energy use … total", "VA/emisi … total" (table); "Did internationally engaged firms change … after the Paris Agreement?" | done, reviewed |
| `05_before_after_paris.do` → `figures/05_before_after_paris.png`, `tables/05_before_after_paris.csv` | Before (2013–14) vs after (2018) the Paris Agreement for every outcome in Deasy's list (energy and CO2 per unit of value added, energy used, CO2 emitted, GJ per tonne — scope 1, 2 and total; electricity; own electricity), for all firms and for each group against other firms, with the % change or gap printed on the chart | "Do global climate commitments reach the factory floor?"; "Did internationally engaged firms change their environmental behaviour more strongly after the Paris Agreement?"; the full outcome list | done, reviewed |
## Details kept out of the figures

**01 — group shares.** Foreign ownership is drawn at 10% or more (`fdi_10_flag`), the usual foreign-investment
threshold and the previous paper's rule; the tables also carry "any foreign ownership" (`fdi_any_flag`). The 2022
direct-export question (344 yes, 1,988 no, 845 unknown) is in the tables only. `01_group_support_cells.csv` gives,
for each group, year and status, how many firms have value added, energy (total, scope 1 = nine fuels, scope 2 =
purchased electricity), CO2 (same three) and self-generation above zero — later exhibits divide by these. Whether a
firm generates its own electricity is unknown for many firms, so self-generation shares divide by `n_selfgen_known`.

**02 — exporters vs non-exporters, yearly.** Medians, because the ratios have extreme tails (a few firms would drive
a mean). VA per GJ and VA per tonne of CO2 (Deasy's "VA/energy use" and "VA/emisi", total scope) are the exact
reciprocals of the drawn medians and are in the table (`med_va_per_gj_*`, `med_va_per_tco2_*`); drawing them would
repeat the same information upside down. The 95% range comes from 999 random redraws of each year's firms (seed
20260925). One sample for both ratios: energy, CO2 and value added above zero (514 firm-years with zero energy and
CO2 dropped). Unknown export status (29–58% of firms a year) is left out; these firms are very unlike both known
groups, so the comparison describes only firms whose status is known. 2022 has no known non-exporters (the 2022
file records direct exporters only): exporter medians are in the table, no comparison is drawn. Exporters are about
four times larger (median workers ~150 vs ~40); groups are not matched on size or industry here — R1-08 matches
them. This file is the template for R1-03 and R1-04 (only the grouping block changes; years listed in `skip_yrs`
are computed and kept in the table but not drawn).

**03 — importers vs non-importers, yearly.** Built from the 02 template (only the grouping block differs).
From 2017 the files count far more firms as importers (share 26% in 2015, 56% in 2017), likely a recording change.
2017 itself is not drawn: importers' recorded energy jumps that year (median 1,404 vs 157 GJ per million of value
added for non-importers). From 2019 about 1,300 importers with no recorded export status report roughly one-fifth
of their earlier fuel and electricity per worker while their value added per worker stays flat — almost certainly a
recording problem, not behaviour — so 2019–2022 are drawn hollow gray (numbers kept in the table). 2018, already with
the enlarged importer group, shows a normal gap (59%). Template changes made with this file (02 re-run, table
byte-identical): shorter notes with a reading rule for the 95% range ("crossing 100 = no clear difference"), years
computed but not drawn labelled under the x axis, and optional hollow-gray years with a legend key.

**04 — foreign-owned vs other firms, yearly.** Built from the 02 template. 2020 is not drawn: 47% of firms are
marked foreign-owned that year (8–11% otherwise), and that year's foreign group has a median of 39 workers against
141–201 in other years, so the flag is wrong. In 2017, 2019, 2021 and 2022 both groups contain many firms whose
energy records jump or drop (the same recording problem found in R1-03; a check that does not rely on import or
export status finds it in exactly those years, and not in 2018), so those years are drawn light gray in both groups,
each with its own legend key; the numbers stay in the table. Keeping the gray years is preferred to dropping the
doubtful firms, which would also drop 5–42% of firms in years whose records look fine. Either way the gap shows no
clear change after Paris. Unknown ownership (up to 10% of firms, in 2021) is left out. Template change made with
this file (02 and 03 re-run, tables byte-identical): optional light-gray marks for the other group
(`flag_g0`, `flag_key0`).

**05 — before vs after Paris, every outcome.**

- **Figure.** R1-05 compares the middle (median) firm before Paris (the average of the 2013 and 2014 yearly medians) with after Paris (2018), for all firms and for exporters, importers and foreign-owned firms (10%+) against the other firms. Every outcome in Deasy's list is covered, for scope 1, scope 2 and total.
- **Numbers on the chart.** Panel (a) shows the % change. Panels (b)–(d) show the gap = the % change in the group's median divided by the other firms' median, which is 0 when both changed alike.
- **Table only.** Value added per GJ and per tonne of CO2 (Deasy's "VA/energy use" and "VA/emisi", rows o21–o26) are in the table only. They mirror the drawn per-value-added rows.
- **Why "after" is 2018 only.** In 2017 and 2019–22, many firms' energy records jump or drop sharply. These are mostly importers with no export answer: in 2017 their median energy per value added jumps tenfold; in 2019–22 their energy per worker falls to about a fifth while their value added per worker holds steady.
  - Figures R1-02 to R1-04 show every later year, with those years in light gray.
  - For exporters, whose comparison leaves these firms out by design, 2017–21 gives the same answer as 2018: a gap in energy per value added of −9.1% against −12.6%.
- **Importers with no export answer drive much of panel (a).** They are 14% of firms in 2013 (318 of 2,331), 12% in 2014 (284 of 2,406) and 41% in 2018 (1,203 of 2,966). In 2018, 86% of them make their own electricity, against 50% of other importers and 16% of non-importers.

  Leaving them out, from 2013–14 to 2018:

  | All firms, row | As drawn | Without them |
  |---|---|---|
  | Energy per value added | −29% | −13% |
  | Fuels per value added | −46% | −39% |
  | Value added | +155% | +62% |
  | Firms making their own electricity | +111% | +39% |
  | Bought electricity per value added | +2% | +33% |
- **Trends before Paris.** Most rows were already moving the same way before Paris. From 2010 to 2013–14, for all firms: energy per value added −34%, fuels per value added −35%, value added +95%, CO2 +76%.
- **Own electricity.** It is recorded for 100% of firms in 2010–13 and 2017–22, but for only 57–60% in 2014–15. The unrecorded firms are mostly firms that make none. So own-electricity rows use a year only if at least 75% of every group's firms have it recorded; "before" is 2013 for these rows.
- **Check window.** The CSV's check columns (`chk_*`) average every later year. They include the 2017 jump year, so for importers they mostly reflect that jump.
- **Units.** Energy and CO2 "per million of value added" means per million Rp000 on the real files. Value added is at current prices.
