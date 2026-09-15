* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_export_share_pct_2019: annual staged raw state -> export_share_pct at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_export_share_pct_2019.log", text replace name(vycell)
generate double export_share_pct=.
generate byte vs_export_share_pct=3
replace export_share_pct=real(subinstr(strtrim(raw_prprex19),",","",.))*1
replace vs_export_share_pct=5 if missing(real(subinstr(strtrim(raw_prprex19),",","",.))) & !inlist(upper(strtrim(raw_prprex19)),"","***",".","NA","N/A","NULL","-")
replace vs_export_share_pct=cond(export_share_pct<0,2,cond(export_share_pct==0,1,0)) if !missing(export_share_pct)
quietly count if !missing(export_share_pct)
local obs=r(N)
quietly count if export_share_pct==0
local zeros=r(N)
quietly count if inlist(vs_export_share_pct,5,6,8)
local bad=r(N)
quietly count if vs_export_share_pct==4
local absent=r(N)
post cell (2019) ("export_share_pct") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row export_share_pct vs_export_share_pct raw_prprex19
isid source_year source_row
save "$VYD/N_G0_export_share_pct_2019.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_export_share_pct_2019"
log close vycell
