* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_shdvcu_2014: annual staged raw state -> val_shdvcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2014 row 130; shdvcu14 | stock semi finish prod end of yr,000 rp
log using "$VYL/N_G0_val_shdvcu_2014.log", text replace name(vycell)
generate double val_shdvcu=.
generate byte vs_val_shdvcu=3
replace val_shdvcu=real(subinstr(strtrim(raw_shdvcu14),",","",.))*1
replace vs_val_shdvcu=5 if missing(real(subinstr(strtrim(raw_shdvcu14),",","",.))) & !inlist(upper(strtrim(raw_shdvcu14)),"","***",".","NA","N/A","NULL","-")
replace vs_val_shdvcu=cond(val_shdvcu<0,2,cond(val_shdvcu==0,1,0)) if !missing(val_shdvcu)
quietly count if !missing(val_shdvcu)
local obs=r(N)
quietly count if val_shdvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_shdvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_shdvcu==4
local absent=r(N)
post cell (2014) ("val_shdvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_shdvcu vs_val_shdvcu raw_shdvcu14
isid source_year source_row
save "$VYD/N_G0_val_shdvcu_2014.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_shdvcu_2014"
log close vycell
