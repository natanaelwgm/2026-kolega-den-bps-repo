* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_eplvcu_2018: annual staged raw state -> val_eplvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_eplvcu_2018.log", text replace name(vycell)
generate double val_eplvcu=.
generate byte vs_val_eplvcu=3
replace val_eplvcu=real(subinstr(strtrim(raw_eplvcu18),",","",.))*1
replace vs_val_eplvcu=5 if missing(real(subinstr(strtrim(raw_eplvcu18),",","",.))) & !inlist(upper(strtrim(raw_eplvcu18)),"","***",".","NA","N/A","NULL","-")
replace vs_val_eplvcu=cond(val_eplvcu<0,2,cond(val_eplvcu==0,1,0)) if !missing(val_eplvcu)
quietly count if !missing(val_eplvcu)
local obs=r(N)
quietly count if val_eplvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_eplvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_eplvcu==4
local absent=r(N)
post cell (2018) ("val_eplvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_eplvcu vs_val_eplvcu raw_eplvcu18
isid source_year source_row
save "$VYD/N_G0_val_eplvcu_2018.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_eplvcu_2018"
log close vycell
