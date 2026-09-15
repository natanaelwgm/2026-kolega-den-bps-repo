* WFDOC: Wooldridge real memerlukan input, kalender, teknologi, dan sistem GMM yang diterima; edge ini tidak menghitung fit.
* WFDOC: Assert menjaga domain tertutup; tfp_wrdg missing/status BLOCKED mencegah placeholder dibaca sebagai estimasi.
* This data-version gate is evaluated before attempting WRDG.
quietly count if g1_eligible_wrdg==1
assert r(N)==0
* No scientific fit is claimed. A future accepted input requires an explicit gate revision.
gen double tfp_wrdg = .
gen str60 tfp_wrdg_status = "BLOCKED_REAL_MEASUREMENT_PRICES"
save "$G1_RUN/S13_wrdg_blocked.dta", replace
