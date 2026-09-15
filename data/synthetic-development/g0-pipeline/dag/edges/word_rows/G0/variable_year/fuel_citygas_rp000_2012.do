* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_fuel_citygas_rp000_2012: annual staged raw state -> fuel_citygas_rp000 at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2012 row 8; egavcu12 | total public pgn used, 000 rp
log using "$VYL/N_G0_fuel_citygas_rp000_2012.log", text replace name(vycell)
generate double fuel_citygas_rp000=.
generate byte vs_fuel_citygas_rp000=3
replace fuel_citygas_rp000=real(subinstr(strtrim(raw_egavcu12),",","",.))*1
replace vs_fuel_citygas_rp000=5 if missing(real(subinstr(strtrim(raw_egavcu12),",","",.))) & !inlist(upper(strtrim(raw_egavcu12)),"","***",".","NA","N/A","NULL","-")
replace vs_fuel_citygas_rp000=cond(fuel_citygas_rp000<0,2,cond(fuel_citygas_rp000==0,1,0)) if !missing(fuel_citygas_rp000)
quietly count if !missing(fuel_citygas_rp000)
local obs=r(N)
quietly count if fuel_citygas_rp000==0
local zeros=r(N)
quietly count if inlist(vs_fuel_citygas_rp000,5,6,8)
local bad=r(N)
quietly count if vs_fuel_citygas_rp000==4
local absent=r(N)
post cell (2012) ("fuel_citygas_rp000") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row fuel_citygas_rp000 vs_fuel_citygas_rp000 raw_egavcu12
isid source_year source_row
save "$VYD/N_G0_fuel_citygas_rp000_2012.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_citygas_rp000_2012"
log close vycell
