* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_fuel_biomass_kg_2013: annual staged raw state -> fuel_biomass_kg at source_year/source_row.
* Evidence: 2020 questionnaire Q302f/i; 2021 Lampung PDF p90 Q302g/j; 2022 Sumbar PDF p69 Q302h/k. Gas MMBTU; mixed biomass tonnes ×1000. Not pure charcoal.
log using "$VYL/N_G0_fuel_biomass_kg_2013.log", text replace name(vycell)
generate double fuel_biomass_kg=.
generate byte vs_fuel_biomass_kg=4
quietly count if !missing(fuel_biomass_kg)
local obs=r(N)
quietly count if fuel_biomass_kg==0
local zeros=r(N)
quietly count if inlist(vs_fuel_biomass_kg,5,6,8)
local bad=r(N)
quietly count if vs_fuel_biomass_kg==4
local absent=r(N)
post cell (2013) ("fuel_biomass_kg") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row fuel_biomass_kg vs_fuel_biomass_kg
isid source_year source_row
save "$VYD/N_G0_fuel_biomass_kg_2013.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_biomass_kg_2013"
log close vycell
