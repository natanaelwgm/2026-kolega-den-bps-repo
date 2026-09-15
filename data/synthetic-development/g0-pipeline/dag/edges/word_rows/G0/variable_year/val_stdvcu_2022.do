* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_stdvcu_2022: annual staged raw state -> val_stdvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_stdvcu_2022.log", text replace name(vycell)
generate double val_stdvcu=.
generate byte vs_val_stdvcu=3
replace val_stdvcu=real(subinstr(strtrim(raw_stdvcu22),",","",.))*1
replace vs_val_stdvcu=5 if missing(real(subinstr(strtrim(raw_stdvcu22),",","",.))) & !inlist(upper(strtrim(raw_stdvcu22)),"","***",".","NA","N/A","NULL","-")
replace vs_val_stdvcu=cond(val_stdvcu<0,2,cond(val_stdvcu==0,1,0)) if !missing(val_stdvcu)
quietly count if !missing(val_stdvcu)
local obs=r(N)
quietly count if val_stdvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_stdvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_stdvcu==4
local absent=r(N)
post cell (2022) ("val_stdvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_stdvcu vs_val_stdvcu raw_stdvcu22
isid source_year source_row
save "$VYD/N_G0_val_stdvcu_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_stdvcu_2022"
log close vycell
