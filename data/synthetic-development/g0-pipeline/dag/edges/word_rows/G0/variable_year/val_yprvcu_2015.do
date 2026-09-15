* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_yprvcu_2015: annual staged raw state -> val_yprvcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2015 row 103; yprvcu15 | total production, 000 rp
log using "$VYL/N_G0_val_yprvcu_2015.log", text replace name(vycell)
generate double val_yprvcu=.
generate byte vs_val_yprvcu=3
replace val_yprvcu=real(subinstr(strtrim(raw_yprvcu),",","",.))*1
replace vs_val_yprvcu=5 if missing(real(subinstr(strtrim(raw_yprvcu),",","",.))) & !inlist(upper(strtrim(raw_yprvcu)),"","***",".","NA","N/A","NULL","-")
replace vs_val_yprvcu=cond(val_yprvcu<0,2,cond(val_yprvcu==0,1,0)) if !missing(val_yprvcu)
quietly count if !missing(val_yprvcu)
local obs=r(N)
quietly count if val_yprvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_yprvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_yprvcu==4
local absent=r(N)
post cell (2015) ("val_yprvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_yprvcu vs_val_yprvcu raw_yprvcu
isid source_year source_row
save "$VYD/N_G0_val_yprvcu_2015.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_yprvcu_2015"
log close vycell
