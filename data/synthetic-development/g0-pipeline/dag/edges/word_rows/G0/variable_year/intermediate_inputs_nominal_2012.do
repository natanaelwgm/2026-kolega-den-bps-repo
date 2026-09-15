* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_intermediate_inputs_nominal_2012: annual staged raw state -> intermediate_inputs_nominal at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2012 row 11; iinput12 | total intermediate input, 000 rp
log using "$VYL/N_G0_intermediate_inputs_nominal_2012.log", text replace name(vycell)
generate double intermediate_inputs_nominal=.
generate byte vs_intermediate_inputs_nominal=3
replace intermediate_inputs_nominal=real(subinstr(strtrim(raw_iinput12),",","",.))*1
replace vs_intermediate_inputs_nominal=5 if missing(real(subinstr(strtrim(raw_iinput12),",","",.))) & !inlist(upper(strtrim(raw_iinput12)),"","***",".","NA","N/A","NULL","-")
replace vs_intermediate_inputs_nominal=cond(intermediate_inputs_nominal<0,2,cond(intermediate_inputs_nominal==0,1,0)) if !missing(intermediate_inputs_nominal)
quietly count if !missing(intermediate_inputs_nominal)
local obs=r(N)
quietly count if intermediate_inputs_nominal==0
local zeros=r(N)
quietly count if inlist(vs_intermediate_inputs_nominal,5,6,8)
local bad=r(N)
quietly count if vs_intermediate_inputs_nominal==4
local absent=r(N)
post cell (2012) ("intermediate_inputs_nominal") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row intermediate_inputs_nominal vs_intermediate_inputs_nominal raw_iinput12
isid source_year source_row
save "$VYD/N_G0_intermediate_inputs_nominal_2012.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_intermediate_inputs_nominal_2012"
log close vycell
