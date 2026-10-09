/*==========================================================================
  Line 1: "Has Indonesian manufacturing actually decarbonised?"
  Prepare Statistik Industri (SI) 2010-2022 for B2-01
  Input : $SI_DATA  (analysis_ready_data.dta from block 0)
  Output: data/b201_si.dta  -- 1 row = 1 firm x year
          (open with: use "$B201_DATA/b201_si.dta", clear  then browse)

  Main variables created:
    kbli2 (with English sector names), va, output, workers
    co2_s1 co2_s2 co2_total    scope 1 (4 fuels), scope 2, total CO2 (tonnes)
    gj_s1 gj_s2 gj_total       the same in energy (GJ)
    gj_per_va gj_per_out       energy intensity
    co2_per_va co2_per_out     carbon intensity
    va_per_gj va_per_co2       energy and carbon productivity
    co2_s1_nine gj_s1_nine     VARIANT: block 0's nine fuels (coal-corrected)
    co2_s1_wide gj_s1_wide     VARIANT: nine fuels + diesel oil, fuel oil and
                               natural gas (the fuels the 2020 form added)
    co2_s2_src                 VARIANT: scope 2 on the sourced annual grid factor
    clean                      1 = not an extreme energy outlier
  The headline is always the 4-fuel scope 1 (the fuels asked in every year).
  The variants are only there to show how much the headline misses.
==========================================================================*/
if "$B201" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$SI_DATA", clear
* new variables are stored in double precision (sums of tonnes and GJ)
set type double

* ---- identifiers ------------------------------------------------------
* year = survey year (there is no 2016 file)
generate kbli2 = real(substr(industry_code, 1, 2))
label define kbli2 0 "All manufacturing" 10 "10 Food" 11 "11 Beverages" 12 "12 Tobacco" 13 "13 Textiles" ///
    14 "14 Apparel" 15 "15 Leather, footwear" 16 "16 Wood" 17 "17 Paper" ///
    18 "18 Printing" 19 "19 Coke, refined petroleum" 20 "20 Chemicals" ///
    21 "21 Pharmaceuticals" 22 "22 Rubber, plastics" 23 "23 Non-metallic minerals" ///
    24 "24 Basic metals" 25 "25 Fabricated metal" 26 "26 Electronics" ///
    27 "27 Electrical equipment" 28 "28 Machinery" 29 "29 Motor vehicles" ///
    30 "30 Other transport" 31 "31 Furniture" 32 "32 Other manufacturing" ///
    33 "33 Repair, installation"
label values kbli2 kbli2

* ---- output, value added (nominal) ------------------------------------
generate va      = value_added_nominal
generate output  = gross_output_nominal

* ---- energy & emissions -----------------------------------------------
* COAL 2017 CORRECTION: block 0 multiplies by 1000 (treats it as tonnes),
* but the price per unit shows the data are already in kg. Divide back.
generate co2_coal = co2_coal_s1
generate gj_coal2 = gj_coal
replace  co2_coal = co2_coal_s1 / 1000 if year == 2017
replace  gj_coal2 = gj_coal / 1000     if year == 2017

* scope 1 = the 4 fuels asked in every year: diesel, petrol, coal, LPG
egen co2_s1 = rowtotal(co2_diesel_s1 co2_petrol_s1 co2_coal co2_lpg_s1), missing
egen gj_s1  = rowtotal(gj_diesel gj_petrol gj_coal2 gj_lpg), missing
* scope 2 = purchased electricity (own generation is already in the fuels)
generate co2_s2 = co2_scope2_s1
generate gj_s2  = gj_electricity
egen co2_total = rowtotal(co2_s1 co2_s2), missing
egen gj_total  = rowtotal(gj_s1 gj_s2), missing

* ---- VARIANTS (comparison only, never in the headline) -----------------
* block 0's nine fuels (adds kerosene, city gas, other gas, coal briquettes,
* coke), with the coal correction applied
generate co2_s1_nine = co2_scope1_s1 - co2_coal_s1 + co2_coal
generate gj_s1_nine  = gj_fuel_s1 - gj_coal + gj_coal2

* the 2020 form added diesel oil, fuel oil and natural gas (MMBTU); block 0
* has their quantities but no CO2/GJ column. Factors: IPCC 2006 defaults
* (Vol 2 Ch 1), CO2 in tonnes per unit.
generate q_dieseloil = fuel_dieseloil_ltr if fuel_dieseloil_ltr >= 0
generate q_fueloil   = fuel_fueloil_ltr   if fuel_fueloil_ltr >= 0
generate q_natgas    = fuel_natgas_mmbtu  if fuel_natgas_mmbtu >= 0
generate co2_dieseloil = q_dieseloil * 0.002708    // per litre
generate co2_fueloil   = q_fueloil   * 0.002971    // per litre
generate co2_natgas    = q_natgas    * 0.059189    // per MMBTU
generate gj_dieseloil  = q_dieseloil * 0.03655
generate gj_fueloil    = q_fueloil   * 0.03838
generate gj_natgas     = q_natgas    * 1.05506
egen co2_s1_wide = rowtotal(co2_s1_nine co2_dieseloil co2_fueloil co2_natgas), missing
egen gj_s1_wide  = rowtotal(gj_s1_nine gj_dieseloil gj_fueloil gj_natgas), missing

