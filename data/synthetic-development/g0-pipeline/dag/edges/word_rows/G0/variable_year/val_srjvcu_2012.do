* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_srjvcu_2012: annual staged raw state -> val_srjvcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2012 row 88; srjvcu12 | stock raw matrl,etc begin yr, 000 rp
log using "$VYL/N_G0_val_srjvcu_2012.log", text replace name(vycell)
generate double val_srjvcu=.
generate byte vs_val_srjvcu=3
replace val_srjvcu=real(subinstr(strtrim(raw_srjvcu12),",","",.))*1
replace vs_val_srjvcu=5 if missing(real(subinstr(strtrim(raw_srjvcu12),",","",.))) & !inlist(upper(strtrim(raw_srjvcu12)),"","***",".","NA","N/A","NULL","-")
replace vs_val_srjvcu=cond(val_srjvcu<0,2,cond(val_srjvcu==0,1,0)) if !missing(val_srjvcu)
quietly count if !missing(val_srjvcu)
local obs=r(N)
quietly count if val_srjvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_srjvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_srjvcu==4
local absent=r(N)
post cell (2012) ("val_srjvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_srjvcu vs_val_srjvcu raw_srjvcu12
isid source_year source_row
save "$VYD/N_G0_val_srjvcu_2012.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_srjvcu_2012"
log close vycell
