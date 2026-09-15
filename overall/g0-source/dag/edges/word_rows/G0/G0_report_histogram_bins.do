* Tujuan: Jalankan perintah yang tercantum di file ini pada data atau argumen yang disediakan pemanggilnya. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: report/tables/histogram_ln_workers.csv; report/tables/histogram_ln_output_nominal.csv; dan 1 masukan lain // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
clear all
set more off
args root
cd "`root'"
capture log close
log using "report/evidence/G0_histogram_bins.log", text replace
* Ulangi blok untuk setiap pair yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach pair in "ln_workers 0.5" "ln_output_nominal 1" "ln_total_gj_s1 1" {
 gettoken variable width : pair
 local width=real(strtrim("`width'"))
 use `variable' using "data/analysis/G0_analysis_ready.dta", clear
 keep if !missing(`variable')
 quietly summarize `variable'
 local n=r(N)
 local start=floor(r(min)/`width')*`width'
 generate long bin=floor((`variable'-`start')/`width')
 contract bin, freq(count)
 generate double left=`start'+bin*`width'
 generate double width=`width'
 generate double proportion=count/`n'
 generate long eligible_n=`n'
 egen double check_total=total(proportion)
 assert abs(check_total-1)<1e-10
 drop check_total
 export delimited using "report/tables/histogram_`variable'.csv", replace
}
display "G0_REPORT_HISTOGRAM_BINS_PASS"
log close
