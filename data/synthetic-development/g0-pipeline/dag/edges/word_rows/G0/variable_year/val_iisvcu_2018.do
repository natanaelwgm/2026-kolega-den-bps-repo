* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_iisvcu_2018: annual staged raw state -> val_iisvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_iisvcu_2018.log", text replace name(vycell)
generate double val_iisvcu=.
generate byte vs_val_iisvcu=3
replace val_iisvcu=real(subinstr(strtrim(raw_iisvcu18),",","",.))*1
replace vs_val_iisvcu=5 if missing(real(subinstr(strtrim(raw_iisvcu18),",","",.))) & !inlist(upper(strtrim(raw_iisvcu18)),"","***",".","NA","N/A","NULL","-")
replace vs_val_iisvcu=cond(val_iisvcu<0,2,cond(val_iisvcu==0,1,0)) if !missing(val_iisvcu)
quietly count if !missing(val_iisvcu)
local obs=r(N)
quietly count if val_iisvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_iisvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_iisvcu==4
local absent=r(N)
post cell (2018) ("val_iisvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_iisvcu vs_val_iisvcu raw_iisvcu18
isid source_year source_row
save "$VYD/N_G0_val_iisvcu_2018.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_iisvcu_2018"
log close vycell
