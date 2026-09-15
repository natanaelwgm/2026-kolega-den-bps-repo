* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_yrnvcu_2014: annual staged raw state -> val_yrnvcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2014 row 123; yrnvcu14 | gross rental income, 000 rp
log using "$VYL/N_G0_val_yrnvcu_2014.log", text replace name(vycell)
generate double val_yrnvcu=.
generate byte vs_val_yrnvcu=3
replace val_yrnvcu=real(subinstr(strtrim(raw_yrnvcu14),",","",.))*1
replace vs_val_yrnvcu=5 if missing(real(subinstr(strtrim(raw_yrnvcu14),",","",.))) & !inlist(upper(strtrim(raw_yrnvcu14)),"","***",".","NA","N/A","NULL","-")
replace vs_val_yrnvcu=cond(val_yrnvcu<0,2,cond(val_yrnvcu==0,1,0)) if !missing(val_yrnvcu)
quietly count if !missing(val_yrnvcu)
local obs=r(N)
quietly count if val_yrnvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_yrnvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_yrnvcu==4
local absent=r(N)
post cell (2014) ("val_yrnvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_yrnvcu vs_val_yrnvcu raw_yrnvcu14
isid source_year source_row
save "$VYD/N_G0_val_yrnvcu_2014.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_yrnvcu_2014"
log close vycell
