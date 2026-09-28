# R1 — Paris Agreement and internationalised firms: exhibit index

Development data — obscured values, fictional firm panel. Not BPS findings.

Run all: open `00_run.do`, check the two paths at the top, press Do. Each file below also runs on its own.
Item-by-item coverage of Deasy's row and the review record: [TRACKER.md](TRACKER.md).

<!-- tables-start -->
Tables that go with the charts: every chart has a table PDF with each plotted point and its number (`_table.pdf`); charts built from regressions also have the full regression table (`_regression.pdf`).

- 01: `tables/01_group_shares_support_table.pdf`
- 02: `tables/02_exporters_energy_co2_per_va_table.pdf`
- 03: `tables/03_importers_energy_co2_per_va_table.pdf`
- 04: `tables/04_foreign_owned_energy_co2_per_va_table.pdf`
- 05: `tables/05_before_after_paris_table.pdf`
- 06: `tables/06_frozen_pre_paris_groups_table.pdf`
- 07: `tables/07_electricity_own_generation_table.pdf`
- 08: `tables/08_matched_gaps_by_year_table.pdf`
- 09: `tables/09_frozen_groups_regression_regression.pdf`, `tables/09_frozen_groups_regression_table.pdf`
- 10: `tables/10_reweighted_frozen_groups_regression.pdf`, `tables/10_reweighted_frozen_groups_table.pdf`
<!-- tables-end -->


**Stata add-ons R1-09 and R1-10 need** (install once; no file installs anything): `ssc install reghdfe`, `ssc install ftools`, `ssc install require`.

