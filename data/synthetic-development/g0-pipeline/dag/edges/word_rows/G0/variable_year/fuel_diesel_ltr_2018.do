* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_fuel_diesel_ltr_2018: annual staged raw state -> fuel_diesel_ltr at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_fuel_diesel_ltr_2018.log", text replace name(vycell)
generate double fuel_diesel_ltr=.
generate byte vs_fuel_diesel_ltr=3
replace fuel_diesel_ltr=real(subinstr(strtrim(raw_esoliu18),",","",.))*1
replace vs_fuel_diesel_ltr=5 if missing(real(subinstr(strtrim(raw_esoliu18),",","",.))) & !inlist(upper(strtrim(raw_esoliu18)),"","***",".","NA","N/A","NULL","-")
replace vs_fuel_diesel_ltr=cond(fuel_diesel_ltr<0,2,cond(fuel_diesel_ltr==0,1,0)) if !missing(fuel_diesel_ltr)
quietly count if !missing(fuel_diesel_ltr)
local obs=r(N)
quietly count if fuel_diesel_ltr==0
local zeros=r(N)
quietly count if inlist(vs_fuel_diesel_ltr,5,6,8)
local bad=r(N)
quietly count if vs_fuel_diesel_ltr==4
local absent=r(N)
post cell (2018) ("fuel_diesel_ltr") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row fuel_diesel_ltr vs_fuel_diesel_ltr raw_esoliu18
isid source_year source_row
save "$VYD/N_G0_fuel_diesel_ltr_2018.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_diesel_ltr_2018"
log close vycell
