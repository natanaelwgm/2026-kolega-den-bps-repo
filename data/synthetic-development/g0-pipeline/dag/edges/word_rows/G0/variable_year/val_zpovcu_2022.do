* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_zpovcu_2022: annual staged raw state -> val_zpovcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_zpovcu_2022.log", text replace name(vycell)
generate double val_zpovcu=.
generate byte vs_val_zpovcu=4
quietly count if !missing(val_zpovcu)
local obs=r(N)
quietly count if val_zpovcu==0
local zeros=r(N)
quietly count if inlist(vs_val_zpovcu,5,6,8)
local bad=r(N)
quietly count if vs_val_zpovcu==4
local absent=r(N)
post cell (2022) ("val_zpovcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_zpovcu vs_val_zpovcu
isid source_year source_row
save "$VYD/N_G0_val_zpovcu_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_zpovcu_2022"
log close vycell
