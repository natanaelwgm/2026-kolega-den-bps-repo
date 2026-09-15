* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_zpivcu_2019: annual staged raw state -> val_zpivcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_zpivcu_2019.log", text replace name(vycell)
generate double val_zpivcu=.
generate byte vs_val_zpivcu=4
quietly count if !missing(val_zpivcu)
local obs=r(N)
quietly count if val_zpivcu==0
local zeros=r(N)
quietly count if inlist(vs_val_zpivcu,5,6,8)
local bad=r(N)
quietly count if vs_val_zpivcu==4
local absent=r(N)
post cell (2019) ("val_zpivcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_zpivcu vs_val_zpivcu
isid source_year source_row
save "$VYD/N_G0_val_zpivcu_2019.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_zpivcu_2019"
log close vycell
