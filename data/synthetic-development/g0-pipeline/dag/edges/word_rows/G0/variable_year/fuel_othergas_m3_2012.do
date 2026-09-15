* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_fuel_othergas_m3_2012: annual staged raw state -> fuel_othergas_m3 at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2012 row 135; egom3u12 | total gas from others used, m3
log using "$VYL/N_G0_fuel_othergas_m3_2012.log", text replace name(vycell)
generate double fuel_othergas_m3=.
generate byte vs_fuel_othergas_m3=3
replace fuel_othergas_m3=real(subinstr(strtrim(raw_egom3u12),",","",.))*1
replace vs_fuel_othergas_m3=5 if missing(real(subinstr(strtrim(raw_egom3u12),",","",.))) & !inlist(upper(strtrim(raw_egom3u12)),"","***",".","NA","N/A","NULL","-")
replace vs_fuel_othergas_m3=cond(fuel_othergas_m3<0,2,cond(fuel_othergas_m3==0,1,0)) if !missing(fuel_othergas_m3)
quietly count if !missing(fuel_othergas_m3)
local obs=r(N)
quietly count if fuel_othergas_m3==0
local zeros=r(N)
quietly count if inlist(vs_fuel_othergas_m3,5,6,8)
local bad=r(N)
quietly count if vs_fuel_othergas_m3==4
local absent=r(N)
post cell (2012) ("fuel_othergas_m3") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row fuel_othergas_m3 vs_fuel_othergas_m3 raw_egom3u12
isid source_year source_row
save "$VYD/N_G0_fuel_othergas_m3_2012.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_othergas_m3_2012"
log close vycell
