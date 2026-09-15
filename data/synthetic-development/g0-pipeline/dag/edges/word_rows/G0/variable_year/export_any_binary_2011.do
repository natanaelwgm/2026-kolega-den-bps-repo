* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_export_any_binary_2011: annual staged raw state -> export_any_binary at source_year/source_row.
* Evidence: 2010–15 legacy layout EKSPOR 1 yes 2 no; 2020 BPS questionnaire reproduction Q402a; 2021 Lampung PDF p92 Q402a. Own or third-party export. 2022 direct-export question belongs to separate field.
log using "$VYL/N_G0_export_any_binary_2011.log", text replace name(vycell)
generate double export_any_binary=.
generate byte vs_export_any_binary=3
replace export_any_binary=(real(subinstr(strtrim(raw_ekspor11),",","",.))==1) if inlist(real(subinstr(strtrim(raw_ekspor11),",","",.)),1,2)
replace vs_export_any_binary=6 if !missing(real(subinstr(strtrim(raw_ekspor11),",","",.))) & !(inlist(real(subinstr(strtrim(raw_ekspor11),",","",.)),1,2))
replace vs_export_any_binary=cond(export_any_binary<0,2,cond(export_any_binary==0,1,0)) if !missing(export_any_binary)
quietly count if !missing(export_any_binary)
local obs=r(N)
quietly count if export_any_binary==0
local zeros=r(N)
quietly count if inlist(vs_export_any_binary,5,6,8)
local bad=r(N)
quietly count if vs_export_any_binary==4
local absent=r(N)
post cell (2011) ("export_any_binary") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row export_any_binary vs_export_any_binary raw_ekspor11
isid source_year source_row
save "$VYD/N_G0_export_any_binary_2011.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_export_any_binary_2011"
log close vycell
