* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_pplihi_raw_2014: annual staged raw state -> pplihi_raw at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_pplihi_raw_2014.log", text replace name(vycell)
generate double pplihi_raw=.
generate byte vs_pplihi_raw=4
quietly count if !missing(pplihi_raw)
local obs=r(N)
quietly count if pplihi_raw==0
local zeros=r(N)
quietly count if inlist(vs_pplihi_raw,5,6,8)
local bad=r(N)
quietly count if vs_pplihi_raw==4
local absent=r(N)
post cell (2014) ("pplihi_raw") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row pplihi_raw vs_pplihi_raw
isid source_year source_row
save "$VYD/N_G0_pplihi_raw_2014.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_pplihi_raw_2014"
log close vycell
