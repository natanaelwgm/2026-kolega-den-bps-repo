* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_esdvce_2012: annual staged raw state -> val_esdvce at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_esdvce_2012.log", text replace name(vycell)
generate double val_esdvce=.
generate byte vs_val_esdvce=4
quietly count if !missing(val_esdvce)
local obs=r(N)
quietly count if val_esdvce==0
local zeros=r(N)
quietly count if inlist(vs_val_esdvce,5,6,8)
local bad=r(N)
quietly count if vs_val_esdvce==4
local absent=r(N)
post cell (2012) ("val_esdvce") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_esdvce vs_val_esdvce
isid source_year source_row
save "$VYD/N_G0_val_esdvce_2012.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_esdvce_2012"
log close vycell
