* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_iotvcu_2015: annual staged raw state -> val_iotvcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2015 row 97; iotvcu15 | others expenses, 000 rp
log using "$VYL/N_G0_val_iotvcu_2015.log", text replace name(vycell)
generate double val_iotvcu=.
generate byte vs_val_iotvcu=3
replace val_iotvcu=real(subinstr(strtrim(raw_iotvcu),",","",.))*1
replace vs_val_iotvcu=5 if missing(real(subinstr(strtrim(raw_iotvcu),",","",.))) & !inlist(upper(strtrim(raw_iotvcu)),"","***",".","NA","N/A","NULL","-")
replace vs_val_iotvcu=cond(val_iotvcu<0,2,cond(val_iotvcu==0,1,0)) if !missing(val_iotvcu)
quietly count if !missing(val_iotvcu)
local obs=r(N)
quietly count if val_iotvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_iotvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_iotvcu==4
local absent=r(N)
post cell (2015) ("val_iotvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_iotvcu vs_val_iotvcu raw_iotvcu
isid source_year source_row
save "$VYD/N_G0_val_iotvcu_2015.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_iotvcu_2015"
log close vycell
