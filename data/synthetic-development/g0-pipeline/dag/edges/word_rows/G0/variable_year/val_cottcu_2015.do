* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_cottcu_2015: annual staged raw state -> val_cottcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2015 row 136; cottcu15 | other fixed capital purchase,000rp
log using "$VYL/N_G0_val_cottcu_2015.log", text replace name(vycell)
generate double val_cottcu=.
generate byte vs_val_cottcu=3
replace val_cottcu=real(subinstr(strtrim(raw_cottcu),",","",.))*1
replace vs_val_cottcu=5 if missing(real(subinstr(strtrim(raw_cottcu),",","",.))) & !inlist(upper(strtrim(raw_cottcu)),"","***",".","NA","N/A","NULL","-")
replace vs_val_cottcu=cond(val_cottcu<0,2,cond(val_cottcu==0,1,0)) if !missing(val_cottcu)
quietly count if !missing(val_cottcu)
local obs=r(N)
quietly count if val_cottcu==0
local zeros=r(N)
quietly count if inlist(vs_val_cottcu,5,6,8)
local bad=r(N)
quietly count if vs_val_cottcu==4
local absent=r(N)
post cell (2015) ("val_cottcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_cottcu vs_val_cottcu raw_cottcu
isid source_year source_row
save "$VYD/N_G0_val_cottcu_2015.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_cottcu_2015"
log close vycell
