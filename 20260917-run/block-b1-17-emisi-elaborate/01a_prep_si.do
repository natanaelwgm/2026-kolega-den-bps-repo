/*==========================================================================
  Line 1 (part a)  Prepare Statistik Industri (SI) 2010-2022 for B1-17
  Input : $SI_DATA  (analysis_ready_data.dta from block 0)
  Output: data/b17_si.dta  -- 1 row = 1 firm x year
          (open with: use "$B17_DATA/b17_si.dta", clear  then browse)

  Copied from b1-18's 01a_prep_si.do (same corrections), plus what B1-17 needs.
  Main variables created:
    co2_s1 co2_s2 co2_total   CO2 (tonnes): scope 1, scope 2, total
    gj_s1 gj_s2 gj_total      energy (GJ) of the same scope 1 fuels / electricity
    co2_per_va co2_pw co2_per_out co2_per_gj   intensities
    gj_<fuel>                 energy (GJ) per source, for "main energy source"
    importer exporter fdi rnd large size_class kbli2 kbli5 prov java
    va output capital workers va_pw out_pw cap_pw, tfp_op tfp_lp tfp_acf tfp_wrdg
    ln_*                      ln of every level variable (missing when <= 0)
    clean                     1 = not an extreme energy outlier
==========================================================================*/
if "$B17" == "" {
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
* medium vs large (100-worker threshold, same as b1-18)
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
* 2022: the form only asks about DIRECT exports, a "no" is never recorded -> missing
replace exporter = . if year == 2022
* 2020: foreign ownership is inconsistent (47% FDI vs 8-11% other years) -> missing
replace fdi = . if year == 2020
label define exporter 0 "Non-exporter" 1 "Exporter"
label values exporter exporter
label define fdi 0 "Domestic" 1 "FDI"
label values fdi fdi

* R&D activity (1 = yes). Asked in 2011 and 2017-2022 only; missing otherwise
generate rnd = rd_activity_flag if inlist(rd_activity_flag, 0, 1)
label define rnd 0 "No R&D" 1 "R&D"
label values rnd rnd

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
generate co2_per_gj  = co2_total / gj_total if gj_total > 0

* ---- energy (GJ) per source, for line 2 "main energy source" ----------
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
             co2_s1 co2_s2 co2_total gj_s1 gj_s2 gj_total co2_per_va gj_per_va co2_pw co2_per_gj {
    generate ln_`v' = ln(`v') if `v' > 0
}

* ---- save -------------------------------------------------------------
keep  firm_id year source_row kbli2 kbli5 prov java large size_class importer exporter fdi rnd ///
      va output capital workers va_pw out_pw cap_pw tfp_* ///
      co2_s1 co2_s2 co2_total gj_s1 gj_s2 gj_total co2_per_va gj_per_va co2_per_out co2_pw gj_pw co2_per_gj ///
      gj_diesel gj_petrol gj_kerosene gj_coal2 gj_lpg gj_citygas gj_othergas gj_coalbriq ///
      gj_dieseloil gj_fueloil gj_natgas gj_biodiesel gj_elec clean ln_*
order firm_id year source_row kbli2 kbli5 prov java large size_class importer exporter fdi rnd
label variable co2_s1    "Scope 1 CO2 (t): diesel, petrol, coal, LPG"
label variable co2_s2    "Scope 2 CO2 (t): purchased electricity"
label variable co2_total "Scope 1 + scope 2 CO2 (t)"
label variable gj_s1     "Energy (GJ): diesel, petrol, coal, LPG"
label variable gj_s2     "Energy (GJ): purchased electricity"
label variable gj_total  "Energy (GJ): scope 1 fuels + purchased electricity"
label variable rnd       "R&D activity (2011, 2017-2022 only)"
label variable clean     "1 = not an energy outlier"
compress
save "$B17_DATA/b17_si.dta", replace
display as result "01a done: $B17_DATA/b17_si.dta (" _N " rows)"
