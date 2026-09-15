* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_stjvcu_2015: annual staged raw state -> val_stjvcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2015 row 117; stjvcu15 | stock at beginning of year, 000rp
log using "$VYL/N_G0_val_stjvcu_2015.log", text replace name(vycell)
generate double val_stjvcu=.
generate byte vs_val_stjvcu=3
replace val_stjvcu=real(subinstr(strtrim(raw_stjvcu),",","",.))*1
replace vs_val_stjvcu=5 if missing(real(subinstr(strtrim(raw_stjvcu),",","",.))) & !inlist(upper(strtrim(raw_stjvcu)),"","***",".","NA","N/A","NULL","-")
replace vs_val_stjvcu=cond(val_stjvcu<0,2,cond(val_stjvcu==0,1,0)) if !missing(val_stjvcu)
quietly count if !missing(val_stjvcu)
local obs=r(N)
quietly count if val_stjvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_stjvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_stjvcu==4
local absent=r(N)
post cell (2015) ("val_stjvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_stjvcu vs_val_stjvcu raw_stjvcu
isid source_year source_row
save "$VYD/N_G0_val_stjvcu_2015.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_stjvcu_2015"
log close vycell
