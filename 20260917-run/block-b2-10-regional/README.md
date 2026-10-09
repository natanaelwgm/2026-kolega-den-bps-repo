# B2-10 — Regional aspects of manufacturing decarbonisation

## How to run

Same as every other block:

```stata
global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo"   // once per Stata session
do "$B12_REPO/20260917-run/block-b2-10-regional/00_run.do"            // all files
do "$B12_REPO/20260917-run/block-b2-10-regional/00_run.do" "" 05      // only file 05
do "$B12_REPO/20260917-run/block-b2-10-regional/00_run.do" "" paths   // only set paths, then run any file by hand
```

No roster is needed. Files 02-11 need `01a_prep_si.do` to have run once.

Results:
- `output/b2_10_tables.xlsx`: every table, 1 sheet = 1 table. Sheet names start with the to-do line number (`t05_...` = line 5).
- `output/fig*.png`: charts. The exact points of each chart are in the sheet `figNN_data`.
- `data/b210_si.dta`: the working dataset, ready to `browse`.

Close the Excel file before running.

## One file per to-do line (file number = line number)

Region levels: province (`_prov`), Java / outside Java (`_java`), district (`_kabkot`).
Every table is pooled 2010-2022 (`period = "pool"`) and by year, unless noted.

| # | To-do line | File | Sheets | Status |
|---|---|---|---|---|
| 1 | Regional aspects of manufacturing decarbonisation | `01a_prep_si.do` | data prep → `data/b210_si.dta` | ✅ |
| 2 | By province, java/non java, kabkot: | `02_overview.do` | t02_overview_java, t02_overview_prov (all of 3-9 in one table) | ⚠️ kabkot |
| 3 | Industrial VA | `03_va.do` | t03_va_java, t03_va_prov, t03_va_dist_java | ⚠️ kabkot |
| 4 | Energy use | `04_energy.do` | t04_energy_java, t04_energy_prov, t04_energy_dist_java | ⚠️ kabkot |
| 5 | Emissions | `05_emissions.do` | t05_co2_java, t05_co2_prov, t05_co2_dist_java | ⚠️ kabkot |
| 6 | Carbon intensity | `06_carbon_intensity.do` | t06_intensity_java, t06_intensity_prov, t06_intensity_dist_java | ⚠️ kabkot |
| 7 | Exporter concentration | `07_exporter_concentration.do` | t07_exp_java, t07_exp_prov | ⚠️ kabkot; no 2022 |
| 8 | Fdi concentration | `08_fdi_concentration.do` | t08_fdi_java, t08_fdi_prov | ⚠️ kabkot; no 2020 |
| 9 | Energy mix | `09_energy_mix.do` | t09_mix_java, t09_mix_prov | ⚠️ kabkot; biomass out |
| 10 | Indentifikasi daerah yg lebih clean mana yg carbon intensive | `10_ranking.do` | t10_rank_prov, t10_quadrant_prov, t10_rank_year_prov | ⚠️ province only |
| — | (no figures line; added) | `11_figures.do` (runs last) | fig03, fig06, fig07, fig08, fig09, fig10 (PNG) + figNN_data | ✅ |

`_sumstats.do` is a small helper that writes an n / mean / sd / p10–p90 / min / max table, pooled + by year, by group
(used for the `_dist_java` sheets, level and ln).

## Gaps against the to-do list

- **kabkot (lines 2-10):** `district_code` is blank on all 33,049 records of block 0. Every file checks
  `count if kabkot != ""` and writes the `_kabkot` sheets automatically once the district code is filled;
  until then it prints "No district (kabkot) codes in this data". Needed: the BPS district code (kabupaten/kota).
- **Line 7:** no exporter rate in 2022 (the form asks only about direct exports, so no "no" is recorded).
  Firms without an export answer are left out of the denominator (about 46% of records).
- **Line 8:** no FDI rate in 2020 (47% FDI in that year is not credible).
- **Line 9:** biomass is left out of the mix (unit kg vs tonne not settled); only the % of firms reporting
  biomass is shown. Diesel oil, fuel oil and natural gas are asked only from 2020 and city/other gas only up
  to 2019, so oil/gas shares shift around 2020 partly because of the questionnaire.

## Decisions (please check)

- **Line 9 energy mix** uses the B2-05 source groups: coal (+ briquettes, coke), oil (diesel, petrol, kerosene,
  diesel oil, fuel oil), gas (LPG, city gas, other gas, natural gas), PLN electricity, non-PLN electricity.
  Own generation is shown as a % of the electricity the firms use, not as a sixth share (its fuel is already in
  coal/oil/gas, so adding it would count it twice).
- **Line 10** ranks provinces by aggregate CO2 / VA (rank 1 = cleanest). Only provinces with ≥ 50 clean
  firm-years are ranked (≥ 10 per year in the yearly ranking); 4 small provinces stay in the table unranked.
  Quadrants: "cleaner" = CO2/VA below the national CO2/VA; "large" = VA share at or above the median of the
  ranked provinces. CO2 per GJ, own-combustion CO2 per GJ and the coal share are shown beside the rank.
- Lines 3-9 use aggregate ratios (sum / sum) for the region and add the firm median and the mean of ln.

## Notes

- **Corrections in 01a**: 2017 coal divided by 1000; 2020 FDI and 2022 export flag
  set missing; 30 energy-outlier records (`clean = 0`) excluded.
- Development-data headline: Java holds 76.2% of VA, 52.4% of energy and 57.5% of CO2; the exporter rate is
  19.2% in Java vs 23.6% outside, Java holds 74.1% of exporters, and the FDI rate is 8.8% vs 11.6%.
- All money values are **nominal** and masked in the development data: read shares and ranks, not levels.
- Scope 2 uses one national grid factor, so a regional difference in scope 2 is a difference in how much
  electricity is bought, not in how it is generated.
- Energy reporting jumps between 2015 and 2017 (questionnaire change); time charts mark 2016 with a dashed line.
