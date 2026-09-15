* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_iotvcu_2018: annual staged raw state -> val_iotvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_iotvcu_2018.log", text replace name(vycell)
generate double val_iotvcu=.
generate byte vs_val_iotvcu=3
replace val_iotvcu=real(subinstr(strtrim(raw_iotvcu18),",","",.))*1
replace vs_val_iotvcu=5 if missing(real(subinstr(strtrim(raw_iotvcu18),",","",.))) & !inlist(upper(strtrim(raw_iotvcu18)),"","***",".","NA","N/A","NULL","-")
replace vs_val_iotvcu=cond(val_iotvcu<0,2,cond(val_iotvcu==0,1,0)) if !missing(val_iotvcu)
quietly count if !missing(val_iotvcu)
local obs=r(N)
quietly count if val_iotvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_iotvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_iotvcu==4
local absent=r(N)
post cell (2018) ("val_iotvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_iotvcu vs_val_iotvcu raw_iotvcu18
isid source_year source_row
save "$VYD/N_G0_val_iotvcu_2018.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_iotvcu_2018"
log close vycell
