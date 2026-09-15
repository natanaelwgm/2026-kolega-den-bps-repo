* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_shfvcu_2013: annual staged raw state -> val_shfvcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2013 row 115; shfvcu13 | stock sm finish prod end-bgn ofyr,000 rp
log using "$VYL/N_G0_val_shfvcu_2013.log", text replace name(vycell)
generate double val_shfvcu=.
generate byte vs_val_shfvcu=3
replace val_shfvcu=real(subinstr(strtrim(raw_shfvcu13),",","",.))*1
replace vs_val_shfvcu=5 if missing(real(subinstr(strtrim(raw_shfvcu13),",","",.))) & !inlist(upper(strtrim(raw_shfvcu13)),"","***",".","NA","N/A","NULL","-")
replace vs_val_shfvcu=cond(val_shfvcu<0,2,cond(val_shfvcu==0,1,0)) if !missing(val_shfvcu)
quietly count if !missing(val_shfvcu)
local obs=r(N)
quietly count if val_shfvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_shfvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_shfvcu==4
local absent=r(N)
post cell (2013) ("val_shfvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_shfvcu vs_val_shfvcu raw_shfvcu13
isid source_year source_row
save "$VYD/N_G0_val_shfvcu_2013.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_shfvcu_2013"
log close vycell
