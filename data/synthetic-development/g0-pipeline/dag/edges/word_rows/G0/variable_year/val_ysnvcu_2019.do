* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_ysnvcu_2019: annual staged raw state -> val_ysnvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_ysnvcu_2019.log", text replace name(vycell)
generate double val_ysnvcu=.
generate byte vs_val_ysnvcu=3
replace val_ysnvcu=real(subinstr(strtrim(raw_ysnvcu19),",","",.))*1
replace vs_val_ysnvcu=5 if missing(real(subinstr(strtrim(raw_ysnvcu19),",","",.))) & !inlist(upper(strtrim(raw_ysnvcu19)),"","***",".","NA","N/A","NULL","-")
replace vs_val_ysnvcu=cond(val_ysnvcu<0,2,cond(val_ysnvcu==0,1,0)) if !missing(val_ysnvcu)
quietly count if !missing(val_ysnvcu)
local obs=r(N)
quietly count if val_ysnvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_ysnvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_ysnvcu==4
local absent=r(N)
post cell (2019) ("val_ysnvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_ysnvcu vs_val_ysnvcu raw_ysnvcu19
isid source_year source_row
save "$VYD/N_G0_val_ysnvcu_2019.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_ysnvcu_2019"
log close vycell
