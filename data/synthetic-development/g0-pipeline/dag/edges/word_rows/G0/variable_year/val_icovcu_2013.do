* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_icovcu_2013: annual staged raw state -> val_icovcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2013 row 97; icovcu13 | expenses for gifts,char,donat, 000 rp
log using "$VYL/N_G0_val_icovcu_2013.log", text replace name(vycell)
generate double val_icovcu=.
generate byte vs_val_icovcu=3
replace val_icovcu=real(subinstr(strtrim(raw_icovcu13),",","",.))*1
replace vs_val_icovcu=5 if missing(real(subinstr(strtrim(raw_icovcu13),",","",.))) & !inlist(upper(strtrim(raw_icovcu13)),"","***",".","NA","N/A","NULL","-")
replace vs_val_icovcu=cond(val_icovcu<0,2,cond(val_icovcu==0,1,0)) if !missing(val_icovcu)
quietly count if !missing(val_icovcu)
local obs=r(N)
quietly count if val_icovcu==0
local zeros=r(N)
quietly count if inlist(vs_val_icovcu,5,6,8)
local bad=r(N)
quietly count if vs_val_icovcu==4
local absent=r(N)
post cell (2013) ("val_icovcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_icovcu vs_val_icovcu raw_icovcu13
isid source_year source_row
save "$VYD/N_G0_val_icovcu_2013.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_icovcu_2013"
log close vycell
