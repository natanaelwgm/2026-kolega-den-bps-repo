* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_env_ukl_upl_flag_2014: annual staged raw state -> env_ukl_upl_flag at source_year/source_row.
* Evidence: 2020 BPS questionnaire reproduction Q225; 2021 Lampung PDF p88 Q225; 2022 Sumbar PDF p68 Q209. pplihi: 3=present, 4=not yet present. 2021 installation versus 2022 treatment wording retained in evidence.
log using "$VYL/N_G0_env_ukl_upl_flag_2014.log", text replace name(vycell)
generate double env_ukl_upl_flag=.
generate byte vs_env_ukl_upl_flag=4
quietly count if !missing(env_ukl_upl_flag)
local obs=r(N)
quietly count if env_ukl_upl_flag==0
local zeros=r(N)
quietly count if inlist(vs_env_ukl_upl_flag,5,6,8)
local bad=r(N)
quietly count if vs_env_ukl_upl_flag==4
local absent=r(N)
post cell (2014) ("env_ukl_upl_flag") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row env_ukl_upl_flag vs_env_ukl_upl_flag
isid source_year source_row
save "$VYD/N_G0_env_ukl_upl_flag_2014.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_env_ukl_upl_flag_2014"
log close vycell
