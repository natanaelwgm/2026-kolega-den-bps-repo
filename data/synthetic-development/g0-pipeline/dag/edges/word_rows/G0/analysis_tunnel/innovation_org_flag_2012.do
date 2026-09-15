* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* Stable tunnel field innovation_org_flag, year 2012. Owner-authorized provisional branch.
log using "dag/logs/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_org_flag_2012.log", text replace name(tcell)
generate double innovation_org_flag=.
generate double v_innovation_org_flag=.
generate byte vs_innovation_org_flag=cond(missing(innovation_org_raw),4,7)
replace innovation_org_flag=(innovation_org_raw==7) if missing(innovation_org_flag) & inlist(innovation_org_raw,7,8)
replace vs_innovation_org_flag=10 if !missing(innovation_org_flag) & missing(v_innovation_org_flag)
assert inlist(innovation_org_flag,0,1) if !missing(innovation_org_flag)
assert innovation_org_flag==v_innovation_org_flag if !missing(v_innovation_org_flag)
quietly count if !missing(innovation_org_flag)
local n=r(N)
quietly count if !missing(v_innovation_org_flag)
local v=r(N)
quietly count if vs_innovation_org_flag==10 & !missing(innovation_org_flag)
post counts (2012) ("innovation_org_flag") (_N) (`n') (`v') (r(N))
preserve
keep source_year source_row innovation_org_flag v_innovation_org_flag vs_innovation_org_flag
isid source_year source_row
save "dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_org_flag_2012.dta", replace
restore
display "TUNNEL_NODE_PASS N_G0_tunnel_innovation_org_flag_2012"
log close tcell
