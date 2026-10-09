/*==========================================================================
  Line 1 (part a)  Prepare Statistik Industri (SI) 2010-2022 for B1-18
  Input : $SI_DATA  (analysis_ready_data.dta from block 0)
  Output: data/b18_si.dta  -- 1 row = 1 firm x year
          (open with: use "$B18_DATA/b18_si.dta", clear  then browse)

  Main variables created:
    importer       1 = imports raw materials, 0 = does not
    imp_share_mat  imports / raw materials (val_rtlvcu)        -- importers only
    imp_share_int  imports / total intermediate inputs         -- importers only
    exporter, fdi, large, kbli2, kbli5, prov, java
    va, output, capital, workers, *_pw (per worker), ln_*
    tfp_op tfp_lp tfp_acf tfp_wrdg
    co2_s1 co2_s2 co2_total gj_s1 gj_s2 gj_total, co2_per_va, gj_per_va
    clean          1 = not an extreme energy outlier
==========================================================================*/
if "$B18" == "" {
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

* ---- imports ----------------------------------------------------------
* importer is only defined where the import question can be evaluated
generate importer = import_flag if import_observed == 1
label define importer 0 "Non-importer" 1 "Importer"
label values importer importer

generate imports   = import_value_nominal
generate materials = val_rtlvcu                     // raw materials value (RTLVCU)
generate inputs    = intermediate_inputs_nominal    // total intermediate inputs

* shares among importers only (with non-importers included the median is 0)
generate imp_share_mat = imports / materials if importer == 1 & imports > 0 & materials > 0
generate imp_share_int = imports / inputs    if importer == 1 & imports > 0 & inputs > 0

* ---- exports & FDI ----------------------------------------------------
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

generate export_share = export_share_pct if export_share_valid == 1

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
generate co2_per_out = co2_total / output  if output > 0
generate co2_pw      = co2_total / workers if workers > 0
generate gj_pw       = gj_total / workers  if workers > 0

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
foreach v in imports materials va output capital workers va_pw out_pw cap_pw ///
             co2_s1 co2_s2 co2_total gj_s1 gj_s2 gj_total co2_per_va gj_per_va {
    generate ln_`v' = ln(`v') if `v' > 0
}

* ---- save -------------------------------------------------------------
keep  firm_id year source_row kbli2 kbli5 prov java large importer imports materials inputs ///
      imp_share_mat imp_share_int exporter export_share fdi va output capital ///
      workers va_pw out_pw cap_pw tfp_* co2_s1 co2_s2 co2_total gj_s1 gj_s2 ///
      gj_total co2_per_va gj_per_va co2_per_out co2_pw gj_pw clean ln_*
order firm_id year source_row kbli2 kbli5 prov java large importer exporter fdi
label variable imp_share_mat "Imports / raw materials (RTLVCU), importers only"
label variable imp_share_int "Imports / total intermediate inputs, importers only"
label variable clean "1 = not an energy outlier"
compress
save "$B18_DATA/b18_si.dta", replace
display as result "01a done: $B18_DATA/b18_si.dta (" _N " rows)"
