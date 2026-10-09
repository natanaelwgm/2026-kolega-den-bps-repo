/*==========================================================================
  Line 1: "How concentrated are industrial emissions?"
  Prepare Statistik Industri (SI) 2010-2022 for B2-03
  (copied from block-b1-18-bahan-baku/01a_prep_si.do, kept what this row
   needs, added the B2-03 variables as plain generate lines)
  Input : $SI_DATA  (analysis_ready_data.dta from block 0)
  Output: data/b203_si.dta  -- 1 row = 1 plant x year
          (open with: use "$B203_DATA/b203_si.dta", clear  then browse)

  Main variables:
    co2_s1 co2_s2 co2_total   CO2 (tonnes): scope 1 (4 fuels) + scope 2
    gj_s1 gj_s2 gj_total      energy (GJ), same scope
    co2_per_va gj_per_va      carbon / energy intensity per value added
    co2_per_out gj_per_out    carbon / energy intensity per output
    co2_pw gj_pw              CO2 / GJ per worker
    va output workers         nominal value added, gross output, workers
    exporter                  1 = exports (2022 set missing)
    export_val                estimated export value = export share x output
                              (only where the export share is valid)
    kbli2 kbli5 prov
    clean                     1 = not an extreme energy outlier
==========================================================================*/
if "$B203" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$SI_DATA", clear

* ---- identifiers ------------------------------------------------------
* year = survey year (there is no 2016 file)
generate kbli2 = real(substr(industry_code, 1, 2))
generate kbli5 = industry_code
generate prov  = real(province_code)

* ---- exports ----------------------------------------------------------
generate exporter = export_flag
* 2022: the form only asks about DIRECT exports, a "no" is never recorded -> missing
replace exporter = . if year == 2022
label define exporter 0 "Non-exporter" 1 "Exporter"
label values exporter exporter

generate export_share = export_share_pct if export_share_valid == 1

* ---- firm size (nominal) ----------------------------------------------
generate va      = value_added_nominal
generate output  = gross_output_nominal
* block 0 has no export VALUE column: estimate it from the reported export
* share (valid on only ~6% of records, none in 2015, 2017 and 2022)
generate export_val = export_share / 100 * output if !missing(export_share) & output >= 0

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

* intensities
generate co2_per_va  = co2_total / va      if va > 0
generate gj_per_va   = gj_total / va       if va > 0
generate co2_per_out = co2_total / output  if output > 0
generate gj_per_out  = gj_total / output   if output > 0
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
foreach v in va output workers co2_total gj_total co2_per_va gj_per_va {
    generate ln_`v' = ln(`v') if `v' > 0
}

* ---- save -------------------------------------------------------------
keep  firm_id year source_row kbli2 kbli5 prov exporter export_share export_val ///
      va output workers co2_s1 co2_s2 co2_total gj_s1 gj_s2 gj_total ///
      co2_per_va gj_per_va co2_per_out gj_per_out co2_pw gj_pw clean ln_*
order firm_id year source_row kbli2 kbli5 prov exporter clean co2_total gj_total
label variable co2_total  "CO2 (t), scope 1 (diesel, petrol, coal, LPG) + scope 2"
label variable gj_total   "Energy (GJ), same scope as co2_total"
label variable co2_per_va "Carbon intensity: CO2 (t) per value added (nominal)"
label variable gj_per_va  "Energy intensity: GJ per value added (nominal)"
label variable co2_per_out "CO2 (t) per gross output (nominal)"
label variable gj_per_out "GJ per gross output (nominal)"
label variable export_val "Estimated export value = export share x output (valid share only)"
label variable clean "1 = not an energy outlier"
compress
save "$B203_DATA/b203_si.dta", replace
display as result "01a done: $B203_DATA/b203_si.dta (" _N " rows)"
