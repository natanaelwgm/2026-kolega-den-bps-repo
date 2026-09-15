* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* Stable tunnel field innovation_product_flag, year 2021. Owner-authorized provisional branch.
log using "dag/logs/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_product_flag_2021.log", text replace name(tcell)
generate double innovation_product_flag=.
generate double v_innovation_product_flag=.
generate byte vs_innovation_product_flag=cond(missing(innovation_product_raw),4,7)
replace innovation_product_flag=(innovation_product_raw==1) if missing(innovation_product_flag) & inlist(innovation_product_raw,1,2)
replace vs_innovation_product_flag=10 if !missing(innovation_product_flag) & missing(v_innovation_product_flag)
assert inlist(innovation_product_flag,0,1) if !missing(innovation_product_flag)
assert innovation_product_flag==v_innovation_product_flag if !missing(v_innovation_product_flag)
quietly count if !missing(innovation_product_flag)
local n=r(N)
quietly count if !missing(v_innovation_product_flag)
local v=r(N)
quietly count if vs_innovation_product_flag==10 & !missing(innovation_product_flag)
post counts (2021) ("innovation_product_flag") (_N) (`n') (`v') (r(N))
preserve
keep source_year source_row innovation_product_flag v_innovation_product_flag vs_innovation_product_flag
isid source_year source_row
save "dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_product_flag_2021.dta", replace
restore
display "TUNNEL_NODE_PASS N_G0_tunnel_innovation_product_flag_2021"
log close tcell
