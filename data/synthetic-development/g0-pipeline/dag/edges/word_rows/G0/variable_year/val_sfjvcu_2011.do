* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_sfjvcu_2011: annual staged raw state -> val_sfjvcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2011 row 99; sfjvcu11 | stock finish prod begin of year,000 rp
log using "$VYL/N_G0_val_sfjvcu_2011.log", text replace name(vycell)
generate double val_sfjvcu=.
generate byte vs_val_sfjvcu=3
replace val_sfjvcu=real(subinstr(strtrim(raw_sfjvcu11),",","",.))*1
replace vs_val_sfjvcu=5 if missing(real(subinstr(strtrim(raw_sfjvcu11),",","",.))) & !inlist(upper(strtrim(raw_sfjvcu11)),"","***",".","NA","N/A","NULL","-")
replace vs_val_sfjvcu=cond(val_sfjvcu<0,2,cond(val_sfjvcu==0,1,0)) if !missing(val_sfjvcu)
quietly count if !missing(val_sfjvcu)
local obs=r(N)
quietly count if val_sfjvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_sfjvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_sfjvcu==4
local absent=r(N)
post cell (2011) ("val_sfjvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_sfjvcu vs_val_sfjvcu raw_sfjvcu11
isid source_year source_row
save "$VYD/N_G0_val_sfjvcu_2011.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_sfjvcu_2011"
log close vycell
