* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_waste_liquid_flag_2022: annual staged raw state -> waste_liquid_flag at source_year/source_row.
* Evidence: 2022 Sumbar PDF p68 Q210: 3=yes, 4=no; asked only when Q209d=7. Out-of-universe observations retained in source text, excluded from harmonized flag.
log using "$VYL/N_G0_waste_liquid_flag_2022.log", text replace name(vycell)
generate double waste_liquid_flag=.
generate byte vs_waste_liquid_flag=3
replace waste_liquid_flag=(real(subinstr(strtrim(raw_liwste22),",","",.))==3) if inlist(real(subinstr(strtrim(raw_liwste22),",","",.)),3,4) & real(raw_inspli22)==7
replace vs_waste_liquid_flag=6 if !missing(real(subinstr(strtrim(raw_liwste22),",","",.))) & !(inlist(real(subinstr(strtrim(raw_liwste22),",","",.)),3,4))
replace vs_waste_liquid_flag=8 if real(raw_inspli22)!=7
replace vs_waste_liquid_flag=cond(waste_liquid_flag<0,2,cond(waste_liquid_flag==0,1,0)) if !missing(waste_liquid_flag)
quietly count if !missing(waste_liquid_flag)
local obs=r(N)
quietly count if waste_liquid_flag==0
local zeros=r(N)
quietly count if inlist(vs_waste_liquid_flag,5,6,8)
local bad=r(N)
quietly count if vs_waste_liquid_flag==4
local absent=r(N)
post cell (2022) ("waste_liquid_flag") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row waste_liquid_flag vs_waste_liquid_flag raw_liwste22
isid source_year source_row
save "$VYD/N_G0_waste_liquid_flag_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_waste_liquid_flag_2022"
log close vycell
