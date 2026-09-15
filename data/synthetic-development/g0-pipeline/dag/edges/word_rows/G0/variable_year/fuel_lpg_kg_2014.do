* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_fuel_lpg_kg_2014: annual staged raw state -> fuel_lpg_kg at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2014 row 87; elpkgu14 | total lpg used, kg
log using "$VYL/N_G0_fuel_lpg_kg_2014.log", text replace name(vycell)
generate double fuel_lpg_kg=.
generate byte vs_fuel_lpg_kg=3
replace fuel_lpg_kg=real(subinstr(strtrim(raw_elpkgu14),",","",.))*1
replace vs_fuel_lpg_kg=5 if missing(real(subinstr(strtrim(raw_elpkgu14),",","",.))) & !inlist(upper(strtrim(raw_elpkgu14)),"","***",".","NA","N/A","NULL","-")
replace vs_fuel_lpg_kg=cond(fuel_lpg_kg<0,2,cond(fuel_lpg_kg==0,1,0)) if !missing(fuel_lpg_kg)
quietly count if !missing(fuel_lpg_kg)
local obs=r(N)
quietly count if fuel_lpg_kg==0
local zeros=r(N)
quietly count if inlist(vs_fuel_lpg_kg,5,6,8)
local bad=r(N)
quietly count if vs_fuel_lpg_kg==4
local absent=r(N)
post cell (2014) ("fuel_lpg_kg") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row fuel_lpg_kg vs_fuel_lpg_kg raw_elpkgu14
isid source_year source_row
save "$VYD/N_G0_fuel_lpg_kg_2014.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_lpg_kg_2014"
log close vycell
