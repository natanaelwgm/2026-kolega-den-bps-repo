* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_waste_hazardous_flag_2022: annual staged raw state -> waste_hazardous_flag at source_year/source_row.
* Evidence: 2022 Sumbar PDF p68 Q210: 5=yes, 6=no; asked only when Q209d=7. Out-of-universe observations retained in source text, excluded from harmonized flag.
log using "$VYL/N_G0_waste_hazardous_flag_2022.log", text replace name(vycell)
generate double waste_hazardous_flag=.
generate byte vs_waste_hazardous_flag=3
replace waste_hazardous_flag=(real(subinstr(strtrim(raw_b3wste22),",","",.))==5) if inlist(real(subinstr(strtrim(raw_b3wste22),",","",.)),5,6) & real(raw_inspli22)==7
replace vs_waste_hazardous_flag=6 if !missing(real(subinstr(strtrim(raw_b3wste22),",","",.))) & !(inlist(real(subinstr(strtrim(raw_b3wste22),",","",.)),5,6))
replace vs_waste_hazardous_flag=8 if real(raw_inspli22)!=7
replace vs_waste_hazardous_flag=cond(waste_hazardous_flag<0,2,cond(waste_hazardous_flag==0,1,0)) if !missing(waste_hazardous_flag)
quietly count if !missing(waste_hazardous_flag)
local obs=r(N)
quietly count if waste_hazardous_flag==0
local zeros=r(N)
quietly count if inlist(vs_waste_hazardous_flag,5,6,8)
local bad=r(N)
quietly count if vs_waste_hazardous_flag==4
local absent=r(N)
post cell (2022) ("waste_hazardous_flag") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row waste_hazardous_flag vs_waste_hazardous_flag raw_b3wste22
isid source_year source_row
save "$VYD/N_G0_waste_hazardous_flag_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_waste_hazardous_flag_2022"
log close vycell
