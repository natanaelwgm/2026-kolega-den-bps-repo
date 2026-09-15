* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_eclvce_2022: annual staged raw state -> val_eclvce at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_eclvce_2022.log", text replace name(vycell)
generate double val_eclvce=.
generate byte vs_val_eclvce=3
replace val_eclvce=real(subinstr(strtrim(raw_eclvce22),",","",.))*1
replace vs_val_eclvce=5 if missing(real(subinstr(strtrim(raw_eclvce22),",","",.))) & !inlist(upper(strtrim(raw_eclvce22)),"","***",".","NA","N/A","NULL","-")
replace vs_val_eclvce=cond(val_eclvce<0,2,cond(val_eclvce==0,1,0)) if !missing(val_eclvce)
quietly count if !missing(val_eclvce)
local obs=r(N)
quietly count if val_eclvce==0
local zeros=r(N)
quietly count if inlist(vs_val_eclvce,5,6,8)
local bad=r(N)
quietly count if vs_val_eclvce==4
local absent=r(N)
post cell (2022) ("val_eclvce") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_eclvce vs_val_eclvce raw_eclvce22
isid source_year source_row
save "$VYD/N_G0_val_eclvce_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_eclvce_2022"
log close vycell
