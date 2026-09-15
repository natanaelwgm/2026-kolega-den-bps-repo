* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_fuel_biodiesel_ltr_2022: annual staged raw state -> fuel_biodiesel_ltr at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_fuel_biodiesel_ltr_2022.log", text replace name(vycell)
generate double fuel_biodiesel_ltr=.
generate byte vs_fuel_biodiesel_ltr=3
replace fuel_biodiesel_ltr=real(subinstr(strtrim(raw_esdliu22),",","",.))*1
replace vs_fuel_biodiesel_ltr=5 if missing(real(subinstr(strtrim(raw_esdliu22),",","",.))) & !inlist(upper(strtrim(raw_esdliu22)),"","***",".","NA","N/A","NULL","-")
replace vs_fuel_biodiesel_ltr=cond(fuel_biodiesel_ltr<0,2,cond(fuel_biodiesel_ltr==0,1,0)) if !missing(fuel_biodiesel_ltr)
quietly count if !missing(fuel_biodiesel_ltr)
local obs=r(N)
quietly count if fuel_biodiesel_ltr==0
local zeros=r(N)
quietly count if inlist(vs_fuel_biodiesel_ltr,5,6,8)
local bad=r(N)
quietly count if vs_fuel_biodiesel_ltr==4
local absent=r(N)
post cell (2022) ("fuel_biodiesel_ltr") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row fuel_biodiesel_ltr vs_fuel_biodiesel_ltr raw_esdliu22
isid source_year source_row
save "$VYD/N_G0_fuel_biodiesel_ltr_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_biodiesel_ltr_2022"
log close vycell
