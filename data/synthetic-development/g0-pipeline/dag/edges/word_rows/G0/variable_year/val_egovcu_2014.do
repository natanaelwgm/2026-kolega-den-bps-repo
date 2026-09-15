* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_egovcu_2014: annual staged raw state -> val_egovcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2014 row 59; egovcu14 | total gas from others used, 000 rp
log using "$VYL/N_G0_val_egovcu_2014.log", text replace name(vycell)
generate double val_egovcu=.
generate byte vs_val_egovcu=3
replace val_egovcu=real(subinstr(strtrim(raw_egovcu14),",","",.))*1
replace vs_val_egovcu=5 if missing(real(subinstr(strtrim(raw_egovcu14),",","",.))) & !inlist(upper(strtrim(raw_egovcu14)),"","***",".","NA","N/A","NULL","-")
replace vs_val_egovcu=cond(val_egovcu<0,2,cond(val_egovcu==0,1,0)) if !missing(val_egovcu)
quietly count if !missing(val_egovcu)
local obs=r(N)
quietly count if val_egovcu==0
local zeros=r(N)
quietly count if inlist(vs_val_egovcu,5,6,8)
local bad=r(N)
quietly count if vs_val_egovcu==4
local absent=r(N)
post cell (2014) ("val_egovcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_egovcu vs_val_egovcu raw_egovcu14
isid source_year source_row
save "$VYD/N_G0_val_egovcu_2014.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_egovcu_2014"
log close vycell
