* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_rd_external_funding_flag_2010: annual staged raw state -> rd_external_funding_flag at source_year/source_row.
* Evidence: 2019 BPS Modul IBS pp47,67; 2020 Q217; 2021 Lampung PDF p88 Q217; 2022 Sumbar PDF p68 Q207. Funding R&D carried out by another party, 1 yes 2 no.
log using "$VYL/N_G0_rd_external_funding_flag_2010.log", text replace name(vycell)
generate double rd_external_funding_flag=.
generate byte vs_rd_external_funding_flag=4
quietly count if !missing(rd_external_funding_flag)
local obs=r(N)
quietly count if rd_external_funding_flag==0
local zeros=r(N)
quietly count if inlist(vs_rd_external_funding_flag,5,6,8)
local bad=r(N)
quietly count if vs_rd_external_funding_flag==4
local absent=r(N)
post cell (2010) ("rd_external_funding_flag") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row rd_external_funding_flag vs_rd_external_funding_flag
isid source_year source_row
save "$VYD/N_G0_rd_external_funding_flag_2010.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_rd_external_funding_flag_2010"
log close vycell
