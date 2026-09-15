* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_cmfpcu_2020: annual staged raw state -> val_cmfpcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_cmfpcu_2020.log", text replace name(vycell)
generate double val_cmfpcu=.
generate byte vs_val_cmfpcu=3
replace val_cmfpcu=real(subinstr(strtrim(raw_cmfpcu20),",","",.))*1
replace vs_val_cmfpcu=5 if missing(real(subinstr(strtrim(raw_cmfpcu20),",","",.))) & !inlist(upper(strtrim(raw_cmfpcu20)),"","***",".","NA","N/A","NULL","-")
replace vs_val_cmfpcu=cond(val_cmfpcu<0,2,cond(val_cmfpcu==0,1,0)) if !missing(val_cmfpcu)
quietly count if !missing(val_cmfpcu)
local obs=r(N)
quietly count if val_cmfpcu==0
local zeros=r(N)
quietly count if inlist(vs_val_cmfpcu,5,6,8)
local bad=r(N)
quietly count if vs_val_cmfpcu==4
local absent=r(N)
post cell (2020) ("val_cmfpcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_cmfpcu vs_val_cmfpcu raw_cmfpcu20
isid source_year source_row
save "$VYD/N_G0_val_cmfpcu_2020.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_cmfpcu_2020"
log close vycell
