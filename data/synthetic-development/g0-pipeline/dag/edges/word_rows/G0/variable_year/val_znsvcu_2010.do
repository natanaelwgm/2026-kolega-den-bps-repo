* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_znsvcu_2010: annual staged raw state -> val_znsvcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2010 row 28; znsvcu10 | wage/salary non prod workers, 000rp
log using "$VYL/N_G0_val_znsvcu_2010.log", text replace name(vycell)
generate double val_znsvcu=.
generate byte vs_val_znsvcu=3
replace val_znsvcu=real(subinstr(strtrim(raw_znsvcu10),",","",.))*1
replace vs_val_znsvcu=5 if missing(real(subinstr(strtrim(raw_znsvcu10),",","",.))) & !inlist(upper(strtrim(raw_znsvcu10)),"","***",".","NA","N/A","NULL","-")
replace vs_val_znsvcu=cond(val_znsvcu<0,2,cond(val_znsvcu==0,1,0)) if !missing(val_znsvcu)
quietly count if !missing(val_znsvcu)
local obs=r(N)
quietly count if val_znsvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_znsvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_znsvcu==4
local absent=r(N)
post cell (2010) ("val_znsvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_znsvcu vs_val_znsvcu raw_znsvcu10
isid source_year source_row
save "$VYD/N_G0_val_znsvcu_2010.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_znsvcu_2010"
log close vycell
