* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_iinvcu_2013: annual staged raw state -> val_iinvcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2013 row 96; iinvcu13 | net interest on loan, 000 rp
log using "$VYL/N_G0_val_iinvcu_2013.log", text replace name(vycell)
generate double val_iinvcu=.
generate byte vs_val_iinvcu=3
replace val_iinvcu=real(subinstr(strtrim(raw_iinvcu13),",","",.))*1
replace vs_val_iinvcu=5 if missing(real(subinstr(strtrim(raw_iinvcu13),",","",.))) & !inlist(upper(strtrim(raw_iinvcu13)),"","***",".","NA","N/A","NULL","-")
replace vs_val_iinvcu=cond(val_iinvcu<0,2,cond(val_iinvcu==0,1,0)) if !missing(val_iinvcu)
quietly count if !missing(val_iinvcu)
local obs=r(N)
quietly count if val_iinvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_iinvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_iinvcu==4
local absent=r(N)
post cell (2013) ("val_iinvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_iinvcu vs_val_iinvcu raw_iinvcu13
isid source_year source_row
save "$VYD/N_G0_val_iinvcu_2013.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_iinvcu_2013"
log close vycell