| File | What it shows | Deasy's words it answers | Status |
|---|---|---|---|
| `01_group_shares_support.do` → `figures/01_group_shares_support.png`, `tables/01_group_shares_support.csv`, `tables/01_group_support_cells.csv` | Each year, the share of firms that export, import or have 10%+ foreign ownership, with the number of firms in, not in, and of unknown status; the support table behind every later R1 comparison | "… dan juga internationalization strategy-nya?"; "Matching per year: export vs non export, import vs non import, fdi vs non fdi" (the groups) | done, reviewed |
| `02_exporters_energy_co2_per_va.do` → `figures/02_exporters_energy_co2_per_va.png`, `tables/02_exporters_energy_co2_per_va.csv` | Each year, the typical (median) exporter's and non-exporter's energy and CO2 per million of value added, and exporters as % of non-exporters with a 95% range; Paris date marked | "Did internationally engaged firms change their environmental behaviour more strongly after the Paris Agreement?"; "Gj/va", "Co2/va" (drawn); "VA/energy use … total", "VA/emisi … total" (reciprocals, table only); "matching yearly" (unmatched yearly comparison) | done, reviewed |
| `03_importers_energy_co2_per_va.do` → `figures/03_importers_energy_co2_per_va.png`, `tables/03_importers_energy_co2_per_va.csv` | Same chart for importers vs non-importers; 2017 kept in the table only; 2019–2022 drawn hollow gray because importers' energy records are in doubt | "import vs non import"; "Gj/va", "Co2/va"; "VA/energy use … total", "VA/emisi … total" (table); "Did internationally engaged firms change … after the Paris Agreement?" | done, reviewed |
| `04_foreign_owned_energy_co2_per_va.do` → `figures/04_foreign_owned_energy_co2_per_va.png`, `tables/04_foreign_owned_energy_co2_per_va.csv` | Same chart for firms with 10%+ foreign ownership vs other firms; 2020 kept in the table only; 2017, 2019, 2021, 2022 drawn light gray in both groups because many firms' energy records are in doubt | "fdi vs non fdi"; "Gj/va", "Co2/va"; "VA/energy use … total", "VA/emisi … total" (table); "Did internationally engaged firms change … after the Paris Agreement?" | done, reviewed |
| `05_before_after_paris.do` → `figures/05_before_after_paris.png`, `tables/05_before_after_paris.csv` | Before (2013–14) vs after (2018) the Paris Agreement for every outcome in Deasy's list (energy and CO2 per unit of value added, energy used, CO2 emitted, GJ per tonne — scope 1, 2 and total; electricity; own electricity), for all firms and for each group against other firms, with the % change or gap printed on the chart | "Do global climate commitments reach the factory floor?"; "Did internationally engaged firms change their environmental behaviour more strongly after the Paris Agreement?"; the full outcome list | done, reviewed |
| `06_frozen_pre_paris_groups.do` → `figures/06_frozen_pre_paris_groups.png`, `tables/06_frozen_pre_paris_groups.csv` | Each firm put once into a group from its 2013–14 records (exporter or not, importer or not, 10%+ foreign-owned or not), then followed 2010–2022: the typical (median) firm's energy and CO2 per unit of value added as % of its group's own 2013–14 level, and the 2018 difference between each group and the other firms, with a 95% range; 2015 marked as the transition year, 2017 in the table only, 2019–2022 light gray | "Freeze internationalisation status sebelum Paris, misalnya average 2013–14: pre exporters x year; 2015 transition year; 2016+ post"; "Did internationally engaged firms change their environmental behaviour more strongly after the Paris Agreement?"; "Gj/va", "Co2/va"; "Energi use … total" (table) | done (descriptive; the regression is R1-09) |
| `07_electricity_own_generation.do` → `figures/07_electricity_own_generation.png`, `tables/07_electricity_own_generation.csv` | Each year, the middle (median) firm's bought electricity per million of value added, the share of firms making some of their own electricity, and own electricity as % of the electricity used by firms that make some, for exporters, importers and 10%+ foreign-owned firms each against other firms; own-electricity rows leave out 2014–15 (too few firms recorded); doubtful years hollow gray, as in R1-03 and R1-04 | "Electricity"; "Self generation"; "Energi use … scope 2" (per unit of value added; amount per firm in the table); "export vs non export, import vs non import, fdi vs non fdi"; "Did internationally engaged firms change their environmental behaviour more strongly after the Paris Agreement?" | done |
| `08_matched_gaps_by_year.do` → `figures/08_matched_gaps_by_year.png`, `tables/08_matched_gaps_by_year.csv` | Each year, exporters, importers and 10%+ foreign-owned firms compared only with other firms of the same year, 2-digit industry and size band (workers): the typical group firm's energy and CO2 per unit of value added as % of its similar firms', with a 95% range, next to the same comparison without matching; per panel, the 2013–14 and 2018 values and their change; importers 2017 and foreign-owned 2020 in the table only, doubtful years light gray | "Matching per year: export vs non export, import vs non import, fdi vs non fdi"; "… kita bs coba dengan method matching yearly.. dan dicompare bagaimana behaviour mereka toward energy use, emisi"; "Did internationally engaged firms change their environmental behaviour more strongly after the Paris Agreement?"; "Gj/va", "Co2/va" (drawn); "VA/energy use … total", "VA/emisi … total" (reciprocals, table only) | done, reviewed |
| `09_frozen_groups_regression.do` → `figures/09_frozen_groups_regression.png`, `tables/09_frozen_groups_regression.csv` | R1-06's groups (fixed once from 2013–14 records) in a regression. For every outcome in Deasy's list: how much more each group's measure changed from 2013–14 to 2018 than that of firms in the same industry and province, each firm against its own average, with a 95% interval; the same for 2010–12 as a before-Paris check. The table adds 2015, Deasy's literal "2016+" (2017–22 together, against 2010–14), firm + year averages only, the stricter and 2013–14-average groupings, a version without doubtful importer records, a 2013–14-and-2018-only version, and one estimate per year for total energy and CO2 per unit of value added | "DID"; "Freeze internationalisation status sebelum Paris, misalnya average 2013–14: pre exporters x year; 2015 transition year; 2016+ post; Firm FE + industry×year FE + province×year FE"; "Did internationally engaged firms change their environmental behaviour more strongly after the Paris Agreement?"; every listed outcome ("VA/energy use", "VA/emisi": mirror columns, table) | done (association only) |
| `10_reweighted_frozen_groups.do` → `figures/10_reweighted_frozen_groups.png`, `tables/10_reweighted_frozen_groups.csv`, `tables/10_reweighted_frozen_groups_balance.csv` | R1-09 again, with the other firms reweighted (entropy balancing) so that in 2013–14 they match each group in workers, value added, energy and CO2 per unit of value added, bought-electricity share, own electricity, industry and island. Top: the 2013–14 gaps before and after weighting, and the gap left among the firms also recorded in 2018. Bottom: 2018 against 2013–14 for the main outcomes, reweighted and not, with a before-Paris check. The table adds every listed outcome, 2015, 2017, 2019–22, matching the spreads too, firm + year averages only, the stricter groups, re-balancing only the firms also recorded in 2018, one estimate per year for total energy and CO2 per unit of value added, and the balance of every measure | "Matching/entropy balancing dapat digunakan sebagai robustness untuk membuat pre-Paris groups comparable"; on R1-09's design ("Freeze internationalisation status sebelum Paris, misalnya average 2013–14 …; Firm FE + industry×year FE + province×year FE"); "Did internationally engaged firms change their environmental behaviour more strongly after the Paris Agreement?"; every listed outcome (table) | done (association only; robustness of R1-09) |

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

