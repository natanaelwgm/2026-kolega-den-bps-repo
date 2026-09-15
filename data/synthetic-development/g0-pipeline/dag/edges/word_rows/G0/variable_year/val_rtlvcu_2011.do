* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_rtlvcu_2011: annual staged raw state -> val_rtlvcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2011 row 86; rtlvcu11 | total raw material used, 000 rp
log using "$VYL/N_G0_val_rtlvcu_2011.log", text replace name(vycell)
generate double val_rtlvcu=.
generate byte vs_val_rtlvcu=3
replace val_rtlvcu=real(subinstr(strtrim(raw_rtlvcu11),",","",.))*1
replace vs_val_rtlvcu=5 if missing(real(subinstr(strtrim(raw_rtlvcu11),",","",.))) & !inlist(upper(strtrim(raw_rtlvcu11)),"","***",".","NA","N/A","NULL","-")
replace vs_val_rtlvcu=cond(val_rtlvcu<0,2,cond(val_rtlvcu==0,1,0)) if !missing(val_rtlvcu)
quietly count if !missing(val_rtlvcu)
local obs=r(N)
quietly count if val_rtlvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_rtlvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_rtlvcu==4
local absent=r(N)
post cell (2011) ("val_rtlvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_rtlvcu vs_val_rtlvcu raw_rtlvcu11
isid source_year source_row
save "$VYD/N_G0_val_rtlvcu_2011.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_rtlvcu_2011"
log close vycell
