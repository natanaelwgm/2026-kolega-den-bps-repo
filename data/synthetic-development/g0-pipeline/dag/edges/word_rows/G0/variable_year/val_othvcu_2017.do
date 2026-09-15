* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_othvcu_2017: annual staged raw state -> val_othvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_othvcu_2017.log", text replace name(vycell)
generate double val_othvcu=.
generate byte vs_val_othvcu=4
quietly count if !missing(val_othvcu)
local obs=r(N)
quietly count if val_othvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_othvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_othvcu==4
local absent=r(N)
post cell (2017) ("val_othvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_othvcu vs_val_othvcu
isid source_year source_row
save "$VYD/N_G0_val_othvcu_2017.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_othvcu_2017"
log close vycell
