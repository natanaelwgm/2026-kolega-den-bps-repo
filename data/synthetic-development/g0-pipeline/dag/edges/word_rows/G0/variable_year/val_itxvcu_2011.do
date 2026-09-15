* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_itxvcu_2011: annual staged raw state -> val_itxvcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2011 row 77; itxvcu11 | indirect taxes, 000 rp
log using "$VYL/N_G0_val_itxvcu_2011.log", text replace name(vycell)
generate double val_itxvcu=.
generate byte vs_val_itxvcu=3
replace val_itxvcu=real(subinstr(strtrim(raw_itxvcu11),",","",.))*1
replace vs_val_itxvcu=5 if missing(real(subinstr(strtrim(raw_itxvcu11),",","",.))) & !inlist(upper(strtrim(raw_itxvcu11)),"","***",".","NA","N/A","NULL","-")
replace vs_val_itxvcu=cond(val_itxvcu<0,2,cond(val_itxvcu==0,1,0)) if !missing(val_itxvcu)
quietly count if !missing(val_itxvcu)
local obs=r(N)
quietly count if val_itxvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_itxvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_itxvcu==4
local absent=r(N)
post cell (2011) ("val_itxvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_itxvcu vs_val_itxvcu raw_itxvcu11
isid source_year source_row
save "$VYD/N_G0_val_itxvcu_2011.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_itxvcu_2011"
log close vycell
