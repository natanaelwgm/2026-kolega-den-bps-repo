* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_clfpcu_2022: annual staged raw state -> val_clfpcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_clfpcu_2022.log", text replace name(vycell)
generate double val_clfpcu=.
generate byte vs_val_clfpcu=3
replace val_clfpcu=real(subinstr(strtrim(raw_clfpcu22),",","",.))*1
replace vs_val_clfpcu=5 if missing(real(subinstr(strtrim(raw_clfpcu22),",","",.))) & !inlist(upper(strtrim(raw_clfpcu22)),"","***",".","NA","N/A","NULL","-")
replace vs_val_clfpcu=cond(val_clfpcu<0,2,cond(val_clfpcu==0,1,0)) if !missing(val_clfpcu)
quietly count if !missing(val_clfpcu)
local obs=r(N)
quietly count if val_clfpcu==0
local zeros=r(N)
quietly count if inlist(vs_val_clfpcu,5,6,8)
local bad=r(N)
quietly count if vs_val_clfpcu==4
local absent=r(N)
post cell (2022) ("val_clfpcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_clfpcu vs_val_clfpcu raw_clfpcu22
isid source_year source_row
save "$VYD/N_G0_val_clfpcu_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_clfpcu_2022"
log close vycell
