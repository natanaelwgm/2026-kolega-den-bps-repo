* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_zpsvcu_2018: annual staged raw state -> val_zpsvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_zpsvcu_2018.log", text replace name(vycell)
generate double val_zpsvcu=.
generate byte vs_val_zpsvcu=3
replace val_zpsvcu=real(subinstr(strtrim(raw_zpsvcu18),",","",.))*1
replace vs_val_zpsvcu=5 if missing(real(subinstr(strtrim(raw_zpsvcu18),",","",.))) & !inlist(upper(strtrim(raw_zpsvcu18)),"","***",".","NA","N/A","NULL","-")
replace vs_val_zpsvcu=cond(val_zpsvcu<0,2,cond(val_zpsvcu==0,1,0)) if !missing(val_zpsvcu)
quietly count if !missing(val_zpsvcu)
local obs=r(N)
quietly count if val_zpsvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_zpsvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_zpsvcu==4
local absent=r(N)
post cell (2018) ("val_zpsvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_zpsvcu vs_val_zpsvcu raw_zpsvcu18
isid source_year source_row
save "$VYD/N_G0_val_zpsvcu_2018.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_zpsvcu_2018"
log close vycell
