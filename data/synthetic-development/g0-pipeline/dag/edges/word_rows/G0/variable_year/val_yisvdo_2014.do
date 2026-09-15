* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_yisvdo_2014: annual staged raw state -> val_yisvdo at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2014 row 120; yisvdo14 | pendapatan jasa industri domestik,000 rp
log using "$VYL/N_G0_val_yisvdo_2014.log", text replace name(vycell)
generate double val_yisvdo=.
generate byte vs_val_yisvdo=3
replace val_yisvdo=real(subinstr(strtrim(raw_yisvdo14),",","",.))*1
replace vs_val_yisvdo=5 if missing(real(subinstr(strtrim(raw_yisvdo14),",","",.))) & !inlist(upper(strtrim(raw_yisvdo14)),"","***",".","NA","N/A","NULL","-")
replace vs_val_yisvdo=cond(val_yisvdo<0,2,cond(val_yisvdo==0,1,0)) if !missing(val_yisvdo)
quietly count if !missing(val_yisvdo)
local obs=r(N)
quietly count if val_yisvdo==0
local zeros=r(N)
quietly count if inlist(vs_val_yisvdo,5,6,8)
local bad=r(N)
quietly count if vs_val_yisvdo==4
local absent=r(N)
post cell (2014) ("val_yisvdo") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_yisvdo vs_val_yisvdo raw_yisvdo14
isid source_year source_row
save "$VYD/N_G0_val_yisvdo_2014.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_yisvdo_2014"
log close vycell
