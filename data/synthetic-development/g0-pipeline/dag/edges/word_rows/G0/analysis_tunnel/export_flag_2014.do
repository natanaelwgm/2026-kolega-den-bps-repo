* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* Stable tunnel field export_flag, year 2014. Owner-authorized provisional branch.
log using "dag/logs/word_data/G0/analysis_tunnel/N_G0_tunnel_export_flag_2014.log", text replace name(tcell)
clonevar v_export_flag=export_flag
generate byte vs_export_flag=cond(missing(v_export_flag),3,0)
replace export_flag=export_any_binary if missing(export_flag) & !missing(export_any_binary) & export_verified_conflict==0
replace vs_export_flag=10 if !missing(export_flag) & missing(v_export_flag)
assert inlist(export_flag,0,1) if !missing(export_flag)
assert export_flag==v_export_flag if !missing(v_export_flag)
quietly count if !missing(export_flag)
local n=r(N)
quietly count if !missing(v_export_flag)
local v=r(N)
quietly count if vs_export_flag==10 & !missing(export_flag)
post counts (2014) ("export_flag") (_N) (`n') (`v') (r(N))
preserve
keep source_year source_row export_flag v_export_flag vs_export_flag
isid source_year source_row
save "dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_export_flag_2014.dta", replace
restore
display "TUNNEL_NODE_PASS N_G0_tunnel_export_flag_2014"
log close tcell
