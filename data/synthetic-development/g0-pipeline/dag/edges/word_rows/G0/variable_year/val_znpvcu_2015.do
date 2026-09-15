* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_znpvcu_2015: annual staged raw state -> val_znpvcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2015 row 36; znpvcu15 | pensi-soc allw-ins non prod wrkrs, 000rp
log using "$VYL/N_G0_val_znpvcu_2015.log", text replace name(vycell)
generate double val_znpvcu=.
generate byte vs_val_znpvcu=3
replace val_znpvcu=real(subinstr(strtrim(raw_znpvcu),",","",.))*1
replace vs_val_znpvcu=5 if missing(real(subinstr(strtrim(raw_znpvcu),",","",.))) & !inlist(upper(strtrim(raw_znpvcu)),"","***",".","NA","N/A","NULL","-")
replace vs_val_znpvcu=cond(val_znpvcu<0,2,cond(val_znpvcu==0,1,0)) if !missing(val_znpvcu)
quietly count if !missing(val_znpvcu)
local obs=r(N)
quietly count if val_znpvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_znpvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_znpvcu==4
local absent=r(N)
post cell (2015) ("val_znpvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_znpvcu vs_val_znpvcu raw_znpvcu
isid source_year source_row
save "$VYD/N_G0_val_znpvcu_2015.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_znpvcu_2015"
log close vycell
