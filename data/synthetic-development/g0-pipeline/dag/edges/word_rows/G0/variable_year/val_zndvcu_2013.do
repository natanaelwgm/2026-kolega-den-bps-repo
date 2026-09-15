* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_zndvcu_2013: annual staged raw state -> val_zndvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_zndvcu_2013.log", text replace name(vycell)
generate double val_zndvcu=.
generate byte vs_val_zndvcu=3
replace val_zndvcu=real(subinstr(strtrim(raw_zndvcu13),",","",.))*1
replace vs_val_zndvcu=5 if missing(real(subinstr(strtrim(raw_zndvcu13),",","",.))) & !inlist(upper(strtrim(raw_zndvcu13)),"","***",".","NA","N/A","NULL","-")
replace vs_val_zndvcu=cond(val_zndvcu<0,2,cond(val_zndvcu==0,1,0)) if !missing(val_zndvcu)
quietly count if !missing(val_zndvcu)
local obs=r(N)
quietly count if val_zndvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_zndvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_zndvcu==4
local absent=r(N)
post cell (2013) ("val_zndvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_zndvcu vs_val_zndvcu raw_zndvcu13
isid source_year source_row
save "$VYD/N_G0_val_zndvcu_2013.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_zndvcu_2013"
log close vycell
