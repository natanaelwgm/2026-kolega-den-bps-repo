* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_innovation_raw_2020: annual staged raw state -> innovation_raw at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_innovation_raw_2020.log", text replace name(vycell)
generate double innovation_raw=.
generate byte vs_innovation_raw=3
replace innovation_raw=real(subinstr(strtrim(raw_inov20),",","",.))*1
replace vs_innovation_raw=5 if missing(real(subinstr(strtrim(raw_inov20),",","",.))) & !inlist(upper(strtrim(raw_inov20)),"","***",".","NA","N/A","NULL","-")
replace vs_innovation_raw=cond(innovation_raw<0,2,cond(innovation_raw==0,1,0)) if !missing(innovation_raw)
quietly count if !missing(innovation_raw)
local obs=r(N)
quietly count if innovation_raw==0
local zeros=r(N)
quietly count if inlist(vs_innovation_raw,5,6,8)
local bad=r(N)
quietly count if vs_innovation_raw==4
local absent=r(N)
post cell (2020) ("innovation_raw") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row innovation_raw vs_innovation_raw raw_inov20
isid source_year source_row
save "$VYD/N_G0_innovation_raw_2020.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_innovation_raw_2020"
log close vycell
