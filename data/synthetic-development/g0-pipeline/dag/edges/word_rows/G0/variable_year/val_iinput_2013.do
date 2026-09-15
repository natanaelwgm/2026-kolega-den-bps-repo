* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_iinput_2013: annual staged raw state -> val_iinput at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2013 row 147; iinput13 | total intermediate input, 000 rp
log using "$VYL/N_G0_val_iinput_2013.log", text replace name(vycell)
generate double val_iinput=.
generate byte vs_val_iinput=3
replace val_iinput=real(subinstr(strtrim(raw_iinput13),",","",.))*1
replace vs_val_iinput=5 if missing(real(subinstr(strtrim(raw_iinput13),",","",.))) & !inlist(upper(strtrim(raw_iinput13)),"","***",".","NA","N/A","NULL","-")
replace vs_val_iinput=cond(val_iinput<0,2,cond(val_iinput==0,1,0)) if !missing(val_iinput)
quietly count if !missing(val_iinput)
local obs=r(N)
quietly count if val_iinput==0
local zeros=r(N)
quietly count if inlist(vs_val_iinput,5,6,8)
local bad=r(N)
quietly count if vs_val_iinput==4
local absent=r(N)
post cell (2013) ("val_iinput") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_iinput vs_val_iinput raw_iinput13
isid source_year source_row
save "$VYD/N_G0_val_iinput_2013.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_iinput_2013"
log close vycell
