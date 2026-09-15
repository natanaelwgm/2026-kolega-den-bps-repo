* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_iklvcu_2010: annual staged raw state -> val_iklvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_iklvcu_2010.log", text replace name(vycell)
generate double val_iklvcu=.
generate byte vs_val_iklvcu=4
quietly count if !missing(val_iklvcu)
local obs=r(N)
quietly count if val_iklvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_iklvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_iklvcu==4
local absent=r(N)
post cell (2010) ("val_iklvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_iklvcu vs_val_iklvcu
isid source_year source_row
save "$VYD/N_G0_val_iklvcu_2010.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_iklvcu_2010"
log close vycell
