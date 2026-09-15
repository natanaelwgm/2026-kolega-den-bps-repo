* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_fuel_fueloil_ltr_2020: annual staged raw state -> fuel_fueloil_ltr at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_fuel_fueloil_ltr_2020.log", text replace name(vycell)
generate double fuel_fueloil_ltr=.
generate byte vs_fuel_fueloil_ltr=3
replace fuel_fueloil_ltr=real(subinstr(strtrim(raw_efoliu20),",","",.))*1
replace vs_fuel_fueloil_ltr=5 if missing(real(subinstr(strtrim(raw_efoliu20),",","",.))) & !inlist(upper(strtrim(raw_efoliu20)),"","***",".","NA","N/A","NULL","-")
replace vs_fuel_fueloil_ltr=cond(fuel_fueloil_ltr<0,2,cond(fuel_fueloil_ltr==0,1,0)) if !missing(fuel_fueloil_ltr)
quietly count if !missing(fuel_fueloil_ltr)
local obs=r(N)
quietly count if fuel_fueloil_ltr==0
local zeros=r(N)
quietly count if inlist(vs_fuel_fueloil_ltr,5,6,8)
local bad=r(N)
quietly count if vs_fuel_fueloil_ltr==4
local absent=r(N)
post cell (2020) ("fuel_fueloil_ltr") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row fuel_fueloil_ltr vs_fuel_fueloil_ltr raw_efoliu20
isid source_year source_row
save "$VYD/N_G0_fuel_fueloil_ltr_2020.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_fueloil_ltr_2020"
log close vycell
