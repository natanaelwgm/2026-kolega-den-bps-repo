* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_iisvcu_2012: annual staged raw state -> val_iisvcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2012 row 74; iisvcu12 | manufact serv by others, 000 rp
log using "$VYL/N_G0_val_iisvcu_2012.log", text replace name(vycell)
generate double val_iisvcu=.
generate byte vs_val_iisvcu=3
replace val_iisvcu=real(subinstr(strtrim(raw_iisvcu12),",","",.))*1
replace vs_val_iisvcu=5 if missing(real(subinstr(strtrim(raw_iisvcu12),",","",.))) & !inlist(upper(strtrim(raw_iisvcu12)),"","***",".","NA","N/A","NULL","-")
replace vs_val_iisvcu=cond(val_iisvcu<0,2,cond(val_iisvcu==0,1,0)) if !missing(val_iisvcu)
quietly count if !missing(val_iisvcu)
local obs=r(N)
quietly count if val_iisvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_iisvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_iisvcu==4
local absent=r(N)
post cell (2012) ("val_iisvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_iisvcu vs_val_iisvcu raw_iisvcu12
isid source_year source_row
save "$VYD/N_G0_val_iisvcu_2012.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_iisvcu_2012"
log close vycell
