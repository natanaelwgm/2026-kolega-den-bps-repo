* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_cvttcu_2012: annual staged raw state -> val_cvttcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2012 row 112; cvttcu12 | vehicles purchases & constr, 000rp
log using "$VYL/N_G0_val_cvttcu_2012.log", text replace name(vycell)
generate double val_cvttcu=.
generate byte vs_val_cvttcu=3
replace val_cvttcu=real(subinstr(strtrim(raw_cvttcu12),",","",.))*1
replace vs_val_cvttcu=5 if missing(real(subinstr(strtrim(raw_cvttcu12),",","",.))) & !inlist(upper(strtrim(raw_cvttcu12)),"","***",".","NA","N/A","NULL","-")
replace vs_val_cvttcu=cond(val_cvttcu<0,2,cond(val_cvttcu==0,1,0)) if !missing(val_cvttcu)
quietly count if !missing(val_cvttcu)
local obs=r(N)
quietly count if val_cvttcu==0
local zeros=r(N)
quietly count if inlist(vs_val_cvttcu,5,6,8)
local bad=r(N)
quietly count if vs_val_cvttcu==4
local absent=r(N)
post cell (2012) ("val_cvttcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_cvttcu vs_val_cvttcu raw_cvttcu12
isid source_year source_row
save "$VYD/N_G0_val_cvttcu_2012.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_cvttcu_2012"
log close vycell
