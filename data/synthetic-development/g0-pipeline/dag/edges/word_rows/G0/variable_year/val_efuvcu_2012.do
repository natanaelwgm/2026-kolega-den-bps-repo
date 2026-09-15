* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_efuvcu_2012: annual staged raw state -> val_efuvcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2012 row 60; efuvcu12 | total energy & lubr used, 000 rp
log using "$VYL/N_G0_val_efuvcu_2012.log", text replace name(vycell)
generate double val_efuvcu=.
generate byte vs_val_efuvcu=3
replace val_efuvcu=real(subinstr(strtrim(raw_efuvcu12),",","",.))*1
replace vs_val_efuvcu=5 if missing(real(subinstr(strtrim(raw_efuvcu12),",","",.))) & !inlist(upper(strtrim(raw_efuvcu12)),"","***",".","NA","N/A","NULL","-")
replace vs_val_efuvcu=cond(val_efuvcu<0,2,cond(val_efuvcu==0,1,0)) if !missing(val_efuvcu)
quietly count if !missing(val_efuvcu)
local obs=r(N)
quietly count if val_efuvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_efuvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_efuvcu==4
local absent=r(N)
post cell (2012) ("val_efuvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_efuvcu vs_val_efuvcu raw_efuvcu12
isid source_year source_row
save "$VYD/N_G0_val_efuvcu_2012.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_efuvcu_2012"
log close vycell
