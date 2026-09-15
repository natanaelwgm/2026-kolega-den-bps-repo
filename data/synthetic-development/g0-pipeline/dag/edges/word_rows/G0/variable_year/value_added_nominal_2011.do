* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_value_added_nominal_2011: annual staged raw state -> value_added_nominal at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2011 row 129; vtlvcu11 | value added, 000 rp
log using "$VYL/N_G0_value_added_nominal_2011.log", text replace name(vycell)
generate double value_added_nominal=.
generate byte vs_value_added_nominal=3
replace value_added_nominal=real(subinstr(strtrim(raw_vtlvcu11),",","",.))*1
replace vs_value_added_nominal=5 if missing(real(subinstr(strtrim(raw_vtlvcu11),",","",.))) & !inlist(upper(strtrim(raw_vtlvcu11)),"","***",".","NA","N/A","NULL","-")
replace vs_value_added_nominal=cond(value_added_nominal<0,2,cond(value_added_nominal==0,1,0)) if !missing(value_added_nominal)
quietly count if !missing(value_added_nominal)
local obs=r(N)
quietly count if value_added_nominal==0
local zeros=r(N)
quietly count if inlist(vs_value_added_nominal,5,6,8)
local bad=r(N)
quietly count if vs_value_added_nominal==4
local absent=r(N)
post cell (2011) ("value_added_nominal") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row value_added_nominal vs_value_added_nominal raw_vtlvcu11
isid source_year source_row
save "$VYD/N_G0_value_added_nominal_2011.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_value_added_nominal_2011"
log close vycell
