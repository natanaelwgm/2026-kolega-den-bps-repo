* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_epevce_2010: annual staged raw state -> val_epevce at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2010 row 37; epevce10 | premium/gasoline used for elec gen,000
log using "$VYL/N_G0_val_epevce_2010.log", text replace name(vycell)
generate double val_epevce=.
generate byte vs_val_epevce=3
replace val_epevce=real(subinstr(strtrim(raw_epevce10),",","",.))*1
replace vs_val_epevce=5 if missing(real(subinstr(strtrim(raw_epevce10),",","",.))) & !inlist(upper(strtrim(raw_epevce10)),"","***",".","NA","N/A","NULL","-")
replace vs_val_epevce=cond(val_epevce<0,2,cond(val_epevce==0,1,0)) if !missing(val_epevce)
quietly count if !missing(val_epevce)
local obs=r(N)
quietly count if val_epevce==0
local zeros=r(N)
quietly count if inlist(vs_val_epevce,5,6,8)
local bad=r(N)
quietly count if vs_val_epevce==4
local absent=r(N)
post cell (2010) ("val_epevce") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_epevce vs_val_epevce raw_epevce10
isid source_year source_row
save "$VYD/N_G0_val_epevce_2010.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_epevce_2010"
log close vycell
