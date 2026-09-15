* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_elec_nonpln_rp000_2021: annual staged raw state -> elec_nonpln_rp000 at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_elec_nonpln_rp000_2021.log", text replace name(vycell)
generate double elec_nonpln_rp000=.
generate byte vs_elec_nonpln_rp000=3
replace elec_nonpln_rp000=real(subinstr(strtrim(raw_enpvcu21),",","",.))*1
replace vs_elec_nonpln_rp000=5 if missing(real(subinstr(strtrim(raw_enpvcu21),",","",.))) & !inlist(upper(strtrim(raw_enpvcu21)),"","***",".","NA","N/A","NULL","-")
replace vs_elec_nonpln_rp000=cond(elec_nonpln_rp000<0,2,cond(elec_nonpln_rp000==0,1,0)) if !missing(elec_nonpln_rp000)
quietly count if !missing(elec_nonpln_rp000)
local obs=r(N)
quietly count if elec_nonpln_rp000==0
local zeros=r(N)
quietly count if inlist(vs_elec_nonpln_rp000,5,6,8)
local bad=r(N)
quietly count if vs_elec_nonpln_rp000==4
local absent=r(N)
post cell (2021) ("elec_nonpln_rp000") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row elec_nonpln_rp000 vs_elec_nonpln_rp000 raw_enpvcu21
isid source_year source_row
save "$VYD/N_G0_elec_nonpln_rp000_2021.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_elec_nonpln_rp000_2021"
log close vycell
