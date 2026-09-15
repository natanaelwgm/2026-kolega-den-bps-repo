* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_production_workers_2011: annual staged raw state -> production_workers at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2011 row 20; lprnou11 | total prodoction workers
log using "$VYL/N_G0_production_workers_2011.log", text replace name(vycell)
generate double production_workers=.
generate byte vs_production_workers=3
replace production_workers=real(subinstr(strtrim(raw_lprnou11),",","",.))*1
replace vs_production_workers=5 if missing(real(subinstr(strtrim(raw_lprnou11),",","",.))) & !inlist(upper(strtrim(raw_lprnou11)),"","***",".","NA","N/A","NULL","-")
replace vs_production_workers=cond(production_workers<0,2,cond(production_workers==0,1,0)) if !missing(production_workers)
quietly count if !missing(production_workers)
local obs=r(N)
quietly count if production_workers==0
local zeros=r(N)
quietly count if inlist(vs_production_workers,5,6,8)
local bad=r(N)
quietly count if vs_production_workers==4
local absent=r(N)
post cell (2011) ("production_workers") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row production_workers vs_production_workers raw_lprnou11
isid source_year source_row
save "$VYD/N_G0_production_workers_2011.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_production_workers_2011"
log close vycell
