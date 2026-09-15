* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_elec_owngen_kwh_2017: annual staged raw state -> elec_owngen_kwh at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_elec_owngen_kwh_2017.log", text replace name(vycell)
generate double elec_owngen_kwh=.
generate byte vs_elec_owngen_kwh=3
replace elec_owngen_kwh=real(subinstr(strtrim(raw_esgkhu17),",","",.))*1
replace vs_elec_owngen_kwh=5 if missing(real(subinstr(strtrim(raw_esgkhu17),",","",.))) & !inlist(upper(strtrim(raw_esgkhu17)),"","***",".","NA","N/A","NULL","-")
replace vs_elec_owngen_kwh=cond(elec_owngen_kwh<0,2,cond(elec_owngen_kwh==0,1,0)) if !missing(elec_owngen_kwh)
quietly count if !missing(elec_owngen_kwh)
local obs=r(N)
quietly count if elec_owngen_kwh==0
local zeros=r(N)
quietly count if inlist(vs_elec_owngen_kwh,5,6,8)
local bad=r(N)
quietly count if vs_elec_owngen_kwh==4
local absent=r(N)
post cell (2017) ("elec_owngen_kwh") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row elec_owngen_kwh vs_elec_owngen_kwh raw_esgkhu17
isid source_year source_row
save "$VYD/N_G0_elec_owngen_kwh_2017.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_elec_owngen_kwh_2017"
log close vycell
