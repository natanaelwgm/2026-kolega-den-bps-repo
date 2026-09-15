* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_intvcu_2019: annual staged raw state -> val_intvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_intvcu_2019.log", text replace name(vycell)
generate double val_intvcu=.
generate byte vs_val_intvcu=3
replace val_intvcu=real(subinstr(strtrim(raw_intvcu19),",","",.))*1
replace vs_val_intvcu=5 if missing(real(subinstr(strtrim(raw_intvcu19),",","",.))) & !inlist(upper(strtrim(raw_intvcu19)),"","***",".","NA","N/A","NULL","-")
replace vs_val_intvcu=cond(val_intvcu<0,2,cond(val_intvcu==0,1,0)) if !missing(val_intvcu)
quietly count if !missing(val_intvcu)
local obs=r(N)
quietly count if val_intvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_intvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_intvcu==4
local absent=r(N)
post cell (2019) ("val_intvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_intvcu vs_val_intvcu raw_intvcu19
isid source_year source_row
save "$VYD/N_G0_val_intvcu_2019.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_intvcu_2019"
log close vycell
