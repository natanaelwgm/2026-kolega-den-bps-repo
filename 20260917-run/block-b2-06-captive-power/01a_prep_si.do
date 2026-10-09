/*==========================================================================
  Line 1: "Captive power/self generation in Indonesian manufacturing"
  Prepare Statistik Industri (SI) 2010-2022 for B2-06
  Input : $SI_DATA  (analysis_ready_data.dta from block 0)
  Output: data/b206_si.dta  -- 1 row = 1 firm x year
          (open with: use "$B206_DATA/b206_si.dta", clear  then browse)

  Main variables created:
    has_owngen     1 = own-generated electricity > 0, 0 = reported none,
                   missing = not asked (2014-2015: about 1,060 firms per year)
    own_kwh        own-generated electricity (kWh)
    purch_kwh      purchased electricity, PLN + non-PLN (kWh)
    elec_all_kwh   own + purchased (kWh)
    owngen_share   own / (own + purchased), 0-1
    has_nonpln     1 = buys electricity from a non-PLN supplier
    exporter, importer, fdi, large, kbli2, kbli5, prov, java
    va, output, workers, co2_s1 co2_s2 co2_total, co2_s1_pw (per worker)
    clean          1 = not an extreme energy outlier
  Copied from block-b1-18-bahan-baku/01a_prep_si.do (same corrections).
==========================================================================*/
if "$B206" == "" {
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

* ---- firm size: medium vs large (100-worker threshold) ----------------
generate large = (workers > 100) if !missing(workers)
label define large 0 "Medium (<=100)" 1 "Large (>100)"
label values large large

* ---- imports, exports & FDI -------------------------------------------
* importer is only defined where the import question can be evaluated
generate importer = import_flag if import_observed == 1
label define importer 0 "Non-importer" 1 "Importer"
label values importer importer

generate exporter = export_flag
generate fdi      = fdi_10_flag                     // foreign ownership >= 10%
* 2022: the form only asks about DIRECT exports, a "no" is never recorded -> missing
replace exporter = . if year == 2022
* 2020: foreign ownership is inconsistent (47% FDI vs 8-11% other years) -> missing
replace fdi = . if year == 2020
label define exporter 0 "Non-exporter" 1 "Exporter"
label values exporter exporter
label define fdi 0 "Domestic" 1 "FDI"
label values fdi fdi

* ---- firm characteristics (nominal) -----------------------------------
generate va      = value_added_nominal
generate output  = gross_output_nominal
generate capital = capital_stock_nominal

* ---- own generation ---------------------------------------------------
* 2014-2015: own generation was not asked for ~1,060 firms per year; block 0
* leaves elec_owngen_kwh missing for them, so has_owngen is missing, not 0.
* double: kWh values are large; float storage would round them
generate double own_kwh   = elec_owngen_kwh
generate double purch_kwh = elec_purchased_kwh      // = elec_pln_kwh + elec_nonpln_kwh
egen double elec_all_kwh  = rowtotal(own_kwh purch_kwh), missing
generate has_owngen          = (own_kwh > 0) if !missing(own_kwh)
generate double owngen_share = own_kwh / (own_kwh + purch_kwh) if (own_kwh + purch_kwh) > 0
generate has_nonpln   = (elec_nonpln_kwh > 0) if !missing(elec_nonpln_kwh)
label define has_owngen 0 "No own generation" 1 "Own generation"
label values has_owngen has_owngen
label define has_nonpln 0 "PLN only" 1 "Buys non-PLN power"
label values has_nonpln has_nonpln

* ---- generator hardware and fuel: NOT in block 0 -----------------------
* The raw SI asks generator capacity (kW) and number of generators every year
* (the raw survey files carry generator capacity, mgekwu, and the count) and
* the fuel used for electricity generation
* (raw_esolie*, raw_esdlie*, raw_eclkge*, raw_elpkge*, raw_engkge*). Block 0
* does not carry them. When it does, they are picked up here under these names.
local genvars ""
foreach v in genset_kw genset_n gen_diesel_ltr gen_petrol_ltr gen_coal_kg gen_lpg_kg gen_natgas_m3 {
    capture confirm variable `v'
    if _rc display as text "  not in block 0 (lines 4 and 7 cannot be answered): `v'"
    else local genvars "`genvars' `v'"
}

* ---- energy & emissions -----------------------------------------------
* COAL 2017 CORRECTION: block 0 multiplies by 1000 (treats it as tonnes),
* but the price per unit shows the data are already in kg. Divide back.
generate co2_coal = co2_coal_s1
generate gj_coal2 = gj_coal
replace  co2_coal = co2_coal_s1 / 1000 if year == 2017
replace  gj_coal2 = gj_coal / 1000     if year == 2017

* scope 1 = the 4 fuels asked in every year: diesel, petrol, coal, LPG
* (fuel burnt in a generator is inside these quantities and cannot be split out)
egen co2_s1 = rowtotal(co2_diesel_s1 co2_petrol_s1 co2_coal co2_lpg_s1), missing
egen gj_s1  = rowtotal(gj_diesel gj_petrol gj_coal2 gj_lpg), missing
* scope 2 = purchased electricity (own generation has no scope 2)
generate co2_s2 = co2_scope2_s1
generate gj_s2  = gj_electricity
egen co2_total = rowtotal(co2_s1 co2_s2), missing
egen gj_total  = rowtotal(gj_s1 gj_s2), missing

generate co2_s1_pw = co2_s1 / workers if workers > 0
generate co2_s1_va = co2_s1 / va      if va > 0

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
foreach v in own_kwh purch_kwh elec_all_kwh output va workers co2_s1 co2_s1_pw co2_s1_va co2_total {
    generate ln_`v' = ln(`v') if `v' > 0
}

* ---- save -------------------------------------------------------------
keep  firm_id year source_row kbli2 kbli5 prov java large importer exporter fdi ///
      va output capital workers own_kwh purch_kwh elec_all_kwh has_owngen ///
      owngen_share has_nonpln co2_s1 co2_s2 co2_total gj_s1 gj_s2 gj_total ///
      co2_s1_pw co2_s1_va clean ln_* elec_pln_kwh elec_nonpln_kwh `genvars'
order firm_id year source_row kbli2 kbli5 prov java large importer exporter fdi ///
      has_owngen own_kwh purch_kwh elec_all_kwh owngen_share has_nonpln
label variable has_owngen   "1 = own-generated electricity > 0; missing = not asked"
label variable own_kwh      "Own-generated electricity (kWh), masked"
label variable purch_kwh    "Purchased electricity PLN + non-PLN (kWh), masked"
label variable elec_all_kwh "Own + purchased electricity (kWh)"
label variable owngen_share "Own / (own + purchased) electricity, 0-1"
label variable has_nonpln   "1 = buys electricity from a non-PLN supplier"
label variable co2_s1       "Scope 1 CO2 (t), diesel + petrol + coal + LPG"
label variable co2_s1_pw    "Scope 1 CO2 per worker (t)"
label variable clean        "1 = not an energy outlier"
compress
save "$B206_DATA/b206_si.dta", replace
display as result "01a done: $B206_DATA/b206_si.dta (" _N " rows)"