**06 — groups fixed before Paris.**
- **Grouping rule.** A firm is in a group if it was recorded as exporter, importer or 10%+ foreign-owned in at least half of its known 2013–14 years. With two years, that means either year; a firm seen in one year keeps that year's answer. Other firms were never so recorded in their known 2013–14 years.
- **Firms left out and counted.** 7,432 of 10,463 firms have no 2013 or 2014 record. A further 712 have records but no known export answer. They are never counted as "not internationalised".
- **Group sizes**, in the group against other firms:
  - exporters 592 against 1,727;
  - importers 891 against 2,140;
  - foreign-owned 397 against 2,634.

  Of the group members, 167, 398 and 184 are in their group through only one of their two years.
- **How the lines and differences are built.**
  - Base = the average of the group's 2013 and 2014 yearly medians, so each group averages 100 over 2013–14.
  - Sample: energy, CO2 and value added all above zero.
  - At least 30 firms per group and year.
  - The difference is the group's line minus the other firms' line, in points.
  - The 95% range comes from 999 redraws of whole firms (all their years) within each group (seed 20260925).
- **Levels hidden by the index.** In 2013–14, energy per million of value added is 144 against 169 (exporters against other firms), 132 against 165 (importers) and 121 against 160 (foreign-owned).
- **Result for 2018, the one solid year after Paris.**
  - Each group fell to about 65–80% of its 2013–14 level, as the other firms did.
  - The differences are −9 and −4 points for exporters, −2 and 0 for importers, and −2 and −9 for foreign-owned firms (energy and CO2). None is clear.
- **Stricter check** (CSV `s*` columns; firms in their group through only one of two years left out):

  | 2018 difference, points | Energy | CO2 | Firms left in the group |
  |---|---|---|---|
  | Exporters | −20.3 [−33.8, +2.3] | −14.8 [−34.1, +5.5] | 160 |
  | Importers | +3.0 [−16.0, +27.5] | +0.1 [−20.9, +29.6] | 193 |
  | Foreign-owned | −32.0 [−47.7, −8.7] | −30.2 [−51.9, −9.0] | 43 |

  So foreign-owned firms clearly fell further under this rule, on 43 firms. The answer depends on the grouping rule.
- **Check that follows each firm against its own 2013–14 level** (`wdiff_pts`). The 2018 differences are within ±2.5 points, so changes in which firms remain do not drive 2018.
- **Before and around Paris.**
  - In 2010–12, importers' energy per value added was falling faster than other firms': +39 to +47 points above them, clear. Foreign-owned firms were +25 to +44, not clear. The groups were not on parallel paths.
  - In 2015 (transition year): importers +20.6 [+5.2, +42.9] and foreign-owned firms +18.5 [+1.4, +59.9], both clear, the second only just.
- **Years in doubt.**
  - 2017 is not drawn: 35–50% of firms in every group are more than 5× the 2013–14 median energy per value added, against 13–21% in 2010–15. Frozen importers' index is 578 that year.
  - 2019–22 are light gray: 23–56% of firms are below a fifth of that median, against 11–21% in 2010–18, and more so inside the groups.
  - The only clear differences after Paris all fall in these gray years: importers in 2019–22 (energy in every year; CO2 in 2019, 2020 and 2022) and foreign-owned CO2 in 2019.
