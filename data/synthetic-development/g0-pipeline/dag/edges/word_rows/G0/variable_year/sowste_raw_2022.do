* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_sowste_raw_2022: annual staged raw state -> sowste_raw at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_sowste_raw_2022.log", text replace name(vycell)
generate double sowste_raw=.
generate byte vs_sowste_raw=3
replace sowste_raw=real(subinstr(strtrim(raw_sowste22),",","",.))*1
replace vs_sowste_raw=5 if missing(real(subinstr(strtrim(raw_sowste22),",","",.))) & !inlist(upper(strtrim(raw_sowste22)),"","***",".","NA","N/A","NULL","-")
replace vs_sowste_raw=cond(sowste_raw<0,2,cond(sowste_raw==0,1,0)) if !missing(sowste_raw)
quietly count if !missing(sowste_raw)
local obs=r(N)
quietly count if sowste_raw==0
local zeros=r(N)
quietly count if inlist(vs_sowste_raw,5,6,8)
local bad=r(N)
quietly count if vs_sowste_raw==4
local absent=r(N)
post cell (2022) ("sowste_raw") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row sowste_raw vs_sowste_raw raw_sowste22
isid source_year source_row
save "$VYD/N_G0_sowste_raw_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_sowste_raw_2022"
log close vycell
