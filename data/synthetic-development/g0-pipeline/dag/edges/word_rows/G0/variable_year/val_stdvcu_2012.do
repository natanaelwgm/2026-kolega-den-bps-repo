* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_stdvcu_2012: annual staged raw state -> val_stdvcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2012 row 98; stdvcu12 | stock at end of year, 000 rp
log using "$VYL/N_G0_val_stdvcu_2012.log", text replace name(vycell)
generate double val_stdvcu=.
generate byte vs_val_stdvcu=3
replace val_stdvcu=real(subinstr(strtrim(raw_stdvcu12),",","",.))*1
replace vs_val_stdvcu=5 if missing(real(subinstr(strtrim(raw_stdvcu12),",","",.))) & !inlist(upper(strtrim(raw_stdvcu12)),"","***",".","NA","N/A","NULL","-")
replace vs_val_stdvcu=cond(val_stdvcu<0,2,cond(val_stdvcu==0,1,0)) if !missing(val_stdvcu)
quietly count if !missing(val_stdvcu)
local obs=r(N)
quietly count if val_stdvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_stdvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_stdvcu==4
local absent=r(N)
post cell (2012) ("val_stdvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_stdvcu vs_val_stdvcu raw_stdvcu12
isid source_year source_row
save "$VYD/N_G0_val_stdvcu_2012.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_stdvcu_2012"
log close vycell
