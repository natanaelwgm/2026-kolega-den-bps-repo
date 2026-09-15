* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_cssacu_2013: annual staged raw state -> val_cssacu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_cssacu_2013.log", text replace name(vycell)
generate double val_cssacu=.
generate byte vs_val_cssacu=4
quietly count if !missing(val_cssacu)
local obs=r(N)
quietly count if val_cssacu==0
local zeros=r(N)
quietly count if inlist(vs_val_cssacu,5,6,8)
local bad=r(N)
quietly count if vs_val_cssacu==4
local absent=r(N)
post cell (2013) ("val_cssacu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_cssacu vs_val_cssacu
isid source_year source_row
save "$VYD/N_G0_val_cssacu_2013.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_cssacu_2013"
log close vycell