* scope 2 on the sourced grid factor: block 0 holds the 2014 factor flat after
* 2014; this variant uses the 2014 Neraca factor scaled by Ember's national
* grid intensity
generate grid_src = grid_factor_s1
replace grid_src = 0.000920 if year == 2015
replace grid_src = 0.000910 if year == 2017
replace grid_src = 0.000904 if year == 2018
replace grid_src = 0.000917 if year == 2019
replace grid_src = 0.000905 if year == 2020
replace grid_src = 0.000905 if year == 2021
replace grid_src = 0.000893 if year == 2022
generate co2_s2_src = elec_purchased_kwh * grid_src

* ---- firm-level ratios ------------------------------------------------
generate gj_per_va   = gj_total / va        if va > 0
generate gj_per_out  = gj_total / output    if output > 0
generate co2_per_va  = co2_total / va       if va > 0
generate co2_per_out = co2_total / output   if output > 0
generate va_per_gj   = va / gj_total        if gj_total > 0
generate va_per_co2  = va / co2_total       if co2_total > 0

* ---- energy outlier flag (clean) --------------------------------------
* a record is left out of the analysis (clean = 0) if any of its energy
* quantities is above 100x that year's 99th percentile. Nothing is deleted.
generate coal_kg_fix = fuel_coal_kg
replace  coal_kg_fix = fuel_coal_kg / 1000 if year == 2017
generate byte clean = 1
levelsof year, local(years)
foreach q in fuel_diesel_ltr fuel_petrol_ltr fuel_kerosene_ltr coal_kg_fix fuel_lpg_kg ///
             fuel_citygas_m3 fuel_othergas_m3 fuel_coalbriq_kg fuel_coke_kg ///
             elec_pln_kwh elec_nonpln_kwh elec_owngen_kwh fuel_dieseloil_ltr ///
             fuel_fueloil_ltr fuel_natgas_mmbtu fuel_biodiesel_ltr fuel_biomass_kg {
    foreach y of local years {
        quietly count if year == `y' & `q' > 0 & !missing(`q')
        if r(N) > 2 {
            quietly summarize `q' if year == `y' & `q' > 0, detail
            quietly replace clean = 0 if year == `y' & `q' > 100 * r(p99) & !missing(`q')
        }
    }
}
replace clean = 0 if workers == 0 & co2_s1 > 0 & !missing(co2_s1)
count if clean == 0
display as result "Outlier records (clean = 0): " r(N)

* ---- ln versions ------------------------------------------------------
foreach v in va output co2_s1 co2_s2 co2_total gj_s1 gj_s2 gj_total ///
             gj_per_va gj_per_out co2_per_va co2_per_out va_per_gj va_per_co2 {
    generate ln_`v' = ln(`v') if `v' > 0
}
set type float

* ---- save -------------------------------------------------------------
keep  firm_id year source_row kbli2 va output workers ///
      co2_s1 co2_s2 co2_total gj_s1 gj_s2 gj_total ///
      co2_s1_nine gj_s1_nine co2_s1_wide gj_s1_wide co2_s2_src ///
      gj_per_va gj_per_out co2_per_va co2_per_out va_per_gj va_per_co2 clean ln_*
order firm_id year source_row kbli2 clean
label variable kbli2       "Sector, KBLI 2-digit"
label variable va          "Value added, nominal (masked)"
label variable output      "Gross output, nominal (masked)"
label variable co2_s1      "Scope 1 CO2 (t): diesel, petrol, coal, LPG"
label variable co2_s2      "Scope 2 CO2 (t): purchased electricity, block 0 grid factor"
label variable co2_total   "Scope 1 + scope 2 CO2 (t)"
label variable gj_s1       "Scope 1 energy (GJ): the same 4 fuels"
label variable gj_s2       "Purchased electricity (GJ)"
label variable gj_total    "Total energy (GJ) = gj_s1 + gj_s2"
label variable co2_s1_nine "VARIANT scope 1 CO2 (t): block 0's nine fuels"
label variable gj_s1_nine  "VARIANT scope 1 GJ: block 0's nine fuels"
label variable co2_s1_wide "VARIANT scope 1 CO2 (t): nine fuels + diesel oil, fuel oil, natural gas"
label variable gj_s1_wide  "VARIANT scope 1 GJ: nine fuels + diesel oil, fuel oil, natural gas"
label variable co2_s2_src  "VARIANT scope 2 CO2 (t): sourced annual grid factor"
label variable clean       "1 = not an energy outlier"
compress
save "$B201_DATA/b201_si.dta", replace
display as result "01a done: $B201_DATA/b201_si.dta (" _N " rows)"
