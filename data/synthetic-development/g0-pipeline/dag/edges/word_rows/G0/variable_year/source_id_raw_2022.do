* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_source_id_raw_2022: annual staged raw state -> source_id_raw at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_source_id_raw_2022.log", text replace name(vycell)
generate str64 source_id_raw=""
generate byte vs_source_id_raw=3
replace source_id_raw=strtrim(raw_kipb)
replace source_id_raw="" if inlist(upper(source_id_raw),"***",".","NA","N/A","NULL","-")
replace vs_source_id_raw=0 if source_id_raw!=""
quietly count if !missing(source_id_raw)
local obs=r(N)
quietly count if 0
local zeros=r(N)
quietly count if inlist(vs_source_id_raw,5,6,8)
local bad=r(N)
quietly count if vs_source_id_raw==4
local absent=r(N)
post cell (2022) ("source_id_raw") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row source_id_raw vs_source_id_raw raw_kipb
isid source_year source_row
save "$VYD/N_G0_source_id_raw_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_source_id_raw_2022"
log close vycell
