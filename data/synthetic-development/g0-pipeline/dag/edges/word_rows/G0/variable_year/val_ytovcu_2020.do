* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_ytovcu_2020: annual staged raw state -> val_ytovcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_ytovcu_2020.log", text replace name(vycell)
generate double val_ytovcu=.
generate byte vs_val_ytovcu=3
replace val_ytovcu=real(subinstr(strtrim(raw_ytovcu20),",","",.))*1
replace vs_val_ytovcu=5 if missing(real(subinstr(strtrim(raw_ytovcu20),",","",.))) & !inlist(upper(strtrim(raw_ytovcu20)),"","***",".","NA","N/A","NULL","-")
replace vs_val_ytovcu=cond(val_ytovcu<0,2,cond(val_ytovcu==0,1,0)) if !missing(val_ytovcu)
quietly count if !missing(val_ytovcu)
local obs=r(N)
quietly count if val_ytovcu==0
local zeros=r(N)
quietly count if inlist(vs_val_ytovcu,5,6,8)
local bad=r(N)
quietly count if vs_val_ytovcu==4
local absent=r(N)
post cell (2020) ("val_ytovcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_ytovcu vs_val_ytovcu raw_ytovcu20
isid source_year source_row
save "$VYD/N_G0_val_ytovcu_2020.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_ytovcu_2020"
log close vycell