- **Fictional links.**
  - How often a firm keeps its flag from one year to the next, 2010–15: exports 53%, imports 47%, foreign ownership 36%.
  - Still in the group in 2018:
    - exporters: 39% of those answering are still exporting, against 12% of other firms;
    - importers: 71% are still importing, against 39%;
    - foreign-owned firms: 15% are still foreign-owned, against 6%.

  On the real files these numbers show real persistence, so re-read them there. This is a pipeline exercise: it shows change, not its cause.
- **Units.** Energy and CO2 "per million of value added" means per million Rp000 on the real files. Value added is at current prices.

**07 — bought and own electricity, yearly, by group.**
- **What is drawn.**
  - (a)–(c): the middle firm's electricity bought from PLN and other suppliers, in thousand kWh per million of value
    added. Only firms with bought electricity and value added above zero count; absent is not zero.
    - Multiplied by 3.6, it is R1-05's scope-2 row in GJ: exporters 2013 12.91 thousand kWh = 46.48 GJ; all firms
      2018 8.91 = 32.08 GJ.
  - (d)–(f): the share of firms making some of their own electricity, among firms whose own electricity is recorded.
    The counts equal R1-01's `n_selfgen_known` and `n_selfgen_pos` (importers 2013: 269 of 555).
  - (g)–(i): own electricity as % of own + bought, for the middle firm among those making some.
  - In the table only: bought electricity as % of energy used, bought electricity per firm, own electricity per firm
    making some.
- **Not the same as R1-05.**
  - R1-05's "Own, % of electricity used" is the average over all firms, with non-makers counted as 0 (8.2% in 2013).
    Here it is the middle maker (22%).
  - R1-05's shares also require energy above zero. So "recorded in 2014–15" reads 57–60% there and 56–60% here, and
    all firms making their own in 2018 read 47.98% there and 47.26% here.
- **Rules.**
  - At least 30 firms per group and year.
  - Own-electricity rows use a year only if at least 75% of both groups' firms have it recorded. This removes 2014–15 in
    all three columns. Recorded shares, 2014/2015: exporters 62/60%, non-exporters 24/14%, importers 82/82%,
    non-importers 49/52%, foreign-owned 66/71%, other firms 55/59%.
  - Why the rule is needed: in 2014–15, 39–41% of recorded firms make their own, against 22% in 2013. Firms not
    recorded in 2014 had made their own in 2013 only 13% of the time (29% for recorded firms; fictional links).
  - The 95% ranges come from 999 redraws of each year's firms within each group (seed 20260925).
- **Years in doubt.** Set by hand in the file's config block, the same years as R1-03 and R1-04.
  - Exporters: none (2022 drops out: no known non-exporters).
  - Importers: 2017 and 2019–22 hollow gray.
  - Foreign-owned: 2020 not drawn; 2017, 2019, 2021 and 2022 light gray in both groups.
  - The check on the electricity itself is in the CSV (`pct_far_below_*`: % of firms buying under a fifth of the
    2013–14 all-firm middle value, 8.69).
    - Importers: 12–15% in 2010–15, 8% in 2018, 56% in 2019, 28–36% in 2020–22.
    - Exporters and non-exporters: 10–22% every year.
  - Importers 2017 passes this check: 22% far below, and only 6% above five times the middle value, against 13–23% before.
    Their bought electricity per worker is normal. Their hollow mark is a caution about their fuel records, which jump
    tenfold that year (R1-03).
  - Exporters 2017 (181% of non-exporters, clear) also passes, and R1-02 draws that year too. The high point comes from
    value added: exporters' value added per worker is 31% below 2015 and 43% below 2018, while their bought electricity
    per worker lies between those years.
  - On the real files, re-read `pct_far_below_*` before keeping these years.
- **Firms with no export answer.**
  - In 2017 they are 90% of importers, and 77% of them make some of their own electricity, against 14% of firms with an
    answer (2013: 35% against 16%).
  - Among firms with an answer, making their own barely moves: 16% in 2013, 14% in 2017, 21% in 2018.
  - They are left out of the exporter column but lift the importer and foreign-owned lines. Without them, foreign-owned
    against other firms in 2018 reads 35% against 19%, not the drawn 43% against 48%.
