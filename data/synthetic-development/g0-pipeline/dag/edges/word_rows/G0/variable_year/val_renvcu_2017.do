* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_renvcu_2017: annual staged raw state -> val_renvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_renvcu_2017.log", text replace name(vycell)
generate double val_renvcu=.
generate byte vs_val_renvcu=3
replace val_renvcu=real(subinstr(strtrim(raw_renvcu17),",","",.))*1
replace vs_val_renvcu=5 if missing(real(subinstr(strtrim(raw_renvcu17),",","",.))) & !inlist(upper(strtrim(raw_renvcu17)),"","***",".","NA","N/A","NULL","-")
replace vs_val_renvcu=cond(val_renvcu<0,2,cond(val_renvcu==0,1,0)) if !missing(val_renvcu)
quietly count if !missing(val_renvcu)
local obs=r(N)
quietly count if val_renvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_renvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_renvcu==4
local absent=r(N)
post cell (2017) ("val_renvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_renvcu vs_val_renvcu raw_renvcu17
isid source_year source_row
save "$VYD/N_G0_val_renvcu_2017.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_renvcu_2017"
log close vycell
