* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_cbsacu_2013: annual staged raw state -> val_cbsacu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2013 row 127; cbsacu13 | sale/reduce of building, 000 rp
log using "$VYL/N_G0_val_cbsacu_2013.log", text replace name(vycell)
generate double val_cbsacu=.
generate byte vs_val_cbsacu=3
replace val_cbsacu=real(subinstr(strtrim(raw_cbsacu13),",","",.))*1
replace vs_val_cbsacu=5 if missing(real(subinstr(strtrim(raw_cbsacu13),",","",.))) & !inlist(upper(strtrim(raw_cbsacu13)),"","***",".","NA","N/A","NULL","-")
replace vs_val_cbsacu=cond(val_cbsacu<0,2,cond(val_cbsacu==0,1,0)) if !missing(val_cbsacu)
quietly count if !missing(val_cbsacu)
local obs=r(N)
quietly count if val_cbsacu==0
local zeros=r(N)
quietly count if inlist(vs_val_cbsacu,5,6,8)
local bad=r(N)
quietly count if vs_val_cbsacu==4
local absent=r(N)
post cell (2013) ("val_cbsacu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_cbsacu vs_val_cbsacu raw_cbsacu13
isid source_year source_row
save "$VYD/N_G0_val_cbsacu_2013.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_cbsacu_2013"
log close vycell
