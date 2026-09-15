* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_cbdacu_2012: annual staged raw state -> val_cbdacu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2012 row 106; cbdacu12 | depreciation of building, 000 rp
log using "$VYL/N_G0_val_cbdacu_2012.log", text replace name(vycell)
generate double val_cbdacu=.
generate byte vs_val_cbdacu=3
replace val_cbdacu=real(subinstr(strtrim(raw_cbdacu12),",","",.))*1
replace vs_val_cbdacu=5 if missing(real(subinstr(strtrim(raw_cbdacu12),",","",.))) & !inlist(upper(strtrim(raw_cbdacu12)),"","***",".","NA","N/A","NULL","-")
replace vs_val_cbdacu=cond(val_cbdacu<0,2,cond(val_cbdacu==0,1,0)) if !missing(val_cbdacu)
quietly count if !missing(val_cbdacu)
local obs=r(N)
quietly count if val_cbdacu==0
local zeros=r(N)
quietly count if inlist(vs_val_cbdacu,5,6,8)
local bad=r(N)
quietly count if vs_val_cbdacu==4
local absent=r(N)
post cell (2012) ("val_cbdacu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_cbdacu vs_val_cbdacu raw_cbdacu12
isid source_year source_row
save "$VYD/N_G0_val_cbdacu_2012.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_cbdacu_2012"
log close vycell
