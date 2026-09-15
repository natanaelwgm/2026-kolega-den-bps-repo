* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_gross_output_nominal_2015: annual staged raw state -> gross_output_nominal at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2015 row 144; output15 | total output, 000 rp
log using "$VYL/N_G0_gross_output_nominal_2015.log", text replace name(vycell)
generate double gross_output_nominal=.
generate byte vs_gross_output_nominal=3
replace gross_output_nominal=real(subinstr(strtrim(raw_output15),",","",.))*1
replace vs_gross_output_nominal=5 if missing(real(subinstr(strtrim(raw_output15),",","",.))) & !inlist(upper(strtrim(raw_output15)),"","***",".","NA","N/A","NULL","-")
replace vs_gross_output_nominal=cond(gross_output_nominal<0,2,cond(gross_output_nominal==0,1,0)) if !missing(gross_output_nominal)
quietly count if !missing(gross_output_nominal)
local obs=r(N)
quietly count if gross_output_nominal==0
local zeros=r(N)
quietly count if inlist(vs_gross_output_nominal,5,6,8)
local bad=r(N)
quietly count if vs_gross_output_nominal==4
local absent=r(N)
post cell (2015) ("gross_output_nominal") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row gross_output_nominal vs_gross_output_nominal raw_output15
isid source_year source_row
save "$VYD/N_G0_gross_output_nominal_2015.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_gross_output_nominal_2015"
log close vycell
