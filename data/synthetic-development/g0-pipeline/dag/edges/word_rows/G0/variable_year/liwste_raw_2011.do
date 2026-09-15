* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_liwste_raw_2011: annual staged raw state -> liwste_raw at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_liwste_raw_2011.log", text replace name(vycell)
generate double liwste_raw=.
generate byte vs_liwste_raw=4
quietly count if !missing(liwste_raw)
local obs=r(N)
quietly count if liwste_raw==0
local zeros=r(N)
quietly count if inlist(vs_liwste_raw,5,6,8)
local bad=r(N)
quietly count if vs_liwste_raw==4
local absent=r(N)
post cell (2011) ("liwste_raw") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row liwste_raw vs_liwste_raw
isid source_year source_row
save "$VYD/N_G0_liwste_raw_2011.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_liwste_raw_2011"
log close vycell
