* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_ykdvcu_2019: annual staged raw state -> val_ykdvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_ykdvcu_2019.log", text replace name(vycell)
generate double val_ykdvcu=.
generate byte vs_val_ykdvcu=3
replace val_ykdvcu=real(subinstr(strtrim(raw_ykdvcu19),",","",.))*1
replace vs_val_ykdvcu=5 if missing(real(subinstr(strtrim(raw_ykdvcu19),",","",.))) & !inlist(upper(strtrim(raw_ykdvcu19)),"","***",".","NA","N/A","NULL","-")
replace vs_val_ykdvcu=cond(val_ykdvcu<0,2,cond(val_ykdvcu==0,1,0)) if !missing(val_ykdvcu)
quietly count if !missing(val_ykdvcu)
local obs=r(N)
quietly count if val_ykdvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_ykdvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_ykdvcu==4
local absent=r(N)
post cell (2019) ("val_ykdvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_ykdvcu vs_val_ykdvcu raw_ykdvcu19
isid source_year source_row
save "$VYD/N_G0_val_ykdvcu_2019.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_ykdvcu_2019"
log close vycell
