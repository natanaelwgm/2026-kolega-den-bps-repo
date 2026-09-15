* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_encvcu_2015: annual staged raw state -> val_encvcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2015 row 73; encvcu15 | total other fuel used, 000 rp
log using "$VYL/N_G0_val_encvcu_2015.log", text replace name(vycell)
generate double val_encvcu=.
generate byte vs_val_encvcu=3
replace val_encvcu=real(subinstr(strtrim(raw_encvcu),",","",.))*1
replace vs_val_encvcu=5 if missing(real(subinstr(strtrim(raw_encvcu),",","",.))) & !inlist(upper(strtrim(raw_encvcu)),"","***",".","NA","N/A","NULL","-")
replace vs_val_encvcu=cond(val_encvcu<0,2,cond(val_encvcu==0,1,0)) if !missing(val_encvcu)
quietly count if !missing(val_encvcu)
local obs=r(N)
quietly count if val_encvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_encvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_encvcu==4
local absent=r(N)
post cell (2015) ("val_encvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_encvcu vs_val_encvcu raw_encvcu
isid source_year source_row
save "$VYD/N_G0_val_encvcu_2015.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_encvcu_2015"
log close vycell
