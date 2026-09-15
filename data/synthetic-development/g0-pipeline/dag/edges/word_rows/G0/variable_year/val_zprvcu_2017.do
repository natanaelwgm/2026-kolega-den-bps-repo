* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_zprvcu_2017: annual staged raw state -> val_zprvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_zprvcu_2017.log", text replace name(vycell)
generate double val_zprvcu=.
generate byte vs_val_zprvcu=4
quietly count if !missing(val_zprvcu)
local obs=r(N)
quietly count if val_zprvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_zprvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_zprvcu==4
local absent=r(N)
post cell (2017) ("val_zprvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_zprvcu vs_val_zprvcu
isid source_year source_row
save "$VYD/N_G0_val_zprvcu_2017.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_zprvcu_2017"
log close vycell
