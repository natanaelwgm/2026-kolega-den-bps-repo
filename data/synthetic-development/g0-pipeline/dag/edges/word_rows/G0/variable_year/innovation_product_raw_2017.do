* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_innovation_product_raw_2017: annual staged raw state -> innovation_product_raw at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_innovation_product_raw_2017.log", text replace name(vycell)
generate double innovation_product_raw=.
generate byte vs_innovation_product_raw=3
replace innovation_product_raw=real(subinstr(strtrim(raw_inoprd17),",","",.))*1
replace vs_innovation_product_raw=5 if missing(real(subinstr(strtrim(raw_inoprd17),",","",.))) & !inlist(upper(strtrim(raw_inoprd17)),"","***",".","NA","N/A","NULL","-")
replace vs_innovation_product_raw=cond(innovation_product_raw<0,2,cond(innovation_product_raw==0,1,0)) if !missing(innovation_product_raw)
quietly count if !missing(innovation_product_raw)
local obs=r(N)
quietly count if innovation_product_raw==0
local zeros=r(N)
quietly count if inlist(vs_innovation_product_raw,5,6,8)
local bad=r(N)
quietly count if vs_innovation_product_raw==4
local absent=r(N)
post cell (2017) ("innovation_product_raw") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row innovation_product_raw vs_innovation_product_raw raw_inoprd17
isid source_year source_row
save "$VYD/N_G0_innovation_product_raw_2017.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_innovation_product_raw_2017"
log close vycell
