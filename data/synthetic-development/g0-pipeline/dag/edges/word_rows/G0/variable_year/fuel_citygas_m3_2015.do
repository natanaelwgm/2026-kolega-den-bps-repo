* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_fuel_citygas_m3_2015: annual staged raw state -> fuel_citygas_m3 at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2015 row 61; egam3u15 | total public pgn used, m3
log using "$VYL/N_G0_fuel_citygas_m3_2015.log", text replace name(vycell)
generate double fuel_citygas_m3=.
generate byte vs_fuel_citygas_m3=3
replace fuel_citygas_m3=real(subinstr(strtrim(raw_egam3u),",","",.))*1
replace vs_fuel_citygas_m3=5 if missing(real(subinstr(strtrim(raw_egam3u),",","",.))) & !inlist(upper(strtrim(raw_egam3u)),"","***",".","NA","N/A","NULL","-")
replace vs_fuel_citygas_m3=cond(fuel_citygas_m3<0,2,cond(fuel_citygas_m3==0,1,0)) if !missing(fuel_citygas_m3)
quietly count if !missing(fuel_citygas_m3)
local obs=r(N)
quietly count if fuel_citygas_m3==0
local zeros=r(N)
quietly count if inlist(vs_fuel_citygas_m3,5,6,8)
local bad=r(N)
quietly count if vs_fuel_citygas_m3==4
local absent=r(N)
post cell (2015) ("fuel_citygas_m3") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row fuel_citygas_m3 vs_fuel_citygas_m3 raw_egam3u
isid source_year source_row
save "$VYD/N_G0_fuel_citygas_m3_2015.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_citygas_m3_2015"
log close vycell
