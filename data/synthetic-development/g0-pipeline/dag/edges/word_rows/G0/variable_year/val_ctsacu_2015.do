* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_ctsacu_2015: annual staged raw state -> val_ctsacu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2015 row 141; ctsacu15 | total sale/reduce, 000 rp
log using "$VYL/N_G0_val_ctsacu_2015.log", text replace name(vycell)
generate double val_ctsacu=.
generate byte vs_val_ctsacu=3
replace val_ctsacu=real(subinstr(strtrim(raw_ctsacu),",","",.))*1
replace vs_val_ctsacu=5 if missing(real(subinstr(strtrim(raw_ctsacu),",","",.))) & !inlist(upper(strtrim(raw_ctsacu)),"","***",".","NA","N/A","NULL","-")
replace vs_val_ctsacu=cond(val_ctsacu<0,2,cond(val_ctsacu==0,1,0)) if !missing(val_ctsacu)
quietly count if !missing(val_ctsacu)
local obs=r(N)
quietly count if val_ctsacu==0
local zeros=r(N)
quietly count if inlist(vs_val_ctsacu,5,6,8)
local bad=r(N)
quietly count if vs_val_ctsacu==4
local absent=r(N)
post cell (2015) ("val_ctsacu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_ctsacu vs_val_ctsacu raw_ctsacu
isid source_year source_row
save "$VYD/N_G0_val_ctsacu_2015.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_ctsacu_2015"
log close vycell
