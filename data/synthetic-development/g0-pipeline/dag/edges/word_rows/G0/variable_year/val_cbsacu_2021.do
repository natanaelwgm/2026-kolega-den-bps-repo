* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_cbsacu_2021: annual staged raw state -> val_cbsacu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_cbsacu_2021.log", text replace name(vycell)
generate double val_cbsacu=.
generate byte vs_val_cbsacu=3
replace val_cbsacu=real(subinstr(strtrim(raw_cbsacu21),",","",.))*1
replace vs_val_cbsacu=5 if missing(real(subinstr(strtrim(raw_cbsacu21),",","",.))) & !inlist(upper(strtrim(raw_cbsacu21)),"","***",".","NA","N/A","NULL","-")
replace vs_val_cbsacu=cond(val_cbsacu<0,2,cond(val_cbsacu==0,1,0)) if !missing(val_cbsacu)
quietly count if !missing(val_cbsacu)
local obs=r(N)
quietly count if val_cbsacu==0
local zeros=r(N)
quietly count if inlist(vs_val_cbsacu,5,6,8)
local bad=r(N)
quietly count if vs_val_cbsacu==4
local absent=r(N)
post cell (2021) ("val_cbsacu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_cbsacu vs_val_cbsacu raw_cbsacu21
isid source_year source_row
save "$VYD/N_G0_val_cbsacu_2021.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_cbsacu_2021"
log close vycell
