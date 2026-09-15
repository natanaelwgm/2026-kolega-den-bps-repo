* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_zpovcu_2017: annual staged raw state -> val_zpovcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_zpovcu_2017.log", text replace name(vycell)
generate double val_zpovcu=.
generate byte vs_val_zpovcu=3
replace val_zpovcu=real(subinstr(strtrim(raw_zpovcu17),",","",.))*1
replace vs_val_zpovcu=5 if missing(real(subinstr(strtrim(raw_zpovcu17),",","",.))) & !inlist(upper(strtrim(raw_zpovcu17)),"","***",".","NA","N/A","NULL","-")
replace vs_val_zpovcu=cond(val_zpovcu<0,2,cond(val_zpovcu==0,1,0)) if !missing(val_zpovcu)
quietly count if !missing(val_zpovcu)
local obs=r(N)
quietly count if val_zpovcu==0
local zeros=r(N)
quietly count if inlist(vs_val_zpovcu,5,6,8)
local bad=r(N)
quietly count if vs_val_zpovcu==4
local absent=r(N)
post cell (2017) ("val_zpovcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_zpovcu vs_val_zpovcu raw_zpovcu17
isid source_year source_row
save "$VYD/N_G0_val_zpovcu_2017.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_zpovcu_2017"
log close vycell
