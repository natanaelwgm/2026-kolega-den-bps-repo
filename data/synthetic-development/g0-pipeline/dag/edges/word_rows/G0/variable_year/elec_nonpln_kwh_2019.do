* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_elec_nonpln_kwh_2019: annual staged raw state -> elec_nonpln_kwh at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_elec_nonpln_kwh_2019.log", text replace name(vycell)
generate double elec_nonpln_kwh=.
generate byte vs_elec_nonpln_kwh=3
replace elec_nonpln_kwh=real(subinstr(strtrim(raw_enpkhu19),",","",.))*1
replace vs_elec_nonpln_kwh=5 if missing(real(subinstr(strtrim(raw_enpkhu19),",","",.))) & !inlist(upper(strtrim(raw_enpkhu19)),"","***",".","NA","N/A","NULL","-")
replace vs_elec_nonpln_kwh=cond(elec_nonpln_kwh<0,2,cond(elec_nonpln_kwh==0,1,0)) if !missing(elec_nonpln_kwh)
quietly count if !missing(elec_nonpln_kwh)
local obs=r(N)
quietly count if elec_nonpln_kwh==0
local zeros=r(N)
quietly count if inlist(vs_elec_nonpln_kwh,5,6,8)
local bad=r(N)
quietly count if vs_elec_nonpln_kwh==4
local absent=r(N)
post cell (2019) ("elec_nonpln_kwh") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row elec_nonpln_kwh vs_elec_nonpln_kwh raw_enpkhu19
isid source_year source_row
save "$VYD/N_G0_elec_nonpln_kwh_2019.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_elec_nonpln_kwh_2019"
log close vycell
