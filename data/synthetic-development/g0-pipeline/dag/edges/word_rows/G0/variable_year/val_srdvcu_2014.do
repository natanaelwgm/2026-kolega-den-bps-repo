* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_srdvcu_2014: annual staged raw state -> val_srdvcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2014 row 129; srdvcu14 | stock raw matrl,etc end year, 000 rp
log using "$VYL/N_G0_val_srdvcu_2014.log", text replace name(vycell)
generate double val_srdvcu=.
generate byte vs_val_srdvcu=3
replace val_srdvcu=real(subinstr(strtrim(raw_srdvcu14),",","",.))*1
replace vs_val_srdvcu=5 if missing(real(subinstr(strtrim(raw_srdvcu14),",","",.))) & !inlist(upper(strtrim(raw_srdvcu14)),"","***",".","NA","N/A","NULL","-")
replace vs_val_srdvcu=cond(val_srdvcu<0,2,cond(val_srdvcu==0,1,0)) if !missing(val_srdvcu)
quietly count if !missing(val_srdvcu)
local obs=r(N)
quietly count if val_srdvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_srdvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_srdvcu==4
local absent=r(N)
post cell (2014) ("val_srdvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_srdvcu vs_val_srdvcu raw_srdvcu14
isid source_year source_row
save "$VYD/N_G0_val_srdvcu_2014.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_srdvcu_2014"
log close vycell
