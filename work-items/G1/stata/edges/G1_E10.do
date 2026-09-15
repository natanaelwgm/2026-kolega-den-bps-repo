* WFDOC: OP real belum dibuka tanpa investasi real/harga, sampel positif, serta risk/exit dan timing yang tervalidasi.
* WFDOC: Assert mengunci eligibility=0; tfp_op missing/status BLOCKED bukan nol atau fallback OLS.
* This data-version gate is evaluated before attempting OP.
quietly count if g1_eligible_op==1
assert r(N)==0
* No scientific fit is claimed. A future accepted input requires an explicit gate revision.
gen double tfp_op = .
gen str60 tfp_op_status = "BLOCKED_REAL_MEASUREMENT_PRICES"
save "$G1_RUN/S10_op_blocked.dta", replace
