* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_esdvcu_2019: annual staged raw state -> val_esdvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_esdvcu_2019.log", text replace name(vycell)
generate double val_esdvcu=.
generate byte vs_val_esdvcu=4
quietly count if !missing(val_esdvcu)
local obs=r(N)
quietly count if val_esdvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_esdvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_esdvcu==4
local absent=r(N)
post cell (2019) ("val_esdvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_esdvcu vs_val_esdvcu
isid source_year source_row
save "$VYD/N_G0_val_esdvcu_2019.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_esdvcu_2019"
log close vycell
