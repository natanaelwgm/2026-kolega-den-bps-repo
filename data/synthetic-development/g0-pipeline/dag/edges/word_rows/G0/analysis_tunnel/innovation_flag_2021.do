* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* Stable tunnel field innovation_flag, year 2021. Owner-authorized provisional branch.
log using "dag/logs/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_flag_2021.log", text replace name(tcell)
clonevar v_innovation_flag=innovation_flag
replace innovation_flag=(innovation_raw==1) if missing(innovation_flag) & inlist(innovation_raw,1,2)
replace vs_innovation_flag=10 if !missing(innovation_flag) & missing(v_innovation_flag)
assert inlist(innovation_flag,0,1) if !missing(innovation_flag)
assert innovation_flag==v_innovation_flag if !missing(v_innovation_flag)
quietly count if !missing(innovation_flag)
local n=r(N)
quietly count if !missing(v_innovation_flag)
local v=r(N)
quietly count if vs_innovation_flag==10 & !missing(innovation_flag)
post counts (2021) ("innovation_flag") (_N) (`n') (`v') (r(N))
preserve
keep source_year source_row innovation_flag v_innovation_flag vs_innovation_flag
isid source_year source_row
save "dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_flag_2021.dta", replace
restore
display "TUNNEL_NODE_PASS N_G0_tunnel_innovation_flag_2021"
log close tcell
