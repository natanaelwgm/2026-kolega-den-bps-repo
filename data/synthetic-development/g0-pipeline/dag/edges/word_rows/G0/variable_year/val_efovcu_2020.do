* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_efovcu_2020: annual staged raw state -> val_efovcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_efovcu_2020.log", text replace name(vycell)
generate double val_efovcu=.
generate byte vs_val_efovcu=3
replace val_efovcu=real(subinstr(strtrim(raw_efovcu20),",","",.))*1
replace vs_val_efovcu=5 if missing(real(subinstr(strtrim(raw_efovcu20),",","",.))) & !inlist(upper(strtrim(raw_efovcu20)),"","***",".","NA","N/A","NULL","-")
replace vs_val_efovcu=cond(val_efovcu<0,2,cond(val_efovcu==0,1,0)) if !missing(val_efovcu)
quietly count if !missing(val_efovcu)
local obs=r(N)
quietly count if val_efovcu==0
local zeros=r(N)
quietly count if inlist(vs_val_efovcu,5,6,8)
local bad=r(N)
quietly count if vs_val_efovcu==4
local absent=r(N)
post cell (2020) ("val_efovcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_efovcu vs_val_efovcu raw_efovcu20
isid source_year source_row
save "$VYD/N_G0_val_efovcu_2020.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_efovcu_2020"
log close vycell
