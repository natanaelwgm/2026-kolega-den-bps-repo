* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_esovce_2012: annual staged raw state -> val_esovce at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2012 row 41; esovce12 | diesel fuel used for elec gen, 000 rp
log using "$VYL/N_G0_val_esovce_2012.log", text replace name(vycell)
generate double val_esovce=.
generate byte vs_val_esovce=3
replace val_esovce=real(subinstr(strtrim(raw_esovce12),",","",.))*1
replace vs_val_esovce=5 if missing(real(subinstr(strtrim(raw_esovce12),",","",.))) & !inlist(upper(strtrim(raw_esovce12)),"","***",".","NA","N/A","NULL","-")
replace vs_val_esovce=cond(val_esovce<0,2,cond(val_esovce==0,1,0)) if !missing(val_esovce)
quietly count if !missing(val_esovce)
local obs=r(N)
quietly count if val_esovce==0
local zeros=r(N)
quietly count if inlist(vs_val_esovce,5,6,8)
local bad=r(N)
quietly count if vs_val_esovce==4
local absent=r(N)
post cell (2012) ("val_esovce") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_esovce vs_val_esovce raw_esovce12
isid source_year source_row
save "$VYD/N_G0_val_esovce_2012.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_esovce_2012"
log close vycell
