* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_fuel_fueloil_ltr_2013: annual staged raw state -> fuel_fueloil_ltr at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_fuel_fueloil_ltr_2013.log", text replace name(vycell)
generate double fuel_fueloil_ltr=.
generate byte vs_fuel_fueloil_ltr=4
quietly count if !missing(fuel_fueloil_ltr)
local obs=r(N)
quietly count if fuel_fueloil_ltr==0
local zeros=r(N)
quietly count if inlist(vs_fuel_fueloil_ltr,5,6,8)
local bad=r(N)
quietly count if vs_fuel_fueloil_ltr==4
local absent=r(N)
post cell (2013) ("fuel_fueloil_ltr") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row fuel_fueloil_ltr vs_fuel_fueloil_ltr
isid source_year source_row
save "$VYD/N_G0_fuel_fueloil_ltr_2013.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_fueloil_ltr_2013"
log close vycell
