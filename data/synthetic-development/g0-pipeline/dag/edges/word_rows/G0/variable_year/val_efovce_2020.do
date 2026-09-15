* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_efovce_2020: annual staged raw state -> val_efovce at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_efovce_2020.log", text replace name(vycell)
generate double val_efovce=.
generate byte vs_val_efovce=3
replace val_efovce=real(subinstr(strtrim(raw_efovce20),",","",.))*1
replace vs_val_efovce=5 if missing(real(subinstr(strtrim(raw_efovce20),",","",.))) & !inlist(upper(strtrim(raw_efovce20)),"","***",".","NA","N/A","NULL","-")
replace vs_val_efovce=cond(val_efovce<0,2,cond(val_efovce==0,1,0)) if !missing(val_efovce)
quietly count if !missing(val_efovce)
local obs=r(N)
quietly count if val_efovce==0
local zeros=r(N)
quietly count if inlist(vs_val_efovce,5,6,8)
local bad=r(N)
quietly count if vs_val_efovce==4
local absent=r(N)
post cell (2020) ("val_efovce") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_efovce vs_val_efovce raw_efovce20
isid source_year source_row
save "$VYD/N_G0_val_efovce_2020.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_efovce_2020"
log close vycell
