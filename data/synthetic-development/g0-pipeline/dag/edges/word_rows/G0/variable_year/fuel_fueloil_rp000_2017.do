* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_fuel_fueloil_rp000_2017: annual staged raw state -> fuel_fueloil_rp000 at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_fuel_fueloil_rp000_2017.log", text replace name(vycell)
generate double fuel_fueloil_rp000=.
generate byte vs_fuel_fueloil_rp000=4
quietly count if !missing(fuel_fueloil_rp000)
local obs=r(N)
quietly count if fuel_fueloil_rp000==0
local zeros=r(N)
quietly count if inlist(vs_fuel_fueloil_rp000,5,6,8)
local bad=r(N)
quietly count if vs_fuel_fueloil_rp000==4
local absent=r(N)
post cell (2017) ("fuel_fueloil_rp000") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row fuel_fueloil_rp000 vs_fuel_fueloil_rp000
isid source_year source_row
save "$VYD/N_G0_fuel_fueloil_rp000_2017.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_fueloil_rp000_2017"
log close vycell
