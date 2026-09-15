* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_ipkvcu_2022: annual staged raw state -> val_ipkvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_ipkvcu_2022.log", text replace name(vycell)
generate double val_ipkvcu=.
generate byte vs_val_ipkvcu=3
replace val_ipkvcu=real(subinstr(strtrim(raw_ipkvcu22),",","",.))*1
replace vs_val_ipkvcu=5 if missing(real(subinstr(strtrim(raw_ipkvcu22),",","",.))) & !inlist(upper(strtrim(raw_ipkvcu22)),"","***",".","NA","N/A","NULL","-")
replace vs_val_ipkvcu=cond(val_ipkvcu<0,2,cond(val_ipkvcu==0,1,0)) if !missing(val_ipkvcu)
quietly count if !missing(val_ipkvcu)
local obs=r(N)
quietly count if val_ipkvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_ipkvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_ipkvcu==4
local absent=r(N)
post cell (2022) ("val_ipkvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_ipkvcu vs_val_ipkvcu raw_ipkvcu22
isid source_year source_row
save "$VYD/N_G0_val_ipkvcu_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_ipkvcu_2022"
log close vycell
