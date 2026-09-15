* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_innovation_flag_2014: annual staged raw state -> innovation_flag at source_year/source_row.
* Evidence: 2011 INNOVA layout; 2020 Q218; 2021 Lampung PDF p88 Q218; 2022 Sumbar PDF p68 Q208. Broad innovation indicator; question wording differs from 2011.
log using "$VYL/N_G0_innovation_flag_2014.log", text replace name(vycell)
generate double innovation_flag=.
generate byte vs_innovation_flag=4
quietly count if !missing(innovation_flag)
local obs=r(N)
quietly count if innovation_flag==0
local zeros=r(N)
quietly count if inlist(vs_innovation_flag,5,6,8)
local bad=r(N)
quietly count if vs_innovation_flag==4
local absent=r(N)
post cell (2014) ("innovation_flag") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row innovation_flag vs_innovation_flag
isid source_year source_row
save "$VYD/N_G0_innovation_flag_2014.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_innovation_flag_2014"
log close vycell
