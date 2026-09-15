* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_zntvcu_2015: annual staged raw state -> val_zntvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_zntvcu_2015.log", text replace name(vycell)
generate double val_zntvcu=.
generate byte vs_val_zntvcu=4
quietly count if !missing(val_zntvcu)
local obs=r(N)
quietly count if val_zntvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_zntvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_zntvcu==4
local absent=r(N)
post cell (2015) ("val_zntvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_zntvcu vs_val_zntvcu
isid source_year source_row
save "$VYD/N_G0_val_zntvcu_2015.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_zntvcu_2015"
log close vycell
