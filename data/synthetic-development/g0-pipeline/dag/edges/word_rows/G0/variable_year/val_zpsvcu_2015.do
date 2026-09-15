* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_zpsvcu_2015: annual staged raw state -> val_zpsvcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2015 row 29; zpsvcu15 | wage/salary prod workers, 000rp
log using "$VYL/N_G0_val_zpsvcu_2015.log", text replace name(vycell)
generate double val_zpsvcu=.
generate byte vs_val_zpsvcu=3
replace val_zpsvcu=real(subinstr(strtrim(raw_zpsvcu),",","",.))*1
replace vs_val_zpsvcu=5 if missing(real(subinstr(strtrim(raw_zpsvcu),",","",.))) & !inlist(upper(strtrim(raw_zpsvcu)),"","***",".","NA","N/A","NULL","-")
replace vs_val_zpsvcu=cond(val_zpsvcu<0,2,cond(val_zpsvcu==0,1,0)) if !missing(val_zpsvcu)
quietly count if !missing(val_zpsvcu)
local obs=r(N)
quietly count if val_zpsvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_zpsvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_zpsvcu==4
local absent=r(N)
post cell (2015) ("val_zpsvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_zpsvcu vs_val_zpsvcu raw_zpsvcu
isid source_year source_row
save "$VYD/N_G0_val_zpsvcu_2015.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_zpsvcu_2015"
log close vycell
