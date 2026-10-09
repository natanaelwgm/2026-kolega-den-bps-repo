/*==========================================================================
  Line 1: "R&D, innovation and environmental capability"
  Prepare Statistik Industri (SI) 2010-2022 for B2-08
  Input : $SI_DATA  (analysis_ready_data.dta from block 0)
  Output: data/b208_si.dta  -- 1 row = 1 firm x year
          (open with: use "$B208_DATA/b208_si.dta", clear  then browse)

  Capability variables (1 = yes, 0 = no, MISSING = not asked or left blank):
    rnd            R&D activity                   2011, 2017-2022
    rnd_ext        external funding for R&D       2017-2022
    rnd_cost       R&D expense (nominal, masked)  2017-2022 (0 = none or blank)
    rnd_workers    R&D workers                    2017-2022 (part of 2018-2021)
    rnd_cost_pos   1 = a positive R&D expense is reported
    rnd_va         R&D expense / value added      2017-2022, VA > 0
    innov          any innovation                 2011, 2017-2018, 2020-2022
    innov_product innov_process innov_marketing innov_org   2017-2018 only
    amdal ukl_upl sppl   environmental documents  2020-2022
    env_doc        1 = holds at least one of AMDAL / UKL-UPL / SPPL
    waste_treat    waste installation / treatment 2020-2022
    waste_solid waste_liquid waste_haz            2022 only
    waste_any      1 = reports at least one of the three waste types
  A blank answer is NOT a "no". It stays missing, so every % below is
  "% yes among firms that answered". File 02 shows how many answered.

  Other variables: exporter, importer, fdi, large, kbli2, kbli5, prov, java,
    va, output, workers, co2_s1 co2_s2 co2_total gj_s1 gj_s2 gj_total,
    co2_per_va, gj_per_va, va_per_co2 (carbon productivity),
    va_per_gj (energy productivity), q_cprod q_eprod (within-year quintiles),
    clean (1 = not an extreme energy outlier), ln_*
==========================================================================*/
if "$B208" == "" {
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

* ---- imports, exports & FDI ---------------------------------------------
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
generate va_pw   = va / workers      if workers > 0

* ---- capability flags (block 0 codes them 1 = yes, 0 = no) -------------
generate rnd          = rd_activity_flag          if inlist(rd_activity_flag, 0, 1)
generate rnd_ext      = rd_external_funding_flag  if inlist(rd_external_funding_flag, 0, 1)
generate innov        = innovation_flag           if inlist(innovation_flag, 0, 1)
generate innov_product   = innovation_product_flag        if inlist(innovation_product_flag, 0, 1)
generate innov_process   = innovation_process_flag        if inlist(innovation_process_flag, 0, 1)
generate innov_marketing = innovation_marketing_flag      if inlist(innovation_marketing_flag, 0, 1)
generate innov_org       = innovation_org_flag            if inlist(innovation_org_flag, 0, 1)
generate amdal        = env_amdal_flag            if inlist(env_amdal_flag, 0, 1)
generate ukl_upl      = env_ukl_upl_flag          if inlist(env_ukl_upl_flag, 0, 1)
generate sppl         = env_sppl_flag             if inlist(env_sppl_flag, 0, 1)
generate waste_treat  = env_waste_treatment_flag  if inlist(env_waste_treatment_flag, 0, 1)
generate waste_solid  = waste_solid_flag          if inlist(waste_solid_flag, 0, 1)
generate waste_liquid = waste_liquid_flag         if inlist(waste_liquid_flag, 0, 1)
generate waste_haz    = waste_hazardous_flag      if inlist(waste_hazardous_flag, 0, 1)

* "holds any environmental document": 1 if any of the three is yes,
* 0 if at least one was answered and none is yes, missing if all three blank
egen env_doc = rowmax(amdal ukl_upl sppl)
egen waste_any = rowmax(waste_solid waste_liquid waste_haz)

* ---- R&D expense ------------------------------------------------------
* block 0 records the amount 2017-2022 and writes 0 when nothing is reported,
* so a 0 can be "no R&D" or "left blank". Only a positive amount is informative.
generate rnd_cost     = rd_cost_nominal
generate rnd_workers  = rd_workers
generate rnd_cost_pos = (rnd_cost > 0) if !missing(rnd_cost)
generate rnd_va       = rnd_cost / va if va > 0 & !missing(rnd_cost)

label define yesno 0 "No" 1 "Yes"
foreach v in rnd rnd_ext innov innov_product innov_process innov_marketing innov_org ///
             amdal ukl_upl sppl env_doc waste_treat waste_solid waste_liquid waste_haz ///
             waste_any rnd_cost_pos {
    label values `v' yesno
}

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
* carbon and energy productivity (va_per_co2, va_per_gj)
generate va_per_co2  = va / co2_total      if co2_total > 0
generate va_per_gj   = va / gj_total       if gj_total > 0

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

* ---- carbon / energy productivity quintiles, within each year ------------
* within-year because values are nominal and the sample changes by year;
* computed on clean records only. 1 = lowest VA per tCO2 (or per GJ).
generate q_cprod = .
generate q_eprod = .
foreach y of local years {
    xtile tmp_c = va_per_co2 if year == `y' & clean == 1, nquantiles(5)
    xtile tmp_e = va_per_gj  if year == `y' & clean == 1, nquantiles(5)
    replace q_cprod = tmp_c if year == `y'
    replace q_eprod = tmp_e if year == `y'
    drop tmp_c tmp_e
}
label define quint 1 "Q1 lowest" 2 "Q2" 3 "Q3" 4 "Q4" 5 "Q5 highest"
label values q_cprod quint
label values q_eprod quint

* ---- ln versions ------------------------------------------------------
foreach v in va output workers va_pw co2_total gj_total co2_per_va gj_per_va ///
             va_per_co2 va_per_gj rnd_cost rnd_va {
    generate ln_`v' = ln(`v') if `v' > 0
}

* ---- save -------------------------------------------------------------
keep  firm_id year source_row kbli2 kbli5 prov java large importer exporter fdi ///
      va output workers va_pw rnd rnd_ext innov innov_* amdal ukl_upl sppl env_doc ///
      waste_treat waste_solid waste_liquid waste_haz waste_any rnd_cost rnd_workers ///
      rnd_cost_pos rnd_va co2_s1 co2_s2 co2_total gj_s1 gj_s2 gj_total ///
      co2_per_va gj_per_va va_per_co2 va_per_gj q_cprod q_eprod clean ln_*
order firm_id year source_row kbli2 kbli5 prov java large importer exporter fdi
label variable rnd          "R&D activity (2011, 2017-2022)"
label variable rnd_ext      "External funding for R&D (2017-2022)"
label variable innov        "Any innovation (2011, 2017-2018, 2020-2022)"
label variable innov_product   "Product innovation (2017-2018)"
label variable innov_process   "Process innovation (2017-2018)"
label variable innov_marketing "Marketing innovation (2017-2018)"
label variable innov_org       "Organisational innovation (2017-2018)"
label variable amdal        "AMDAL document (2020-2022)"
label variable ukl_upl      "UKL/UPL document (2020-2022)"
label variable sppl         "SPPL document (2020-2022)"
label variable env_doc      "Holds AMDAL, UKL/UPL or SPPL (2020-2022)"
label variable waste_treat  "Waste installation / treatment (2020-2022)"
label variable waste_solid  "Solid waste reported (2022)"
label variable waste_liquid "Liquid waste reported (2022)"
label variable waste_haz    "Hazardous (B3) waste reported (2022)"
label variable waste_any    "Reports solid, liquid or hazardous waste (2022)"
label variable rnd_cost     "R&D expense, nominal, masked (2017-2022)"
label variable rnd_cost_pos "1 = positive R&D expense reported"
label variable rnd_workers  "R&D workers (persons, masked)"
label variable rnd_va       "R&D expense / value added"
label variable va_per_co2   "Carbon productivity: VA / tCO2"
label variable va_per_gj    "Energy productivity: VA / GJ"
label variable q_cprod      "Quintile of VA/tCO2 within year (clean only)"
label variable q_eprod      "Quintile of VA/GJ within year (clean only)"
label variable clean        "1 = not an energy outlier"
compress
save "$B208_DATA/b208_si.dta", replace
display as result "01a done: $B208_DATA/b208_si.dta (" _N " rows)"
