* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_costrd_2015: annual staged raw state -> val_costrd at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_costrd_2015.log", text replace name(vycell)
generate double val_costrd=.
generate byte vs_val_costrd=4
quietly count if !missing(val_costrd)
local obs=r(N)
quietly count if val_costrd==0
local zeros=r(N)
quietly count if inlist(vs_val_costrd,5,6,8)
local bad=r(N)
quietly count if vs_val_costrd==4
local absent=r(N)
post cell (2015) ("val_costrd") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_costrd vs_val_costrd
isid source_year source_row
save "$VYD/N_G0_val_costrd_2015.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_costrd_2015"
log close vycell
