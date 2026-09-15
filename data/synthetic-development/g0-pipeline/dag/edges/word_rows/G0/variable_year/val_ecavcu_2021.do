* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_ecavcu_2021: annual staged raw state -> val_ecavcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_ecavcu_2021.log", text replace name(vycell)
generate double val_ecavcu=.
generate byte vs_val_ecavcu=3
replace val_ecavcu=real(subinstr(strtrim(raw_ecavcu21),",","",.))*1
replace vs_val_ecavcu=5 if missing(real(subinstr(strtrim(raw_ecavcu21),",","",.))) & !inlist(upper(strtrim(raw_ecavcu21)),"","***",".","NA","N/A","NULL","-")
replace vs_val_ecavcu=cond(val_ecavcu<0,2,cond(val_ecavcu==0,1,0)) if !missing(val_ecavcu)
quietly count if !missing(val_ecavcu)
local obs=r(N)
quietly count if val_ecavcu==0
local zeros=r(N)
quietly count if inlist(vs_val_ecavcu,5,6,8)
local bad=r(N)
quietly count if vs_val_ecavcu==4
local absent=r(N)
post cell (2021) ("val_ecavcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_ecavcu vs_val_ecavcu raw_ecavcu21
isid source_year source_row
save "$VYD/N_G0_val_ecavcu_2021.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_ecavcu_2021"
log close vycell
