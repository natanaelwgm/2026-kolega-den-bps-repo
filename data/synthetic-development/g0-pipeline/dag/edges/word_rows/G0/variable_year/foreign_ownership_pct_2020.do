* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_foreign_ownership_pct_2020: annual staged raw state -> foreign_ownership_pct at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_foreign_ownership_pct_2020.log", text replace name(vycell)
generate double foreign_ownership_pct=.
generate byte vs_foreign_ownership_pct=3
replace foreign_ownership_pct=real(subinstr(strtrim(raw_dasing20),",","",.))*1
replace vs_foreign_ownership_pct=5 if missing(real(subinstr(strtrim(raw_dasing20),",","",.))) & !inlist(upper(strtrim(raw_dasing20)),"","***",".","NA","N/A","NULL","-")
replace vs_foreign_ownership_pct=cond(foreign_ownership_pct<0,2,cond(foreign_ownership_pct==0,1,0)) if !missing(foreign_ownership_pct)
quietly count if !missing(foreign_ownership_pct)
local obs=r(N)
quietly count if foreign_ownership_pct==0
local zeros=r(N)
quietly count if inlist(vs_foreign_ownership_pct,5,6,8)
local bad=r(N)
quietly count if vs_foreign_ownership_pct==4
local absent=r(N)
post cell (2020) ("foreign_ownership_pct") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row foreign_ownership_pct vs_foreign_ownership_pct raw_dasing20
isid source_year source_row
save "$VYD/N_G0_foreign_ownership_pct_2020.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_foreign_ownership_pct_2020"
log close vycell
