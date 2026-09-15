* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_output_2010: annual staged raw state -> val_output at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2010 row 130; output10 | total output, 000 rp
log using "$VYL/N_G0_val_output_2010.log", text replace name(vycell)
generate double val_output=.
generate byte vs_val_output=3
replace val_output=real(subinstr(strtrim(raw_output10),",","",.))*1
replace vs_val_output=5 if missing(real(subinstr(strtrim(raw_output10),",","",.))) & !inlist(upper(strtrim(raw_output10)),"","***",".","NA","N/A","NULL","-")
replace vs_val_output=cond(val_output<0,2,cond(val_output==0,1,0)) if !missing(val_output)
quietly count if !missing(val_output)
local obs=r(N)
quietly count if val_output==0
local zeros=r(N)
quietly count if inlist(vs_val_output,5,6,8)
local bad=r(N)
quietly count if vs_val_output==4
local absent=r(N)
post cell (2010) ("val_output") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_output vs_val_output raw_output10
isid source_year source_row
save "$VYD/N_G0_val_output_2010.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_output_2010"
log close vycell
