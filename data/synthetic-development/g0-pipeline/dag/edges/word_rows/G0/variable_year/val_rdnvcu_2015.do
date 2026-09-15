* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_rdnvcu_2015: annual staged raw state -> val_rdnvcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2015 row 99; rdnvcu15 | domestic raw material used, 000rp
log using "$VYL/N_G0_val_rdnvcu_2015.log", text replace name(vycell)
generate double val_rdnvcu=.
generate byte vs_val_rdnvcu=3
replace val_rdnvcu=real(subinstr(strtrim(raw_rdnvcu),",","",.))*1
replace vs_val_rdnvcu=5 if missing(real(subinstr(strtrim(raw_rdnvcu),",","",.))) & !inlist(upper(strtrim(raw_rdnvcu)),"","***",".","NA","N/A","NULL","-")
replace vs_val_rdnvcu=cond(val_rdnvcu<0,2,cond(val_rdnvcu==0,1,0)) if !missing(val_rdnvcu)
quietly count if !missing(val_rdnvcu)
local obs=r(N)
quietly count if val_rdnvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_rdnvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_rdnvcu==4
local absent=r(N)
post cell (2015) ("val_rdnvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_rdnvcu vs_val_rdnvcu raw_rdnvcu
isid source_year source_row
save "$VYD/N_G0_val_rdnvcu_2015.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_rdnvcu_2015"
log close vycell
