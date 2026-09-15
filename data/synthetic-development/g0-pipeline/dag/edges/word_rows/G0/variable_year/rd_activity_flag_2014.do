* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_rd_activity_flag_2014: annual staged raw state -> rd_activity_flag at source_year/source_row.
* Evidence: 2011 RESECH layout; 2019 BPS Modul IBS pp47,67: 1 yes 2 no; 2020 Q216; 2021 Lampung PDF p88 Q216; 2022 Sumbar PDF p68 Q206. 2011 general R&D; later own R&D.
log using "$VYL/N_G0_rd_activity_flag_2014.log", text replace name(vycell)
generate double rd_activity_flag=.
generate byte vs_rd_activity_flag=4
quietly count if !missing(rd_activity_flag)
local obs=r(N)
quietly count if rd_activity_flag==0
local zeros=r(N)
quietly count if inlist(vs_rd_activity_flag,5,6,8)
local bad=r(N)
quietly count if vs_rd_activity_flag==4
local absent=r(N)
post cell (2014) ("rd_activity_flag") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row rd_activity_flag vs_rd_activity_flag
isid source_year source_row
save "$VYD/N_G0_rd_activity_flag_2014.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_rd_activity_flag_2014"
log close vycell
