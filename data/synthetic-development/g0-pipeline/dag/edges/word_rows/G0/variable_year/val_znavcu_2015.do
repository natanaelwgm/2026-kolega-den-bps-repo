* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_znavcu_2015: annual staged raw state -> val_znavcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2015 row 38; znavcu15 | accident allw non prod workers, 000rp
log using "$VYL/N_G0_val_znavcu_2015.log", text replace name(vycell)
generate double val_znavcu=.
generate byte vs_val_znavcu=3
replace val_znavcu=real(subinstr(strtrim(raw_znavcu),",","",.))*1
replace vs_val_znavcu=5 if missing(real(subinstr(strtrim(raw_znavcu),",","",.))) & !inlist(upper(strtrim(raw_znavcu)),"","***",".","NA","N/A","NULL","-")
replace vs_val_znavcu=cond(val_znavcu<0,2,cond(val_znavcu==0,1,0)) if !missing(val_znavcu)
quietly count if !missing(val_znavcu)
local obs=r(N)
quietly count if val_znavcu==0
local zeros=r(N)
quietly count if inlist(vs_val_znavcu,5,6,8)
local bad=r(N)
quietly count if vs_val_znavcu==4
local absent=r(N)
post cell (2015) ("val_znavcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_znavcu vs_val_znavcu raw_znavcu
isid source_year source_row
save "$VYD/N_G0_val_znavcu_2015.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_znavcu_2015"
log close vycell
