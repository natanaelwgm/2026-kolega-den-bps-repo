/*==========================================================================
  Prep  Prepare Statistik Industri (SI) 2010-2022 for B1-13
  Input : $SI_DATA  (analysis_ready_data.dta from block 0)
  Output: data/b13_si.dta  -- 1 row = 1 firm x year
          (open with: use "$B13_DATA/b13_si.dta", clear  then browse)

  Copied from b1-17's 01a_prep_si.do (same corrections: 2017 coal / 1000,
  2020 FDI and 2022 exporter set missing, clean outlier flag, scope 1 = the
  4 fuels asked every year), plus what rows 7-16 need (same file in blocks b1-07 to b1-16).
  Main variables created:
    kbli2 kbli5 prov java large size_class            sector, location, size
    exporter importer fdi fdi_any trade_profile rnd   firm groups
    main_src                                          main energy source (largest GJ)
    va output capital inputs materials import_val     nominal money (masked)
    workers prod_workers nonprod_workers              employment
    va_pw out_pw cap_pw                               per worker
    va_share_out prod_share import_share_mat export_share foreign_share   ratios / %
    tfp_op tfp_lp tfp_acf tfp_wrdg                    block 0 nominal development TFP
    co2_s1 co2_s2 co2_total gj_s1 gj_s2 gj_total      emissions (t) and energy (GJ)
    co2_pw gj_pw co2_per_va gj_per_va co2_per_gj      intensities
    elec_purch_kwh elec_owngen_kwh elec_total_kwh selfgen_share   electricity
    ln_*                                              ln of every level variable (missing when <= 0)
    clean                                             1 = not an extreme energy outlier
==========================================================================*/
if "$B13" == "" {
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
label define prov 11 "Aceh" 12 "North Sumatra" 13 "West Sumatra" 14 "Riau" 15 "Jambi" ///
    16 "South Sumatra" 17 "Bengkulu" 18 "Lampung" 19 "Bangka Belitung" 21 "Riau Islands" ///
    31 "DKI Jakarta" 32 "West Java" 33 "Central Java" 34 "DI Yogyakarta" 35 "East Java" ///
    36 "Banten" 51 "Bali" 52 "West Nusa Tenggara" 53 "East Nusa Tenggara" ///
    61 "West Kalimantan" 62 "Central Kalimantan" 63 "South Kalimantan" 64 "East Kalimantan" ///
    65 "North Kalimantan" 71 "North Sulawesi" 72 "Central Sulawesi" 73 "South Sulawesi" ///
    74 "Southeast Sulawesi" 75 "Gorontalo" 76 "West Sulawesi" 81 "Maluku" 82 "North Maluku" ///
    91 "West Papua" 94 "Papua"
label values prov prov

* ---- firm size --------------------------------------------------------
* medium vs large (100-worker threshold, Analysis.docx row 13; same as b1-17)
generate large = (workers > 100) if !missing(workers)
label define large 0 "Medium (<=100)" 1 "Large (>100)"
label values large large
* size classes by number of workers
generate size_class = 1 if workers < 20
replace  size_class = 2 if workers >= 20  & workers < 50
replace  size_class = 3 if workers >= 50  & workers < 100
replace  size_class = 4 if workers >= 100 & workers < 500
replace  size_class = 5 if workers >= 500 & !missing(workers)
label define size_class 1 "<20 workers" 2 "20-49" 3 "50-99" 4 "100-499" 5 "500+"
label values size_class size_class

* ---- imports, exports, FDI, R&D ---------------------------------------
* importer is only defined where the import question can be evaluated
generate importer = import_flag if import_observed == 1
label define importer 0 "Non-importer" 1 "Importer"
label values importer importer

generate exporter = export_flag
generate fdi      = fdi_10_flag                     // foreign ownership >= 10%
generate fdi_any  = fdi_any_flag                    // foreign ownership > 0%
* 2022: the form only asks about DIRECT exports, a "no" is never recorded -> missing
replace exporter = . if year == 2022
* 2020: foreign ownership is inconsistent (47% FDI vs 8-11% other years) -> missing
replace fdi     = . if year == 2020
replace fdi_any = . if year == 2020
label define exporter 0 "Non-exporter" 1 "Exporter"
label values exporter exporter
label define fdi 0 "Domestic" 1 "FDI (>=10%)"
label values fdi fdi
label define fdi_any 0 "Domestic" 1 "Any foreign share (>0%)"
label values fdi_any fdi_any

* four-way trade profile (row 10); only where both answers are known
generate trade_profile = 1 if exporter == 0 & importer == 0
replace  trade_profile = 2 if exporter == 1 & importer == 0
replace  trade_profile = 3 if exporter == 0 & importer == 1
replace  trade_profile = 4 if exporter == 1 & importer == 1
label define trade_profile 1 "Non-trading" 2 "Export only" 3 "Import only" 4 "Export and import"
label values trade_profile trade_profile

* R&D activity (1 = yes). Asked in 2011 and 2017-2022; only 2017-2022 is used
* (same as b1-17 line 11: the 2011 question is not the same)
generate rnd = rd_activity_flag if inlist(rd_activity_flag, 0, 1) & year >= 2017
label define rnd 0 "No R&D" 1 "R&D"
label values rnd rnd

* ---- firm characteristics (nominal) -----------------------------------
generate va         = value_added_nominal
generate output     = gross_output_nominal
generate capital    = capital_stock_nominal
generate inputs     = intermediate_inputs_nominal
generate materials  = val_rtlvcu                   // reported materials value (RTLVCU)
generate import_val = import_value_nominal
generate va_pw   = va / workers      if workers > 0
generate out_pw  = output / workers  if workers > 0
generate cap_pw  = capital / workers if workers > 0

* employment mix
generate prod_workers    = production_workers
generate nonprod_workers = workers - production_workers if production_workers <= workers
generate prod_share      = 100 * production_workers / workers if workers > 0 & production_workers <= workers

* ratios (%)
generate va_share_out     = 100 * va / output          if output > 0
generate import_share_mat = 100 * import_val / materials if materials > 0
generate export_share     = export_share_pct if export_share_valid == 1   // drops 1 record above 100%
generate foreign_share    = foreign_ownership_pct
replace  foreign_share    = . if year == 2020         // same rule as fdi

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
generate co2_pw      = co2_total / workers if workers > 0
generate gj_pw       = gj_total / workers  if workers > 0
generate co2_per_gj  = co2_total / gj_total if gj_total > 0

* ---- electricity (kWh) ------------------------------------------------
* purchased = PLN + non-PLN (block 0); own generation is reported separately
* and is not scope 2 (its fuel is already in the fuel lines)
generate elec_purch_kwh  = elec_purchased_kwh       // elec_owngen_kwh is used as in block 0
egen elec_total_kwh = rowtotal(elec_purch_kwh elec_owngen_kwh), missing
generate selfgen_share = 100 * elec_owngen_kwh / elec_total_kwh if elec_total_kwh > 0 & !missing(elec_owngen_kwh)

* ---- main energy source (row 16), same rule as b1-17 line 2 -------------
* block 0 publishes GJ for the legacy fuels; coal uses the corrected gj_coal2.
* The fuels the 2020 form added have no GJ column in block 0: GJ per unit
* from the IPCC 2006 default net calorific values (Vol 2 Ch 1, Table 1.2),
* one plain line each.
generate gj_dieseloil = fuel_dieseloil_ltr * 0.03655 if fuel_dieseloil_ltr >= 0   // per litre
generate gj_fueloil   = fuel_fueloil_ltr   * 0.03838 if fuel_fueloil_ltr >= 0     // per litre
generate gj_natgas    = fuel_natgas_mmbtu  * 1.05506 if fuel_natgas_mmbtu >= 0    // per MMBTU
generate gj_biodiesel = fuel_biodiesel_ltr * 0.02376 if fuel_biodiesel_ltr >= 0   // per litre
* biomass is left out: its unit (kg in block 0, tonne on the 2020 form) is not settled
generate gj_elec = gj_s2                    // purchased electricity (own generation excluded)

* main source = the source with the largest GJ; ties go to the source listed
* first; firms with no energy use are "No energy reported"
generate main_src = 0
generate best_gj  = 0
local k 0
foreach v in gj_diesel gj_petrol gj_kerosene gj_coal2 gj_lpg gj_citygas gj_othergas ///
             gj_coalbriq gj_dieseloil gj_fueloil gj_natgas gj_biodiesel gj_elec {
    local ++k
    replace main_src = `k' if `v' > best_gj & !missing(`v')
    replace best_gj  = `v' if `v' > best_gj & !missing(`v')
}
drop best_gj
label define main_src 0 "No energy reported" 1 "Diesel" 2 "Petrol" 3 "Kerosene" 4 "Coal" ///
    5 "LPG" 6 "City gas" 7 "Other gas" 8 "Coal briquettes" 9 "Diesel oil (2020+)" ///
    10 "Fuel oil (2020+)" 11 "Natural gas (2020+)" 12 "Biodiesel (2020+)" ///
    13 "Electricity (purchased)"
