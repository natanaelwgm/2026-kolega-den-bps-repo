* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_egovce_2013: annual staged raw state -> val_egovce at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2013 row 70; egovce13 | gas from others for elec gen, 000rp
log using "$VYL/N_G0_val_egovce_2013.log", text replace name(vycell)
generate double val_egovce=.
generate byte vs_val_egovce=3
replace val_egovce=real(subinstr(strtrim(raw_egovce13),",","",.))*1
replace vs_val_egovce=5 if missing(real(subinstr(strtrim(raw_egovce13),",","",.))) & !inlist(upper(strtrim(raw_egovce13)),"","***",".","NA","N/A","NULL","-")
replace vs_val_egovce=cond(val_egovce<0,2,cond(val_egovce==0,1,0)) if !missing(val_egovce)
quietly count if !missing(val_egovce)
local obs=r(N)
quietly count if val_egovce==0
local zeros=r(N)
quietly count if inlist(vs_val_egovce,5,6,8)
local bad=r(N)
quietly count if vs_val_egovce==4
local absent=r(N)
post cell (2013) ("val_egovce") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_egovce vs_val_egovce raw_egovce13
isid source_year source_row
save "$VYD/N_G0_val_egovce_2013.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_egovce_2013"
log close vycell
