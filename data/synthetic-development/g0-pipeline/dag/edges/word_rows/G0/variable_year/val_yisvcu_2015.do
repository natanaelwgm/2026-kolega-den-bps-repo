* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_yisvcu_2015: annual staged raw state -> val_yisvcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2015 row 105; yisvcu15 | income from manufacturing service,000 rp
log using "$VYL/N_G0_val_yisvcu_2015.log", text replace name(vycell)
generate double val_yisvcu=.
generate byte vs_val_yisvcu=3
replace val_yisvcu=real(subinstr(strtrim(raw_yisvcu),",","",.))*1
replace vs_val_yisvcu=5 if missing(real(subinstr(strtrim(raw_yisvcu),",","",.))) & !inlist(upper(strtrim(raw_yisvcu)),"","***",".","NA","N/A","NULL","-")
replace vs_val_yisvcu=cond(val_yisvcu<0,2,cond(val_yisvcu==0,1,0)) if !missing(val_yisvcu)
quietly count if !missing(val_yisvcu)
local obs=r(N)
quietly count if val_yisvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_yisvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_yisvcu==4
local absent=r(N)
post cell (2015) ("val_yisvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_yisvcu vs_val_yisvcu raw_yisvcu
isid source_year source_row
save "$VYD/N_G0_val_yisvcu_2015.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_yisvcu_2015"
log close vycell
