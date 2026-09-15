* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_elec_pln_rp000_2011: annual staged raw state -> elec_pln_rp000 at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2011 row 69; eplvcu11 | electricity purch from pln, 000rp
log using "$VYL/N_G0_elec_pln_rp000_2011.log", text replace name(vycell)
generate double elec_pln_rp000=.
generate byte vs_elec_pln_rp000=3
replace elec_pln_rp000=real(subinstr(strtrim(raw_eplvcu11),",","",.))*1
replace vs_elec_pln_rp000=5 if missing(real(subinstr(strtrim(raw_eplvcu11),",","",.))) & !inlist(upper(strtrim(raw_eplvcu11)),"","***",".","NA","N/A","NULL","-")
replace vs_elec_pln_rp000=cond(elec_pln_rp000<0,2,cond(elec_pln_rp000==0,1,0)) if !missing(elec_pln_rp000)
quietly count if !missing(elec_pln_rp000)
local obs=r(N)
quietly count if elec_pln_rp000==0
local zeros=r(N)
quietly count if inlist(vs_elec_pln_rp000,5,6,8)
local bad=r(N)
quietly count if vs_elec_pln_rp000==4
local absent=r(N)
post cell (2011) ("elec_pln_rp000") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row elec_pln_rp000 vs_elec_pln_rp000 raw_eplvcu11
isid source_year source_row
save "$VYD/N_G0_elec_pln_rp000_2011.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_elec_pln_rp000_2011"
log close vycell
