* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_export_binary_raw_2011: annual staged raw state -> export_binary_raw at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2011 row 87; ekspor11 | export? (1.yes  2.no)
log using "$VYL/N_G0_export_binary_raw_2011.log", text replace name(vycell)
generate double export_binary_raw=.
generate byte vs_export_binary_raw=3
replace export_binary_raw=real(subinstr(strtrim(raw_ekspor11),",","",.))*1
replace vs_export_binary_raw=5 if missing(real(subinstr(strtrim(raw_ekspor11),",","",.))) & !inlist(upper(strtrim(raw_ekspor11)),"","***",".","NA","N/A","NULL","-")
replace vs_export_binary_raw=cond(export_binary_raw<0,2,cond(export_binary_raw==0,1,0)) if !missing(export_binary_raw)
quietly count if !missing(export_binary_raw)
local obs=r(N)
quietly count if export_binary_raw==0
local zeros=r(N)
quietly count if inlist(vs_export_binary_raw,5,6,8)
local bad=r(N)
quietly count if vs_export_binary_raw==4
local absent=r(N)
post cell (2011) ("export_binary_raw") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row export_binary_raw vs_export_binary_raw raw_ekspor11
isid source_year source_row
save "$VYD/N_G0_export_binary_raw_2011.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_export_binary_raw_2011"
log close vycell
