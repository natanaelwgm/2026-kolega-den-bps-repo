* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_spplhi_raw_2020: annual staged raw state -> spplhi_raw at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_spplhi_raw_2020.log", text replace name(vycell)
generate double spplhi_raw=.
generate byte vs_spplhi_raw=3
replace spplhi_raw=real(subinstr(strtrim(raw_spplhi20),",","",.))*1
replace vs_spplhi_raw=5 if missing(real(subinstr(strtrim(raw_spplhi20),",","",.))) & !inlist(upper(strtrim(raw_spplhi20)),"","***",".","NA","N/A","NULL","-")
replace vs_spplhi_raw=cond(spplhi_raw<0,2,cond(spplhi_raw==0,1,0)) if !missing(spplhi_raw)
quietly count if !missing(spplhi_raw)
local obs=r(N)
quietly count if spplhi_raw==0
local zeros=r(N)
quietly count if inlist(vs_spplhi_raw,5,6,8)
local bad=r(N)
quietly count if vs_spplhi_raw==4
local absent=r(N)
post cell (2020) ("spplhi_raw") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row spplhi_raw vs_spplhi_raw raw_spplhi20
isid source_year source_row
save "$VYD/N_G0_spplhi_raw_2020.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_spplhi_raw_2020"
log close vycell
