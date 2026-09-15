* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* Stable tunnel field innovation_marketing_flag, year 2015. Owner-authorized provisional branch.
log using "dag/logs/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_marketing_flag_2015.log", text replace name(tcell)
generate double innovation_marketing_flag=.
generate double v_innovation_marketing_flag=.
generate byte vs_innovation_marketing_flag=cond(missing(innovation_marketing_raw),4,7)
replace innovation_marketing_flag=(innovation_marketing_raw==5) if missing(innovation_marketing_flag) & inlist(innovation_marketing_raw,5,6)
replace vs_innovation_marketing_flag=10 if !missing(innovation_marketing_flag) & missing(v_innovation_marketing_flag)
assert inlist(innovation_marketing_flag,0,1) if !missing(innovation_marketing_flag)
assert innovation_marketing_flag==v_innovation_marketing_flag if !missing(v_innovation_marketing_flag)
quietly count if !missing(innovation_marketing_flag)
local n=r(N)
quietly count if !missing(v_innovation_marketing_flag)
local v=r(N)
quietly count if vs_innovation_marketing_flag==10 & !missing(innovation_marketing_flag)
post counts (2015) ("innovation_marketing_flag") (_N) (`n') (`v') (r(N))
preserve
keep source_year source_row innovation_marketing_flag v_innovation_marketing_flag vs_innovation_marketing_flag
isid source_year source_row
save "dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_marketing_flag_2015.dta", replace
restore
display "TUNNEL_NODE_PASS N_G0_tunnel_innovation_marketing_flag_2015"
log close tcell
