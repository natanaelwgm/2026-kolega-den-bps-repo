* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_znpvcu_2019: annual staged raw state -> val_znpvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_znpvcu_2019.log", text replace name(vycell)
generate double val_znpvcu=.
generate byte vs_val_znpvcu=4
quietly count if !missing(val_znpvcu)
local obs=r(N)
quietly count if val_znpvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_znpvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_znpvcu==4
local absent=r(N)
post cell (2019) ("val_znpvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_znpvcu vs_val_znpvcu
isid source_year source_row
save "$VYD/N_G0_val_znpvcu_2019.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_znpvcu_2019"
log close vycell
