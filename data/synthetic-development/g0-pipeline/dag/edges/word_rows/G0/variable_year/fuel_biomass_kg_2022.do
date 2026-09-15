* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_fuel_biomass_kg_2022: annual staged raw state -> fuel_biomass_kg at source_year/source_row.
* Evidence: 2020 questionnaire Q302f/i; 2021 Lampung PDF p90 Q302g/j; 2022 Sumbar PDF p69 Q302h/k. Gas MMBTU; mixed biomass tonnes ×1000. Not pure charcoal.
log using "$VYL/N_G0_fuel_biomass_kg_2022.log", text replace name(vycell)
generate double fuel_biomass_kg=.
generate byte vs_fuel_biomass_kg=3
replace fuel_biomass_kg=real(subinstr(strtrim(raw_ecakgu22),",","",.))*1000
replace vs_fuel_biomass_kg=5 if missing(real(subinstr(strtrim(raw_ecakgu22),",","",.))) & !inlist(upper(strtrim(raw_ecakgu22)),"","***",".","NA","N/A","NULL","-")
replace vs_fuel_biomass_kg=cond(fuel_biomass_kg<0,2,cond(fuel_biomass_kg==0,1,0)) if !missing(fuel_biomass_kg)
quietly count if !missing(fuel_biomass_kg)
local obs=r(N)
quietly count if fuel_biomass_kg==0
local zeros=r(N)
quietly count if inlist(vs_fuel_biomass_kg,5,6,8)
local bad=r(N)
quietly count if vs_fuel_biomass_kg==4
local absent=r(N)
post cell (2022) ("fuel_biomass_kg") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row fuel_biomass_kg vs_fuel_biomass_kg raw_ecakgu22
isid source_year source_row
save "$VYD/N_G0_fuel_biomass_kg_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_biomass_kg_2022"
log close vycell
