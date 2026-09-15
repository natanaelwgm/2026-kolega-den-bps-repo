* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_sfjvcu_2022: annual staged raw state -> val_sfjvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_sfjvcu_2022.log", text replace name(vycell)
generate double val_sfjvcu=.
generate byte vs_val_sfjvcu=3
replace val_sfjvcu=real(subinstr(strtrim(raw_sfjvcu22),",","",.))*1
replace vs_val_sfjvcu=5 if missing(real(subinstr(strtrim(raw_sfjvcu22),",","",.))) & !inlist(upper(strtrim(raw_sfjvcu22)),"","***",".","NA","N/A","NULL","-")
replace vs_val_sfjvcu=cond(val_sfjvcu<0,2,cond(val_sfjvcu==0,1,0)) if !missing(val_sfjvcu)
quietly count if !missing(val_sfjvcu)
local obs=r(N)
quietly count if val_sfjvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_sfjvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_sfjvcu==4
local absent=r(N)
post cell (2022) ("val_sfjvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_sfjvcu vs_val_sfjvcu raw_sfjvcu22
isid source_year source_row
save "$VYD/N_G0_val_sfjvcu_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_sfjvcu_2022"
log close vycell
