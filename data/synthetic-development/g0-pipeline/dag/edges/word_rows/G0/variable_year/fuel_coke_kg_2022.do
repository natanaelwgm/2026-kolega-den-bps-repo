* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_fuel_coke_kg_2022: annual staged raw state -> fuel_coke_kg at source_year/source_row.
* Evidence: 2022 BPS Sumbar questionnaire appendix PDF p69 Q302f: coke in tonnes.
log using "$VYL/N_G0_fuel_coke_kg_2022.log", text replace name(vycell)
generate double fuel_coke_kg=.
generate byte vs_fuel_coke_kg=3
replace fuel_coke_kg=real(subinstr(strtrim(raw_eckkgu22),",","",.))*1000
replace vs_fuel_coke_kg=5 if missing(real(subinstr(strtrim(raw_eckkgu22),",","",.))) & !inlist(upper(strtrim(raw_eckkgu22)),"","***",".","NA","N/A","NULL","-")
replace vs_fuel_coke_kg=cond(fuel_coke_kg<0,2,cond(fuel_coke_kg==0,1,0)) if !missing(fuel_coke_kg)
quietly count if !missing(fuel_coke_kg)
local obs=r(N)
quietly count if fuel_coke_kg==0
local zeros=r(N)
quietly count if inlist(vs_fuel_coke_kg,5,6,8)
local bad=r(N)
quietly count if vs_fuel_coke_kg==4
local absent=r(N)
post cell (2022) ("fuel_coke_kg") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row fuel_coke_kg vs_fuel_coke_kg raw_eckkgu22
isid source_year source_row
save "$VYD/N_G0_fuel_coke_kg_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_coke_kg_2022"
log close vycell
