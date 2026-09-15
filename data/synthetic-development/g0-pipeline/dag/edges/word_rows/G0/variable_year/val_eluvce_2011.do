* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_eluvce_2011: annual staged raw state -> val_eluvce at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2011 row 63; eluvce11 | lubricant used for elec gen, 000rp
log using "$VYL/N_G0_val_eluvce_2011.log", text replace name(vycell)
generate double val_eluvce=.
generate byte vs_val_eluvce=3
replace val_eluvce=real(subinstr(strtrim(raw_eluvce11),",","",.))*1
replace vs_val_eluvce=5 if missing(real(subinstr(strtrim(raw_eluvce11),",","",.))) & !inlist(upper(strtrim(raw_eluvce11)),"","***",".","NA","N/A","NULL","-")
replace vs_val_eluvce=cond(val_eluvce<0,2,cond(val_eluvce==0,1,0)) if !missing(val_eluvce)
quietly count if !missing(val_eluvce)
local obs=r(N)
quietly count if val_eluvce==0
local zeros=r(N)
quietly count if inlist(vs_val_eluvce,5,6,8)
local bad=r(N)
quietly count if vs_val_eluvce==4
local absent=r(N)
post cell (2011) ("val_eluvce") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_eluvce vs_val_eluvce raw_eluvce11
isid source_year source_row
save "$VYD/N_G0_val_eluvce_2011.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_eluvce_2011"
log close vycell
