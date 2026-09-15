* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_sfnvcu_2021: annual staged raw state -> val_sfnvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_sfnvcu_2021.log", text replace name(vycell)
generate double val_sfnvcu=.
generate byte vs_val_sfnvcu=3
replace val_sfnvcu=real(subinstr(strtrim(raw_sfnvcu21),",","",.))*1
replace vs_val_sfnvcu=5 if missing(real(subinstr(strtrim(raw_sfnvcu21),",","",.))) & !inlist(upper(strtrim(raw_sfnvcu21)),"","***",".","NA","N/A","NULL","-")
replace vs_val_sfnvcu=cond(val_sfnvcu<0,2,cond(val_sfnvcu==0,1,0)) if !missing(val_sfnvcu)
quietly count if !missing(val_sfnvcu)
local obs=r(N)
quietly count if val_sfnvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_sfnvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_sfnvcu==4
local absent=r(N)
post cell (2021) ("val_sfnvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_sfnvcu vs_val_sfnvcu raw_sfnvcu21
isid source_year source_row
save "$VYD/N_G0_val_sfnvcu_2021.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_sfnvcu_2021"
log close vycell
