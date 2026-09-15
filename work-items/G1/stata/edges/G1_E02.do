* WFDOC: Prefix dua digit industry_code hanya kategori deskriptif; tidak membuktikan pool teknologi atau dukungan estimator.
* WFDOC: Gate konsep, proxy, harga, seleksi, timing, dan pengukuran dimulai nol sampai bukti terkait diterima; output S02_concepts.dta.
* Observed code prefixes are descriptive categories, not accepted technology pools.
gen str20 g1_code_prefix = substr(industry_code,1,2)
replace g1_code_prefix = "UNKNOWN" if missing(g1_code_prefix)
gen byte g1_technology_verified = 0
gen byte g1_proxy_definition_verified = 0
gen byte g1_investment_price_verified = 0
gen byte g1_selection_verified = 0
gen byte g1_timing_verified = 0
gen byte g1_measurement_admitted = 0
save "$G1_RUN/S02_concepts.dta", replace
