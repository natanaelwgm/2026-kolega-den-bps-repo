* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_fuel_lpg_rp000_2014: annual staged raw state -> fuel_lpg_rp000 at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2014 row 60; elpvcu14 | total lpg used, 000 rp
log using "$VYL/N_G0_fuel_lpg_rp000_2014.log", text replace name(vycell)
generate double fuel_lpg_rp000=.
generate byte vs_fuel_lpg_rp000=3
replace fuel_lpg_rp000=real(subinstr(strtrim(raw_elpvcu14),",","",.))*1
replace vs_fuel_lpg_rp000=5 if missing(real(subinstr(strtrim(raw_elpvcu14),",","",.))) & !inlist(upper(strtrim(raw_elpvcu14)),"","***",".","NA","N/A","NULL","-")
replace vs_fuel_lpg_rp000=cond(fuel_lpg_rp000<0,2,cond(fuel_lpg_rp000==0,1,0)) if !missing(fuel_lpg_rp000)
quietly count if !missing(fuel_lpg_rp000)
local obs=r(N)
quietly count if fuel_lpg_rp000==0
local zeros=r(N)
quietly count if inlist(vs_fuel_lpg_rp000,5,6,8)
local bad=r(N)
quietly count if vs_fuel_lpg_rp000==4
local absent=r(N)
post cell (2014) ("fuel_lpg_rp000") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row fuel_lpg_rp000 vs_fuel_lpg_rp000 raw_elpvcu14
isid source_year source_row
save "$VYD/N_G0_fuel_lpg_rp000_2014.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_lpg_rp000_2014"
log close vycell
