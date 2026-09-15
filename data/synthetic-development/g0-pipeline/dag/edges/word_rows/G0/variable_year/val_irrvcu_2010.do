* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_irrvcu_2010: annual staged raw state -> val_irrvcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2010 row 81; irrvcu10 | representative+royalty, 000rp
log using "$VYL/N_G0_val_irrvcu_2010.log", text replace name(vycell)
generate double val_irrvcu=.
generate byte vs_val_irrvcu=3
replace val_irrvcu=real(subinstr(strtrim(raw_irrvcu10),",","",.))*1
replace vs_val_irrvcu=5 if missing(real(subinstr(strtrim(raw_irrvcu10),",","",.))) & !inlist(upper(strtrim(raw_irrvcu10)),"","***",".","NA","N/A","NULL","-")
replace vs_val_irrvcu=cond(val_irrvcu<0,2,cond(val_irrvcu==0,1,0)) if !missing(val_irrvcu)
quietly count if !missing(val_irrvcu)
local obs=r(N)
quietly count if val_irrvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_irrvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_irrvcu==4
local absent=r(N)
post cell (2010) ("val_irrvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_irrvcu vs_val_irrvcu raw_irrvcu10
isid source_year source_row
save "$VYD/N_G0_val_irrvcu_2010.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_irrvcu_2010"
log close vycell
