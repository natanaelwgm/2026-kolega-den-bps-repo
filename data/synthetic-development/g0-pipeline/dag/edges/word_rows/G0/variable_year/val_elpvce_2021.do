* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_elpvce_2021: annual staged raw state -> val_elpvce at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_elpvce_2021.log", text replace name(vycell)
generate double val_elpvce=.
generate byte vs_val_elpvce=3
replace val_elpvce=real(subinstr(strtrim(raw_elpvce21),",","",.))*1
replace vs_val_elpvce=5 if missing(real(subinstr(strtrim(raw_elpvce21),",","",.))) & !inlist(upper(strtrim(raw_elpvce21)),"","***",".","NA","N/A","NULL","-")
replace vs_val_elpvce=cond(val_elpvce<0,2,cond(val_elpvce==0,1,0)) if !missing(val_elpvce)
quietly count if !missing(val_elpvce)
local obs=r(N)
quietly count if val_elpvce==0
local zeros=r(N)
quietly count if inlist(vs_val_elpvce,5,6,8)
local bad=r(N)
quietly count if vs_val_elpvce==4
local absent=r(N)
post cell (2021) ("val_elpvce") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_elpvce vs_val_elpvce raw_elpvce21
isid source_year source_row
save "$VYD/N_G0_val_elpvce_2021.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_elpvce_2021"
log close vycell
