* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_zppvcu_2020: annual staged raw state -> val_zppvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_zppvcu_2020.log", text replace name(vycell)
generate double val_zppvcu=.
generate byte vs_val_zppvcu=4
quietly count if !missing(val_zppvcu)
local obs=r(N)
quietly count if val_zppvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_zppvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_zppvcu==4
local absent=r(N)
post cell (2020) ("val_zppvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_zppvcu vs_val_zppvcu
isid source_year source_row
save "$VYD/N_G0_val_zppvcu_2020.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_zppvcu_2020"
log close vycell
