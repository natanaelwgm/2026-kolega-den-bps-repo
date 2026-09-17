* Tujuan: Bentuk tabel atau laporan dari kolom dan kondisi yang tercantum langsung di file ini. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: data/analysis/signed_thresholds.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "rows/G0/corrections/_utils.do"
g0c_begin "C050_signed_tail_threshold"
use source_year source_row va_signed_nominal using "data/analysis/G0_analysis_ready.dta", clear
generate double __absolute=abs(va_signed_nominal)
bysort source_year: egen double p99_abs_va=pctile(__absolute), p(99)
generate long __nonzero=va_signed_nominal!=0 & !missing(va_signed_nominal)
collapse (count) n_signed_va=va_signed_nominal (sum) n_nonzero=__nonzero (first) p99_abs_va, by(source_year)
recast long n_signed_va n_nonzero
replace p99_abs_va=. if n_signed_va==0
isid source_year
keep source_year n_signed_va n_nonzero p99_abs_va
order source_year
save "data/analysis/signed_thresholds.dta", replace
capture log close G0CHILD
