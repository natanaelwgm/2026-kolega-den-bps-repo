* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_cvttcu_2011: annual staged raw state -> val_cvttcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2011 row 117; cvttcu11 | vehicles purchases & constr, 000rp
log using "$VYL/N_G0_val_cvttcu_2011.log", text replace name(vycell)
generate double val_cvttcu=.
generate byte vs_val_cvttcu=3
replace val_cvttcu=real(subinstr(strtrim(raw_cvttcu11),",","",.))*1
replace vs_val_cvttcu=5 if missing(real(subinstr(strtrim(raw_cvttcu11),",","",.))) & !inlist(upper(strtrim(raw_cvttcu11)),"","***",".","NA","N/A","NULL","-")
replace vs_val_cvttcu=cond(val_cvttcu<0,2,cond(val_cvttcu==0,1,0)) if !missing(val_cvttcu)
quietly count if !missing(val_cvttcu)
local obs=r(N)
quietly count if val_cvttcu==0
local zeros=r(N)
quietly count if inlist(vs_val_cvttcu,5,6,8)
local bad=r(N)
quietly count if vs_val_cvttcu==4
local absent=r(N)
post cell (2011) ("val_cvttcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_cvttcu vs_val_cvttcu raw_cvttcu11
isid source_year source_row
save "$VYD/N_G0_val_cvttcu_2011.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_cvttcu_2011"
log close vycell