- **Results** (group as % of other firms for bought electricity; difference in points for the shares):
  - **Exporters.** Bought electricity:
    - 118–175% of non-exporters' in 2010–15 (average 144%; clear in 2011, 2012 and 2014);
    - 181% in 2017;
    - 112% [80, 151] in 2018;
    - 93–104% in 2019–21, not clear. The pre-Paris gap closes.

    Making their own:
    - +7 to +14 points in 2010–13, all clear;
    - +9 in 2017;
    - +23 [+17, +28] in 2018;
    - +20 in 2019;
    - +10 and +9 in 2020–21.
  - **Importers.**
    - Bought electricity 107–145% before Paris, then 59% [52, 67] in 2018 (clear).
    - Making their own +23 to +34 points before, then +62 [+60, +65] in 2018 (78% against 16%). This is mostly who the
      files count as importers.
  - **Foreign-owned.**
    - Bought electricity 121–164% before Paris (clear 2013–15), then 120% [96, 148] in 2018, not clear.
    - Making their own −3 to +9 points before, then −4 [−11, +2] in 2018.
  - **Own share among makers.**
    - Before Paris, 95% ranges are about ±20 points wide.
    - After 2016 it is mostly 1–8% in every group (non-importers 12% in 2018 and 23% in 2022).
    - Row (g)–(i)'s scale reaches 80 because of one cell: foreign-owned 2012, 65% on 34 makers. After-2016 gaps are
      read from the table.
- **Units.** "Per million of value added" means per million Rp000 on the real files; value added is at current prices.
  Runtime is about 90 s.

**08 — each group against similar firms, yearly (matching).**
- **Matching rule.** Each year, each group firm is compared only with the other firms in its cell. A cell = same year, same 2-digit industry (`industry2_reported`) and same size band (under 50, 50–99, 100–249, 250–499, 500+ workers).
  - Only cells that hold both kinds of firm are used: 92–100% of group firms find similar firms (59–107 cells a year).
  - Each group firm's energy or CO2 per unit of value added is set against the average of its cell's other firms. These comparisons are then averaged over the group's firms, so the answer is about the group's own firms.
  - Unknown status is left out (export status is unknown for 29–58% of firms a year).
  - Sample: energy, CO2 and value added above zero, plus a known number of workers (28 rows in 2022 lack it).
- **"Typical" is an average of ratios, not the median.** A firm at half and one at double cancel out. Differences in logs can be averaged within cells, and medians cannot. The circle ("not matched") uses the same average against all other firms that year, so diamond against circle shows only what matching changes.
  - The circles equal the `gmean_*` ratios in the R1-02 to R1-04 tables. They are not the medians drawn there. Exporters 2018: 85 here against 73 in R1-02; importers 2015: 93 against 81.
- **What matching changes.**
  - Typical workers, exporters against non-exporters: 145–207 against 41–55 unmatched; 130–196 against 128–179 matched.
  - Unmatched, exporters look leaner in 2010–11 (74 and 87); matched, they are 96 and 110. Size alone explains about half of this (84 and 98 when matching on size only; column `chk_size_pct`).
  - Foreign-owned firms move the same way: 55 unmatched, 72 matched in 2010.
  - The effective number of other firms is smaller than the count, because cells weigh their other firms unevenly: exporters 168–329 of 884–1,173 (`n_other_effective`).
  - Checks (`chk_*`): industry only, size only, also the same province (loses about 40% of group firms), finer size bands, and firms with a known export status only.
- **Results, matched (energy; CO2 alike).**
  - **Exporters** use about as much as similar non-exporters: 70–125 in 2010–15, clearly lower only in 2015 (70, energy). After Paris they are clearly lower in 2019 (68 and 70), not in other years.
  - **Importers** use clearly less: 70–90, clear in every year 2010–15 except 2012; 2018: 70 and 67, clear.
  - **Foreign-owned firms (10%+):** 63–83 in 2010–14, clearly lower only in 2012 (both) and 2013 (energy). About the same from 2015 (101 and 107); 2018: 92 and 99.
- **Before (2013–14 average) against after (2018), matched.** No change is clear in any panel. The 95% ranges come from 999 redraws of whole firms with all their years, matching again each time (seed 20260925).

  | | Energy | CO2 |
  |---|---|---|
  | Exporters | 89 → 91, +1 (−29 to +48) | 92 → 93, 0 (−30 to +50) |
  | Importers | 77 → 70, −7 (−22 to +8) | 79 → 67, −12 (−28 to +3) |
  | Foreign-owned | 75 → 92, +17 (−7 to +43) | 80 → 99, +19 (−9 to +48) |

  Without matching, importers' falls are clear: −15 (−27 to −3) and −20 (−33 to −8). Matching on size and industry makes them unclear.
