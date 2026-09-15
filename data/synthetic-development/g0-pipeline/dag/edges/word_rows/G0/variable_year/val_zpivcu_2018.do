* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_zpivcu_2018: annual staged raw state -> val_zpivcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_zpivcu_2018.log", text replace name(vycell)
generate double val_zpivcu=.
generate byte vs_val_zpivcu=3
replace val_zpivcu=real(subinstr(strtrim(raw_zpivcu18),",","",.))*1
replace vs_val_zpivcu=5 if missing(real(subinstr(strtrim(raw_zpivcu18),",","",.))) & !inlist(upper(strtrim(raw_zpivcu18)),"","***",".","NA","N/A","NULL","-")
replace vs_val_zpivcu=cond(val_zpivcu<0,2,cond(val_zpivcu==0,1,0)) if !missing(val_zpivcu)
quietly count if !missing(val_zpivcu)
local obs=r(N)
quietly count if val_zpivcu==0
local zeros=r(N)
quietly count if inlist(vs_val_zpivcu,5,6,8)
local bad=r(N)
quietly count if vs_val_zpivcu==4
local absent=r(N)
post cell (2018) ("val_zpivcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_zpivcu vs_val_zpivcu raw_zpivcu18
isid source_year source_row
save "$VYD/N_G0_val_zpivcu_2018.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_zpivcu_2018"
log close vycell
