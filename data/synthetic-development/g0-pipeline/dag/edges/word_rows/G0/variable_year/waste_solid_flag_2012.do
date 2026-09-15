* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_waste_solid_flag_2012: annual staged raw state -> waste_solid_flag at source_year/source_row.
* Evidence: 2022 Sumbar PDF p68 Q210: 1=yes, 2=no; asked only when Q209d=7. Out-of-universe observations retained in source text, excluded from harmonized flag.
log using "$VYL/N_G0_waste_solid_flag_2012.log", text replace name(vycell)
generate double waste_solid_flag=.
generate byte vs_waste_solid_flag=4
quietly count if !missing(waste_solid_flag)
local obs=r(N)
quietly count if waste_solid_flag==0
local zeros=r(N)
quietly count if inlist(vs_waste_solid_flag,5,6,8)
local bad=r(N)
quietly count if vs_waste_solid_flag==4
local absent=r(N)
post cell (2012) ("waste_solid_flag") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row waste_solid_flag vs_waste_solid_flag
isid source_year source_row
save "$VYD/N_G0_waste_solid_flag_2012.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_waste_solid_flag_2012"
log close vycell