- **Wider window** (all years before 2015 against all solid later years: exporters 2017–21; importers and foreign-owned 2018 only):
  - exporters −8 and −7;
  - importers −7 and −12;
  - foreign-owned +21 (−1 to +46) and +24 (+0.2 to +52). The last is clear only just: a reviewer's separate 299-draw run gave +0.4 to +51, and the normal approximation −1 to +49.
  - Treat it as not clear.
- **Doubtful years** (same as R1-03 and R1-04; matching does not fix them):
  - Importers 2017 (gap 658) and foreign-owned 2020 (307) are in the table only. Importers 2019–22 (18–26) and foreign-owned 2017, 2019, 2021, 2022 are light gray.
  - Among firms with a known export status, importers are 88 in 2017 and 43, 74, 92, 108 in 2019–22 (`chk_knownx_pct`). So the jump and most of the drop come from importers with no export answer (lesson 16).
  - Foreign-owned 2021–22 are 119 and 129 matched against 76 and 80 unmatched, and 102 and 75 among firms with a known export status: do not interpret them.
- **Exporters 2022.** No known non-exporters (the 2022 file records direct exporters only): no comparison.
- **Runtime and add-ons.** About 20 s. Built-in Stata only: the redraw arithmetic runs in Mata, which ships with Stata, and draw 0 is checked against the plain-Stata calculation.
- **Units.** "Per million of value added" means per million Rp000 on the real files; value added is at current prices. This shows differences between firms of the same year, industry and size, not their cause.

**09 — groups fixed before Paris, as a regression.**
- **Groups.** R1-06's rule and code:
  - exporters 592 against 1,727, importers 891 against 2,140, foreign-owned 397 against 2,634;
  - left out: 7,432 firms without a 2013–14 record and 712 without a known export answer.
