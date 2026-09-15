* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_cosacu_2014: annual staged raw state -> val_cosacu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2014 row 154; cosacu14 | sale/reduce of oth fix cap, 000rp
log using "$VYL/N_G0_val_cosacu_2014.log", text replace name(vycell)
generate double val_cosacu=.
generate byte vs_val_cosacu=3
replace val_cosacu=real(subinstr(strtrim(raw_cosacu14),",","",.))*1
replace vs_val_cosacu=5 if missing(real(subinstr(strtrim(raw_cosacu14),",","",.))) & !inlist(upper(strtrim(raw_cosacu14)),"","***",".","NA","N/A","NULL","-")
replace vs_val_cosacu=cond(val_cosacu<0,2,cond(val_cosacu==0,1,0)) if !missing(val_cosacu)
quietly count if !missing(val_cosacu)
local obs=r(N)
quietly count if val_cosacu==0
local zeros=r(N)
quietly count if inlist(vs_val_cosacu,5,6,8)
local bad=r(N)
quietly count if vs_val_cosacu==4
local absent=r(N)
post cell (2014) ("val_cosacu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_cosacu vs_val_cosacu raw_cosacu14
isid source_year source_row
save "$VYD/N_G0_val_cosacu_2014.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_cosacu_2014"
log close vycell
