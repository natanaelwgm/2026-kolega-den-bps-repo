* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_industry_code_2022: annual staged raw state -> industry_code at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_industry_code_2022.log", text replace name(vycell)
generate str64 industry_code=""
generate byte vs_industry_code=3
replace industry_code=strtrim(raw_disic522)
replace industry_code="" if inlist(upper(industry_code),"***",".","NA","N/A","NULL","-")
replace vs_industry_code=0 if industry_code!=""
quietly count if !missing(industry_code)
local obs=r(N)
quietly count if 0
local zeros=r(N)
quietly count if inlist(vs_industry_code,5,6,8)
local bad=r(N)
quietly count if vs_industry_code==4
local absent=r(N)
post cell (2022) ("industry_code") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row industry_code vs_industry_code raw_disic522
isid source_year source_row
save "$VYD/N_G0_industry_code_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_industry_code_2022"
log close vycell
