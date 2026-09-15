* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_rimvcu_2015: annual staged raw state -> val_rimvcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2015 row 100; rimvcu15 | imported raw material used, 000rp
log using "$VYL/N_G0_val_rimvcu_2015.log", text replace name(vycell)
generate double val_rimvcu=.
generate byte vs_val_rimvcu=3
replace val_rimvcu=real(subinstr(strtrim(raw_rimvcu),",","",.))*1
replace vs_val_rimvcu=5 if missing(real(subinstr(strtrim(raw_rimvcu),",","",.))) & !inlist(upper(strtrim(raw_rimvcu)),"","***",".","NA","N/A","NULL","-")
replace vs_val_rimvcu=cond(val_rimvcu<0,2,cond(val_rimvcu==0,1,0)) if !missing(val_rimvcu)
quietly count if !missing(val_rimvcu)
local obs=r(N)
quietly count if val_rimvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_rimvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_rimvcu==4
local absent=r(N)
post cell (2015) ("val_rimvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_rimvcu vs_val_rimvcu raw_rimvcu
isid source_year source_row
save "$VYD/N_G0_val_rimvcu_2015.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_rimvcu_2015"
log close vycell
