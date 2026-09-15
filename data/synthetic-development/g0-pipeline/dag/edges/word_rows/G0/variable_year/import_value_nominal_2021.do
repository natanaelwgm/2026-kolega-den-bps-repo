* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_import_value_nominal_2021: annual staged raw state -> import_value_nominal at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_import_value_nominal_2021.log", text replace name(vycell)
generate double import_value_nominal=.
generate byte vs_import_value_nominal=3
replace import_value_nominal=real(subinstr(strtrim(raw_rimvcu21),",","",.))*1
replace vs_import_value_nominal=5 if missing(real(subinstr(strtrim(raw_rimvcu21),",","",.))) & !inlist(upper(strtrim(raw_rimvcu21)),"","***",".","NA","N/A","NULL","-")
replace vs_import_value_nominal=cond(import_value_nominal<0,2,cond(import_value_nominal==0,1,0)) if !missing(import_value_nominal)
quietly count if !missing(import_value_nominal)
local obs=r(N)
quietly count if import_value_nominal==0
local zeros=r(N)
quietly count if inlist(vs_import_value_nominal,5,6,8)
local bad=r(N)
quietly count if vs_import_value_nominal==4
local absent=r(N)
post cell (2021) ("import_value_nominal") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row import_value_nominal vs_import_value_nominal raw_rimvcu21
isid source_year source_row
save "$VYD/N_G0_import_value_nominal_2021.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_import_value_nominal_2021"
log close vycell
