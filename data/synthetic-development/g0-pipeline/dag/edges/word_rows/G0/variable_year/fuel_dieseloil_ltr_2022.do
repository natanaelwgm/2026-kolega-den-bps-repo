* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_fuel_dieseloil_ltr_2022: annual staged raw state -> fuel_dieseloil_ltr at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_fuel_dieseloil_ltr_2022.log", text replace name(vycell)
generate double fuel_dieseloil_ltr=.
generate byte vs_fuel_dieseloil_ltr=3
replace fuel_dieseloil_ltr=real(subinstr(strtrim(raw_ediliu22),",","",.))*1
replace vs_fuel_dieseloil_ltr=5 if missing(real(subinstr(strtrim(raw_ediliu22),",","",.))) & !inlist(upper(strtrim(raw_ediliu22)),"","***",".","NA","N/A","NULL","-")
replace vs_fuel_dieseloil_ltr=cond(fuel_dieseloil_ltr<0,2,cond(fuel_dieseloil_ltr==0,1,0)) if !missing(fuel_dieseloil_ltr)
quietly count if !missing(fuel_dieseloil_ltr)
local obs=r(N)
quietly count if fuel_dieseloil_ltr==0
local zeros=r(N)
quietly count if inlist(vs_fuel_dieseloil_ltr,5,6,8)
local bad=r(N)
quietly count if vs_fuel_dieseloil_ltr==4
local absent=r(N)
post cell (2022) ("fuel_dieseloil_ltr") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row fuel_dieseloil_ltr vs_fuel_dieseloil_ltr raw_ediliu22
isid source_year source_row
save "$VYD/N_G0_fuel_dieseloil_ltr_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_dieseloil_ltr_2022"
log close vycell
