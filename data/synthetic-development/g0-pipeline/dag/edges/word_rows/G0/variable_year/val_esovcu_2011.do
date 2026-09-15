* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_esovcu_2011: annual staged raw state -> val_esovcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2011 row 39; esovcu11 | total diesel fuel used, 000 rp
log using "$VYL/N_G0_val_esovcu_2011.log", text replace name(vycell)
generate double val_esovcu=.
generate byte vs_val_esovcu=3
replace val_esovcu=real(subinstr(strtrim(raw_esovcu11),",","",.))*1
replace vs_val_esovcu=5 if missing(real(subinstr(strtrim(raw_esovcu11),",","",.))) & !inlist(upper(strtrim(raw_esovcu11)),"","***",".","NA","N/A","NULL","-")
replace vs_val_esovcu=cond(val_esovcu<0,2,cond(val_esovcu==0,1,0)) if !missing(val_esovcu)
quietly count if !missing(val_esovcu)
local obs=r(N)
quietly count if val_esovcu==0
local zeros=r(N)
quietly count if inlist(vs_val_esovcu,5,6,8)
local bad=r(N)
quietly count if vs_val_esovcu==4
local absent=r(N)
post cell (2011) ("val_esovcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_esovcu vs_val_esovcu raw_esovcu11
isid source_year source_row
save "$VYD/N_G0_val_esovcu_2011.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_esovcu_2011"
log close vycell
