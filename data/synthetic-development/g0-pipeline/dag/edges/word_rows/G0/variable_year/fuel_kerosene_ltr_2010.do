* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_fuel_kerosene_ltr_2010: annual staged raw state -> fuel_kerosene_ltr at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2010 row 42; eoiliu10 | total kerosene used, ltr
log using "$VYL/N_G0_fuel_kerosene_ltr_2010.log", text replace name(vycell)
generate double fuel_kerosene_ltr=.
generate byte vs_fuel_kerosene_ltr=3
replace fuel_kerosene_ltr=real(subinstr(strtrim(raw_eoiliu10),",","",.))*1
replace vs_fuel_kerosene_ltr=5 if missing(real(subinstr(strtrim(raw_eoiliu10),",","",.))) & !inlist(upper(strtrim(raw_eoiliu10)),"","***",".","NA","N/A","NULL","-")
replace vs_fuel_kerosene_ltr=cond(fuel_kerosene_ltr<0,2,cond(fuel_kerosene_ltr==0,1,0)) if !missing(fuel_kerosene_ltr)
quietly count if !missing(fuel_kerosene_ltr)
local obs=r(N)
quietly count if fuel_kerosene_ltr==0
local zeros=r(N)
quietly count if inlist(vs_fuel_kerosene_ltr,5,6,8)
local bad=r(N)
quietly count if vs_fuel_kerosene_ltr==4
local absent=r(N)
post cell (2010) ("fuel_kerosene_ltr") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row fuel_kerosene_ltr vs_fuel_kerosene_ltr raw_eoiliu10
isid source_year source_row
save "$VYD/N_G0_fuel_kerosene_ltr_2010.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_kerosene_ltr_2010"
log close vycell
