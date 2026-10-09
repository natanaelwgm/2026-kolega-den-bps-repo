/*==========================================================================
  Line 1 (part a)  Prepare Statistik Industri (SI) 2010-2022 for B1-21
  Input : $SI_DATA  (analysis_ready_data.dta from block 0)
  Output: data/b21_si.dta  -- 1 row = 1 firm x year
          (open with: use "$B21_DATA/b21_si.dta", clear  then browse)

  Copied from b1-18's 01a (same corrections). B1-21
  uses the SI panel for:
    importer, fdi   firm status, merged onto the Proman roster cell in 01b
                    (year x province x KBLI5) for the line 8 comparison
    exporter        kept for reference (the roster has its own export data)
    prod_innov      block 0's product-innovation question (2017-2018 only),
                    the one product question in SI; used in line 8
    clean           1 = not an extreme energy outlier
==========================================================================*/
if "$B21" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$SI_DATA", clear

* ---- identifiers ------------------------------------------------------
* year = survey year (there is no 2016 file)
generate kbli2 = real(substr(industry_code, 1, 2))
generate kbli5 = industry_code
generate prov  = real(province_code)
generate prov_s = province_code
generate java  = inlist(prov, 31, 32, 33, 34, 35, 36) if !missing(prov)
label define java 0 "Outside Java" 1 "Java"
label values java java

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

generate export_share = export_share_pct if export_share_valid == 1

* ---- product innovation (asked in 2017 and 2018 only) -----------------
generate prod_innov = innovation_product_flag if inlist(innovation_product_flag, 0, 1)
label define prod_innov 0 "No product innovation" 1 "Product innovation"
label values prod_innov prod_innov

* ---- firm characteristics (nominal) -----------------------------------
generate va      = value_added_nominal
generate output  = gross_output_nominal

* ---- energy (only needed for the outlier flag) ------------------------
* COAL 2017 CORRECTION: block 0 multiplies by 1000 (treats it as tonnes),
* but the price per unit shows the data are already in kg. Divide back.
generate co2_coal = co2_coal_s1
replace  co2_coal = co2_coal_s1 / 1000 if year == 2017
* scope 1 = the 4 fuels asked in every year: diesel, petrol, coal, LPG
egen co2_s1 = rowtotal(co2_diesel_s1 co2_petrol_s1 co2_coal co2_lpg_s1), missing

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

* ---- save -------------------------------------------------------------
keep  firm_id year source_row kbli2 kbli5 prov prov_s java importer exporter fdi ///
      export_share prod_innov va output workers clean
order firm_id year source_row kbli2 kbli5 prov prov_s java importer exporter fdi
label variable prod_innov "1 = introduced a new or improved product (2017-2018 only)"
label variable clean "1 = not an energy outlier"
compress
save "$B21_DATA/b21_si.dta", replace
display as result "01a done: $B21_DATA/b21_si.dta (" _N " rows)"
