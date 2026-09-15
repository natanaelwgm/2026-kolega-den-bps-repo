* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_province_code_2014: annual staged raw state -> province_code at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2014 row 4; dprovi14 | province
log using "$VYL/N_G0_province_code_2014.log", text replace name(vycell)
generate str64 province_code=""
generate byte vs_province_code=3
replace province_code=strtrim(raw_dprovi14)
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
post cell (2014) ("province_code") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row province_code vs_province_code raw_dprovi14
isid source_year source_row
save "$VYD/N_G0_province_code_2014.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_province_code_2014"
log close vycell
