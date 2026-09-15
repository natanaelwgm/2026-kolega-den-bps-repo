* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_stlvcu_2012: annual staged raw state -> val_stlvcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2012 row 99; stlvcu12 | stock end-beginning of year, 000rp
log using "$VYL/N_G0_val_stlvcu_2012.log", text replace name(vycell)
generate double val_stlvcu=.
generate byte vs_val_stlvcu=3
replace val_stlvcu=real(subinstr(strtrim(raw_stlvcu12),",","",.))*1
replace vs_val_stlvcu=5 if missing(real(subinstr(strtrim(raw_stlvcu12),",","",.))) & !inlist(upper(strtrim(raw_stlvcu12)),"","***",".","NA","N/A","NULL","-")
replace vs_val_stlvcu=cond(val_stlvcu<0,2,cond(val_stlvcu==0,1,0)) if !missing(val_stlvcu)
quietly count if !missing(val_stlvcu)
local obs=r(N)
quietly count if val_stlvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_stlvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_stlvcu==4
local absent=r(N)
post cell (2012) ("val_stlvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_stlvcu vs_val_stlvcu raw_stlvcu12
isid source_year source_row
save "$VYD/N_G0_val_stlvcu_2012.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_stlvcu_2012"
log close vycell
