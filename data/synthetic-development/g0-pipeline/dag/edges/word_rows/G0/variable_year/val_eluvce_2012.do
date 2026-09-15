* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_eluvce_2012: annual staged raw state -> val_eluvce at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2012 row 59; eluvce12 | lubricant used for elec gen, 000rp
log using "$VYL/N_G0_val_eluvce_2012.log", text replace name(vycell)
generate double val_eluvce=.
generate byte vs_val_eluvce=3
replace val_eluvce=real(subinstr(strtrim(raw_eluvce12),",","",.))*1
replace vs_val_eluvce=5 if missing(real(subinstr(strtrim(raw_eluvce12),",","",.))) & !inlist(upper(strtrim(raw_eluvce12)),"","***",".","NA","N/A","NULL","-")
replace vs_val_eluvce=cond(val_eluvce<0,2,cond(val_eluvce==0,1,0)) if !missing(val_eluvce)
quietly count if !missing(val_eluvce)
local obs=r(N)
quietly count if val_eluvce==0
local zeros=r(N)
quietly count if inlist(vs_val_eluvce,5,6,8)
local bad=r(N)
quietly count if vs_val_eluvce==4
local absent=r(N)
post cell (2012) ("val_eluvce") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_eluvce vs_val_eluvce raw_eluvce12
isid source_year source_row
save "$VYD/N_G0_val_eluvce_2012.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_eluvce_2012"
log close vycell
