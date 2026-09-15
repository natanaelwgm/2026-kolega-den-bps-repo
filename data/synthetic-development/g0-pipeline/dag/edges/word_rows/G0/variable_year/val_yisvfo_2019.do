* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_yisvfo_2019: annual staged raw state -> val_yisvfo at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_yisvfo_2019.log", text replace name(vycell)
generate double val_yisvfo=.
generate byte vs_val_yisvfo=3
replace val_yisvfo=real(subinstr(strtrim(raw_yisvfo19),",","",.))*1
replace vs_val_yisvfo=5 if missing(real(subinstr(strtrim(raw_yisvfo19),",","",.))) & !inlist(upper(strtrim(raw_yisvfo19)),"","***",".","NA","N/A","NULL","-")
replace vs_val_yisvfo=cond(val_yisvfo<0,2,cond(val_yisvfo==0,1,0)) if !missing(val_yisvfo)
quietly count if !missing(val_yisvfo)
local obs=r(N)
quietly count if val_yisvfo==0
local zeros=r(N)
quietly count if inlist(vs_val_yisvfo,5,6,8)
local bad=r(N)
quietly count if vs_val_yisvfo==4
local absent=r(N)
post cell (2019) ("val_yisvfo") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_yisvfo vs_val_yisvfo raw_yisvfo19
isid source_year source_row
save "$VYD/N_G0_val_yisvfo_2019.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_yisvfo_2019"
log close vycell
