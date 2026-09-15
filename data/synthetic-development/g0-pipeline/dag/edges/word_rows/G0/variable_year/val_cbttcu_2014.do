* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_cbttcu_2014: annual staged raw state -> val_cbttcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2014 row 141; cbttcu14 | building purchases & constr, 000rp
log using "$VYL/N_G0_val_cbttcu_2014.log", text replace name(vycell)
generate double val_cbttcu=.
generate byte vs_val_cbttcu=3
replace val_cbttcu=real(subinstr(strtrim(raw_cbttcu14),",","",.))*1
replace vs_val_cbttcu=5 if missing(real(subinstr(strtrim(raw_cbttcu14),",","",.))) & !inlist(upper(strtrim(raw_cbttcu14)),"","***",".","NA","N/A","NULL","-")
replace vs_val_cbttcu=cond(val_cbttcu<0,2,cond(val_cbttcu==0,1,0)) if !missing(val_cbttcu)
quietly count if !missing(val_cbttcu)
local obs=r(N)
quietly count if val_cbttcu==0
local zeros=r(N)
quietly count if inlist(vs_val_cbttcu,5,6,8)
local bad=r(N)
quietly count if vs_val_cbttcu==4
local absent=r(N)
post cell (2014) ("val_cbttcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_cbttcu vs_val_cbttcu raw_cbttcu14
isid source_year source_row
save "$VYD/N_G0_val_cbttcu_2014.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_cbttcu_2014"
log close vycell
