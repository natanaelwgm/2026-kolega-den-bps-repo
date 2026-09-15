* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_fuel_charcoal_rp000_2020: annual staged raw state -> fuel_charcoal_rp000 at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_fuel_charcoal_rp000_2020.log", text replace name(vycell)
generate double fuel_charcoal_rp000=.
generate byte vs_fuel_charcoal_rp000=3
replace fuel_charcoal_rp000=real(subinstr(strtrim(raw_ecavcu20),",","",.))*1
replace vs_fuel_charcoal_rp000=5 if missing(real(subinstr(strtrim(raw_ecavcu20),",","",.))) & !inlist(upper(strtrim(raw_ecavcu20)),"","***",".","NA","N/A","NULL","-")
replace vs_fuel_charcoal_rp000=cond(fuel_charcoal_rp000<0,2,cond(fuel_charcoal_rp000==0,1,0)) if !missing(fuel_charcoal_rp000)
quietly count if !missing(fuel_charcoal_rp000)
local obs=r(N)
quietly count if fuel_charcoal_rp000==0
local zeros=r(N)
quietly count if inlist(vs_fuel_charcoal_rp000,5,6,8)
local bad=r(N)
quietly count if vs_fuel_charcoal_rp000==4
local absent=r(N)
post cell (2020) ("fuel_charcoal_rp000") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row fuel_charcoal_rp000 vs_fuel_charcoal_rp000 raw_ecavcu20
isid source_year source_row
save "$VYD/N_G0_fuel_charcoal_rp000_2020.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_charcoal_rp000_2020"
log close vycell
