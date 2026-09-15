* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_zppvcu_2010: annual staged raw state -> val_zppvcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2010 row 25; zppvcu10 | pension-soc allw-ins prod workers, 000rp
log using "$VYL/N_G0_val_zppvcu_2010.log", text replace name(vycell)
generate double val_zppvcu=.
generate byte vs_val_zppvcu=3
replace val_zppvcu=real(subinstr(strtrim(raw_zppvcu10),",","",.))*1
replace vs_val_zppvcu=5 if missing(real(subinstr(strtrim(raw_zppvcu10),",","",.))) & !inlist(upper(strtrim(raw_zppvcu10)),"","***",".","NA","N/A","NULL","-")
replace vs_val_zppvcu=cond(val_zppvcu<0,2,cond(val_zppvcu==0,1,0)) if !missing(val_zppvcu)
quietly count if !missing(val_zppvcu)
local obs=r(N)
quietly count if val_zppvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_zppvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_zppvcu==4
local absent=r(N)
post cell (2010) ("val_zppvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_zppvcu vs_val_zppvcu raw_zppvcu10
isid source_year source_row
save "$VYD/N_G0_val_zppvcu_2010.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_zppvcu_2010"
log close vycell
