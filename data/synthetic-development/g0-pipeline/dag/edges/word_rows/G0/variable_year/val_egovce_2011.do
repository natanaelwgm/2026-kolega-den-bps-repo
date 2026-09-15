* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_egovce_2011: annual staged raw state -> val_egovce at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_egovce_2011.log", text replace name(vycell)
generate double val_egovce=.
generate byte vs_val_egovce=4
quietly count if !missing(val_egovce)
local obs=r(N)
quietly count if val_egovce==0
local zeros=r(N)
quietly count if inlist(vs_val_egovce,5,6,8)
local bad=r(N)
quietly count if vs_val_egovce==4
local absent=r(N)
post cell (2011) ("val_egovce") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_egovce vs_val_egovce
isid source_year source_row
save "$VYD/N_G0_val_egovce_2011.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_egovce_2011"
log close vycell
