* WFDOC: ACF real memerlukan dukungan input LP dan timing/momen ACF; edge ini hanya menguji gate sebelum estimator dipanggil.
* WFDOC: Assert menghentikan placeholder bila domain terbuka; jika tertutup, tfp_acf tetap missing dengan status blocker.
* This data-version gate is evaluated before attempting ACF.
quietly count if g1_eligible_acf==1
assert r(N)==0
* No scientific fit is claimed. A future accepted input requires an explicit gate revision.
gen double tfp_acf = .
gen str60 tfp_acf_status = "BLOCKED_REAL_MEASUREMENT_PRICES"
save "$G1_RUN/S12_acf_blocked.dta", replace
