* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_district_code_2012: annual staged raw state -> district_code at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2012 row 4; dkabup12 | regency/municipality
log using "$VYL/N_G0_district_code_2012.log", text replace name(vycell)
generate str64 district_code=""
generate byte vs_district_code=3
replace district_code=strtrim(raw_dkabup12)
replace district_code="" if inlist(upper(district_code),"***",".","NA","N/A","NULL","-")
replace vs_district_code=0 if district_code!=""
quietly count if !missing(district_code)
local obs=r(N)
quietly count if 0
local zeros=r(N)
quietly count if inlist(vs_district_code,5,6,8)
local bad=r(N)
quietly count if vs_district_code==4
local absent=r(N)
post cell (2012) ("district_code") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row district_code vs_district_code raw_dkabup12
isid source_year source_row
save "$VYD/N_G0_district_code_2012.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_district_code_2012"
log close vycell