label values main_src main_src

* ---- energy outlier flag (clean), same rule as b1-17 ------------------
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
foreach v in va output capital inputs materials import_val workers va_pw out_pw cap_pw ///
             co2_s1 co2_s2 co2_total gj_s1 gj_s2 gj_total elec_total_kwh {
    generate ln_`v' = ln(`v') if `v' > 0
}

* ---- save -------------------------------------------------------------
keep  firm_id year source_row kbli2 kbli5 prov java large size_class ///
      importer exporter fdi fdi_any trade_profile rnd main_src ///
      va output capital inputs materials import_val workers prod_workers nonprod_workers ///
      va_pw out_pw cap_pw va_share_out prod_share import_share_mat export_share foreign_share ///
      tfp_* co2_s1 co2_s2 co2_total gj_s1 gj_s2 gj_total ///
      co2_per_va gj_per_va co2_pw gj_pw co2_per_gj ///
      elec_purch_kwh elec_owngen_kwh elec_total_kwh selfgen_share ///
      gj_diesel gj_petrol gj_kerosene gj_coal2 gj_lpg gj_citygas gj_othergas gj_coalbriq ///
      gj_dieseloil gj_fueloil gj_natgas gj_biodiesel gj_elec ///
      fuel_diesel_ltr fuel_petrol_ltr fuel_kerosene_ltr coal_kg_fix fuel_lpg_kg ///
      fuel_citygas_m3 fuel_othergas_m3 fuel_coalbriq_kg fuel_coke_kg ///
      fuel_dieseloil_ltr fuel_fueloil_ltr fuel_natgas_mmbtu fuel_biodiesel_ltr ///
      clean ln_*
