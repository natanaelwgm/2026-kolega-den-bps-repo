* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_irevcu_2015: annual staged raw state -> val_irevcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2015 row 96; irevcu15 | representative+royalty, 000rp
log using "$VYL/N_G0_val_irevcu_2015.log", text replace name(vycell)
generate double val_irevcu=.
generate byte vs_val_irevcu=3
replace val_irevcu=real(subinstr(strtrim(raw_irevcu),",","",.))*1
replace vs_val_irevcu=5 if missing(real(subinstr(strtrim(raw_irevcu),",","",.))) & !inlist(upper(strtrim(raw_irevcu)),"","***",".","NA","N/A","NULL","-")
replace vs_val_irevcu=cond(val_irevcu<0,2,cond(val_irevcu==0,1,0)) if !missing(val_irevcu)
quietly count if !missing(val_irevcu)
local obs=r(N)
quietly count if val_irevcu==0
local zeros=r(N)
quietly count if inlist(vs_val_irevcu,5,6,8)
local bad=r(N)
quietly count if vs_val_irevcu==4
local absent=r(N)
post cell (2015) ("val_irevcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_irevcu vs_val_irevcu raw_irevcu
isid source_year source_row
save "$VYD/N_G0_val_irevcu_2015.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_irevcu_2015"
log close vycell
