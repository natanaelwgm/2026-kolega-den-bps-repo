* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_fuel_charcoal_kg_2022: annual staged raw state -> fuel_charcoal_kg at source_year/source_row.
* Evidence: 2020–22 annual Q302: natural gas MMBTU and biomass tonnes. Use fuel_natgas_mmbtu or fuel_biomass_kg, respectively; source original remains unchanged.
log using "$VYL/N_G0_fuel_charcoal_kg_2022.log", text replace name(vycell)
generate double fuel_charcoal_kg=.
generate byte vs_fuel_charcoal_kg=3
replace vs_fuel_charcoal_kg=9
replace vs_fuel_charcoal_kg=cond(fuel_charcoal_kg<0,2,cond(fuel_charcoal_kg==0,1,0)) if !missing(fuel_charcoal_kg)
quietly count if !missing(fuel_charcoal_kg)
local obs=r(N)
quietly count if fuel_charcoal_kg==0
local zeros=r(N)
quietly count if inlist(vs_fuel_charcoal_kg,5,6,8)
local bad=r(N)
quietly count if vs_fuel_charcoal_kg==4
local absent=r(N)
post cell (2022) ("fuel_charcoal_kg") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row fuel_charcoal_kg vs_fuel_charcoal_kg raw_ecakgu22
isid source_year source_row
save "$VYD/N_G0_fuel_charcoal_kg_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_charcoal_kg_2022"
log close vycell
