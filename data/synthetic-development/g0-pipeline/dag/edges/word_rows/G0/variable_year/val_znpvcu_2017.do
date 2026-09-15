* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_znpvcu_2017: annual staged raw state -> val_znpvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_znpvcu_2017.log", text replace name(vycell)
generate double val_znpvcu=.
generate byte vs_val_znpvcu=3
replace val_znpvcu=real(subinstr(strtrim(raw_znpvcu17),",","",.))*1
replace vs_val_znpvcu=5 if missing(real(subinstr(strtrim(raw_znpvcu17),",","",.))) & !inlist(upper(strtrim(raw_znpvcu17)),"","***",".","NA","N/A","NULL","-")
replace vs_val_znpvcu=cond(val_znpvcu<0,2,cond(val_znpvcu==0,1,0)) if !missing(val_znpvcu)
quietly count if !missing(val_znpvcu)
local obs=r(N)
quietly count if val_znpvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_znpvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_znpvcu==4
local absent=r(N)
post cell (2017) ("val_znpvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_znpvcu vs_val_znpvcu raw_znpvcu17
isid source_year source_row
save "$VYD/N_G0_val_znpvcu_2017.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_znpvcu_2017"
log close vycell
