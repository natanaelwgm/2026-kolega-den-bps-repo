* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_fuel_othergas_rp000_2015: annual staged raw state -> fuel_othergas_rp000 at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2015 row 66; egovcu15 | total gas from others used, 000 rp
log using "$VYL/N_G0_fuel_othergas_rp000_2015.log", text replace name(vycell)
generate double fuel_othergas_rp000=.
generate byte vs_fuel_othergas_rp000=4
quietly count if !missing(fuel_othergas_rp000)
local obs=r(N)
quietly count if fuel_othergas_rp000==0
local zeros=r(N)
quietly count if inlist(vs_fuel_othergas_rp000,5,6,8)
local bad=r(N)
quietly count if vs_fuel_othergas_rp000==4
local absent=r(N)
post cell (2015) ("fuel_othergas_rp000") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row fuel_othergas_rp000 vs_fuel_othergas_rp000
isid source_year source_row
save "$VYD/N_G0_fuel_othergas_rp000_2015.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_othergas_rp000_2015"
log close vycell
