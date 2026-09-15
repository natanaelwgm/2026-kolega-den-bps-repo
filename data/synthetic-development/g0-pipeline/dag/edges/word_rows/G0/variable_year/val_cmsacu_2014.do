* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_cmsacu_2014: annual staged raw state -> val_cmsacu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2014 row 146; cmsacu14 | sale/reduce of mchn & eqp, 000 rp
log using "$VYL/N_G0_val_cmsacu_2014.log", text replace name(vycell)
generate double val_cmsacu=.
generate byte vs_val_cmsacu=3
replace val_cmsacu=real(subinstr(strtrim(raw_cmsacu14),",","",.))*1
replace vs_val_cmsacu=5 if missing(real(subinstr(strtrim(raw_cmsacu14),",","",.))) & !inlist(upper(strtrim(raw_cmsacu14)),"","***",".","NA","N/A","NULL","-")
replace vs_val_cmsacu=cond(val_cmsacu<0,2,cond(val_cmsacu==0,1,0)) if !missing(val_cmsacu)
quietly count if !missing(val_cmsacu)
local obs=r(N)
quietly count if val_cmsacu==0
local zeros=r(N)
quietly count if inlist(vs_val_cmsacu,5,6,8)
local bad=r(N)
quietly count if vs_val_cmsacu==4
local absent=r(N)
post cell (2014) ("val_cmsacu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_cmsacu vs_val_cmsacu raw_cmsacu14
isid source_year source_row
save "$VYD/N_G0_val_cmsacu_2014.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_cmsacu_2014"
log close vycell
