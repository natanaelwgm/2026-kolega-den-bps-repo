* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_ctdacu_2014: annual staged raw state -> val_ctdacu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2014 row 159; ctdacu14 | depreciation of total fix cap, 000 rp
log using "$VYL/N_G0_val_ctdacu_2014.log", text replace name(vycell)
generate double val_ctdacu=.
generate byte vs_val_ctdacu=3
replace val_ctdacu=real(subinstr(strtrim(raw_ctdacu14),",","",.))*1
replace vs_val_ctdacu=5 if missing(real(subinstr(strtrim(raw_ctdacu14),",","",.))) & !inlist(upper(strtrim(raw_ctdacu14)),"","***",".","NA","N/A","NULL","-")
replace vs_val_ctdacu=cond(val_ctdacu<0,2,cond(val_ctdacu==0,1,0)) if !missing(val_ctdacu)
quietly count if !missing(val_ctdacu)
local obs=r(N)
quietly count if val_ctdacu==0
local zeros=r(N)
quietly count if inlist(vs_val_ctdacu,5,6,8)
local bad=r(N)
quietly count if vs_val_ctdacu==4
local absent=r(N)
post cell (2014) ("val_ctdacu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_ctdacu vs_val_ctdacu raw_ctdacu14
isid source_year source_row
save "$VYD/N_G0_val_ctdacu_2014.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_ctdacu_2014"
log close vycell
