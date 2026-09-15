* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_fuel_charcoal_kg_2018: annual staged raw state -> fuel_charcoal_kg at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_fuel_charcoal_kg_2018.log", text replace name(vycell)
generate double fuel_charcoal_kg=.
generate byte vs_fuel_charcoal_kg=4
quietly count if !missing(fuel_charcoal_kg)
local obs=r(N)
quietly count if fuel_charcoal_kg==0
local zeros=r(N)
quietly count if inlist(vs_fuel_charcoal_kg,5,6,8)
local bad=r(N)
quietly count if vs_fuel_charcoal_kg==4
local absent=r(N)
post cell (2018) ("fuel_charcoal_kg") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row fuel_charcoal_kg vs_fuel_charcoal_kg
isid source_year source_row
save "$VYD/N_G0_fuel_charcoal_kg_2018.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_charcoal_kg_2018"
log close vycell
