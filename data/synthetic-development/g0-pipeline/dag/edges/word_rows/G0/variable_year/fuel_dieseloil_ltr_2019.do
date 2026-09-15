* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_fuel_dieseloil_ltr_2019: annual staged raw state -> fuel_dieseloil_ltr at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_fuel_dieseloil_ltr_2019.log", text replace name(vycell)
generate double fuel_dieseloil_ltr=.
generate byte vs_fuel_dieseloil_ltr=4
quietly count if !missing(fuel_dieseloil_ltr)
local obs=r(N)
quietly count if fuel_dieseloil_ltr==0
local zeros=r(N)
quietly count if inlist(vs_fuel_dieseloil_ltr,5,6,8)
local bad=r(N)
quietly count if vs_fuel_dieseloil_ltr==4
local absent=r(N)
post cell (2019) ("fuel_dieseloil_ltr") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row fuel_dieseloil_ltr vs_fuel_dieseloil_ltr
isid source_year source_row
save "$VYD/N_G0_fuel_dieseloil_ltr_2019.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_dieseloil_ltr_2019"
log close vycell
