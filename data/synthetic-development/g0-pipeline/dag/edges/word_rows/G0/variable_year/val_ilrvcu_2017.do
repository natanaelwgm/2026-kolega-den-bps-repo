* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_ilrvcu_2017: annual staged raw state -> val_ilrvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_ilrvcu_2017.log", text replace name(vycell)
generate double val_ilrvcu=.
generate byte vs_val_ilrvcu=3
replace val_ilrvcu=real(subinstr(strtrim(raw_ilrvcu17),",","",.))*1
replace vs_val_ilrvcu=5 if missing(real(subinstr(strtrim(raw_ilrvcu17),",","",.))) & !inlist(upper(strtrim(raw_ilrvcu17)),"","***",".","NA","N/A","NULL","-")
replace vs_val_ilrvcu=cond(val_ilrvcu<0,2,cond(val_ilrvcu==0,1,0)) if !missing(val_ilrvcu)
quietly count if !missing(val_ilrvcu)
local obs=r(N)
quietly count if val_ilrvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_ilrvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_ilrvcu==4
local absent=r(N)
post cell (2017) ("val_ilrvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_ilrvcu vs_val_ilrvcu raw_ilrvcu17
isid source_year source_row
save "$VYD/N_G0_val_ilrvcu_2017.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_ilrvcu_2017"
log close vycell
