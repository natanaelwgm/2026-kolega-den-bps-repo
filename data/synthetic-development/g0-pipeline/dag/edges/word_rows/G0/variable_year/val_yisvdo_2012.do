* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_yisvdo_2012: annual staged raw state -> val_yisvdo at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_yisvdo_2012.log", text replace name(vycell)
generate double val_yisvdo=.
generate byte vs_val_yisvdo=4
quietly count if !missing(val_yisvdo)
local obs=r(N)
quietly count if val_yisvdo==0
local zeros=r(N)
quietly count if inlist(vs_val_yisvdo,5,6,8)
local bad=r(N)
quietly count if vs_val_yisvdo==4
local absent=r(N)
post cell (2012) ("val_yisvdo") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_yisvdo vs_val_yisvdo
isid source_year source_row
save "$VYD/N_G0_val_yisvdo_2012.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_yisvdo_2012"
log close vycell
