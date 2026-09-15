* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_innovation_marketing_raw_2017: annual staged raw state -> innovation_marketing_raw at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_innovation_marketing_raw_2017.log", text replace name(vycell)
generate double innovation_marketing_raw=.
generate byte vs_innovation_marketing_raw=3
replace innovation_marketing_raw=real(subinstr(strtrim(raw_inomkt17),",","",.))*1
replace vs_innovation_marketing_raw=5 if missing(real(subinstr(strtrim(raw_inomkt17),",","",.))) & !inlist(upper(strtrim(raw_inomkt17)),"","***",".","NA","N/A","NULL","-")
replace vs_innovation_marketing_raw=cond(innovation_marketing_raw<0,2,cond(innovation_marketing_raw==0,1,0)) if !missing(innovation_marketing_raw)
quietly count if !missing(innovation_marketing_raw)
local obs=r(N)
quietly count if innovation_marketing_raw==0
local zeros=r(N)
quietly count if inlist(vs_innovation_marketing_raw,5,6,8)
local bad=r(N)
quietly count if vs_innovation_marketing_raw==4
local absent=r(N)
post cell (2017) ("innovation_marketing_raw") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row innovation_marketing_raw vs_innovation_marketing_raw raw_inomkt17
isid source_year source_row
save "$VYD/N_G0_innovation_marketing_raw_2017.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_innovation_marketing_raw_2017"
log close vycell
