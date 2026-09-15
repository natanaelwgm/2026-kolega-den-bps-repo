* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_amdal_raw_2021: annual staged raw state -> amdal_raw at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_amdal_raw_2021.log", text replace name(vycell)
generate double amdal_raw=.
generate byte vs_amdal_raw=3
replace amdal_raw=real(subinstr(strtrim(raw_amdal21),",","",.))*1
replace vs_amdal_raw=5 if missing(real(subinstr(strtrim(raw_amdal21),",","",.))) & !inlist(upper(strtrim(raw_amdal21)),"","***",".","NA","N/A","NULL","-")
replace vs_amdal_raw=cond(amdal_raw<0,2,cond(amdal_raw==0,1,0)) if !missing(amdal_raw)
quietly count if !missing(amdal_raw)
local obs=r(N)
quietly count if amdal_raw==0
local zeros=r(N)
quietly count if inlist(vs_amdal_raw,5,6,8)
local bad=r(N)
quietly count if vs_amdal_raw==4
local absent=r(N)
post cell (2021) ("amdal_raw") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row amdal_raw vs_amdal_raw raw_amdal21
isid source_year source_row
save "$VYD/N_G0_amdal_raw_2021.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_amdal_raw_2021"
log close vycell
