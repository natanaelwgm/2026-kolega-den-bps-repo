/*==========================================================================
  Line 1 (part a): "What happened during covid:"
  Prepare Statistik Industri (SI) 2010-2022 for B1-20
  Input : $SI_DATA  (analysis_ready_data.dta from block 0)
  Output: data/b20_si.dta  -- 1 row = 1 firm x year
          (open with: use "$B20_DATA/b20_si.dta", clear  then browse)

  Main variables created:
    period         COVID period: 1 Pre 2017-19, 2 Covid 2020, 3 Recovery 2021-22
    prev_year      the survey year before this one  (2017 -> 2015: no 2016 wave)
    next_year      the survey year after this one   (2015 -> 2017)
    importer, exporter, fdi, large, kbli2, kbli5, prov, java
    va, output, capital, workers, *_pw (per worker), ln_*
    tfp_op tfp_lp tfp_acf tfp_wrdg
    co2_s1 co2_s2 co2_total gj_s1 gj_s2 gj_total, co2_per_va, gj_per_va
    has_owngen     1 = generates some of its own electricity (self generation)
    owngen_share   own-generated kWh / (own + purchased kWh)
    clean          1 = not an extreme energy outlier

  NOTE: there is no 2016 wave. "Previous / next year" always means the
        previous / next SURVEY year, so 2015 and 2017 count as consecutive.
==========================================================================*/
if "$B20" == "" {
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

* ---- COVID period -------------------------------------------------------
generate period = 1 if inrange(year, 2017, 2019)
replace  period = 2 if year == 2020
replace  period = 3 if inrange(year, 2021, 2022)
label define period 1 "Pre 2017-19" 2 "Covid 2020" 3 "Recovery 2021-22"
label values period period

* ---- previous / next survey year (2016 is missing) --------------------
generate prev_year = year - 1 if year > 2010
replace  prev_year = 2015 if year == 2017
generate next_year = year + 1 if year < 2022
replace  next_year = 2017 if year == 2015

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
generate va_pw   = va / workers      if workers > 0
generate out_pw  = output / workers  if workers > 0
generate cap_pw  = capital / workers if workers > 0

generate tfp_op   = dev_nominal_tfp_op
generate tfp_lp   = dev_nominal_tfp_lp
generate tfp_acf  = dev_nominal_tfp_acf
generate tfp_wrdg = dev_nominal_tfp_wrdg

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

generate co2_per_va  = co2_total / va      if va > 0
generate gj_per_va   = gj_total / va       if va > 0
generate gj_per_out  = gj_total / output   if output > 0
generate co2_pw      = co2_total / workers if workers > 0

* ---- self generation --------------------------------------------------
generate has_owngen = (elec_owngen_kwh > 0) if !missing(elec_owngen_kwh)
generate owngen_share = elec_owngen_kwh / (elec_owngen_kwh + elec_purchased_kwh) ///
    if (elec_owngen_kwh + elec_purchased_kwh) > 0
label define has_owngen 0 "No own generation" 1 "Own generation"
label values has_owngen has_owngen

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
foreach v in va output capital workers va_pw out_pw cap_pw ///
             co2_total gj_total co2_per_va gj_per_va {
    generate ln_`v' = ln(`v') if `v' > 0
}

* ---- save -------------------------------------------------------------
keep  firm_id year source_row period prev_year next_year kbli2 kbli5 prov java large ///
      importer exporter fdi va output capital workers va_pw out_pw cap_pw tfp_* ///
      co2_s1 co2_s2 co2_total gj_s1 gj_s2 gj_total co2_per_va gj_per_va gj_per_out ///
      co2_pw has_owngen owngen_share clean ln_*
order firm_id year source_row period prev_year next_year kbli2 kbli5 prov java large ///
      importer exporter fdi
label variable period       "COVID period"
label variable prev_year    "Previous survey year (2017 -> 2015, no 2016 wave)"
label variable next_year    "Next survey year (2015 -> 2017, no 2016 wave)"
label variable has_owngen   "1 = some own-generated electricity"
label variable owngen_share "Own-generated / (own + purchased) electricity, kWh"
label variable clean        "1 = not an energy outlier"
compress
save "$B20_DATA/b20_si.dta", replace
display as result "01a done: $B20_DATA/b20_si.dta (" _N " rows)"
