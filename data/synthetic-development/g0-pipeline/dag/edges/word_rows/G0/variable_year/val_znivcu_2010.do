* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_znivcu_2010: annual staged raw state -> val_znivcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2010 row 30; znivcu10 | bonus non prod workers, 000rp
log using "$VYL/N_G0_val_znivcu_2010.log", text replace name(vycell)
generate double val_znivcu=.
generate byte vs_val_znivcu=3
replace val_znivcu=real(subinstr(strtrim(raw_znivcu10),",","",.))*1
replace vs_val_znivcu=5 if missing(real(subinstr(strtrim(raw_znivcu10),",","",.))) & !inlist(upper(strtrim(raw_znivcu10)),"","***",".","NA","N/A","NULL","-")
replace vs_val_znivcu=cond(val_znivcu<0,2,cond(val_znivcu==0,1,0)) if !missing(val_znivcu)
quietly count if !missing(val_znivcu)
local obs=r(N)
quietly count if val_znivcu==0
local zeros=r(N)
quietly count if inlist(vs_val_znivcu,5,6,8)
local bad=r(N)
quietly count if vs_val_znivcu==4
local absent=r(N)
post cell (2010) ("val_znivcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_znivcu vs_val_znivcu raw_znivcu10
isid source_year source_row
save "$VYD/N_G0_val_znivcu_2010.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_znivcu_2010"
log close vycell
