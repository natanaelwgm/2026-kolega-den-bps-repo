# R3 — who reduces energy use and emissions: exhibit index

Development data — obscured values, fictional firm panel. Not BPS findings.

Run all: open `00_run.do`, check the two paths at the top, press Do. Each file below also runs on its own.
Item-by-item coverage of Deasy's row and the review record: [TRACKER.md](TRACKER.md).

<!-- tables-start -->
Tables that go with the charts: every chart has a table PDF with each plotted point and its number (`_table.pdf`); charts built from regressions also have the full regression table (`_regression.pdf`).

- 01: `tables/01_reducer_shares_by_year_table.pdf`
- 02: `tables/02_who_reduces_by_group_table.pdf`
- 03: `tables/03_who_reduces_by_sector_table.pdf`
- 04: `tables/04_trait_associations_fe_regression.pdf`, `tables/04_trait_associations_fe_table.pdf`
- 05: `tables/05_motivation_proxies_table.pdf`
- 06: `tables/06_own_electricity_reducers_table.pdf`
- 07: `tables/07_productivity_reducers_regression.pdf`, `tables/07_productivity_reducers_table.pdf`
- 09: `tables/09_who_reduces_by_province_table.pdf`
<!-- tables-end -->


| File | What it shows | Deasy's words it answers | Status |
|---|---|---|---|
| `01_reducer_shares_by_year.do` → `figures/01_reducer_shares_by_year.png`, `tables/01_reducer_shares_by_year.csv`, `tables/01_reducer_firms.csv` | Share of firms whose energy use and CO2 (total, and per unit of value added) fell from the year before, each year; defines the firm-level "reducer" flag used by the later R3 files | "Siapa yang reduce energy use and emisi?" | done, reviewed |
| `02_who_reduces_by_group.do` → `figures/02_who_reduces_by_group.png`, `tables/02_who_reduces_by_group.csv`, `tables/02_who_reduces_firm_flag.csv` | For firm size, exporters, importers and foreign-owned firms: the share of their one-year changes in which energy and CO2 (per unit of value added and in total) fell more, or rose less, than at the typical firm that year | "Siapa yang reduce energy use and emisi?"; "determinan motivasi" (who, not why); "Bukan kausal" | done, reviewed |
| `03_who_reduces_by_sector.do` → `figures/03_who_reduces_by_sector.png`, `tables/03_who_reduces_by_sector.csv`, `tables/03_who_reduces_by_sector_firm_flag.csv` | For each of the 24 manufacturing sectors: the share of one-year changes in which energy and CO2 (per unit of value added and in total) fell more, or rose less, than at the typical firm that year | "Siapa yang reduce energy use and emisi?"; "determinan motivasi" (which sectors, not why) | done, reviewed |
| `04_trait_associations_fe.do` → `figures/04_trait_associations_fe.png`, `tables/04_trait_associations_fe.csv`, `tables/04_trait_associations_fe_all_terms.csv` | Which firm traits (size, exporting, importing, 10%+ foreign ownership, making own electricity) go with bigger one-year cuts in energy and CO2, other traits held fixed; (A) against similar firms (same year, sector, province), (B) the same firm in its other years; starting level shown separately | "determinan motivasi apa yg membuat firms respond" (traits, not motives); Strategy "FE"; "Bukan kausal" | done, reviewed |
| `05_motivation_proxies.do` → `figures/05_motivation_proxies.png`, `tables/05_motivation_proxies.csv`, `tables/05_motivation_proxies_fe.csv` | Firms with environmental permit documents (AMDAL, UKL-UPL, SPPL), waste treatment, R&D or innovation vs firms without: share of one-year changes that fell more (or rose less) than the typical firm answering the same question that year | "determinan motivasi apa yg membuat firms respond" (closest stand-ins: rules faced, capacity to change); "Bukan kausal" | done, reviewed |
| `06_own_electricity_reducers.do` → `figures/06_own_electricity_reducers.png`, `tables/06_own_electricity_reducers_by_year.csv`, `tables/06_own_electricity_reducers_changes.csv` | A: share of reducers vs non-reducers making some of their own electricity, by year (reducers found from all changes, and without changes starting in 2017); B: share of one-year changes beating the typical change, by own electricity at the start and from start to end | "Siapa yang reduce energy use and emisi?"; brief: "electricity self-generation among reducers vs non" | done, reviewed |
| `07_productivity_reducers.do` → `figures/07_productivity_reducers.png`, `tables/07_productivity_reducers_*.csv` | A: productivity of reducers vs non-reducers (with and without changes starting in 2017); B: share of one-year changes beating the typical change by productivity at the start | Brief: "TFP residual … of reducers vs non"; "Siapa yang reduce energy use and emisi?" | done, reviewed |
| `08_environmental_goods_imports.do` → `tables/08_environmental_goods_imports_unavailable.csv` (no figure) | **Cannot be answered with this data.** Each firm reports only one yearly total for the imported raw materials it used, with no list of what was bought, so solar panels and other environmental goods cannot be picked out. The table says what is missing and what data would answer it (customs import records per firm, item by item, plus an agreed list of environmental goods). Files 02 and 04 here and R1's `01_group_shares_support.do` use the same total only to mark "importers of any raw material"; they say nothing about environmental goods. | "Tambahan: Siapa yang impor lebih banyak (EGs) environment goods list (termasuk solar panel, dll)" | unavailable (no data), reviewed |
| `09_who_reduces_by_province.do` → `figures/09_who_reduces_by_province.png`, `tables/09_who_reduces_by_province.csv`, `tables/09_who_reduces_by_province_firm_flag.csv` | For each province (shown by code: the file has no province names) and each island group: the share of one-year changes in which energy and CO2 (per unit of value added and in total) fell more, or rose less, than at the typical firm that year; provinces with fewer than 100 changes are shown together within their island group | "Siapa yang reduce energy use and emisi?"; "determinan motivasi" (where, not why); "Bukan kausal" | done, reviewed |

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
added every group is within 2 points of 50%; only non-exporters (51.1%, interval 50.2–52.0) and firms with no
export answer (48.9%, 48.0–49.9) are clearly, though slightly, different, and exporters themselves are not (49.3%); in total energy use, importers and the largest third cut more often,
and in total CO2 foreign-owned firms do (52.6%, interval 50.1–55.2) — but in totals, changes that start from a
high energy level fall back more often (top fifth 69% vs bottom fifth 30%), so groups that start bigger look better
there partly automatically (sentence added to the figure notes after the R3-05 review). There is no stable pattern: the importer and
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

