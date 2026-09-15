* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_cmfpcu_2013: annual staged raw state -> val_cmfpcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_cmfpcu_2013.log", text replace name(vycell)
generate double val_cmfpcu=.
generate byte vs_val_cmfpcu=4
quietly count if !missing(val_cmfpcu)
local obs=r(N)
quietly count if val_cmfpcu==0
local zeros=r(N)
quietly count if inlist(vs_val_cmfpcu,5,6,8)
local bad=r(N)
quietly count if vs_val_cmfpcu==4
local absent=r(N)
post cell (2013) ("val_cmfpcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_cmfpcu vs_val_cmfpcu
isid source_year source_row
save "$VYD/N_G0_val_cmfpcu_2013.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_cmfpcu_2013"
log close vycell
