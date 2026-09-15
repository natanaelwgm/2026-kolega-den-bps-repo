* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_cldacu_2014: annual staged raw state -> val_cldacu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2014 row 139; cldacu14 | depreciation of land, 000 rp
log using "$VYL/N_G0_val_cldacu_2014.log", text replace name(vycell)
generate double val_cldacu=.
generate byte vs_val_cldacu=3
replace val_cldacu=real(subinstr(strtrim(raw_cldacu14),",","",.))*1
replace vs_val_cldacu=5 if missing(real(subinstr(strtrim(raw_cldacu14),",","",.))) & !inlist(upper(strtrim(raw_cldacu14)),"","***",".","NA","N/A","NULL","-")
replace vs_val_cldacu=cond(val_cldacu<0,2,cond(val_cldacu==0,1,0)) if !missing(val_cldacu)
quietly count if !missing(val_cldacu)
local obs=r(N)
quietly count if val_cldacu==0
local zeros=r(N)
quietly count if inlist(vs_val_cldacu,5,6,8)
local bad=r(N)
quietly count if vs_val_cldacu==4
local absent=r(N)
post cell (2014) ("val_cldacu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_cldacu vs_val_cldacu raw_cldacu14
isid source_year source_row
save "$VYD/N_G0_val_cldacu_2014.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_cldacu_2014"
log close vycell
