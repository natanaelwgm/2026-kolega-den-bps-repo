* WFDOC: OP memerlukan investasi/modal/VA real yang positif dan terverifikasi, ditambah panel-lag, teknologi, selection-risk, dan timing yang diterima.
* WFDOC: g1_real_investment sengaja missing sampai investasi real dan harganya tersedia; edge menyimpan dukungan, bukan menjalankan OP.
gen byte g1_nominal_op = g1_nominal_base & capital_additions_nominal>0 & !missing(capital_additions_nominal)
gen byte g1_concept_op = g1_nominal_op & g1_stock_concept & capital_additions_verified==1
gen double g1_real_investment = .
gen byte g1_real_op = g1_concept_op & g1_real_base & g1_real_investment>0 & !missing(g1_real_investment) & g1_investment_price_verified
gen byte g1_eligible_op = g1_real_op & g1_panel_usable & g1_lag1==1 & g1_technology_verified & g1_selection_verified & g1_timing_verified
save "$G1_RUN/S05_OP_support.dta", replace
