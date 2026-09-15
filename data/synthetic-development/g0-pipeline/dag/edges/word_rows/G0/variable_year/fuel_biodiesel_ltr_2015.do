* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_fuel_biodiesel_ltr_2015: annual staged raw state -> fuel_biodiesel_ltr at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_fuel_biodiesel_ltr_2015.log", text replace name(vycell)
generate double fuel_biodiesel_ltr=.
generate byte vs_fuel_biodiesel_ltr=4
quietly count if !missing(fuel_biodiesel_ltr)
local obs=r(N)
quietly count if fuel_biodiesel_ltr==0
local zeros=r(N)
quietly count if inlist(vs_fuel_biodiesel_ltr,5,6,8)
local bad=r(N)
quietly count if vs_fuel_biodiesel_ltr==4
local absent=r(N)
post cell (2015) ("fuel_biodiesel_ltr") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row fuel_biodiesel_ltr vs_fuel_biodiesel_ltr
isid source_year source_row
save "$VYD/N_G0_fuel_biodiesel_ltr_2015.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_biodiesel_ltr_2015"
log close vycell
