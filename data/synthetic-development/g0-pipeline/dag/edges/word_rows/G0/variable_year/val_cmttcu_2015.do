* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_cmttcu_2015: annual staged raw state -> val_cmttcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2015 row 128; cmttcu15 | machinery & equip purchases, 000rp
log using "$VYL/N_G0_val_cmttcu_2015.log", text replace name(vycell)
generate double val_cmttcu=.
generate byte vs_val_cmttcu=3
replace val_cmttcu=real(subinstr(strtrim(raw_cmttcu),",","",.))*1
replace vs_val_cmttcu=5 if missing(real(subinstr(strtrim(raw_cmttcu),",","",.))) & !inlist(upper(strtrim(raw_cmttcu)),"","***",".","NA","N/A","NULL","-")
replace vs_val_cmttcu=cond(val_cmttcu<0,2,cond(val_cmttcu==0,1,0)) if !missing(val_cmttcu)
quietly count if !missing(val_cmttcu)
local obs=r(N)
quietly count if val_cmttcu==0
local zeros=r(N)
quietly count if inlist(vs_val_cmttcu,5,6,8)
local bad=r(N)
quietly count if vs_val_cmttcu==4
local absent=r(N)
post cell (2015) ("val_cmttcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_cmttcu vs_val_cmttcu raw_cmttcu
isid source_year source_row
save "$VYD/N_G0_val_cmttcu_2015.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_cmttcu_2015"
log close vycell
