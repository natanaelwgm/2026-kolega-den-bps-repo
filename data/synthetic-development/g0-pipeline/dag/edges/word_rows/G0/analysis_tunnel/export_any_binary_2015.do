* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* Stable tunnel field export_any_binary, year 2015. Owner-authorized provisional branch.
log using "dag/logs/word_data/G0/analysis_tunnel/N_G0_tunnel_export_any_binary_2015.log", text replace name(tcell)
clonevar v_export_any_binary=export_any_binary
replace export_any_binary=(export_binary_raw==1) if missing(export_any_binary) & inlist(export_binary_raw,1,2)
replace vs_export_any_binary=10 if !missing(export_any_binary) & missing(v_export_any_binary)
assert inlist(export_any_binary,0,1) if !missing(export_any_binary)
assert export_any_binary==v_export_any_binary if !missing(v_export_any_binary)
quietly count if !missing(export_any_binary)
local n=r(N)
quietly count if !missing(v_export_any_binary)
local v=r(N)
quietly count if vs_export_any_binary==10 & !missing(export_any_binary)
post counts (2015) ("export_any_binary") (_N) (`n') (`v') (r(N))
preserve
keep source_year source_row export_any_binary v_export_any_binary vs_export_any_binary
isid source_year source_row
save "dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_export_any_binary_2015.dta", replace
restore
display "TUNNEL_NODE_PASS N_G0_tunnel_export_any_binary_2015"
log close tcell
