* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_rdnvcu_2012: annual staged raw state -> val_rdnvcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2012 row 79; rdnvcu12 | domestic raw material used, 000rp
log using "$VYL/N_G0_val_rdnvcu_2012.log", text replace name(vycell)
generate double val_rdnvcu=.
generate byte vs_val_rdnvcu=3
replace val_rdnvcu=real(subinstr(strtrim(raw_rdnvcu12),",","",.))*1
replace vs_val_rdnvcu=5 if missing(real(subinstr(strtrim(raw_rdnvcu12),",","",.))) & !inlist(upper(strtrim(raw_rdnvcu12)),"","***",".","NA","N/A","NULL","-")
replace vs_val_rdnvcu=cond(val_rdnvcu<0,2,cond(val_rdnvcu==0,1,0)) if !missing(val_rdnvcu)
quietly count if !missing(val_rdnvcu)
local obs=r(N)
quietly count if val_rdnvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_rdnvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_rdnvcu==4
local absent=r(N)
post cell (2012) ("val_rdnvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_rdnvcu vs_val_rdnvcu raw_rdnvcu12
isid source_year source_row
save "$VYD/N_G0_val_rdnvcu_2012.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_rdnvcu_2012"
log close vycell
