* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_sfcvcu_2014: annual staged raw state -> val_sfcvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_sfcvcu_2014.log", text replace name(vycell)
generate double val_sfcvcu=.
generate byte vs_val_sfcvcu=4
quietly count if !missing(val_sfcvcu)
local obs=r(N)
quietly count if val_sfcvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_sfcvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_sfcvcu==4
local absent=r(N)
post cell (2014) ("val_sfcvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_sfcvcu vs_val_sfcvcu
isid source_year source_row
save "$VYD/N_G0_val_sfcvcu_2014.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_sfcvcu_2014"
log close vycell
