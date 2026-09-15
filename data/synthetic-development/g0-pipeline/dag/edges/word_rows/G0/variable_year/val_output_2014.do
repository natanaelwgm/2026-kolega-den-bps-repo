* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_output_2014: annual staged raw state -> val_output at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2014 row 111; output14 | total output, 000 rp
log using "$VYL/N_G0_val_output_2014.log", text replace name(vycell)
generate double val_output=.
generate byte vs_val_output=3
replace val_output=real(subinstr(strtrim(raw_output14),",","",.))*1
replace vs_val_output=5 if missing(real(subinstr(strtrim(raw_output14),",","",.))) & !inlist(upper(strtrim(raw_output14)),"","***",".","NA","N/A","NULL","-")
replace vs_val_output=cond(val_output<0,2,cond(val_output==0,1,0)) if !missing(val_output)
quietly count if !missing(val_output)
local obs=r(N)
quietly count if val_output==0
local zeros=r(N)
quietly count if inlist(vs_val_output,5,6,8)
local bad=r(N)
quietly count if vs_val_output==4
local absent=r(N)
post cell (2014) ("val_output") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_output vs_val_output raw_output14
isid source_year source_row
save "$VYD/N_G0_val_output_2014.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_output_2014"
log close vycell
