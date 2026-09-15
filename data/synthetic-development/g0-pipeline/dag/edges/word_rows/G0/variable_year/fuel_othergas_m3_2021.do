* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_fuel_othergas_m3_2021: annual staged raw state -> fuel_othergas_m3 at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_fuel_othergas_m3_2021.log", text replace name(vycell)
generate double fuel_othergas_m3=.
generate byte vs_fuel_othergas_m3=4
quietly count if !missing(fuel_othergas_m3)
local obs=r(N)
quietly count if fuel_othergas_m3==0
local zeros=r(N)
quietly count if inlist(vs_fuel_othergas_m3,5,6,8)
local bad=r(N)
quietly count if vs_fuel_othergas_m3==4
local absent=r(N)
post cell (2021) ("fuel_othergas_m3") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row fuel_othergas_m3 vs_fuel_othergas_m3
isid source_year source_row
save "$VYD/N_G0_fuel_othergas_m3_2021.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_othergas_m3_2021"
log close vycell
