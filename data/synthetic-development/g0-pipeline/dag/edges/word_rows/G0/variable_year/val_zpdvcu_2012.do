* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_zpdvcu_2012: annual staged raw state -> val_zpdvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_zpdvcu_2012.log", text replace name(vycell)
generate double val_zpdvcu=.
generate byte vs_val_zpdvcu=3
replace val_zpdvcu=real(subinstr(strtrim(raw_zpdvcu12),",","",.))*1
replace vs_val_zpdvcu=5 if missing(real(subinstr(strtrim(raw_zpdvcu12),",","",.))) & !inlist(upper(strtrim(raw_zpdvcu12)),"","***",".","NA","N/A","NULL","-")
replace vs_val_zpdvcu=cond(val_zpdvcu<0,2,cond(val_zpdvcu==0,1,0)) if !missing(val_zpdvcu)
quietly count if !missing(val_zpdvcu)
local obs=r(N)
quietly count if val_zpdvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_zpdvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_zpdvcu==4
local absent=r(N)
post cell (2012) ("val_zpdvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_zpdvcu vs_val_zpdvcu raw_zpdvcu12
isid source_year source_row
save "$VYD/N_G0_val_zpdvcu_2012.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_zpdvcu_2012"
log close vycell
