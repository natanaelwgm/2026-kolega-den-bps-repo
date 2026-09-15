* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_rd_indicator_raw_2020: annual staged raw state -> rd_indicator_raw at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_rd_indicator_raw_2020.log", text replace name(vycell)
generate double rd_indicator_raw=.
generate byte vs_rd_indicator_raw=3
replace rd_indicator_raw=real(subinstr(strtrim(raw_rnd20),",","",.))*1
replace vs_rd_indicator_raw=5 if missing(real(subinstr(strtrim(raw_rnd20),",","",.))) & !inlist(upper(strtrim(raw_rnd20)),"","***",".","NA","N/A","NULL","-")
replace vs_rd_indicator_raw=cond(rd_indicator_raw<0,2,cond(rd_indicator_raw==0,1,0)) if !missing(rd_indicator_raw)
quietly count if !missing(rd_indicator_raw)
local obs=r(N)
quietly count if rd_indicator_raw==0
local zeros=r(N)
quietly count if inlist(vs_rd_indicator_raw,5,6,8)
local bad=r(N)
quietly count if vs_rd_indicator_raw==4
local absent=r(N)
post cell (2020) ("rd_indicator_raw") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row rd_indicator_raw vs_rd_indicator_raw raw_rnd20
isid source_year source_row
save "$VYD/N_G0_rd_indicator_raw_2020.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_rd_indicator_raw_2020"
log close vycell
