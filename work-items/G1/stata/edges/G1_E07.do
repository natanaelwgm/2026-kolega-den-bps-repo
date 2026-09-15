* WFDOC: ACF mewarisi domain input/proxy LP lalu menambah gate timing ACF; S07_ACF_support.dta hanya mencatat eligibility dan tidak mengestimasi koefisien.
gen byte g1_nominal_acf = g1_nominal_lp
gen byte g1_concept_acf = g1_concept_lp
gen byte g1_real_acf = g1_real_lp
gen byte g1_eligible_acf = g1_eligible_lp & g1_timing_verified
save "$G1_RUN/S07_ACF_support.dta", replace
