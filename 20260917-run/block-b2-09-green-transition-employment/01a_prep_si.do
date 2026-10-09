/*==========================================================================
  Line 1: "Green transition and employment"
  Prepare Statistik Industri (SI) 2010-2022 for B2-09
  Input : $SI_DATA  (analysis_ready_data.dta from block 0)
  Output: data/b209_si.dta  -- 1 row = 1 firm x year
          (open with: use "$B209_DATA/b209_si.dta", clear  then browse)

  Main variables created:
    co2_s1 co2_s2 co2_total gj_total, co2_per_va  (carbon intensity)
    workers, production_workers, nonprod_workers, nonprod_share
    va, capital, va_pw, cap_pw (per worker), ln_*
    exporter, fdi, large, kbli2, prov, java
    clean          1 = not an extreme energy outlier
  Male/female and wage columns are carried only if they exist (they are not
  in block 0; see files 07 and 08).
==========================================================================*/
if "$B209" == "" {
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

* ---- firm characteristics (nominal) -----------------------------------
generate va      = value_added_nominal
generate output  = gross_output_nominal
generate capital = capital_stock_nominal
generate va_pw   = va / workers      if workers > 0
generate out_pw  = output / workers  if workers > 0
generate cap_pw  = capital / workers if workers > 0

* ---- workers: production / non-production -----------------------------
* block 0 has total workers and production workers; non-production = the rest.
* 2020 and 2021: production workers are missing for ~40-47% of firms.
* 1 record reports more production workers than total workers -> split missing.
generate prod_workers    = production_workers if production_workers <= workers
generate nonprod_workers = workers - prod_workers
generate nonprod_share   = 100 * nonprod_workers / workers if workers > 0
label variable prod_workers    "Production workers (missing if > total workers)"
label variable nonprod_workers "Non-production workers = total - production"
label variable nonprod_share   "Non-production workers, % of all workers"

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

* carbon intensity = tonnes CO2 per (nominal) value added
generate co2_per_va  = co2_total / va      if va > 0
generate co2_pw      = co2_total / workers if workers > 0

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
foreach v in va output capital workers prod_workers nonprod_workers va_pw out_pw cap_pw ///
             co2_s1 co2_s2 co2_total gj_total co2_per_va {
    generate ln_`v' = ln(`v') if `v' > 0
}

* ---- male/female and wages: carried only if the data have them --------
local extra ""
foreach v in workers_male workers_female wage_total wage_prod wage_nonprod {
    capture confirm variable `v'
    if !_rc local extra "`extra' `v'"
}
display as result "Gender / wage columns found: `extra'"

* ---- save -------------------------------------------------------------
keep  firm_id year source_row kbli2 kbli5 prov java large exporter fdi va output capital ///
      workers prod_workers nonprod_workers nonprod_share va_pw out_pw cap_pw ///
      co2_s1 co2_s2 co2_total gj_total co2_per_va co2_pw clean ln_* `extra'
order firm_id year source_row kbli2 kbli5 prov java large exporter fdi
label variable co2_per_va "CO2 (t) per nominal value added"
label variable clean "1 = not an energy outlier"
compress
save "$B209_DATA/b209_si.dta", replace
display as result "01a done: $B209_DATA/b209_si.dta (" _N " rows)"
