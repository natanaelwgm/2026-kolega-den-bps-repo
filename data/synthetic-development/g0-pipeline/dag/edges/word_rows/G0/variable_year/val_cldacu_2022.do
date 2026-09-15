* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_cldacu_2022: annual staged raw state -> val_cldacu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_cldacu_2022.log", text replace name(vycell)
generate double val_cldacu=.
generate byte vs_val_cldacu=4
quietly count if !missing(val_cldacu)
local obs=r(N)
quietly count if val_cldacu==0
local zeros=r(N)
quietly count if inlist(vs_val_cldacu,5,6,8)
local bad=r(N)
quietly count if vs_val_cldacu==4
local absent=r(N)
post cell (2022) ("val_cldacu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_cldacu vs_val_cldacu
isid source_year source_row
save "$VYD/N_G0_val_cldacu_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_cldacu_2022"
log close vycell
