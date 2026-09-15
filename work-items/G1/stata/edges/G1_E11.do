* WFDOC: LP real belum dijalankan sebelum input antara real, stok modal, bridge harga, teknologi, panel, dan timing diterima.
* WFDOC: Assert mengunci eligibility=0; tfp_lp missing/status BLOCKED tidak diganti proxy nominal atau OLS.
* This data-version gate is evaluated before attempting LP.
quietly count if g1_eligible_lp==1
assert r(N)==0
* No scientific fit is claimed. A future accepted input requires an explicit gate revision.
gen double tfp_lp = .
gen str60 tfp_lp_status = "BLOCKED_REAL_MEASUREMENT_PRICES"
save "$G1_RUN/S11_lp_blocked.dta", replace
