* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_fuel_diesel_rp000_2022: annual staged raw state -> fuel_diesel_rp000 at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_fuel_diesel_rp000_2022.log", text replace name(vycell)
generate double fuel_diesel_rp000=.
generate byte vs_fuel_diesel_rp000=3
replace fuel_diesel_rp000=real(subinstr(strtrim(raw_esovcu22),",","",.))*1
replace vs_fuel_diesel_rp000=5 if missing(real(subinstr(strtrim(raw_esovcu22),",","",.))) & !inlist(upper(strtrim(raw_esovcu22)),"","***",".","NA","N/A","NULL","-")
replace vs_fuel_diesel_rp000=cond(fuel_diesel_rp000<0,2,cond(fuel_diesel_rp000==0,1,0)) if !missing(fuel_diesel_rp000)
quietly count if !missing(fuel_diesel_rp000)
local obs=r(N)
quietly count if fuel_diesel_rp000==0
local zeros=r(N)
quietly count if inlist(vs_fuel_diesel_rp000,5,6,8)
local bad=r(N)
quietly count if vs_fuel_diesel_rp000==4
local absent=r(N)
post cell (2022) ("fuel_diesel_rp000") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row fuel_diesel_rp000 vs_fuel_diesel_rp000 raw_esovcu22
isid source_year source_row
save "$VYD/N_G0_fuel_diesel_rp000_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_diesel_rp000_2022"
log close vycell
