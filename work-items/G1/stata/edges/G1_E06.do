* WFDOC: val_rtlvcu adalah kandidat tagihan, bukan bukti kuantitas material atau harga yang sesuai untuk LP.
* WFDOC: LP memerlukan input antara real positif, definisi proxy, stok/VA real, panel, lag kalender, teknologi dan timing; log proxy hanya untuk angka positif.
* val_rtlvcu is only a materials candidate; a positive bill does not prove its definition or price.
gen byte g1_nominal_lp = g1_nominal_base & val_rtlvcu>0 & !missing(val_rtlvcu)
gen byte g1_concept_lp = g1_nominal_lp & g1_stock_concept
gen byte g1_real_lp = g1_concept_lp & g1_real_base & intermediate_inputs_real>0 & !missing(intermediate_inputs_real) & g1_proxy_definition_verified
gen byte g1_eligible_lp = g1_real_lp & g1_panel_usable & g1_lag1==1 & g1_technology_verified & g1_timing_verified
gen double g1_ln_proxy = ln(intermediate_inputs_real) if intermediate_inputs_real>0 & !missing(intermediate_inputs_real)
save "$G1_RUN/S06_LP_support.dta", replace
