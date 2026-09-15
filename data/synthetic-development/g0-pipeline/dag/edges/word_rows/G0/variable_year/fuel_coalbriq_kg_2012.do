* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_fuel_coalbriq_kg_2012: annual staged raw state -> fuel_coalbriq_kg at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2012 row 131; ecbkgu12 | total coal briq used for elec gen, kg
log using "$VYL/N_G0_fuel_coalbriq_kg_2012.log", text replace name(vycell)
generate double fuel_coalbriq_kg=.
generate byte vs_fuel_coalbriq_kg=3
replace fuel_coalbriq_kg=real(subinstr(strtrim(raw_ecbkgu12),",","",.))*1
replace vs_fuel_coalbriq_kg=5 if missing(real(subinstr(strtrim(raw_ecbkgu12),",","",.))) & !inlist(upper(strtrim(raw_ecbkgu12)),"","***",".","NA","N/A","NULL","-")
replace vs_fuel_coalbriq_kg=cond(fuel_coalbriq_kg<0,2,cond(fuel_coalbriq_kg==0,1,0)) if !missing(fuel_coalbriq_kg)
quietly count if !missing(fuel_coalbriq_kg)
local obs=r(N)
quietly count if fuel_coalbriq_kg==0
local zeros=r(N)
quietly count if inlist(vs_fuel_coalbriq_kg,5,6,8)
local bad=r(N)
quietly count if vs_fuel_coalbriq_kg==4
local absent=r(N)
post cell (2012) ("fuel_coalbriq_kg") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row fuel_coalbriq_kg vs_fuel_coalbriq_kg raw_ecbkgu12
isid source_year source_row
save "$VYD/N_G0_fuel_coalbriq_kg_2012.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_coalbriq_kg_2012"
log close vycell
