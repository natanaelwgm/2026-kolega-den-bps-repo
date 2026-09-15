* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_innovation_product_raw_2020: annual staged raw state -> innovation_product_raw at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_innovation_product_raw_2020.log", text replace name(vycell)
generate double innovation_product_raw=.
generate byte vs_innovation_product_raw=4
quietly count if !missing(innovation_product_raw)
local obs=r(N)
quietly count if innovation_product_raw==0
local zeros=r(N)
quietly count if inlist(vs_innovation_product_raw,5,6,8)
local bad=r(N)
quietly count if vs_innovation_product_raw==4
local absent=r(N)
post cell (2020) ("innovation_product_raw") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row innovation_product_raw vs_innovation_product_raw
isid source_year source_row
save "$VYD/N_G0_innovation_product_raw_2020.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_innovation_product_raw_2020"
log close vycell
