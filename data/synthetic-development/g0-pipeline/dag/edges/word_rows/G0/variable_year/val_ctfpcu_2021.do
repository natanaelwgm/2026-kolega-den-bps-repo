* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_ctfpcu_2021: annual staged raw state -> val_ctfpcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_ctfpcu_2021.log", text replace name(vycell)
generate double val_ctfpcu=.
generate byte vs_val_ctfpcu=3
replace val_ctfpcu=real(subinstr(strtrim(raw_ctfpcu21),",","",.))*1
replace vs_val_ctfpcu=5 if missing(real(subinstr(strtrim(raw_ctfpcu21),",","",.))) & !inlist(upper(strtrim(raw_ctfpcu21)),"","***",".","NA","N/A","NULL","-")
replace vs_val_ctfpcu=cond(val_ctfpcu<0,2,cond(val_ctfpcu==0,1,0)) if !missing(val_ctfpcu)
quietly count if !missing(val_ctfpcu)
local obs=r(N)
quietly count if val_ctfpcu==0
local zeros=r(N)
quietly count if inlist(vs_val_ctfpcu,5,6,8)
local bad=r(N)
quietly count if vs_val_ctfpcu==4
local absent=r(N)
post cell (2021) ("val_ctfpcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_ctfpcu vs_val_ctfpcu raw_ctfpcu21
isid source_year source_row
save "$VYD/N_G0_val_ctfpcu_2021.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_ctfpcu_2021"
log close vycell
