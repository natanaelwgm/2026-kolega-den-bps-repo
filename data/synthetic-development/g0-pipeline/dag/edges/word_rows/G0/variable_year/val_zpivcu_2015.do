* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_zpivcu_2015: annual staged raw state -> val_zpivcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2015 row 33; zpivcu15 | bonus prod workers, 000rp
log using "$VYL/N_G0_val_zpivcu_2015.log", text replace name(vycell)
generate double val_zpivcu=.
generate byte vs_val_zpivcu=3
replace val_zpivcu=real(subinstr(strtrim(raw_zpivcu),",","",.))*1
replace vs_val_zpivcu=5 if missing(real(subinstr(strtrim(raw_zpivcu),",","",.))) & !inlist(upper(strtrim(raw_zpivcu)),"","***",".","NA","N/A","NULL","-")
replace vs_val_zpivcu=cond(val_zpivcu<0,2,cond(val_zpivcu==0,1,0)) if !missing(val_zpivcu)
quietly count if !missing(val_zpivcu)
local obs=r(N)
quietly count if val_zpivcu==0
local zeros=r(N)
quietly count if inlist(vs_val_zpivcu,5,6,8)
local bad=r(N)
quietly count if vs_val_zpivcu==4
local absent=r(N)
post cell (2015) ("val_zpivcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_zpivcu vs_val_zpivcu raw_zpivcu
isid source_year source_row
save "$VYD/N_G0_val_zpivcu_2015.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_zpivcu_2015"
log close vycell
