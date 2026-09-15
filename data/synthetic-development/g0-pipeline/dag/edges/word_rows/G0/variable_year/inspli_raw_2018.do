* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_inspli_raw_2018: annual staged raw state -> inspli_raw at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_inspli_raw_2018.log", text replace name(vycell)
generate double inspli_raw=.
generate byte vs_inspli_raw=4
quietly count if !missing(inspli_raw)
local obs=r(N)
quietly count if inspli_raw==0
local zeros=r(N)
quietly count if inlist(vs_inspli_raw,5,6,8)
local bad=r(N)
quietly count if vs_inspli_raw==4
local absent=r(N)
post cell (2018) ("inspli_raw") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row inspli_raw vs_inspli_raw
isid source_year source_row
save "$VYD/N_G0_inspli_raw_2018.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_inspli_raw_2018"
log close vycell
