# B2-05 — Energy transition and carbon lock-in at plant level

## How to run

Same as every other block:

```stata
global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo"   // once per Stata session
do "$B12_REPO/20260917-run/block-b2-05-energy-mix/00_run.do"            // all files
do "$B12_REPO/20260917-run/block-b2-05-energy-mix/00_run.do" "" 03      // only file 03
do "$B12_REPO/20260917-run/block-b2-05-energy-mix/00_run.do" "" paths   // only set paths, then run any file by hand
```

This block uses the SI panel only, so there is no roster path to edit. A full run takes about 10 seconds.
File 02 needs 01a; 03 needs 02; 04 needs 03; 05 needs all of them.

Results:
- `output/b2_05_tables.xlsx`: every table, 1 sheet = 1 table. Sheet names start with the to-do line number (`t03_...` = line 3).
- `output/fig*.png`: charts. The exact points of each chart are in the sheet `figNN_data` / `fig05_*_data`.
- `data/b205_si.dta` (prepared SI), `b205_mix.dta` (firm-year mix), `b205_class.dta` (firm-year class),
  `b205_pairs.dta` (firm x wave and its class next wave), `b205_firm_status.dta` (firm: first vs last wave).

Close the Excel file before running.

## One file per to-do line (file number = line number)

| # | To-do line | File | Sheets | Status |
|---|---|---|---|---|
| 1 | Energy transition and carbon lock in at plant level | `01a_prep_si.do` | data prep → `data/b205_si.dta` | ✅ |
| 2 | Construct firm energy mix per year: coal, diesel/fuel oil, gas/lpg, electicity pln, non pln, self generation, biomass. | `02_energy_mix.do` | t02_mix_mean, t02_mix_aggregate, t02_share_stats, t02_self_generation, t02_biomass | ⚠️ self generation and biomass are shown apart, not inside the mix (see below) |
| 3 | Classify firm menjadi coal-intensive, oil intensive, gas intensive, electricity intensive, mixed. | `03_classify.do` | t03_class_by_year, t03_class_profile | ✅ |
| 4 | Buat transition matrix 2010-22 dan cek siapa yg successfully switch keluar dari high carbon fuel dan siapa yg ttp carbon-locked. | `04_transition_matrix.do` | t04_matrix, t04_switch_rate, t04_matrix_long, t04_who_switches | ⚠️ runs, but firm links are fictional in the development data |
| 5 | Grafik by sectors | `05_figures_by_sector.do` (runs last) | t05_mix_by_kbli2, t05_class_by_kbli2, t05_switch_by_kbli2 + fig02, fig03, fig04, fig05 (×3) PNG and their `_data` sheets | ✅ |

`_sumstats.do` is a small helper that writes an n / mean / sd / p10–p90 / min / max table, pooled + by year.

## Definitions

- **Energy mix** (line 2) = GJ per source as % of the firm's GJ, with six sources:
  coal (coal + briquettes + coke), oil (diesel + petrol + kerosene + diesel oil + fuel oil),
  gas (LPG + city gas + other gas + natural gas), electricity bought from PLN, electricity bought from non-PLN,
  and biodiesel. The 2020+ fuels get GJ per unit from the IPCC 2006 default net calorific values (Vol 2 Ch 1, Table 1.2); electricity is kWh × 0.0036.
  Two views: the mean of firm shares (`t02_mix_mean`) and all firms' GJ / all GJ (`t02_mix_aggregate`, dominated by big coal users).
- **Self generation is not one of the six.** The generator burns diesel, coal or gas the firm already reports among its
  fuels; adding the kWh it produces would count the same energy twice. It is reported apart in `t02_self_generation`:
  % of firms with own generation, and own kWh / (PLN + non-PLN + own kWh).
- **Biomass is not one of the six.** Block 0 calls the column kg, the 2020 form says tonne, and nothing settles which
  (same choice as B1-17). `t02_biomass` shows the reporters (2020-22) and what share biomass would take:
  if the column is kg, 34% of reporters would be biomass-dominant; if tonnes, 99%. Settle the unit before using it.
- **Class** (line 3) = the source with ≥ 50% of the firm's GJ, else "Mixed" (decided 9 Oct). Electricity = PLN + non-PLN.
  Biodiesel ≥ 50% gets its own class "Biofuel-intensive" (23 firm-years) instead of hiding in "Mixed".
  Firm-years with no energy at all (489) have no class. The 50 is `local cut 50` in `03_classify.do`.
- **High-carbon** (line 4) = coal- or oil-intensive. **Switched out** = high-carbon this wave, not next wave
  (`t04_switch_rate`), or high-carbon in the firm's first wave and not in its last (`t04_matrix_long`, `t04_who_switches`).
  **Carbon-locked** = high-carbon in both. "Next wave" is year + 1, and 2015 → 2017 (there is no 2016).
  Electricity-intensive counts as "out of high-carbon fuel" although grid power is mostly coal-fired.

## Gaps and caveats

- **Line 4: firm links (`firm_id`) are fictional in the development data** (block 0: `panel_id_synthetic = 1`).
  The matrix and switching rates run, but only mean something on the real BPS data.
- **The 2020 form adds diesel oil, fuel oil, natural gas, biodiesel and biomass.** Part of the 2020 change in the mix
  and classes, and of the 2019 → 2020 switching rate, is the form, not the firms. Pooled sector charts mix both forms;
  the yearly rows are in the `t05_*` tables.
- **Energy reporting jumps between 2015 and 2017** (questionnaire change; "Mixed" rises from 5% to 19%). No survey in 2016.
- Own generation is missing for about 1,000 firms in 2014 and 2015, so the self-generation rate jumps in those years.
- Line 2 lists "self generation" as a source, but block 0 has no generator fuel, so own generation cannot be split by fuel
  (see B2-06).
- Corrections in 01a: 2017 coal divided by 1000; 30 energy-outlier records (`clean = 0`)
  excluded; 2020 FDI and 2022 export flag set missing (used only in the profiles). Lubricant is not energy and is left out.

## Checks done (Oct 2026)

- Full run, single file (`"" 03`, `"" 05`) and `paths` + `04` by hand: no errors.
- Diesel oil, fuel oil and natural gas have no GJ column in block 0. Counting them (GJ from the IPCC defaults)
  gives 157-252 more gas-intensive and 241-344 fewer electricity-intensive firms per year (2020-22) than leaving
  them out.
