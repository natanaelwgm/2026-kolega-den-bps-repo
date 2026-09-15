* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_pplihi_raw_2022: annual staged raw state -> pplihi_raw at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_pplihi_raw_2022.log", text replace name(vycell)
generate double pplihi_raw=.
generate byte vs_pplihi_raw=3
replace pplihi_raw=real(subinstr(strtrim(raw_pplihi22),",","",.))*1
replace vs_pplihi_raw=5 if missing(real(subinstr(strtrim(raw_pplihi22),",","",.))) & !inlist(upper(strtrim(raw_pplihi22)),"","***",".","NA","N/A","NULL","-")
replace vs_pplihi_raw=cond(pplihi_raw<0,2,cond(pplihi_raw==0,1,0)) if !missing(pplihi_raw)
quietly count if !missing(pplihi_raw)
local obs=r(N)
quietly count if pplihi_raw==0
local zeros=r(N)
quietly count if inlist(vs_pplihi_raw,5,6,8)
local bad=r(N)
quietly count if vs_pplihi_raw==4
local absent=r(N)
post cell (2022) ("pplihi_raw") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row pplihi_raw vs_pplihi_raw raw_pplihi22
isid source_year source_row
save "$VYD/N_G0_pplihi_raw_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_pplihi_raw_2022"
log close vycell
