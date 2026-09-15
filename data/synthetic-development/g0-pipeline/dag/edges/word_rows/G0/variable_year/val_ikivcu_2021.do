* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_ikivcu_2021: annual staged raw state -> val_ikivcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_ikivcu_2021.log", text replace name(vycell)
generate double val_ikivcu=.
generate byte vs_val_ikivcu=4
quietly count if !missing(val_ikivcu)
local obs=r(N)
quietly count if val_ikivcu==0
local zeros=r(N)
quietly count if inlist(vs_val_ikivcu,5,6,8)
local bad=r(N)
quietly count if vs_val_ikivcu==4
local absent=r(N)
post cell (2021) ("val_ikivcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_ikivcu vs_val_ikivcu
isid source_year source_row
save "$VYD/N_G0_val_ikivcu_2021.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_ikivcu_2021"
log close vycell