- **Model.**
  - The log of each outcome on group × period, with firm averages and industry × year and province × year averages (Deasy's "Firm FE + industry×year FE + province×year FE").
  - 95% intervals are clustered by firm.
  - Periods: 2010–12 (before-Paris check), 2013–14 (comparison years, Deasy's freeze years), 2015 (transition), 2017 (records jump), 2018 (drawn), 2019–22 (records in doubt).
  - Each period has its own term, so the 2017 jump and the 2019–22 records do not enter the 2018 number. Using only the 2013, 2014 and 2018 records (`window`) gives nearly the same answers: exporters' energy used −26% [−43, −5], energy per value added 0%.
- **Outcomes and units.**
  - R1-05's rows: % = 100 × (exp(b) − 1); electricity rows in percentage points.
  - "VA/energy use" and "VA/emisi" are the `mirror_diff*` columns.
  - Scope-2 CO2 repeats scope-2 energy exactly (one grid factor a year). GJ per tonne of scope-2 CO2 is the same for every firm and is not estimated.
  - Own-electricity rows compare with 2013 only: in 2014–15, only 57–61% of frozen firms have it recorded.
- **Support.**
  - A period is shown only with at least 30 firms of the group and 30 other firms in each of its years and each comparison year.
  - Only the stricter foreign-owned group falls short (2010–12, 2019–22).
- **2018 against 2013–14 (drawn).**
  - Energy and CO2 per unit of value added: no group differs clearly. Total energy per value added: exporters −3% [−25, +26], importers +8% [−12, +32], foreign-owned +10% [−18, +46]. CO2: −5%, +12%, +5%.
  - Exporters used 27% less energy [−43, −7] and emitted 29% less CO2 [−44, −10] than similar firms (clear). But their value added fell 25% [−38, −10] and their workers 14%. Before Paris, their value added was already 28% lower and their workers 19% lower (clear). The group was large in 2013–14, the years it was picked in, and smaller on both sides: a size effect, not a Paris response. Without importers' records that have no export answer, the energy-used result is −23% [−45, +8], not clear.
  - Importers' electricity: the bought share is up 6.4 points [2.2, 10.6]; firms making their own are down 12.1 points [−19.2, −4.9]; own electricity as a share is down 4.4 points [−7.1, −1.7]. Before Paris, the same rows were already −22.8 and −6.2 points (clear).
  - Clear results: 10 of the 51 drawn after-Paris markers (7 of 45 on Deasy's outcomes alone). 18 of 51 before-Paris markers are clear.
- **Before Paris, and the choice of comparison years.**
  - In 2010–12, exporters' and importers' energy per value added were +31% [+8, +60] and +27% [+8, +48] above their 2013–14 level, compared with other firms. They were falling faster before Paris.
  - One estimate per year (`yearly`) shows exporters sliding steadily against other firms: +53% (2010), +23% (2012), +9% (2015), −3% (2018), −24% (2022). There is no break at Paris.
  - Measured against 2010–12 instead of 2013–14, exporters' 2018 energy per value added is −26% [−43, −5] (review check). That is the same slide continuing.
  - 2015: importers +28% [+8, +53], clear (R1-06: +20.6 points).
- **Stricter rule** (flagged in every known 2013–14 year): 16 of 51 are clear.
  - Exporters: energy used −32% [−50, −9], value added −30%.
  - Foreign-owned (42 firms): energy used −54% [−74, −18] and CO2 −58% [−77, −25], but value added −36% and workers −43%.
  - Taking the 2013–14 average itself as the group measure: foreign-owned energy used −38% [−60, −3].
  - The answer depends on the grouping rule, as in R1-06, and the stricter groups shrink too.
- **Deasy's literal version** ("2016+" = 2017–22 together, 2015 as the transition year, against 2010–14).
  - Totals show no clear difference: energy per value added −5% [−23, +17] for exporters, +6% for importers, −1% for foreign-owned.
  - With firm + year averages only, energy used is clearly lower for exporters (−23%) and foreign-owned firms (−34%).
  - 2017–22 pooled mixes the 2017 recording jump (energy per value added +72% for exporters, +105% for importers) with the doubtful 2019–22 years. That is why 2018 is drawn.
- **Matching on industry and province matters** (○ = firm + year averages only).
  - Foreign-owned scope-2 energy per value added: −26% against −4% with the matching.
  - Foreign-owned energy used: −34% against −19%.
- **Fictional links.** Still so recorded in 2018: 39% of answering exporters (53 of 136), 71% of importers (333 of 466), 15% of foreign-owned firms (22 of 150).
- **Takeaway.** Firms that exported, imported or were foreign-owned in 2013–14 did not clearly change their energy or CO2 per unit of value added differently from similar firms by 2018. Where energy used fell more (exporters), the group's value added and workforce fell too. Several gaps were already opening before Paris. Nothing here links a change to the Paris Agreement.
- **Run.** About 1 minute and ~500 regressions on the development file; longer on the full files. Needs reghdfe, ftools and require.

**10 — groups fixed before Paris, other firms reweighted (entropy balancing).**
- **Why.** In 2013–14 the groups of R1-09 were far larger than the other firms: about one standard deviation more workers and value added. Each other firm gets one weight so that, in 2013–14, the weighted other firms match the group exactly. R1-09's regression is then run again with these weights.
- **Weights.**
  - Entropy balancing (Hainmueller 2012), written out in Mata, so the add-on `ebalance` is not needed. The weights stay as equal as possible while matching the targets exactly.
  - Targets come only from each firm's own 2013–14 records (nothing after Paris): workers and value added (logs); energy and CO2 per unit of value added (logs); bought electricity as % of energy; makes own electricity; own electricity not recorded; 2-digit industry shares; island shares (Sumatra, Java, other). The 34 provinces would leave tiny cells; province × year averages stay in the regression.
  - Group firms keep weight 1; the other firms' weights add up to the group's size.
  - Firms: exporters 582 against 1,693, importers 882 against 2,106, foreign-owned 384 against 2,604. Left out: frozen firms with no usable 2013–14 record (29, 43, 43), and 15 non-exporters in industry 33, which has no exporters.
  - What the weighted other firms are worth (as many firms counted equally): 283, 338 and 570. The largest weight is 70, 36 and 35 times the average.
  - Before weighting, the groups were larger by 0.92 (exporters' workers) to 1.13 (foreign-owned value added) standard deviations. Importers also made their own electricity far more often (0.85). After weighting every gap is 0.
- **The 2018 result rests on the firms also recorded in 2018:** 254 exporters against 794 other firms, 464 against 877, 147 against 1,194 (worth 240, 159 and 301). Among them the weights leave the group larger again (◇ in the figure):
  - exporters' workers +0.39 and value added +0.28 standard deviations;
  - importers' value added +0.25 and own electricity +0.19;
  - foreign-owned workers +0.21 and value added +0.19.
- **2018 against 2013–14, reweighted (drawn).**
  - Exporters: energy used −17% [−36, +7] and CO2 −18% [−36, +5], no longer clear (without weights −27% and −29%, clear). Value added −7% [−26, +17] (without weights −25%, clear). Energy per value added −11% [−33, +19]. R1-09's "exporters used 27% less energy" was mostly a size difference.
  - Importers: value added +34% [+6, +71], clear (without weights −9%). Energy per value added −25% [−44, +1]. Energy used +1% [−23, +31]. Their lower energy per value added comes from value added rising, not from using less energy.
  - Foreign-owned: nothing clear. Energy used −2% [−29, +34] (without weights −18%); value added −4%.
  - Clear results: 2 of 51 after-Paris markers (10 without weights): exporters' bought-electricity energy used −27% [−45, −2], and importers' value added.
- **Before Paris (2010–12 against 2013–14).** R1-09's early gaps go away: exporters' energy per value added +10% [−11, +37] (without weights +31%, clear), importers' +2% (+27%, clear). 2 of 51 before-Paris markers are clear (18 without weights).
- **Checks (table, and review checks where marked).**
  - Matching the spreads of the five size and energy measures too (`eb_sd`): 6 of 51 clear, all importers'. Energy per value added −27% [−46, −2], CO2 per value added −26%, value added +39% [+9, +79].
  - Re-balancing only the firms also recorded in 2018 (`eb_s18`; worth 116, 76, 189): 4 of 51 clear, all importers'. Energy per value added −30% [−49, −4], CO2 per value added −31%, value added +66% [+23, +125]; energy used +17%, not clear. Exporters' energy used −5% [−29, +26].
  - Firm + year averages only (`eb_fe1`): 1 of 51 clear.
  - Stricter groups (`eb_st`): 4 of 51 clear, all bought electricity (exporters' energy per value added −35%, energy used −40%; foreign-owned −44% and −46%). Foreign-owned total energy used −38% [−64, +8] (without weights −53%, clear).
  - Largest weights (review check): capping the weights at 10 or 20 times the average moves no drawn 2018 number by more than 4 points. Leaving out the 1% most heavily weighted other firms and re-balancing moves importers' energy used to +21% and energy per value added to −13% (neither clear); value added stays clear at +39%.
  - The 95% intervals treat the weights as known. In 199 firm redraws that re-estimate the weights (review check), the spread of the 2018 estimates is 8% smaller to 12% larger than reported. No answer changes, except that importers' energy per value added sits on the edge either way: the interval ends at +1% here and at −0.3% in the redraws.
- **Why importers' value added is +34%** (review check).
  - Among firms recorded in both 2013–14 and 2018, value added rose 0.64 log points for importers, 0.75 for all other firms and 0.44 for the reweighted other firms.
  - The tenth of other firms with the largest weights (most like importers in 2013–14) rose only 0.11, the rest 0.80.
  - At the same 2013–14 value added, importers grew 0.34 log points more.
  - Firms picked for being large in 2013–14 may partly have been large only for a while and then fell back. With fictional firm links, this cannot be told apart from importers really growing faster. Exporters and foreign-owned firms show no such gap.
- **Fictional links.** Still so recorded in 2018: 39% of answering exporters (53 of 136), 72% of importers (333 of 465), 15% of foreign-owned firms (22 of 148).
- **Takeaway.** Once the other firms look like each group in 2013–14, no group's energy use or CO2 changed clearly differently by 2018, and the groups no longer drift apart before Paris. Importers' value added grew more than that of similar firms, which lowers their energy per unit of value added. Nothing here links a change to the Paris Agreement.
- **Run.** About 1 minute and ~400 regressions on the development file; longer on the full files. Needs reghdfe, ftools and require.
