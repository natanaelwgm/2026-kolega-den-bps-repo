* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_province_code_2017: annual staged raw state -> province_code at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_province_code_2017.log", text replace name(vycell)
generate str64 province_code=""
generate byte vs_province_code=3
replace province_code=strtrim(raw_dprovi17)
replace province_code="" if inlist(upper(province_code),"***",".","NA","N/A","NULL","-")
replace vs_province_code=0 if province_code!=""
quietly count if !missing(province_code)
local obs=r(N)
quietly count if 0
local zeros=r(N)
quietly count if inlist(vs_province_code,5,6,8)
local bad=r(N)
quietly count if vs_province_code==4
local absent=r(N)
post cell (2017) ("province_code") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row province_code vs_province_code raw_dprovi17
isid source_year source_row
save "$VYD/N_G0_province_code_2017.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_province_code_2017"
log close vycell
