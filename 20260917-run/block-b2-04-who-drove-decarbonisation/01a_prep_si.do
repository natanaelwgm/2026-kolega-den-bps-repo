/*==========================================================================
  Line 1: "Who drove aggregate manufacturing decarbonisation? Pakai FHK
           decomposition (2001) dan Melitz-Polanec (2015)"
  Prepare Statistik Industri (SI) 2010-2022 for B2-04
  (copied from block-b1-18-bahan-baku/01a_prep_si.do, only the variables
  this row needs are kept)

  Input : $SI_DATA  (analysis_ready_data.dta from block 0)
  Output: data/b204_si.dta  -- 1 row = 1 firm x year
          (open with: use "$B204_DATA/b204_si.dta", clear  then browse)

  Main variables created:
    firm_id        firm link across years (FICTIONAL in the development data)
    exporter, fdi, importer, kbli2, kbli5
    va, workers
    co2_s1 co2_s2 co2_total gj_s1 gj_s2 gj_total
    co2_per_va     carbon intensity  (CO2 tonnes / nominal VA)
    gj_per_va      energy intensity  (GJ / nominal VA)
    clean          1 = not an extreme energy outlier
  The energy and emission variables are stored as double, because the
  decompositions add up many small firm terms.
==========================================================================*/
if "$B204" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$SI_DATA", clear

* ---- identifiers ------------------------------------------------------
* year = survey year (there is no 2016 file)
* firm_id x year is unique. The firm links are FICTIONAL in the development
* data, so anything about the same firm over time only means something on
* the real BPS data.
generate kbli2 = real(substr(industry_code, 1, 2))
generate kbli5 = industry_code

* ---- imports ----------------------------------------------------------
* importer is only defined where the import question can be evaluated
generate importer = import_flag if import_observed == 1
label define importer 0 "Non-importer" 1 "Importer"
label values importer importer

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

* ---- size (nominal) ---------------------------------------------------
generate double va = value_added_nominal         // double: VA is large, float loses digits

* ---- energy & emissions -----------------------------------------------
* COAL 2017 CORRECTION: block 0 multiplies by 1000 (treats it as tonnes),
* but the price per unit shows the data are already in kg. Divide back.
generate double co2_coal = co2_coal_s1
generate double gj_coal2 = gj_coal
replace  co2_coal = co2_coal_s1 / 1000 if year == 2017
replace  gj_coal2 = gj_coal / 1000     if year == 2017

* scope 1 = the 4 fuels asked in every year: diesel, petrol, coal, LPG
egen double co2_s1 = rowtotal(co2_diesel_s1 co2_petrol_s1 co2_coal co2_lpg_s1), missing
egen double gj_s1  = rowtotal(gj_diesel gj_petrol gj_coal2 gj_lpg), missing
* scope 2 = purchased electricity
generate double co2_s2 = co2_scope2_s1
generate double gj_s2  = gj_electricity
egen double co2_total = rowtotal(co2_s1 co2_s2), missing
egen double gj_total  = rowtotal(gj_s1 gj_s2), missing

* the two intensities this row decomposes (firm level)
generate double co2_per_va = co2_total / va  if va > 0
generate double gj_per_va  = gj_total / va   if va > 0

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
foreach v in va co2_total gj_total co2_per_va gj_per_va {
    generate ln_`v' = ln(`v') if `v' > 0
}

* ---- save -------------------------------------------------------------
keep  firm_id year source_row kbli2 kbli5 importer exporter fdi va workers ///
      co2_s1 co2_s2 co2_total gj_s1 gj_s2 gj_total co2_per_va gj_per_va clean ln_*
order firm_id year source_row kbli2 kbli5 importer exporter fdi
label variable firm_id    "Firm id (links across years are FICTIONAL in the dev data)"
label variable co2_total  "CO2 scope 1 (4 fuels) + scope 2, tonnes"
label variable gj_total   "Energy scope 1 (4 fuels) + purchased electricity, GJ"
label variable co2_per_va "Carbon intensity: CO2 / nominal VA"
label variable gj_per_va  "Energy intensity: GJ / nominal VA"
label variable clean      "1 = not an energy outlier"
compress
save "$B204_DATA/b204_si.dta", replace
display as result "01a done: $B204_DATA/b204_si.dta (" _N " rows)"
