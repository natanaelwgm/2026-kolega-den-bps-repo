* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_vtlvcu_2020: annual staged raw state -> val_vtlvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_vtlvcu_2020.log", text replace name(vycell)
generate double val_vtlvcu=.
generate byte vs_val_vtlvcu=3
replace val_vtlvcu=real(subinstr(strtrim(raw_vtlvcu20),",","",.))*1
replace vs_val_vtlvcu=5 if missing(real(subinstr(strtrim(raw_vtlvcu20),",","",.))) & !inlist(upper(strtrim(raw_vtlvcu20)),"","***",".","NA","N/A","NULL","-")
replace vs_val_vtlvcu=cond(val_vtlvcu<0,2,cond(val_vtlvcu==0,1,0)) if !missing(val_vtlvcu)
quietly count if !missing(val_vtlvcu)
local obs=r(N)
quietly count if val_vtlvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_vtlvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_vtlvcu==4
local absent=r(N)
post cell (2020) ("val_vtlvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_vtlvcu vs_val_vtlvcu raw_vtlvcu20
isid source_year source_row
save "$VYD/N_G0_val_vtlvcu_2020.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_vtlvcu_2020"
log close vycell
