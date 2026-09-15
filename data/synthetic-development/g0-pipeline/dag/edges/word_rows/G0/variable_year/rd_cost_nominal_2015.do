* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_rd_cost_nominal_2015: annual staged raw state -> rd_cost_nominal at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_rd_cost_nominal_2015.log", text replace name(vycell)
generate double rd_cost_nominal=.
generate byte vs_rd_cost_nominal=4
quietly count if !missing(rd_cost_nominal)
local obs=r(N)
quietly count if rd_cost_nominal==0
local zeros=r(N)
quietly count if inlist(vs_rd_cost_nominal,5,6,8)
local bad=r(N)
quietly count if vs_rd_cost_nominal==4
local absent=r(N)
post cell (2015) ("rd_cost_nominal") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row rd_cost_nominal vs_rd_cost_nominal
isid source_year source_row
save "$VYD/N_G0_rd_cost_nominal_2015.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_rd_cost_nominal_2015"
log close vycell
