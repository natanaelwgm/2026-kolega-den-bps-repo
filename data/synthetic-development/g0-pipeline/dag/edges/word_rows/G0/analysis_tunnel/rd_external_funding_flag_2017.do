* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* Stable tunnel field rd_external_funding_flag, year 2017. Owner-authorized provisional branch.
log using "dag/logs/word_data/G0/analysis_tunnel/N_G0_tunnel_rd_external_funding_flag_2017.log", text replace name(tcell)
clonevar v_rd_external_funding_flag=rd_external_funding_flag
replace rd_external_funding_flag=(legacy_rd_cost_mislabelled==1) if missing(rd_external_funding_flag) & inlist(legacy_rd_cost_mislabelled,1,2)
replace vs_rd_external_funding_flag=10 if !missing(rd_external_funding_flag) & missing(v_rd_external_funding_flag)
assert inlist(rd_external_funding_flag,0,1) if !missing(rd_external_funding_flag)
assert rd_external_funding_flag==v_rd_external_funding_flag if !missing(v_rd_external_funding_flag)
quietly count if !missing(rd_external_funding_flag)
local n=r(N)
quietly count if !missing(v_rd_external_funding_flag)
local v=r(N)
quietly count if vs_rd_external_funding_flag==10 & !missing(rd_external_funding_flag)
post counts (2017) ("rd_external_funding_flag") (_N) (`n') (`v') (r(N))
preserve
keep source_year source_row rd_external_funding_flag v_rd_external_funding_flag vs_rd_external_funding_flag
isid source_year source_row
save "dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_rd_external_funding_flag_2017.dta", replace
restore
display "TUNNEL_NODE_PASS N_G0_tunnel_rd_external_funding_flag_2017"
log close tcell
