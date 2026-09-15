* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_eckvce_2022: annual staged raw state -> val_eckvce at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_eckvce_2022.log", text replace name(vycell)
generate double val_eckvce=.
generate byte vs_val_eckvce=3
replace val_eckvce=real(subinstr(strtrim(raw_eckvce22),",","",.))*1
replace vs_val_eckvce=5 if missing(real(subinstr(strtrim(raw_eckvce22),",","",.))) & !inlist(upper(strtrim(raw_eckvce22)),"","***",".","NA","N/A","NULL","-")
replace vs_val_eckvce=cond(val_eckvce<0,2,cond(val_eckvce==0,1,0)) if !missing(val_eckvce)
quietly count if !missing(val_eckvce)
local obs=r(N)
quietly count if val_eckvce==0
local zeros=r(N)
quietly count if inlist(vs_val_eckvce,5,6,8)
local bad=r(N)
quietly count if vs_val_eckvce==4
local absent=r(N)
post cell (2022) ("val_eckvce") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_eckvce vs_val_eckvce raw_eckvce22
isid source_year source_row
save "$VYD/N_G0_val_eckvce_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_eckvce_2022"
log close vycell
