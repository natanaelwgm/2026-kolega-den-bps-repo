* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_csdacu_2018: annual staged raw state -> val_csdacu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_csdacu_2018.log", text replace name(vycell)
generate double val_csdacu=.
generate byte vs_val_csdacu=4
quietly count if !missing(val_csdacu)
local obs=r(N)
quietly count if val_csdacu==0
local zeros=r(N)
quietly count if inlist(vs_val_csdacu,5,6,8)
local bad=r(N)
quietly count if vs_val_csdacu==4
local absent=r(N)
post cell (2018) ("val_csdacu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_csdacu vs_val_csdacu
isid source_year source_row
save "$VYD/N_G0_val_csdacu_2018.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_csdacu_2018"
log close vycell
