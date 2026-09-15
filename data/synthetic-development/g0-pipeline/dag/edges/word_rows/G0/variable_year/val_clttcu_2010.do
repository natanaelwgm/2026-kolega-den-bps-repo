* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_clttcu_2010: annual staged raw state -> val_clttcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2010 row 105; clttcu10 | land purchases & construction, 000 rp
log using "$VYL/N_G0_val_clttcu_2010.log", text replace name(vycell)
generate double val_clttcu=.
generate byte vs_val_clttcu=3
replace val_clttcu=real(subinstr(strtrim(raw_clttcu10),",","",.))*1
replace vs_val_clttcu=5 if missing(real(subinstr(strtrim(raw_clttcu10),",","",.))) & !inlist(upper(strtrim(raw_clttcu10)),"","***",".","NA","N/A","NULL","-")
replace vs_val_clttcu=cond(val_clttcu<0,2,cond(val_clttcu==0,1,0)) if !missing(val_clttcu)
quietly count if !missing(val_clttcu)
local obs=r(N)
quietly count if val_clttcu==0
local zeros=r(N)
quietly count if inlist(vs_val_clttcu,5,6,8)
local bad=r(N)
quietly count if vs_val_clttcu==4
local absent=r(N)
post cell (2010) ("val_clttcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_clttcu vs_val_clttcu raw_clttcu10
isid source_year source_row
save "$VYD/N_G0_val_clttcu_2010.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_clttcu_2010"
log close vycell
