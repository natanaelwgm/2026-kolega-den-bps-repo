* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_elec_nonpln_rp000_2012: annual staged raw state -> elec_nonpln_rp000 at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2012 row 67; enpvcu12 | electricity purch from non-pln,000 rp
log using "$VYL/N_G0_elec_nonpln_rp000_2012.log", text replace name(vycell)
generate double elec_nonpln_rp000=.
generate byte vs_elec_nonpln_rp000=3
replace elec_nonpln_rp000=real(subinstr(strtrim(raw_enpvcu12),",","",.))*1
replace vs_elec_nonpln_rp000=5 if missing(real(subinstr(strtrim(raw_enpvcu12),",","",.))) & !inlist(upper(strtrim(raw_enpvcu12)),"","***",".","NA","N/A","NULL","-")
replace vs_elec_nonpln_rp000=cond(elec_nonpln_rp000<0,2,cond(elec_nonpln_rp000==0,1,0)) if !missing(elec_nonpln_rp000)
quietly count if !missing(elec_nonpln_rp000)
local obs=r(N)
quietly count if elec_nonpln_rp000==0
local zeros=r(N)
quietly count if inlist(vs_elec_nonpln_rp000,5,6,8)
local bad=r(N)
quietly count if vs_elec_nonpln_rp000==4
local absent=r(N)
post cell (2012) ("elec_nonpln_rp000") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row elec_nonpln_rp000 vs_elec_nonpln_rp000 raw_enpvcu12
isid source_year source_row
save "$VYD/N_G0_elec_nonpln_rp000_2012.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_elec_nonpln_rp000_2012"
log close vycell
