* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_egavcu_2010: annual staged raw state -> val_egavcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2010 row 51; egavcu10 | total public pgn used, 000 rp
log using "$VYL/N_G0_val_egavcu_2010.log", text replace name(vycell)
generate double val_egavcu=.
generate byte vs_val_egavcu=3
replace val_egavcu=real(subinstr(strtrim(raw_egavcu10),",","",.))*1
replace vs_val_egavcu=5 if missing(real(subinstr(strtrim(raw_egavcu10),",","",.))) & !inlist(upper(strtrim(raw_egavcu10)),"","***",".","NA","N/A","NULL","-")
replace vs_val_egavcu=cond(val_egavcu<0,2,cond(val_egavcu==0,1,0)) if !missing(val_egavcu)
quietly count if !missing(val_egavcu)
local obs=r(N)
quietly count if val_egavcu==0
local zeros=r(N)
quietly count if inlist(vs_val_egavcu,5,6,8)
local bad=r(N)
quietly count if vs_val_egavcu==4
local absent=r(N)
post cell (2010) ("val_egavcu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_egavcu vs_val_egavcu raw_egavcu10
isid source_year source_row
save "$VYD/N_G0_val_egavcu_2010.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_egavcu_2010"
log close vycell