**04 — fixed-effects associations.** Outcome: the one-year change in log energy (or CO2) per unit of value added
and in total; traits measured at the start of each change. (A) year + sector + province fixed effects (main: it
compares firms with each other, which is what "which firms respond" asks); (B) firm + year fixed effects (a firm
against itself: only firms whose trait changes drive it — exporter 691, importer 1,781, foreign-owned 775, own
electricity 1,943 firms — and such switches may be recording shifts); (C) sector×year + province×year, in the
tables only (it never differs from (A) by more than 3.2 points). All standard errors clustered by firm. Sample:
17,922 changes, 5,176 firms — changes starting in 2020 are left out of every model because foreign status that
year is unusable (keeping them changes no conclusion; see the `A_keepbreak` rows). "Not recorded" export, foreign
and own-electricity status are their own groups in the model, not drawn. Main results in (a): making own
electricity −36% [−41, −31], importer −9% [−16, −1], others unclear. Both rest on the changes starting in 2017:
without them own electricity is −18% and the importer gap flips to +14% (the gray bars show this leave-one-year-out
range). In 2017 own-electricity firms recorded about 31 times other firms' fuel (1.4 to 4 times in other years)
and the share making own electricity doubles in 2017–19 — likely a recording change, not behaviour. Starting level
(separate model): a level twice as high goes with a ~38% bigger cut, a third to a half of which is automatic
fall-back. The all-terms CSV has 356 coefficients from 11 variants (incl. before/after 2016, without own
electricity, firm effects split at 2016). Hand-off: R3-06 (self-generation) must deal with the 2017 pattern.

**05 — motivation stand-ins.** No survey question asks why firms cut energy; the closest stand-ins are the rules a
firm faces (permit documents, waste treatment; asked only in 2020–2022) and its capacity to change (R&D: 2011 and
2017–2021; any innovation: 2011, 2017–2018, 2020–2021; process innovation: 2017–2018; 2017–18 R&D and innovation
codes are provisional). Answers are taken in the first year of each one-year change. Each change is compared with
the typical change of firms that ANSWERED the same question that year, because blank-answer firms behave very
differently (against all firms, innovators would look worse, 42.9% vs 49.0%; within answering firms there is no
gap). Permits: each firm is grouped by the strictest document it holds (AMDAL, then UKL-UPL, then SPPL). Per unit of
value added no stand-in clearly differs from "No". In totals, permit holders and innovators cut a little more often,
but they start with 2–7× more energy and high starts fall back (67% vs 32% of changes beat the typical one, top vs
bottom fifth); with starting energy held fixed every total-energy gap disappears or reverses. "Not recorded" rows
are nearly the same records for every question and their distance from 50% depends on the start year — not a
result. The FE companion (R3-04 comparison A with each answer added, blank answers given a baseline per year) is in
`05_motivation_proxies_fe.csv`.

**06 — own electricity and reducers.**

