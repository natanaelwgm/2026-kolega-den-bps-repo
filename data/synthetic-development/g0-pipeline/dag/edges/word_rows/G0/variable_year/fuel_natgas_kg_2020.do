* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_fuel_natgas_kg_2020: annual staged raw state -> fuel_natgas_kg at source_year/source_row.
* Evidence: 2020–22 annual Q302: natural gas MMBTU and biomass tonnes. Use fuel_natgas_mmbtu or fuel_biomass_kg, respectively; source original remains unchanged.
log using "$VYL/N_G0_fuel_natgas_kg_2020.log", text replace name(vycell)
generate double fuel_natgas_kg=.
generate byte vs_fuel_natgas_kg=3
replace vs_fuel_natgas_kg=9
replace vs_fuel_natgas_kg=cond(fuel_natgas_kg<0,2,cond(fuel_natgas_kg==0,1,0)) if !missing(fuel_natgas_kg)
quietly count if !missing(fuel_natgas_kg)
local obs=r(N)
quietly count if fuel_natgas_kg==0
local zeros=r(N)
quietly count if inlist(vs_fuel_natgas_kg,5,6,8)
local bad=r(N)
quietly count if vs_fuel_natgas_kg==4
local absent=r(N)
post cell (2020) ("fuel_natgas_kg") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row fuel_natgas_kg vs_fuel_natgas_kg raw_engkgu20
isid source_year source_row
save "$VYD/N_G0_fuel_natgas_kg_2020.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_natgas_kg_2020"
log close vycell
