* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_eoivcu_2019: annual staged raw state -> val_eoivcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_eoivcu_2019.log", text replace name(vycell)
generate double val_eoivcu=.
generate byte vs_val_eoivcu=4
quietly count if !missing(val_eoivcu)
local obs=r(N)
quietly count if val_eoivcu==0
local zeros=r(N)
quietly count if inlist(vs_val_eoivcu,5,6,8)
local bad=r(N)
quietly count if vs_val_eoivcu==4
local absent=r(N)
post cell (2019) ("val_eoivcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_eoivcu vs_val_eoivcu
isid source_year source_row
save "$VYD/N_G0_val_eoivcu_2019.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_eoivcu_2019"
log close vycell