order firm_id year source_row kbli2 kbli5 prov java large size_class ///
      importer exporter fdi fdi_any trade_profile rnd main_src
label variable co2_s1          "Scope 1 CO2 (t): diesel, petrol, coal, LPG"
label variable co2_s2          "Scope 2 CO2 (t): purchased electricity"
label variable co2_total       "Scope 1 + scope 2 CO2 (t)"
label variable gj_s1           "Energy (GJ): diesel, petrol, coal, LPG"
label variable gj_s2           "Energy (GJ): purchased electricity"
label variable gj_total        "Energy (GJ): scope 1 fuels + purchased electricity"
label variable inputs          "Intermediate inputs (nominal, masked)"
label variable materials       "Materials value RTLVCU (nominal, masked)"
label variable import_val      "Imports (nominal, masked)"
label variable nonprod_workers "Non-production workers = workers - production workers"
label variable va_share_out    "Value added / output (%)"
label variable prod_share      "Production workers / workers (%)"
label variable import_share_mat "Imports / materials (%)"
label variable export_share    "Export share of output (%)"
label variable foreign_share   "Foreign ownership (%); 2020 set missing"
label variable elec_purch_kwh  "Purchased electricity, PLN + non-PLN (kWh)"
label variable elec_owngen_kwh "Own-generated electricity (kWh)"
label variable elec_total_kwh  "Purchased + own-generated electricity (kWh)"
label variable selfgen_share   "Own generation / (purchased + own) electricity (%)"
label variable coal_kg_fix     "Coal (kg), 2017 divided by 1000"
label variable trade_profile   "Trade profile: none / export only / import only / both"
label variable main_src        "Main energy source (largest GJ)"
label variable fdi_any         "Any foreign ownership (>0%); 2020 set missing"
label variable rnd             "R&D activity (2017-2022 only)"
label variable clean           "1 = not an energy outlier"
compress
save "$B13_DATA/b13_si.dta", replace
display as result "01a done: $B13_DATA/b13_si.dta (" _N " rows)"
