* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_edivcu_2021: annual staged raw state -> val_edivcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_edivcu_2021.log", text replace name(vycell)
generate double val_edivcu=.
generate byte vs_val_edivcu=3
replace val_edivcu=real(subinstr(strtrim(raw_edivcu21),",","",.))*1
replace vs_val_edivcu=5 if missing(real(subinstr(strtrim(raw_edivcu21),",","",.))) & !inlist(upper(strtrim(raw_edivcu21)),"","***",".","NA","N/A","NULL","-")
replace vs_val_edivcu=cond(val_edivcu<0,2,cond(val_edivcu==0,1,0)) if !missing(val_edivcu)
quietly count if !missing(val_edivcu)
local obs=r(N)
quietly count if val_edivcu==0
local zeros=r(N)
quietly count if inlist(vs_val_edivcu,5,6,8)
local bad=r(N)
quietly count if vs_val_edivcu==4
local absent=r(N)
post cell (2021) ("val_edivcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_edivcu vs_val_edivcu raw_edivcu21
isid source_year source_row
save "$VYD/N_G0_val_edivcu_2021.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_edivcu_2021"
log close vycell
