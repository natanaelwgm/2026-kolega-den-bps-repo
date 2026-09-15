* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_edivcu_2011: annual staged raw state -> val_edivcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_edivcu_2011.log", text replace name(vycell)
generate double val_edivcu=.
generate byte vs_val_edivcu=4
quietly count if !missing(val_edivcu)
local obs=r(N)
quietly count if val_edivcu==0
local zeros=r(N)
quietly count if inlist(vs_val_edivcu,5,6,8)
local bad=r(N)
quietly count if vs_val_edivcu==4
local absent=r(N)
post cell (2011) ("val_edivcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_edivcu vs_val_edivcu
isid source_year source_row
save "$VYD/N_G0_val_edivcu_2011.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_edivcu_2011"
log close vycell
