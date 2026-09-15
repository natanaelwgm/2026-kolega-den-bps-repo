* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_yrsvcu_2020: annual staged raw state -> val_yrsvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_yrsvcu_2020.log", text replace name(vycell)
generate double val_yrsvcu=.
generate byte vs_val_yrsvcu=3
replace val_yrsvcu=real(subinstr(strtrim(raw_yrsvcu20),",","",.))*1
replace vs_val_yrsvcu=5 if missing(real(subinstr(strtrim(raw_yrsvcu20),",","",.))) & !inlist(upper(strtrim(raw_yrsvcu20)),"","***",".","NA","N/A","NULL","-")
replace vs_val_yrsvcu=cond(val_yrsvcu<0,2,cond(val_yrsvcu==0,1,0)) if !missing(val_yrsvcu)
quietly count if !missing(val_yrsvcu)
local obs=r(N)
quietly count if val_yrsvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_yrsvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_yrsvcu==4
local absent=r(N)
post cell (2020) ("val_yrsvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_yrsvcu vs_val_yrsvcu raw_yrsvcu20
isid source_year source_row
save "$VYD/N_G0_val_yrsvcu_2020.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_yrsvcu_2020"
log close vycell
