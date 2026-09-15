* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_shjvcu_2010: annual staged raw state -> val_shjvcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2010 row 96; shjvcu10 | stock semi finish prod bgn of yr,000 rp
log using "$VYL/N_G0_val_shjvcu_2010.log", text replace name(vycell)
generate double val_shjvcu=.
generate byte vs_val_shjvcu=3
replace val_shjvcu=real(subinstr(strtrim(raw_shjvcu10),",","",.))*1
replace vs_val_shjvcu=5 if missing(real(subinstr(strtrim(raw_shjvcu10),",","",.))) & !inlist(upper(strtrim(raw_shjvcu10)),"","***",".","NA","N/A","NULL","-")
replace vs_val_shjvcu=cond(val_shjvcu<0,2,cond(val_shjvcu==0,1,0)) if !missing(val_shjvcu)
quietly count if !missing(val_shjvcu)
local obs=r(N)
quietly count if val_shjvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_shjvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_shjvcu==4
local absent=r(N)
post cell (2010) ("val_shjvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_shjvcu vs_val_shjvcu raw_shjvcu10
isid source_year source_row
save "$VYD/N_G0_val_shjvcu_2010.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_shjvcu_2010"
log close vycell
