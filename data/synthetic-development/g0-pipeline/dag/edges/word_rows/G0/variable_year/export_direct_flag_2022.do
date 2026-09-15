* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_export_direct_flag_2022: annual staged raw state -> export_direct_flag at source_year/source_row.
* Evidence: 2022 Sumbar PDF p72 Q402a: direct export, 1 yes 2 no. Direct no does not imply no indirect exports.
log using "$VYL/N_G0_export_direct_flag_2022.log", text replace name(vycell)
generate double export_direct_flag=.
generate byte vs_export_direct_flag=3
replace export_direct_flag=(real(subinstr(strtrim(raw_ekspor22),",","",.))==1) if inlist(real(subinstr(strtrim(raw_ekspor22),",","",.)),1,2)
replace vs_export_direct_flag=6 if !missing(real(subinstr(strtrim(raw_ekspor22),",","",.))) & !(inlist(real(subinstr(strtrim(raw_ekspor22),",","",.)),1,2))
replace vs_export_direct_flag=cond(export_direct_flag<0,2,cond(export_direct_flag==0,1,0)) if !missing(export_direct_flag)
quietly count if !missing(export_direct_flag)
local obs=r(N)
quietly count if export_direct_flag==0
local zeros=r(N)
quietly count if inlist(vs_export_direct_flag,5,6,8)
local bad=r(N)
quietly count if vs_export_direct_flag==4
local absent=r(N)
post cell (2022) ("export_direct_flag") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row export_direct_flag vs_export_direct_flag raw_ekspor22
isid source_year source_row
save "$VYD/N_G0_export_direct_flag_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_export_direct_flag_2022"
log close vycell
