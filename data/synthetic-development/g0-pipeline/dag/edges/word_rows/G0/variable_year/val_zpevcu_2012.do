* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_zpevcu_2012: annual staged raw state -> val_zpevcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_zpevcu_2012.log", text replace name(vycell)
generate double val_zpevcu=.
generate byte vs_val_zpevcu=4
quietly count if !missing(val_zpevcu)
local obs=r(N)
quietly count if val_zpevcu==0
local zeros=r(N)
quietly count if inlist(vs_val_zpevcu,5,6,8)
local bad=r(N)
quietly count if vs_val_zpevcu==4
local absent=r(N)
post cell (2012) ("val_zpevcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_zpevcu vs_val_zpevcu
isid source_year source_row
save "$VYD/N_G0_val_zpevcu_2012.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_zpevcu_2012"
log close vycell
