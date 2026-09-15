* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_workers_2010: annual staged raw state -> workers at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2010 row 136; ltlnou10 | total workers
log using "$VYL/N_G0_workers_2010.log", text replace name(vycell)
generate double workers=.
generate byte vs_workers=3
replace workers=real(subinstr(strtrim(raw_ltlnou10),",","",.))*1
replace vs_workers=5 if missing(real(subinstr(strtrim(raw_ltlnou10),",","",.))) & !inlist(upper(strtrim(raw_ltlnou10)),"","***",".","NA","N/A","NULL","-")
replace vs_workers=cond(workers<0,2,cond(workers==0,1,0)) if !missing(workers)
quietly count if !missing(workers)
local obs=r(N)
quietly count if workers==0
local zeros=r(N)
quietly count if inlist(vs_workers,5,6,8)
local bad=r(N)
quietly count if vs_workers==4
local absent=r(N)
post cell (2010) ("workers") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row workers vs_workers raw_ltlnou10
isid source_year source_row
save "$VYD/N_G0_workers_2010.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_workers_2010"
log close vycell
