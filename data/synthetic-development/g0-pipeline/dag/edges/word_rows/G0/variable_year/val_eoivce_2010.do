* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_eoivce_2010: annual staged raw state -> val_eoivce at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2010 row 45; eoivce10 | kerosene used for elec gen, 000 rp
log using "$VYL/N_G0_val_eoivce_2010.log", text replace name(vycell)
generate double val_eoivce=.
generate byte vs_val_eoivce=3
replace val_eoivce=real(subinstr(strtrim(raw_eoivce10),",","",.))*1
replace vs_val_eoivce=5 if missing(real(subinstr(strtrim(raw_eoivce10),",","",.))) & !inlist(upper(strtrim(raw_eoivce10)),"","***",".","NA","N/A","NULL","-")
replace vs_val_eoivce=cond(val_eoivce<0,2,cond(val_eoivce==0,1,0)) if !missing(val_eoivce)
quietly count if !missing(val_eoivce)
local obs=r(N)
quietly count if val_eoivce==0
local zeros=r(N)
quietly count if inlist(vs_val_eoivce,5,6,8)
local bad=r(N)
quietly count if vs_val_eoivce==4
local absent=r(N)
post cell (2010) ("val_eoivce") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_eoivce vs_val_eoivce raw_eoivce10
isid source_year source_row
save "$VYD/N_G0_val_eoivce_2010.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_eoivce_2010"
log close vycell
