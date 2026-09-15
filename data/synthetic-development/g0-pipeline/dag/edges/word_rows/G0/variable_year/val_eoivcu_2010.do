* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_eoivcu_2010: annual staged raw state -> val_eoivcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2010 row 43; eoivcu10 | total kerosene used, 000 rp
log using "$VYL/N_G0_val_eoivcu_2010.log", text replace name(vycell)
generate double val_eoivcu=.
generate byte vs_val_eoivcu=3
replace val_eoivcu=real(subinstr(strtrim(raw_eoivcu10),",","",.))*1
replace vs_val_eoivcu=5 if missing(real(subinstr(strtrim(raw_eoivcu10),",","",.))) & !inlist(upper(strtrim(raw_eoivcu10)),"","***",".","NA","N/A","NULL","-")
replace vs_val_eoivcu=cond(val_eoivcu<0,2,cond(val_eoivcu==0,1,0)) if !missing(val_eoivcu)
quietly count if !missing(val_eoivcu)
local obs=r(N)
quietly count if val_eoivcu==0
local zeros=r(N)
quietly count if inlist(vs_val_eoivcu,5,6,8)
local bad=r(N)
quietly count if vs_val_eoivcu==4
local absent=r(N)
post cell (2010) ("val_eoivcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_eoivcu vs_val_eoivcu raw_eoivcu10
isid source_year source_row
save "$VYD/N_G0_val_eoivcu_2010.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_eoivcu_2010"
log close vycell
