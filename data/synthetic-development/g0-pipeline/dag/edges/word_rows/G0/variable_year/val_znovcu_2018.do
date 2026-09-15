* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_znovcu_2018: annual staged raw state -> val_znovcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_znovcu_2018.log", text replace name(vycell)
generate double val_znovcu=.
generate byte vs_val_znovcu=3
replace val_znovcu=real(subinstr(strtrim(raw_znovcu18),",","",.))*1
replace vs_val_znovcu=5 if missing(real(subinstr(strtrim(raw_znovcu18),",","",.))) & !inlist(upper(strtrim(raw_znovcu18)),"","***",".","NA","N/A","NULL","-")
replace vs_val_znovcu=cond(val_znovcu<0,2,cond(val_znovcu==0,1,0)) if !missing(val_znovcu)
quietly count if !missing(val_znovcu)
local obs=r(N)
quietly count if val_znovcu==0
local zeros=r(N)
quietly count if inlist(vs_val_znovcu,5,6,8)
local bad=r(N)
quietly count if vs_val_znovcu==4
local absent=r(N)
post cell (2018) ("val_znovcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_znovcu vs_val_znovcu raw_znovcu18
isid source_year source_row
save "$VYD/N_G0_val_znovcu_2018.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_znovcu_2018"
log close vycell