**Own electricity and the 2017 recording change.** Firms recorded as making their own electricity show 31 times
the fuel of other firms in 2017 (1.4–4.0 times in every other year); their share of all firms doubles in 2017–19,
and makers' self-made share of their electricity falls from 19–27% (2010–15) to 1.4–6.9% (2017–22). This looks
like a change in recording. Their 2017 to 2018 changes then look like big cuts, which is why reducers make own
electricity far more often in 2017–19 (gap +30.7 points in 2017). Leaving out changes that start in 2017 (chosen
from the data: it moves the gap 5.0 points, other years at most 1.6), the pooled gap falls from +10.1 [8.3, 11.9]
to +2.4 [0.5, 4.2] points.

**Without 2017: no robust difference either way (N1).** In panel (a), firms making own electricity beat the typical
change in 49.0% of changes, against 50.1% for firms making none. This raw result depends on starting levels:
without 2017 they start with 0.65 times the energy per unit of value added of other firms, and low starts tend to
rise back. Comparing firms in the same fifth of starting energy per unit of value added, they beat the typical
change 4.3 points more often [2.6, 5.9]; comparing firms in the same fifth of starting energy, 6.0 points less often
[−7.7, −4.3]. Starts before 2016: −2.8 points; starts 2018–21: +9.1 (same fifth of energy per unit of value added).
So there is no robust difference either way; do not read the raw shares as "no difference" or as "own-electricity
firms cut more".

**Energy use and CO2 totals, panels (c)–(d).** Firms making own electricity start with 4.4 times the energy of other
firms in the same start year, and big starts fall back (share beating the typical energy-use change by fifth of
starting energy: 30, 41, 50, 59, 69%). In the same fifth of starting energy, their gap in (c) reverses from +7.3 to
−2.7 points [−4.2, −1.1] (+1.8 to −4.2 without 2017). The (c)–(d) gaps are size fall-back, not a finding.

**Switching to own power does not fake cuts (N2).** Self-made power is not counted in energy use (nine fuels plus
bought electricity); fuel burnt to make it counts only if it is one of the nine fuels. If switching faked cuts,
firms that start making own electricity would beat the typical energy-use change more often. They do not: 47.9%
[45.9, 50.0], against 47.4% for firms making none in both years. Their bought electricity fell more than the typical
firm's in 51.2% of changes [49.1, 53.3], against 49.4% [48.5, 50.3]; this excludes 42 starters whose bought power
fell to zero and 73 with none at the start (52.1% if the 42 count as cuts). Their gap in (a) comes from value added,
which rose 18.7% more than the typical firm's (stoppers: −18.3%). Considered and rejected: adding self-made kWh to
energy use, which double counts generator fuel and mechanically raises starters' changes.

**Not recorded (N3).** Own-electricity status is blank for 2,125 rows, all in 2014–15; blanks are never counted as
"none". They are left out of panel A and shown as hollow gray rows in B (795 changes, all starting in 2014; 1,808
with a blank in either year). Blanks are more common for non-reducers (46–49% of their 2014–15 rows) than for
reducers (34–39%). The 2014 gap in A is +4.5 points among recorded firms; it would be +6.5 if every blank were
"none".

**07 — productivity and reducers.**

**Which productivity measure, and why not the one in the brief (M3).** The brief asked for
`dev_nominal_common_tfp_lp`. This exhibit uses `dev_nominal_tfp_lp` instead. Both come from the same
Levinsohn–Petrin estimate: log value added (current prices) minus what the firm's workers and last year's capital stock
predict, estimated per sector, no deflation, fictional firm links. The "common" version exists only where all four
methods can be estimated; Olley–Pakes needs reported investment, so it covers 665 firm-years (385 firms, 184 reducers /
201 non-reducers), against 10,284 firm-years (2,740 firms) for the own-sample version. Where both exist they correlate
0.996. With the common version the gap in energy per unit of value added is 25.6% [−4.1, 64.4]: too uncertain to read.
It stays in the CSV (row 11) with two other methods: ACF 41.1% [31.1, 51.8], WRDG 50.1% [36.3, 65.3].

**Coverage.** A productivity figure exists for 2011–15 and 2018–22 only (it needs last year's capital, so never 2010
or 2017), in 12 of 24 sectors (10, 12–16, 20, 22, 23, 25, 31, 32). Even there, only 10,284 of 17,552 firm-years with a
record the year before have one (other inputs missing). Covered: 2,740 of the 3,709 firms with a reducer flag (A) and
7,115 of the 20,169 one-year changes (B). Covered firms are smaller: median 38 workers vs 57. Each figure is compared
with the average of the same sector and year.

