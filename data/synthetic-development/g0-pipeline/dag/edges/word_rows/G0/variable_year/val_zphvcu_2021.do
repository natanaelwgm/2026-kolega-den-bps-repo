* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_zphvcu_2021: annual staged raw state -> val_zphvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_zphvcu_2021.log", text replace name(vycell)
generate double val_zphvcu=.
generate byte vs_val_zphvcu=3
replace val_zphvcu=real(subinstr(strtrim(raw_zphvcu21),",","",.))*1
replace vs_val_zphvcu=5 if missing(real(subinstr(strtrim(raw_zphvcu21),",","",.))) & !inlist(upper(strtrim(raw_zphvcu21)),"","***",".","NA","N/A","NULL","-")
replace vs_val_zphvcu=cond(val_zphvcu<0,2,cond(val_zphvcu==0,1,0)) if !missing(val_zphvcu)
quietly count if !missing(val_zphvcu)
local obs=r(N)
quietly count if val_zphvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_zphvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_zphvcu==4
local absent=r(N)
post cell (2021) ("val_zphvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_zphvcu vs_val_zphvcu raw_zphvcu21
isid source_year source_row
save "$VYD/N_G0_val_zphvcu_2021.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_zphvcu_2021"
log close vycell
