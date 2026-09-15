* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_stlvcu_2018: annual staged raw state -> val_stlvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_stlvcu_2018.log", text replace name(vycell)
generate double val_stlvcu=.
generate byte vs_val_stlvcu=3
replace val_stlvcu=real(subinstr(strtrim(raw_stlvcu18),",","",.))*1
replace vs_val_stlvcu=5 if missing(real(subinstr(strtrim(raw_stlvcu18),",","",.))) & !inlist(upper(strtrim(raw_stlvcu18)),"","***",".","NA","N/A","NULL","-")
replace vs_val_stlvcu=cond(val_stlvcu<0,2,cond(val_stlvcu==0,1,0)) if !missing(val_stlvcu)
quietly count if !missing(val_stlvcu)
local obs=r(N)
quietly count if val_stlvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_stlvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_stlvcu==4
local absent=r(N)
post cell (2018) ("val_stlvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_stlvcu vs_val_stlvcu raw_stlvcu18
isid source_year source_row
save "$VYD/N_G0_val_stlvcu_2018.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_stlvcu_2018"
log close vycell
