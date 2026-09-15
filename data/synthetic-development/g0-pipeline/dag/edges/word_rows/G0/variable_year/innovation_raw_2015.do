* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_innovation_raw_2015: annual staged raw state -> innovation_raw at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_innovation_raw_2015.log", text replace name(vycell)
generate double innovation_raw=.
generate byte vs_innovation_raw=4
quietly count if !missing(innovation_raw)
local obs=r(N)
quietly count if innovation_raw==0
local zeros=r(N)
quietly count if inlist(vs_innovation_raw,5,6,8)
local bad=r(N)
quietly count if vs_innovation_raw==4
local absent=r(N)
post cell (2015) ("innovation_raw") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row innovation_raw vs_innovation_raw
isid source_year source_row
save "$VYD/N_G0_innovation_raw_2015.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_innovation_raw_2015"
log close vycell
