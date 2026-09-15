* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_ecbvce_2020: annual staged raw state -> val_ecbvce at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_ecbvce_2020.log", text replace name(vycell)
generate double val_ecbvce=.
generate byte vs_val_ecbvce=3
replace val_ecbvce=real(subinstr(strtrim(raw_ecbvce20),",","",.))*1
replace vs_val_ecbvce=5 if missing(real(subinstr(strtrim(raw_ecbvce20),",","",.))) & !inlist(upper(strtrim(raw_ecbvce20)),"","***",".","NA","N/A","NULL","-")
replace vs_val_ecbvce=cond(val_ecbvce<0,2,cond(val_ecbvce==0,1,0)) if !missing(val_ecbvce)
quietly count if !missing(val_ecbvce)
local obs=r(N)
quietly count if val_ecbvce==0
local zeros=r(N)
quietly count if inlist(vs_val_ecbvce,5,6,8)
local bad=r(N)
quietly count if vs_val_ecbvce==4
local absent=r(N)
post cell (2020) ("val_ecbvce") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_ecbvce vs_val_ecbvce raw_ecbvce20
isid source_year source_row
save "$VYD/N_G0_val_ecbvce_2020.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_ecbvce_2020"
log close vycell
