* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_encvce_2013: annual staged raw state -> val_encvce at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2013 row 76; encvce13 | other fuel used for elec gen,000rp
log using "$VYL/N_G0_val_encvce_2013.log", text replace name(vycell)
generate double val_encvce=.
generate byte vs_val_encvce=3
replace val_encvce=real(subinstr(strtrim(raw_encvce13),",","",.))*1
replace vs_val_encvce=5 if missing(real(subinstr(strtrim(raw_encvce13),",","",.))) & !inlist(upper(strtrim(raw_encvce13)),"","***",".","NA","N/A","NULL","-")
replace vs_val_encvce=cond(val_encvce<0,2,cond(val_encvce==0,1,0)) if !missing(val_encvce)
quietly count if !missing(val_encvce)
local obs=r(N)
quietly count if val_encvce==0
local zeros=r(N)
quietly count if inlist(vs_val_encvce,5,6,8)
local bad=r(N)
quietly count if vs_val_encvce==4
local absent=r(N)
post cell (2013) ("val_encvce") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_encvce vs_val_encvce raw_encvce13
isid source_year source_row
save "$VYD/N_G0_val_encvce_2013.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_encvce_2013"
log close vycell