**A: reducers look more productive, mostly because of 2017 and because value added is in both numbers.** Reducers
(energy per unit of value added) average 51.5% [37.1, 67.4] higher productivity than non-reducers (1,359 / 1,381
firms). Changes starting in 2017 move this most (0.290 log points; next 2018 0.103). From 2017 to 2018 one firm in ten
cut its recorded energy by 99.7% or more, against at most 91.7% in other years: likely a recording change (see R3-06).
The 296 firms that stop being reducers without those changes are 95% own-electricity makers. Without them the gap is
13.3% [2.2, 25.6]; for energy use it goes from 28.1% to −6.5% [−15.7, 3.7] and for CO2 from 28.9% to −7.7%. Value
added is in both productivity and energy per unit of value added, so a good year raises one and lowers the other at
once. Holding each firm's value-added change fixed shrinks the gap from 0.415 to 0.325 log points; without 2017 starts
and holding it fixed, nothing is left: −0.004 [−0.111, 0.103]. Controlling for firm size: 0.415 → 0.332.

**B: more productive firms do not go on to cut energy use more often.** Productivity is measured at the start of each
change and split into four equal groups within each start year. Energy per unit of value added fell more than the
typical firm's in 56.7% of the least productive group's changes and 42.6% of the most productive group's; the reason is
value added: it fell more than typical in 36.0% vs 61.0% of their changes (a high start falls back). Energy use: 48.7,
53.0, 47.2, 50.0% (highest − lowest +1.35 [−1.61, 4.30]). In this data productivity rises steeply with size (0.72 per
log worker within sector and year): the most productive 25% start with 5.5× the workers, 107× the value added and 49×
the energy of the least productive (ratios of typical values within the start year). Holding starting size fixed, the
answer does not turn positive: same fifth of starting workers +1.1 [−2.6, 4.7] points; same fifth of starting energy
−21.8 [−25.5, −18.1] (big starts fall back: 35, 48, 54, 56, 65% by fifth); both −16.0. Energy per unit of value added,
starts before 2016 vs 2018–21: 56.2 / 57.2% (least productive) and 41.4 / 43.9% (most productive).

**Considered and rejected.** Productivity at the end of the change (value added in both numbers: 39.9% → 57.9% by
group, pure arithmetic); productivity a year before the start (4,776 changes, needs four consecutive years; value added
still falls back 42.3% → 52.3%, so the link is not removed).

**09 — who reduces, by province.** Same unit, measure, intervals and chart form as 02 and 03. The file has no
province names (no value label or name variable; codes as recorded each year, with no boundary harmonisation — code
65 appears only from 2015), so rows show codes; island group = first digit of the code (1–2 Sumatra, 3 Java, 5–9
other islands). Province = code at the start of each change; no change switches province in this file (the fictional
firm link is drawn within province and sector). Provinces with at least 100 changes are drawn on their own (12 here);
smaller ones are drawn together within their island group (Sumatra: 11 13 15 16 17 19, 305 changes; other islands: 16
codes, 474 changes), and each keeps its own share in the table without an interval. Java holds 88% of the 20,169
changes. Per unit of value added no province differs: in panel (a) 0 of 14 rows miss 50% (about 1 by chance), joint
test F(13, 5278) = 1.16, p = 0.30 (CO2 per VA 1.44, p = 0.13); island groups F(2, 5278) = 0.43 — unlike sectors
(03: 9 of 22, F = 4.56). In totals 3 rows miss 50% in (c) and 4 in (d) (F = 2.64 and 2.78); the largest, province 14
(58.8 [50.9, 66.7]), is mostly start size: its changes start at 11.3 times the typical firm's energy that year, and big
starts fall back (30% vs 69% of changes beat the typical change, lowest vs highest fifth of starting energy); in the
same fifth of starting energy it drops to 45.9 [37.6, 54.2]. Holding the starting level fixed does separate provinces
(F = 6.35 in (a)): 36 (55.6 [53.4, 57.8]) and 31 (53.9) above 50%, 18 (38.3 [31.2, 45.4]), 12 (43.8) and Sumatra as a
whole (45.1 [42.7, 47.5]) below — kept in the table (`st_*` columns), not drawn, so the chart stays comparable with 03.
Holding sector fixed moves no drawn row in (a) by more than 1.9 points (`sf_*`); leaving out changes that start in 2017,
by at most 3.5 (province 51, only 22 such changes). A firm-level bootstrap (999 redraws) gives the same intervals as the
clustered ones (province 21: [43.6, 58.2] vs [43.3, 58.0]). Each province's share of all energy and CO2 is in the table
only: one masked row can dominate (province 63 holds 38.5% of all energy on 51 changes), so do not call a province "the
biggest energy user" from it. Firm-level companion (3,709 firms, province at each firm's first change): other islands
42.7% [36.2, 49.4] against 50–51% in Sumatra and Java; province 32 56.8%, 35 44.0% — it differs from the change view
because it depends on which years a firm is observed.
