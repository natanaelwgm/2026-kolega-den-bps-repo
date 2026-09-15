* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_rd_workers_2013: annual staged raw state -> rd_workers at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_rd_workers_2013.log", text replace name(vycell)
generate double rd_workers=.
generate byte vs_rd_workers=4
quietly count if !missing(rd_workers)
local obs=r(N)
quietly count if rd_workers==0
local zeros=r(N)
quietly count if inlist(vs_rd_workers,5,6,8)
local bad=r(N)
quietly count if vs_rd_workers==4
local absent=r(N)
post cell (2013) ("rd_workers") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row rd_workers vs_rd_workers
isid source_year source_row
save "$VYD/N_G0_rd_workers_2013.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_rd_workers_2013"
log close vycell
