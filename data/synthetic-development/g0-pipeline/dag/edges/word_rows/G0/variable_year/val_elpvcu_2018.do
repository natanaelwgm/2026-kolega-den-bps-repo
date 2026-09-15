* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_elpvcu_2018: annual staged raw state -> val_elpvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_elpvcu_2018.log", text replace name(vycell)
generate double val_elpvcu=.
generate byte vs_val_elpvcu=3
replace val_elpvcu=real(subinstr(strtrim(raw_elpvcu18),",","",.))*1
replace vs_val_elpvcu=5 if missing(real(subinstr(strtrim(raw_elpvcu18),",","",.))) & !inlist(upper(strtrim(raw_elpvcu18)),"","***",".","NA","N/A","NULL","-")
replace vs_val_elpvcu=cond(val_elpvcu<0,2,cond(val_elpvcu==0,1,0)) if !missing(val_elpvcu)
quietly count if !missing(val_elpvcu)
local obs=r(N)
quietly count if val_elpvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_elpvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_elpvcu==4
local absent=r(N)
post cell (2018) ("val_elpvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_elpvcu vs_val_elpvcu raw_elpvcu18
isid source_year source_row
save "$VYD/N_G0_val_elpvcu_2018.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_elpvcu_2018"
log close vycell
