* WFDOC: Menghitung status gate per tahun dan mengunci eligibility real/common tetap tertutup sebelum estimasi primer.
* WFDOC: eligibility_gates.csv memisahkan N_pass, N_unknown, dan sisa N_source; pemeriksaan akhir memastikan TFP tetap missing.
tempname gates
postfile `gates' double source_year str40 gate double N_source N_pass N_unknown using "$G1_RUN/gates.dta", replace
levelsof source_year, local(years)
foreach y of local years {
    quietly count if source_year==`y'
    local n=r(N)
    foreach v in g1_panel_usable g1_lag1 g1_lag2 g1_stock_concept g1_measurement_admitted g1_technology_verified g1_proxy_definition_verified g1_investment_price_verified g1_selection_verified g1_timing_verified g1_real_base {
        quietly count if source_year==`y' & `v'==1
        local pass=r(N)
        quietly count if source_year==`y' & missing(`v')
        post `gates' (`y') ("`v'") (`n') (`pass') (r(N))
    }
}
postclose `gates'
preserve
use "$G1_RUN/gates.dta", clear
* WFDOC: Flag eksplisit bukan satu masuk not-pass; missing tetap kategori unknown.
gen double N_not_pass = N_source-N_pass-N_unknown
assert N_not_pass>=0
gen str100 data_label = "G0.5 DEVELOPMENT - perturbed data; not final empirical findings"
export delimited using "$G1_RUN/outputs/eligibility_gates.csv", replace
restore
* WFDOC: Pemeriksaan akhir menolak TFP terisi atau domain terbuka dan menjaga satu record per obs_id.
foreach m in op lp acf wrdg {
    assert missing(tfp_`m')
    assert g1_eligible_`m'==0
}
assert g1_common==0
isid obs_id
