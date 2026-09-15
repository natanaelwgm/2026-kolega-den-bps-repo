* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_sfkvcu_2020: annual staged raw state -> val_sfkvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_sfkvcu_2020.log", text replace name(vycell)
generate double val_sfkvcu=.
generate byte vs_val_sfkvcu=3
replace val_sfkvcu=real(subinstr(strtrim(raw_sfkvcu20),",","",.))*1
replace vs_val_sfkvcu=5 if missing(real(subinstr(strtrim(raw_sfkvcu20),",","",.))) & !inlist(upper(strtrim(raw_sfkvcu20)),"","***",".","NA","N/A","NULL","-")
replace vs_val_sfkvcu=cond(val_sfkvcu<0,2,cond(val_sfkvcu==0,1,0)) if !missing(val_sfkvcu)
quietly count if !missing(val_sfkvcu)
local obs=r(N)
quietly count if val_sfkvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_sfkvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_sfkvcu==4
local absent=r(N)
post cell (2020) ("val_sfkvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_sfkvcu vs_val_sfkvcu raw_sfkvcu20
isid source_year source_row
save "$VYD/N_G0_val_sfkvcu_2020.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_sfkvcu_2020"
log close vycell
