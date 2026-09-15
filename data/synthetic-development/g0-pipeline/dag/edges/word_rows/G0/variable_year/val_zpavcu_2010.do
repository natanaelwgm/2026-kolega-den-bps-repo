* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_zpavcu_2010: annual staged raw state -> val_zpavcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2010 row 26; zpavcu10 | accident allw prod workers, 000rp
log using "$VYL/N_G0_val_zpavcu_2010.log", text replace name(vycell)
generate double val_zpavcu=.
generate byte vs_val_zpavcu=3
replace val_zpavcu=real(subinstr(strtrim(raw_zpavcu10),",","",.))*1
replace vs_val_zpavcu=5 if missing(real(subinstr(strtrim(raw_zpavcu10),",","",.))) & !inlist(upper(strtrim(raw_zpavcu10)),"","***",".","NA","N/A","NULL","-")
replace vs_val_zpavcu=cond(val_zpavcu<0,2,cond(val_zpavcu==0,1,0)) if !missing(val_zpavcu)
quietly count if !missing(val_zpavcu)
local obs=r(N)
quietly count if val_zpavcu==0
local zeros=r(N)
quietly count if inlist(vs_val_zpavcu,5,6,8)
local bad=r(N)
quietly count if vs_val_zpavcu==4
local absent=r(N)
post cell (2010) ("val_zpavcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_zpavcu vs_val_zpavcu raw_zpavcu10
isid source_year source_row
save "$VYD/N_G0_val_zpavcu_2010.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_zpavcu_2010"
log close vycell
