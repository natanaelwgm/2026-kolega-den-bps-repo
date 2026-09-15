* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_sfsvcu_2018: annual staged raw state -> val_sfsvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_sfsvcu_2018.log", text replace name(vycell)
generate double val_sfsvcu=.
generate byte vs_val_sfsvcu=4
quietly count if !missing(val_sfsvcu)
local obs=r(N)
quietly count if val_sfsvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_sfsvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_sfsvcu==4
local absent=r(N)
post cell (2018) ("val_sfsvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_sfsvcu vs_val_sfsvcu
isid source_year source_row
save "$VYD/N_G0_val_sfsvcu_2018.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_sfsvcu_2018"
log close vycell
