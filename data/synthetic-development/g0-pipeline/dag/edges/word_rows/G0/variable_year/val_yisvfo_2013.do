* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_yisvfo_2013: annual staged raw state -> val_yisvfo at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_yisvfo_2013.log", text replace name(vycell)
generate double val_yisvfo=.
generate byte vs_val_yisvfo=4
quietly count if !missing(val_yisvfo)
local obs=r(N)
quietly count if val_yisvfo==0
local zeros=r(N)
quietly count if inlist(vs_val_yisvfo,5,6,8)
local bad=r(N)
quietly count if vs_val_yisvfo==4
local absent=r(N)
post cell (2013) ("val_yisvfo") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_yisvfo vs_val_yisvfo
isid source_year source_row
save "$VYD/N_G0_val_yisvfo_2013.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_yisvfo_2013"
log close vycell
