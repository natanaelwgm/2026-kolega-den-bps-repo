* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_fuel_coal_kg_2019: annual staged raw state -> fuel_coal_kg at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_fuel_coal_kg_2019.log", text replace name(vycell)
generate double fuel_coal_kg=.
generate byte vs_fuel_coal_kg=3
replace fuel_coal_kg=real(subinstr(strtrim(raw_eclkgu19),",","",.))*1
replace vs_fuel_coal_kg=5 if missing(real(subinstr(strtrim(raw_eclkgu19),",","",.))) & !inlist(upper(strtrim(raw_eclkgu19)),"","***",".","NA","N/A","NULL","-")
replace vs_fuel_coal_kg=cond(fuel_coal_kg<0,2,cond(fuel_coal_kg==0,1,0)) if !missing(fuel_coal_kg)
quietly count if !missing(fuel_coal_kg)
local obs=r(N)
quietly count if fuel_coal_kg==0
local zeros=r(N)
quietly count if inlist(vs_fuel_coal_kg,5,6,8)
local bad=r(N)
quietly count if vs_fuel_coal_kg==4
local absent=r(N)
post cell (2019) ("fuel_coal_kg") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row fuel_coal_kg vs_fuel_coal_kg raw_eclkgu19
isid source_year source_row
save "$VYD/N_G0_fuel_coal_kg_2019.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_coal_kg_2019"
log close vycell
