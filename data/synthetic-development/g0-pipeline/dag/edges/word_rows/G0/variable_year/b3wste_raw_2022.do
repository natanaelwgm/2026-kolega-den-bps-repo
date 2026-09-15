* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_b3wste_raw_2022: annual staged raw state -> b3wste_raw at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_b3wste_raw_2022.log", text replace name(vycell)
generate double b3wste_raw=.
generate byte vs_b3wste_raw=3
replace b3wste_raw=real(subinstr(strtrim(raw_b3wste22),",","",.))*1
replace vs_b3wste_raw=5 if missing(real(subinstr(strtrim(raw_b3wste22),",","",.))) & !inlist(upper(strtrim(raw_b3wste22)),"","***",".","NA","N/A","NULL","-")
replace vs_b3wste_raw=cond(b3wste_raw<0,2,cond(b3wste_raw==0,1,0)) if !missing(b3wste_raw)
quietly count if !missing(b3wste_raw)
local obs=r(N)
quietly count if b3wste_raw==0
local zeros=r(N)
quietly count if inlist(vs_b3wste_raw,5,6,8)
local bad=r(N)
quietly count if vs_b3wste_raw==4
local absent=r(N)
post cell (2022) ("b3wste_raw") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row b3wste_raw vs_b3wste_raw raw_b3wste22
isid source_year source_row
save "$VYD/N_G0_b3wste_raw_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_b3wste_raw_2022"
log close vycell
