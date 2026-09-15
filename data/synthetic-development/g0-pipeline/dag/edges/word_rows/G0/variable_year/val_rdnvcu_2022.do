* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_rdnvcu_2022: annual staged raw state -> val_rdnvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_rdnvcu_2022.log", text replace name(vycell)
generate double val_rdnvcu=.
generate byte vs_val_rdnvcu=3
replace val_rdnvcu=real(subinstr(strtrim(raw_rdnvcu22),",","",.))*1
replace vs_val_rdnvcu=5 if missing(real(subinstr(strtrim(raw_rdnvcu22),",","",.))) & !inlist(upper(strtrim(raw_rdnvcu22)),"","***",".","NA","N/A","NULL","-")
replace vs_val_rdnvcu=cond(val_rdnvcu<0,2,cond(val_rdnvcu==0,1,0)) if !missing(val_rdnvcu)
quietly count if !missing(val_rdnvcu)
local obs=r(N)
quietly count if val_rdnvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_rdnvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_rdnvcu==4
local absent=r(N)
post cell (2022) ("val_rdnvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_rdnvcu vs_val_rdnvcu raw_rdnvcu22
isid source_year source_row
save "$VYD/N_G0_val_rdnvcu_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_rdnvcu_2022"
log close vycell
