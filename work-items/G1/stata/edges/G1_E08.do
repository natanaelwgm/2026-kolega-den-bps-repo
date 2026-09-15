* WFDOC: Wooldridge mewarisi domain LP dan menambah timing; sistem GMM shared-theta dijalankan terpisah oleh wrapper setelah gate diterima.
gen byte g1_nominal_wrdg = g1_nominal_lp
gen byte g1_concept_wrdg = g1_concept_lp
gen byte g1_real_wrdg = g1_real_lp
gen byte g1_eligible_wrdg = g1_eligible_lp & g1_timing_verified
save "$G1_RUN/S08_WRDG_support.dta", replace
