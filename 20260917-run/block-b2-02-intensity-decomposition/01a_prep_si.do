/*==========================================================================
  Line 1 (part a)  Prepare Statistik Industri (SI) 2010-2022 for B2-02
  Input : $SI_DATA  (analysis_ready_data.dta from block 0)
  Output: data/b202_si.dta  -- 1 row = 1 firm x year
          (open with: use "$B202_DATA/b202_si.dta", clear  then browse)

  Main variables created:
    kbli2 (with English sector names), prov, java, large
    va, output, workers                          (nominal, masked)
    co2_s1 co2_s2 co2_total gj_s1 gj_s2 gj_total (scope 1 = 4 fuels, scope 2 = purchased electricity)
    co2_s2_static  co2_total_static    scope 2 on block 0's STATIC grid factor
    co2_s2_sourced co2_total_sourced   scope 2 on the sourced annual grid factor
    co2_per_va gj_per_va co2_per_gj    the three terms of the decomposition
    co2_per_gj_s1 co2_per_gj_s2 gj_share_s1, co2_pw gj_pw, ln_*
    clean          1 = not an extreme energy outlier

  Copied from block-b1-18's 01a_prep_si.do (same corrections); the lines
  added for this block are marked "B2-02".
==========================================================================*/
if "$B202" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$SI_DATA", clear

* ---- identifiers ------------------------------------------------------
* year = survey year (there is no 2016 file)
generate kbli2 = real(substr(industry_code, 1, 2))
generate kbli5 = industry_code
generate prov  = real(province_code)
generate java  = inlist(prov, 31, 32, 33, 34, 35, 36) if !missing(prov)
label define java 0 "Outside Java" 1 "Java"
label values java java

* B2-02: sector names, so the tables read without a codebook
label define kbli2 10 "10 Food" 11 "11 Beverages" 12 "12 Tobacco" 13 "13 Textiles" ///
    14 "14 Apparel" 15 "15 Leather, footwear" 16 "16 Wood" 17 "17 Paper" ///
    18 "18 Printing" 19 "19 Coke, refined petroleum" 20 "20 Chemicals" ///
    21 "21 Pharmaceuticals" 22 "22 Rubber, plastics" 23 "23 Non-metallic minerals" ///
    24 "24 Basic metals" 25 "25 Fabricated metal" 26 "26 Electronics" ///
    27 "27 Electrical equipment" 28 "28 Machinery" 29 "29 Motor vehicles" ///
    30 "30 Other transport" 31 "31 Furniture" 32 "32 Other manufacturing" ///
    33 "33 Repair, installation"
label values kbli2 kbli2

* ---- firm size: medium vs large (100-worker threshold) ----------------
generate large = (workers > 100) if !missing(workers)
label define large 0 "Medium (<=100)" 1 "Large (>100)"
label values large large

* ---- firm characteristics (nominal) -----------------------------------
generate va      = value_added_nominal
generate output  = gross_output_nominal
generate va_pw   = va / workers      if workers > 0

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
* scope 2 = purchased electricity
generate co2_s2 = co2_scope2_s1
generate gj_s2  = gj_electricity
egen co2_total = rowtotal(co2_s1 co2_s2), missing
egen gj_total  = rowtotal(gj_s1 gj_s2), missing

* B2-02: scope 2 on two other grid factors (scope 1 and the GJ are unchanged)
* (a) STATIC: block 0's sensitivity factor, 0.000867 t/kWh in every year
generate co2_s2_static = co2_scope2_s2
* (b) SOURCED: 2010-2014 as block 0 (Neraca); from 2015 the 2014 value scaled
*     by Ember's national grid intensity
generate grid_sourced = grid_factor_s1
replace  grid_sourced = 0.000920 if year == 2015
replace  grid_sourced = 0.000910 if year == 2017
replace  grid_sourced = 0.000904 if year == 2018
replace  grid_sourced = 0.000917 if year == 2019
replace  grid_sourced = 0.000905 if year == 2020
replace  grid_sourced = 0.000905 if year == 2021
replace  grid_sourced = 0.000893 if year == 2022
generate co2_s2_sourced = elec_purchased_kwh * grid_sourced
egen co2_total_static  = rowtotal(co2_s1 co2_s2_static), missing
egen co2_total_sourced = rowtotal(co2_s1 co2_s2_sourced), missing

generate co2_per_va  = co2_total / va      if va > 0
generate gj_per_va   = gj_total / va       if va > 0
generate co2_per_out = co2_total / output  if output > 0
generate co2_pw      = co2_total / workers if workers > 0
generate gj_pw       = gj_total / workers  if workers > 0

* B2-02: the second term (carbon content of the energy), total and per scope
generate co2_per_gj    = co2_total / gj_total if gj_total > 0
generate co2_per_gj_s1 = co2_s1 / gj_s1       if gj_s1 > 0
generate co2_per_gj_s2 = co2_s2 / gj_s2       if gj_s2 > 0
generate gj_share_s1   = gj_s1 / gj_total     if gj_total > 0

* ---- energy outlier flag (clean) --------------------------------------
* a record is left out of the analysis (clean = 0) if any of its energy
* quantities is above 100x that year's 99th percentile. Nothing is deleted.
generate coal_kg_fix = fuel_coal_kg
replace  coal_kg_fix = fuel_coal_kg / 1000 if year == 2017
generate clean = 1
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
foreach v in va output workers va_pw co2_s1 co2_s2 co2_total gj_s1 gj_s2 gj_total ///
             co2_per_va gj_per_va co2_per_gj co2_per_gj_s1 co2_pw gj_pw {
    generate ln_`v' = ln(`v') if `v' > 0
}

* ---- save -------------------------------------------------------------
keep  firm_id year source_row kbli2 kbli5 prov java large va output workers va_pw ///
      co2_s1 co2_s2 co2_total gj_s1 gj_s2 gj_total co2_s2_static co2_s2_sourced ///
      co2_total_static co2_total_sourced grid_sourced co2_per_va gj_per_va co2_per_out ///
      co2_pw gj_pw co2_per_gj co2_per_gj_s1 co2_per_gj_s2 gj_share_s1 clean ln_*
order firm_id year source_row kbli2 kbli5 prov java large
label variable co2_s1         "Scope 1 CO2 (t): diesel, petrol, coal, LPG"
label variable co2_s2         "Scope 2 CO2 (t): purchased electricity, block 0 grid factor"
label variable co2_s2_static  "Scope 2 CO2 (t), static grid factor 0.000867 t/kWh"
label variable co2_s2_sourced "Scope 2 CO2 (t), sourced annual grid factor"
label variable gj_s1          "Energy from the 4 fuels (GJ)"
label variable gj_s2          "Purchased electricity (GJ)"
label variable co2_per_va     "CO2 / VA (t per nominal VA)"
label variable gj_per_va      "GJ / VA (GJ per nominal VA)"
label variable co2_per_gj     "CO2 / GJ (t per GJ), scope 1 + 2"
label variable co2_per_gj_s1  "CO2 / GJ, scope 1 only"
label variable co2_per_gj_s2  "CO2 / GJ, scope 2 only (= grid factor / 0.0036)"
label variable gj_share_s1    "Fuel (scope 1) share of total GJ"
label variable clean "1 = not an energy outlier"
compress
save "$B202_DATA/b202_si.dta", replace
display as result "01a done: $B202_DATA/b202_si.dta (" _N " rows)"
