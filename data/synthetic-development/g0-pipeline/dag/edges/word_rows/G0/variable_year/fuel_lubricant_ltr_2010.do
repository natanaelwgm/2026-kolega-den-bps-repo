* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_fuel_lubricant_ltr_2010: annual staged raw state -> fuel_lubricant_ltr at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2010 row 60; eluliu10 | total lubricant used, ltr
log using "$VYL/N_G0_fuel_lubricant_ltr_2010.log", text replace name(vycell)
generate double fuel_lubricant_ltr=.
generate byte vs_fuel_lubricant_ltr=3
replace fuel_lubricant_ltr=real(subinstr(strtrim(raw_eluliu10),",","",.))*1
replace vs_fuel_lubricant_ltr=5 if missing(real(subinstr(strtrim(raw_eluliu10),",","",.))) & !inlist(upper(strtrim(raw_eluliu10)),"","***",".","NA","N/A","NULL","-")
replace vs_fuel_lubricant_ltr=cond(fuel_lubricant_ltr<0,2,cond(fuel_lubricant_ltr==0,1,0)) if !missing(fuel_lubricant_ltr)
quietly count if !missing(fuel_lubricant_ltr)
local obs=r(N)
quietly count if fuel_lubricant_ltr==0
local zeros=r(N)
quietly count if inlist(vs_fuel_lubricant_ltr,5,6,8)
local bad=r(N)
quietly count if vs_fuel_lubricant_ltr==4
local absent=r(N)
post cell (2010) ("fuel_lubricant_ltr") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row fuel_lubricant_ltr vs_fuel_lubricant_ltr raw_eluliu10
isid source_year source_row
save "$VYD/N_G0_fuel_lubricant_ltr_2010.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_lubricant_ltr_2010"
log close vycell
