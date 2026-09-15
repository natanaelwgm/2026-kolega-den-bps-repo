* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_env_sppl_flag_2011: annual staged raw state -> env_sppl_flag at source_year/source_row.
* Evidence: 2020 BPS questionnaire reproduction Q225; 2021 Lampung PDF p88 Q225; 2022 Sumbar PDF p68 Q209. spplhi: 5=present, 6=not yet present. 2021 installation versus 2022 treatment wording retained in evidence.
log using "$VYL/N_G0_env_sppl_flag_2011.log", text replace name(vycell)
generate double env_sppl_flag=.
generate byte vs_env_sppl_flag=4
quietly count if !missing(env_sppl_flag)
local obs=r(N)
quietly count if env_sppl_flag==0
local zeros=r(N)
quietly count if inlist(vs_env_sppl_flag,5,6,8)
local bad=r(N)
quietly count if vs_env_sppl_flag==4
local absent=r(N)
post cell (2011) ("env_sppl_flag") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row env_sppl_flag vs_env_sppl_flag
isid source_year source_row
save "$VYD/N_G0_env_sppl_flag_2011.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_env_sppl_flag_2011"
log close vycell
