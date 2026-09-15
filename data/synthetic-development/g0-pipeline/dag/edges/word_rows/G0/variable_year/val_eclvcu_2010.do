* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_eclvcu_2010: annual staged raw state -> val_eclvcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2010 row 47; eclvcu10 | total coal used, 000 rp
log using "$VYL/N_G0_val_eclvcu_2010.log", text replace name(vycell)
generate double val_eclvcu=.
generate byte vs_val_eclvcu=3
replace val_eclvcu=real(subinstr(strtrim(raw_eclvcu10),",","",.))*1
replace vs_val_eclvcu=5 if missing(real(subinstr(strtrim(raw_eclvcu10),",","",.))) & !inlist(upper(strtrim(raw_eclvcu10)),"","***",".","NA","N/A","NULL","-")
replace vs_val_eclvcu=cond(val_eclvcu<0,2,cond(val_eclvcu==0,1,0)) if !missing(val_eclvcu)
quietly count if !missing(val_eclvcu)
local obs=r(N)
quietly count if val_eclvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_eclvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_eclvcu==4
local absent=r(N)
post cell (2010) ("val_eclvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_eclvcu vs_val_eclvcu raw_eclvcu10
isid source_year source_row
save "$VYD/N_G0_val_eclvcu_2010.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_eclvcu_2010"
log close vycell
