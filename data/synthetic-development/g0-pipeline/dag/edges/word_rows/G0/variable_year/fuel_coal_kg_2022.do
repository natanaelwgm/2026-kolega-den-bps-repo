* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_fuel_coal_kg_2022: annual staged raw state -> fuel_coal_kg at source_year/source_row.
* Evidence: 2017 SILASTIK ECLKGU17 explicitly TON; 2021 BPS Lampung appendix PDF p90 Q302e; 2022 BPS Sumbar appendix PDF p69 Q302e. Multiply tonnes by 1000.
log using "$VYL/N_G0_fuel_coal_kg_2022.log", text replace name(vycell)
generate double fuel_coal_kg=.
generate byte vs_fuel_coal_kg=3
replace fuel_coal_kg=real(subinstr(strtrim(raw_eclkgu22),",","",.))*1000
replace vs_fuel_coal_kg=5 if missing(real(subinstr(strtrim(raw_eclkgu22),",","",.))) & !inlist(upper(strtrim(raw_eclkgu22)),"","***",".","NA","N/A","NULL","-")
replace vs_fuel_coal_kg=cond(fuel_coal_kg<0,2,cond(fuel_coal_kg==0,1,0)) if !missing(fuel_coal_kg)
quietly count if !missing(fuel_coal_kg)
local obs=r(N)
quietly count if fuel_coal_kg==0
local zeros=r(N)
quietly count if inlist(vs_fuel_coal_kg,5,6,8)
local bad=r(N)
quietly count if vs_fuel_coal_kg==4
local absent=r(N)
post cell (2022) ("fuel_coal_kg") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row fuel_coal_kg vs_fuel_coal_kg raw_eclkgu22
isid source_year source_row
save "$VYD/N_G0_fuel_coal_kg_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_coal_kg_2022"
log close vycell
