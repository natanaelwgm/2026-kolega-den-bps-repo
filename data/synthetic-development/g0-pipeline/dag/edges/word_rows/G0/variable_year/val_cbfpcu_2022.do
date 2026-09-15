* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_cbfpcu_2022: annual staged raw state -> val_cbfpcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_cbfpcu_2022.log", text replace name(vycell)
generate double val_cbfpcu=.
generate byte vs_val_cbfpcu=3
replace val_cbfpcu=real(subinstr(strtrim(raw_cbfpcu22),",","",.))*1
replace vs_val_cbfpcu=5 if missing(real(subinstr(strtrim(raw_cbfpcu22),",","",.))) & !inlist(upper(strtrim(raw_cbfpcu22)),"","***",".","NA","N/A","NULL","-")
replace vs_val_cbfpcu=cond(val_cbfpcu<0,2,cond(val_cbfpcu==0,1,0)) if !missing(val_cbfpcu)
quietly count if !missing(val_cbfpcu)
local obs=r(N)
quietly count if val_cbfpcu==0
local zeros=r(N)
quietly count if inlist(vs_val_cbfpcu,5,6,8)
local bad=r(N)
quietly count if vs_val_cbfpcu==4
local absent=r(N)
post cell (2022) ("val_cbfpcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_cbfpcu vs_val_cbfpcu raw_cbfpcu22
isid source_year source_row
save "$VYD/N_G0_val_cbfpcu_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_cbfpcu_2022"
log close vycell
