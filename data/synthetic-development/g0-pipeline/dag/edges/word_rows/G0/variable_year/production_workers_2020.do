* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_production_workers_2020: annual staged raw state -> production_workers at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_production_workers_2020.log", text replace name(vycell)
generate double production_workers=.
generate byte vs_production_workers=3
replace production_workers=real(subinstr(strtrim(raw_lprnou20),",","",.))*1
replace vs_production_workers=5 if missing(real(subinstr(strtrim(raw_lprnou20),",","",.))) & !inlist(upper(strtrim(raw_lprnou20)),"","***",".","NA","N/A","NULL","-")
replace vs_production_workers=cond(production_workers<0,2,cond(production_workers==0,1,0)) if !missing(production_workers)
quietly count if !missing(production_workers)
local obs=r(N)
quietly count if production_workers==0
local zeros=r(N)
quietly count if inlist(vs_production_workers,5,6,8)
local bad=r(N)
quietly count if vs_production_workers==4
local absent=r(N)
post cell (2020) ("production_workers") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row production_workers vs_production_workers raw_lprnou20
isid source_year source_row
save "$VYD/N_G0_production_workers_2020.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_production_workers_2020"
log close vycell
