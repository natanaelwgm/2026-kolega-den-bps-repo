* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_egavce_2011: annual staged raw state -> val_egavce at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2011 row 53; egavce11 | public pgn used for elec gen, 000 rp
log using "$VYL/N_G0_val_egavce_2011.log", text replace name(vycell)
generate double val_egavce=.
generate byte vs_val_egavce=3
replace val_egavce=real(subinstr(strtrim(raw_egavce11),",","",.))*1
replace vs_val_egavce=5 if missing(real(subinstr(strtrim(raw_egavce11),",","",.))) & !inlist(upper(strtrim(raw_egavce11)),"","***",".","NA","N/A","NULL","-")
replace vs_val_egavce=cond(val_egavce<0,2,cond(val_egavce==0,1,0)) if !missing(val_egavce)
quietly count if !missing(val_egavce)
local obs=r(N)
quietly count if val_egavce==0
local zeros=r(N)
quietly count if inlist(vs_val_egavce,5,6,8)
local bad=r(N)
quietly count if vs_val_egavce==4
local absent=r(N)
post cell (2011) ("val_egavce") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_egavce vs_val_egavce raw_egavce11
isid source_year source_row
save "$VYD/N_G0_val_egavce_2011.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_egavce_2011"
log close vycell
