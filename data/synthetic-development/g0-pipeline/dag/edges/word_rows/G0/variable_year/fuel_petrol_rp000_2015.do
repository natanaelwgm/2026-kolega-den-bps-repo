* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_fuel_petrol_rp000_2015: annual staged raw state -> fuel_petrol_rp000 at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2015 row 42; epevcu15 | total premium/gasoline used, 000rp
log using "$VYL/N_G0_fuel_petrol_rp000_2015.log", text replace name(vycell)
generate double fuel_petrol_rp000=.
generate byte vs_fuel_petrol_rp000=3
replace fuel_petrol_rp000=real(subinstr(strtrim(raw_epevcu),",","",.))*1
replace vs_fuel_petrol_rp000=5 if missing(real(subinstr(strtrim(raw_epevcu),",","",.))) & !inlist(upper(strtrim(raw_epevcu)),"","***",".","NA","N/A","NULL","-")
replace vs_fuel_petrol_rp000=cond(fuel_petrol_rp000<0,2,cond(fuel_petrol_rp000==0,1,0)) if !missing(fuel_petrol_rp000)
quietly count if !missing(fuel_petrol_rp000)
local obs=r(N)
quietly count if fuel_petrol_rp000==0
local zeros=r(N)
quietly count if inlist(vs_fuel_petrol_rp000,5,6,8)
local bad=r(N)
quietly count if vs_fuel_petrol_rp000==4
local absent=r(N)
post cell (2015) ("fuel_petrol_rp000") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row fuel_petrol_rp000 vs_fuel_petrol_rp000 raw_epevcu
isid source_year source_row
save "$VYD/N_G0_fuel_petrol_rp000_2015.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_petrol_rp000_2015"
log close vycell
