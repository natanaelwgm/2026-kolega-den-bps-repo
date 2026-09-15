* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_export_share_pct_2017: annual staged raw state -> export_share_pct at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_export_share_pct_2017.log", text replace name(vycell)
generate double export_share_pct=.
generate byte vs_export_share_pct=4
quietly count if !missing(export_share_pct)
local obs=r(N)
quietly count if export_share_pct==0
local zeros=r(N)
quietly count if inlist(vs_export_share_pct,5,6,8)
local bad=r(N)
quietly count if vs_export_share_pct==4
local absent=r(N)
post cell (2017) ("export_share_pct") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row export_share_pct vs_export_share_pct
isid source_year source_row
save "$VYD/N_G0_export_share_pct_2017.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_export_share_pct_2017"
log close vycell
