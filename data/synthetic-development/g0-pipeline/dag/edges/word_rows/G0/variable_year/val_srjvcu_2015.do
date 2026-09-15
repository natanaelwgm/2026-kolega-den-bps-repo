* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_srjvcu_2015: annual staged raw state -> val_srjvcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2015 row 108; srjvcu15 | stock raw matrl,etc begin yr, 000 rp
log using "$VYL/N_G0_val_srjvcu_2015.log", text replace name(vycell)
generate double val_srjvcu=.
generate byte vs_val_srjvcu=3
replace val_srjvcu=real(subinstr(strtrim(raw_srjvcu),",","",.))*1
replace vs_val_srjvcu=5 if missing(real(subinstr(strtrim(raw_srjvcu),",","",.))) & !inlist(upper(strtrim(raw_srjvcu)),"","***",".","NA","N/A","NULL","-")
replace vs_val_srjvcu=cond(val_srjvcu<0,2,cond(val_srjvcu==0,1,0)) if !missing(val_srjvcu)
quietly count if !missing(val_srjvcu)
local obs=r(N)
quietly count if val_srjvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_srjvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_srjvcu==4
local absent=r(N)
post cell (2015) ("val_srjvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_srjvcu vs_val_srjvcu raw_srjvcu
isid source_year source_row
save "$VYD/N_G0_val_srjvcu_2015.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_srjvcu_2015"
log close vycell
