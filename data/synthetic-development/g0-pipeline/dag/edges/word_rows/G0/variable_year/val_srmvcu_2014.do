* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_srmvcu_2014: annual staged raw state -> val_srmvcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2014 row 132; srmvcu14 | stock raw matrl,etc end-bgn yr,000 rp
log using "$VYL/N_G0_val_srmvcu_2014.log", text replace name(vycell)
generate double val_srmvcu=.
generate byte vs_val_srmvcu=3
replace val_srmvcu=real(subinstr(strtrim(raw_srmvcu14),",","",.))*1
replace vs_val_srmvcu=5 if missing(real(subinstr(strtrim(raw_srmvcu14),",","",.))) & !inlist(upper(strtrim(raw_srmvcu14)),"","***",".","NA","N/A","NULL","-")
replace vs_val_srmvcu=cond(val_srmvcu<0,2,cond(val_srmvcu==0,1,0)) if !missing(val_srmvcu)
quietly count if !missing(val_srmvcu)
local obs=r(N)
quietly count if val_srmvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_srmvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_srmvcu==4
local absent=r(N)
post cell (2014) ("val_srmvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_srmvcu vs_val_srmvcu raw_srmvcu14
isid source_year source_row
save "$VYD/N_G0_val_srmvcu_2014.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_srmvcu_2014"
log close vycell
