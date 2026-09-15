* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_env_amdal_flag_2020: annual staged raw state -> env_amdal_flag at source_year/source_row.
* Evidence: 2020 BPS questionnaire reproduction Q225; 2021 Lampung PDF p88 Q225; 2022 Sumbar PDF p68 Q209. amdal: 1=present, 2=not yet present. 2021 installation versus 2022 treatment wording retained in evidence.
log using "$VYL/N_G0_env_amdal_flag_2020.log", text replace name(vycell)
generate double env_amdal_flag=.
generate byte vs_env_amdal_flag=3
replace env_amdal_flag=(real(subinstr(strtrim(raw_amdal20),",","",.))==1) if inlist(real(subinstr(strtrim(raw_amdal20),",","",.)),1,2)
replace vs_env_amdal_flag=6 if !missing(real(subinstr(strtrim(raw_amdal20),",","",.))) & !(inlist(real(subinstr(strtrim(raw_amdal20),",","",.)),1,2))
replace vs_env_amdal_flag=cond(env_amdal_flag<0,2,cond(env_amdal_flag==0,1,0)) if !missing(env_amdal_flag)
quietly count if !missing(env_amdal_flag)
local obs=r(N)
quietly count if env_amdal_flag==0
local zeros=r(N)
quietly count if inlist(vs_env_amdal_flag,5,6,8)
local bad=r(N)
quietly count if vs_env_amdal_flag==4
local absent=r(N)
post cell (2020) ("env_amdal_flag") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row env_amdal_flag vs_env_amdal_flag raw_amdal20
isid source_year source_row
save "$VYD/N_G0_env_amdal_flag_2020.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_env_amdal_flag_2020"
log close vycell
