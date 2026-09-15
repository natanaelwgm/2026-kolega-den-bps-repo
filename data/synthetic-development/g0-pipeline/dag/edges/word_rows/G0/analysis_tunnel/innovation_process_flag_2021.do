* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* Stable tunnel field innovation_process_flag, year 2021. Owner-authorized provisional branch.
log using "dag/logs/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_process_flag_2021.log", text replace name(tcell)
generate double innovation_process_flag=.
generate double v_innovation_process_flag=.
generate byte vs_innovation_process_flag=cond(missing(innovation_process_raw),4,7)
replace innovation_process_flag=(innovation_process_raw==3) if missing(innovation_process_flag) & inlist(innovation_process_raw,3,4)
replace vs_innovation_process_flag=10 if !missing(innovation_process_flag) & missing(v_innovation_process_flag)
assert inlist(innovation_process_flag,0,1) if !missing(innovation_process_flag)
assert innovation_process_flag==v_innovation_process_flag if !missing(v_innovation_process_flag)
quietly count if !missing(innovation_process_flag)
local n=r(N)
quietly count if !missing(v_innovation_process_flag)
local v=r(N)
quietly count if vs_innovation_process_flag==10 & !missing(innovation_process_flag)
post counts (2021) ("innovation_process_flag") (_N) (`n') (`v') (r(N))
preserve
keep source_year source_row innovation_process_flag v_innovation_process_flag vs_innovation_process_flag
isid source_year source_row
save "dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_process_flag_2021.dta", replace
restore
display "TUNNEL_NODE_PASS N_G0_tunnel_innovation_process_flag_2021"
log close tcell
