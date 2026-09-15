* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_zpevcu_2019: annual staged raw state -> val_zpevcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_zpevcu_2019.log", text replace name(vycell)
generate double val_zpevcu=.
generate byte vs_val_zpevcu=3
replace val_zpevcu=real(subinstr(strtrim(raw_zpevcu19),",","",.))*1
replace vs_val_zpevcu=5 if missing(real(subinstr(strtrim(raw_zpevcu19),",","",.))) & !inlist(upper(strtrim(raw_zpevcu19)),"","***",".","NA","N/A","NULL","-")
replace vs_val_zpevcu=cond(val_zpevcu<0,2,cond(val_zpevcu==0,1,0)) if !missing(val_zpevcu)
quietly count if !missing(val_zpevcu)
local obs=r(N)
quietly count if val_zpevcu==0
local zeros=r(N)
quietly count if inlist(vs_val_zpevcu,5,6,8)
local bad=r(N)
quietly count if vs_val_zpevcu==4
local absent=r(N)
post cell (2019) ("val_zpevcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_zpevcu vs_val_zpevcu raw_zpevcu19
isid source_year source_row
save "$VYD/N_G0_val_zpevcu_2019.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_zpevcu_2019"
log close vycell
