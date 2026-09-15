* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_efuvce_2014: annual staged raw state -> val_efuvce at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2014 row 63; efuvce14 | ttl energy & lubr used elec gen,000 rp
log using "$VYL/N_G0_val_efuvce_2014.log", text replace name(vycell)
generate double val_efuvce=.
generate byte vs_val_efuvce=3
replace val_efuvce=real(subinstr(strtrim(raw_efuvce14),",","",.))*1
replace vs_val_efuvce=5 if missing(real(subinstr(strtrim(raw_efuvce14),",","",.))) & !inlist(upper(strtrim(raw_efuvce14)),"","***",".","NA","N/A","NULL","-")
replace vs_val_efuvce=cond(val_efuvce<0,2,cond(val_efuvce==0,1,0)) if !missing(val_efuvce)
quietly count if !missing(val_efuvce)
local obs=r(N)
quietly count if val_efuvce==0
local zeros=r(N)
quietly count if inlist(vs_val_efuvce,5,6,8)
local bad=r(N)
quietly count if vs_val_efuvce==4
local absent=r(N)
post cell (2014) ("val_efuvce") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_efuvce vs_val_efuvce raw_efuvce14
isid source_year source_row
save "$VYD/N_G0_val_efuvce_2014.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_efuvce_2014"
log close vycell
