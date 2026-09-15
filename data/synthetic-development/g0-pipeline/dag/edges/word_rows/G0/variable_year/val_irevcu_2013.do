* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_irevcu_2013: annual staged raw state -> val_irevcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_irevcu_2013.log", text replace name(vycell)
generate double val_irevcu=.
generate byte vs_val_irevcu=4
quietly count if !missing(val_irevcu)
local obs=r(N)
quietly count if val_irevcu==0
local zeros=r(N)
quietly count if inlist(vs_val_irevcu,5,6,8)
local bad=r(N)
quietly count if vs_val_irevcu==4
local absent=r(N)
post cell (2013) ("val_irevcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_irevcu vs_val_irevcu
isid source_year source_row
save "$VYD/N_G0_val_irevcu_2013.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_irevcu_2013"
log close vycell
