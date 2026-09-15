* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* Stable tunnel field rd_activity_flag, year 2012. Owner-authorized provisional branch.
log using "dag/logs/word_data/G0/analysis_tunnel/N_G0_tunnel_rd_activity_flag_2012.log", text replace name(tcell)
clonevar v_rd_activity_flag=rd_activity_flag
replace rd_activity_flag=(rd_indicator_raw==1) if missing(rd_activity_flag) & inlist(rd_indicator_raw,1,2)
replace vs_rd_activity_flag=10 if !missing(rd_activity_flag) & missing(v_rd_activity_flag)
assert inlist(rd_activity_flag,0,1) if !missing(rd_activity_flag)
assert rd_activity_flag==v_rd_activity_flag if !missing(v_rd_activity_flag)
quietly count if !missing(rd_activity_flag)
local n=r(N)
quietly count if !missing(v_rd_activity_flag)
local v=r(N)
quietly count if vs_rd_activity_flag==10 & !missing(rd_activity_flag)
post counts (2012) ("rd_activity_flag") (_N) (`n') (`v') (r(N))
preserve
keep source_year source_row rd_activity_flag v_rd_activity_flag vs_rd_activity_flag
isid source_year source_row
save "dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_rd_activity_flag_2012.dta", replace
restore
display "TUNNEL_NODE_PASS N_G0_tunnel_rd_activity_flag_2012"
log close tcell
