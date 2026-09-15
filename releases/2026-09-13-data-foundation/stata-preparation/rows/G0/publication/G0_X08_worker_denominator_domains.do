* Tujuan: Hitung pekerja positif, nol, negatif, dan missing per tahun agar pembagi yang layak dapat dibedakan dari yang tidak layak. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: corrections/reports/__worker_ratio_domains.dta; corrections/reports/worker_denominator_domains.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:step-version" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 1 183 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:step-version" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 1 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L2:step-do" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 2 183 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L2:step-do" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 2 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L3:step-g0c_begin" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 3 183 `=_rc' // WFLOG-INJECTED
g0c_begin "G0-X08"
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L3:step-g0c_begin" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 3 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L4:step-use" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 4 183 `=_rc' // WFLOG-INJECTED
use source_year source_row workers using "data/analysis/G0_analysis_ready.dta", clear
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L4:step-use" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 4 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L5:step-generate" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 5 183 `=_rc' // WFLOG-INJECTED
* Hitung masing-masing pekerja positif, nol, negatif, atau missing; hanya nilai positif terisi yang dapat menjadi pembagi. // WFDOC-INJECTED
generate long positive_workers_n=workers>0 & !missing(workers)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L5:step-generate" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 5 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L6:step-generate" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 6 183 `=_rc' // WFLOG-INJECTED
* Hitung masing-masing pekerja positif, nol, negatif, atau missing; hanya nilai positif terisi yang dapat menjadi pembagi. // WFDOC-INJECTED
generate long zero_workers_n=workers==0
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L6:step-generate" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 6 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L7:step-generate" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 7 183 `=_rc' // WFLOG-INJECTED
* Hitung masing-masing pekerja positif, nol, negatif, atau missing; hanya nilai positif terisi yang dapat menjadi pembagi. // WFDOC-INJECTED
generate long negative_workers_n=workers<0 & !missing(workers)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L7:step-generate" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 7 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L8:step-generate" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 8 183 `=_rc' // WFLOG-INJECTED
* Hitung masing-masing pekerja positif, nol, negatif, atau missing; hanya nilai positif terisi yang dapat menjadi pembagi. // WFDOC-INJECTED
generate long missing_workers_n=missing(workers)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L8:step-generate" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 8 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L9:step-generate" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 9 183 `=_rc' // WFLOG-INJECTED
generate long rows=1
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L9:step-generate" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 9 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L10:step-collapse" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 10 183 `=_rc' // WFLOG-INJECTED
* Jumlahkan empat kategori menjadi hitungan per tahun; kategori tidak dilebur ke satu angka pekerja. // WFDOC-INJECTED
collapse (sum) rows positive_workers_n zero_workers_n negative_workers_n missing_workers_n, by(source_year)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L10:step-collapse" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 10 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L11:step-assert" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 11 183 `=_rc' // WFLOG-INJECTED
assert positive_workers_n+zero_workers_n+negative_workers_n+missing_workers_n==rows
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L11:step-assert" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 11 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L12:step-tempfile" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 12 183 `=_rc' // WFLOG-INJECTED
tempfile worker_domains
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L12:step-tempfile" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 12 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L13:step-save" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 13 183 `=_rc' // WFLOG-INJECTED
save `worker_domains'
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L13:step-save" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 13 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L14:step-use" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 14 183 `=_rc' // WFLOG-INJECTED
use "data/analysis/G0_analysis_ready.dta", clear
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L14:step-use" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 14 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L15:step-tempname" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 15 183 `=_rc' // WFLOG-INJECTED
tempname p
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L15:step-tempname" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 15 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L16:step-postfile" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 16 183 `=_rc' // WFLOG-INJECTED
* Siapkan tabel ringkasan; perintah post di bawah menambahkan hitungan atau hasil per kelompok. // WFDOC-INJECTED
postfile `p' int source_year str32 ratio long ratio_eligible_n using "corrections/reports/__worker_ratio_domains.dta", replace
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L16:step-postfile" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 16 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L17:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 17 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L17:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L17:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L18:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L17:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_labor_productivity_nominal)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L18:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L17:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L19:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L17:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_labor_productivity_nominal") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L19:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L17:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L17:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L17:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L17:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 17 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L21:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 18 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L21:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L21:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L22:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L21:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_output_per_worker_nominal)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L22:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L21:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L23:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L21:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_output_per_worker_nominal") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L23:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L21:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L21:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L21:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L21:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 18 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L25:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 19 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L25:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L25:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L26:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L25:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_capital_per_worker_nominal)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L26:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L25:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L27:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L25:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_capital_per_worker_nominal") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L27:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L25:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L25:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L25:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L25:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 19 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L29:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 20 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L29:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L29:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L30:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L29:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_inputs_per_worker_nominal)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L30:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L29:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L31:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L29:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_inputs_per_worker_nominal") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L31:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L29:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L29:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L29:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L29:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 20 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L33:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 21 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L33:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L33:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L34:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L33:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_rd_cost_per_worker_nominal)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L34:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L33:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L35:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L33:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_rd_cost_per_worker_nominal") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L35:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L33:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L33:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L33:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L33:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 21 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L37:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 22 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L37:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L37:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L38:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L37:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_energy_cost_per_worker)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L38:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L37:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L39:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L37:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_energy_cost_per_worker") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L39:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L37:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L37:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L37:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L37:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 22 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L41:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 23 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L41:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L41:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L42:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L41:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_total_gj_per_worker)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L42:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L41:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L43:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L41:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_total_gj_per_worker") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L43:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L41:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L41:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L41:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L41:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 23 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L45:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 24 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L45:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L45:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L46:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L45:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_co2_per_worker)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L46:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L45:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L47:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L45:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_co2_per_worker") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L47:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L45:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L45:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L45:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L45:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 24 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L49:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 25 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L49:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L49:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L50:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L49:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_capital_stock_per_worker)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L50:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L49:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L51:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L49:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_capital_stock_per_worker") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L51:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L49:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L49:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L49:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L49:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 25 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L53:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 26 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L53:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L53:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L54:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L53:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_capital_additions_per_worker)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L54:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L53:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L55:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L53:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_capital_additions_per_worker") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L55:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L53:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L53:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L53:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L53:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 26 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L57:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 27 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L57:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L57:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L58:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L57:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_cbdacu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L58:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L57:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L59:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L57:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_cbdacu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L59:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L57:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L57:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L57:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L57:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 27 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L61:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 28 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L61:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L61:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L62:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L61:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_cbfpcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L62:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L61:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L63:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L61:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_cbfpcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L63:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L61:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L61:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L61:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L61:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 28 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L65:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 29 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L65:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L65:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L66:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L65:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_cbsacu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L66:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L65:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L67:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L65:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_cbsacu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L67:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L65:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L65:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L65:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L65:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 29 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L69:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 30 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L69:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L69:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L70:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L69:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_cbttcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L70:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L69:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L71:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L69:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_cbttcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L71:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L69:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L69:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L69:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L69:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 30 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L73:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 31 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L73:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L73:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L74:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L73:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_cldacu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L74:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L73:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L75:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L73:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_cldacu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L75:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L73:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L73:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L73:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L73:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 31 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L77:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 32 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L77:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L77:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L78:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L77:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_clfpcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L78:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L77:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L79:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L77:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_clfpcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L79:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L77:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L77:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L77:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L77:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 32 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L81:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 33 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L81:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L81:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L82:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L81:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_clsacu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L82:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L81:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L83:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L81:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_clsacu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L83:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L81:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L81:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L81:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L81:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 33 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L85:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 34 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L85:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L85:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L86:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L85:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_clttcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L86:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L85:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L87:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L85:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_clttcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L87:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L85:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L85:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L85:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L85:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 34 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L89:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 35 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L89:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L89:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L90:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L89:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_cmdacu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L90:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L89:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L91:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L89:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_cmdacu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L91:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L89:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L89:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L89:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L89:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 35 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L93:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 36 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L93:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L93:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L94:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L93:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_cmfpcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L94:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L93:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L95:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L93:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_cmfpcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L95:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L93:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L93:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L93:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L93:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 36 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L97:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 37 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L97:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L97:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L98:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L97:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_cmsacu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L98:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L97:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L99:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L97:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_cmsacu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L99:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L97:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L97:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L97:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L97:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 37 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L101:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 38 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L101:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L101:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L102:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L101:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_cmttcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L102:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L101:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L103:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L101:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_cmttcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L103:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L101:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L101:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L101:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L101:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 38 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L105:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 39 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L105:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L105:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L106:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L105:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_codacu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L106:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L105:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L107:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L105:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_codacu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L107:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L105:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L105:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L105:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L105:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 39 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L109:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 40 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L109:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L109:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L110:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L109:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_cofpcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L110:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L109:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L111:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L109:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_cofpcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L111:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L109:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L109:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L109:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L109:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 40 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L113:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 41 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L113:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L113:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L114:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L113:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_cosacu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L114:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L113:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L115:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L113:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_cosacu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L115:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L113:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L113:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L113:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L113:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 41 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L117:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 42 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L117:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L117:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L118:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L117:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_costrd)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L118:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L117:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L119:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L117:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_costrd") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L119:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L117:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L117:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L117:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L117:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 42 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L121:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 43 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L121:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L121:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L122:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L121:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_cottcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L122:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L121:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L123:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L121:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_cottcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L123:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L121:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L121:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L121:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L121:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 43 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L125:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 44 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L125:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L125:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L126:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L125:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_csdacu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L126:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L125:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L127:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L125:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_csdacu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L127:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L125:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L125:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L125:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L125:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 44 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L129:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 45 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L129:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L129:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L130:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L129:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_csfpcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L130:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L129:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L131:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L129:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_csfpcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L131:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L129:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L129:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L129:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L129:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 45 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L133:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 46 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L133:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L133:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L134:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L133:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_cssacu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L134:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L133:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L135:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L133:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_cssacu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L135:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L133:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L133:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L133:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L133:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 46 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L137:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 47 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L137:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L137:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L138:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L137:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_csttcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L138:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L137:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L139:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L137:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_csttcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L139:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L137:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L137:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L137:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L137:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 47 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L141:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 48 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L141:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L141:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L142:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L141:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_ctdacu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L142:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L141:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L143:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L141:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_ctdacu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L143:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L141:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L141:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L141:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L141:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 48 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L145:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 49 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L145:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L145:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L146:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L145:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_ctfpcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L146:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L145:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L147:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L145:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_ctfpcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L147:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L145:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L145:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L145:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L145:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 49 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L149:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 50 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L149:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L149:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L150:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L149:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_ctsacu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L150:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L149:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L151:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L149:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_ctsacu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L151:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L149:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L149:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L149:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L149:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 50 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L153:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 51 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L153:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L153:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L154:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L153:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_cttcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L154:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L153:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L155:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L153:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_cttcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L155:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L153:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L153:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L153:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L153:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 51 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L157:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 52 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L157:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L157:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L158:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L157:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_ctttcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L158:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L157:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L159:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L157:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_ctttcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L159:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L157:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L157:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L157:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L157:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 52 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L161:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 53 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L161:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L161:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L162:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L161:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_cvdacu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L162:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L161:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L163:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L161:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_cvdacu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L163:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L161:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L161:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L161:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L161:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 53 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L165:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 54 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L165:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L165:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L166:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L165:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_cvfpcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L166:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L165:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L167:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L165:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_cvfpcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L167:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L165:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L165:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L165:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L165:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 54 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L169:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 55 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L169:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L169:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L170:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L169:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_cvsacu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L170:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L169:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L171:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L169:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_cvsacu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L171:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L169:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L169:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L169:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L169:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 55 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L173:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 56 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L173:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L173:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L174:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L173:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_cvttcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L174:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L173:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L175:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L173:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_cvttcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L175:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L173:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L173:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L173:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L173:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 56 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L177:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 57 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L177:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L177:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L178:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L177:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_devvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L178:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L177:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L179:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L177:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_devvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L179:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L177:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L177:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L177:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L177:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 57 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L181:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 58 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L181:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L181:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L182:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L181:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_ecavce)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L182:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L181:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L183:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L181:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_ecavce") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L183:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L181:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L181:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L181:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L181:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 58 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L185:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 59 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L185:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L185:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L186:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L185:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_ecavcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L186:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L185:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L187:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L185:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_ecavcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L187:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L185:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L185:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L185:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L185:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 59 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L189:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 60 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L189:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L189:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L190:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L189:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_ecbvce)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L190:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L189:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L191:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L189:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_ecbvce") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L191:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L189:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L189:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L189:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L189:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 60 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L193:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 61 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L193:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L193:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L194:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L193:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_ecbvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L194:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L193:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L195:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L193:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_ecbvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L195:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L193:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L193:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L193:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L193:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 61 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L197:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 62 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L197:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L197:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L198:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L197:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_eckvce)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L198:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L197:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L199:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L197:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_eckvce") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L199:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L197:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L197:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L197:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L197:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 62 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L201:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 63 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L201:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L201:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L202:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L201:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_eckvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L202:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L201:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L203:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L201:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_eckvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L203:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L201:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L201:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L201:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L201:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 63 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L205:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 64 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L205:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L205:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L206:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L205:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_eclvce)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L206:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L205:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L207:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L205:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_eclvce") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L207:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L205:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L205:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L205:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L205:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 64 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L209:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 65 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L209:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L209:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L210:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L209:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_eclvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L210:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L209:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L211:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L209:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_eclvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L211:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L209:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L209:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L209:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L209:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 65 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L213:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 66 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L213:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L213:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L214:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L213:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_edivce)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L214:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L213:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L215:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L213:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_edivce") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L215:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L213:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L213:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L213:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L213:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 66 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L217:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 67 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L217:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L217:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L218:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L217:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_edivcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L218:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L217:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L219:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L217:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_edivcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L219:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L217:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L217:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L217:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L217:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 67 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L221:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 68 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L221:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L221:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L222:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L221:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_efovce)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L222:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L221:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L223:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L221:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_efovce") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L223:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L221:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L221:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L221:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L221:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 68 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L225:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 69 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L225:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L225:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L226:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L225:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_efovcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L226:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L225:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L227:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L225:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_efovcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L227:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L225:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L225:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L225:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L225:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 69 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L229:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 70 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L229:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L229:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L230:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L229:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_efuvce)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L230:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L229:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L231:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L229:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_efuvce") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L231:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L229:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L229:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L229:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L229:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 70 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L233:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 71 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L233:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L233:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L234:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L233:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_efuvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L234:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L233:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L235:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L233:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_efuvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L235:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L233:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L233:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L233:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L233:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 71 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L237:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 72 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L237:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L237:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L238:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L237:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_egavce)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L238:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L237:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L239:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L237:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_egavce") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L239:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L237:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L237:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L237:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L237:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 72 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L241:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 73 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L241:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L241:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L242:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L241:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_egavcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L242:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L241:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L243:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L241:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_egavcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L243:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L241:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L241:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L241:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L241:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 73 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L245:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 74 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L245:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L245:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L246:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L245:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_egovce)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L246:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L245:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L247:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L245:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_egovce") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L247:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L245:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L245:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L245:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L245:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 74 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L249:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 75 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L249:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L249:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L250:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L249:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_egovcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L250:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L249:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L251:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L249:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_egovcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L251:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L249:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L249:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L249:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L249:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 75 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L253:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 76 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L253:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L253:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L254:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L253:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_elpvce)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L254:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L253:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L255:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L253:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_elpvce") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L255:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L253:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L253:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L253:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L253:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 76 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L257:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 77 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L257:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L257:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L258:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L257:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_elpvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L258:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L257:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L259:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L257:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_elpvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L259:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L257:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L257:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L257:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L257:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 77 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L261:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 78 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L261:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L261:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L262:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L261:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_eluvce)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L262:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L261:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L263:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L261:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_eluvce") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L263:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L261:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L261:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L261:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L261:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 78 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L265:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 79 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L265:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L265:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L266:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L265:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_eluvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L266:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L265:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L267:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L265:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_eluvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L267:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L265:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L265:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L265:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L265:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 79 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L269:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 80 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L269:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L269:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L270:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L269:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_encvce)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L270:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L269:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L271:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L269:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_encvce") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L271:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L269:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L269:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L269:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L269:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 80 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L273:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 81 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L273:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L273:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L274:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L273:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_encvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L274:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L273:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L275:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L273:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_encvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L275:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L273:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L273:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L273:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L273:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 81 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L277:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 82 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L277:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L277:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L278:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L277:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_engvce)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L278:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L277:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L279:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L277:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_engvce") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L279:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L277:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L277:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L277:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L277:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 82 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L281:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 83 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L281:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L281:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L282:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L281:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_engvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L282:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L281:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L283:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L281:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_engvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L283:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L281:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L281:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L281:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L281:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 83 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L285:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 84 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L285:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L285:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L286:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L285:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_enpvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L286:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L285:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L287:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L285:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_enpvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L287:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L285:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L285:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L285:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L285:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 84 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L289:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 85 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L289:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L289:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L290:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L289:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_eoivce)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L290:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L289:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L291:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L289:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_eoivce") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L291:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L289:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L289:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L289:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L289:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 85 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L293:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 86 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L293:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L293:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L294:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L293:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_eoivcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L294:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L293:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L295:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L293:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_eoivcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L295:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L293:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L293:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L293:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L293:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 86 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L297:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 87 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L297:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L297:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L298:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L297:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_epevce)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L298:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L297:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L299:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L297:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_epevce") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L299:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L297:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L297:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L297:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L297:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 87 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L301:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 88 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L301:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L301:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L302:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L301:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_epevcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L302:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L301:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L303:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L301:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_epevcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L303:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L301:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L301:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L301:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L301:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 88 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L305:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 89 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L305:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L305:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L306:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L305:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_eplvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L306:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L305:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L307:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L305:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_eplvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L307:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L305:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L305:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L305:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L305:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 89 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L309:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 90 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L309:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L309:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L310:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L309:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_esdvce)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L310:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L309:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L311:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L309:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_esdvce") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L311:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L309:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L309:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L309:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L309:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 90 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L313:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 91 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L313:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L313:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L314:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L313:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_esdvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L314:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L313:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L315:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L313:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_esdvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L315:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L313:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L313:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L313:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L313:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 91 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L317:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 92 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L317:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L317:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L318:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L317:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_esovce)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L318:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L317:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L319:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L317:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_esovce") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L319:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L317:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L317:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L317:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L317:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 92 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L321:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 93 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L321:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L321:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L322:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L321:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_esovcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L322:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L321:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L323:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L321:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_esovcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L323:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L321:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L321:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L321:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L321:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 93 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L325:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 94 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L325:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L325:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L326:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L325:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_ibrvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L326:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L325:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L327:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L325:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_ibrvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L327:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L325:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L325:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L325:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L325:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 94 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L329:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 95 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L329:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L329:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L330:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L329:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_icovcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L330:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L329:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L331:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L329:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_icovcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L331:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L329:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L329:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L329:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L329:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 95 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L333:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 96 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L333:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L333:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L334:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L333:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_idevcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L334:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L333:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L335:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L333:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_idevcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L335:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L333:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L333:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L333:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L333:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 96 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L337:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 97 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L337:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L337:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L338:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L337:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_iinput)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L338:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L337:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L339:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L337:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_iinput") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L339:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L337:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L337:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L337:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L337:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 97 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L341:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 98 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L341:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L341:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L342:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L341:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_iinvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L342:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L341:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L343:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L341:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_iinvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L343:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L341:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L341:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L341:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L341:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 98 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L345:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 99 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L345:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L345:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L346:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L345:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_iisfov)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L346:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L345:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L347:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L345:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_iisfov") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L347:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L345:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L345:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L345:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L345:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 99 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L349:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 100 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L349:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L349:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L350:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L349:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_iislov)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L350:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L349:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L351:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L349:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_iislov") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L351:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L349:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L349:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L349:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L349:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 100 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L353:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 101 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L353:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L353:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L354:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L353:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_iisvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L354:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L353:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L355:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L353:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_iisvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L355:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L353:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L353:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L353:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L353:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 101 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L357:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 102 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L357:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L357:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L358:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L357:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_ikivcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L358:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L357:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L359:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L357:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_ikivcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L359:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L357:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L357:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L357:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L357:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 102 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L361:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 103 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L361:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L361:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L362:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L361:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_iklvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L362:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L361:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L363:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L361:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_iklvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L363:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L361:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L361:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L361:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L361:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 103 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L365:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 104 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L365:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L365:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L366:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L365:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_ikovcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L366:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L365:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L367:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L365:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_ikovcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L367:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L365:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L365:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L365:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L365:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 104 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L369:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 105 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L369:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L369:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L370:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L369:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_ilrvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L370:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L369:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L371:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L369:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_ilrvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L371:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L369:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L369:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L369:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L369:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 105 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L373:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 106 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L373:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L373:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L374:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L373:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_insvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L374:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L373:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L375:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L373:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_insvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L375:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L373:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L373:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L373:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L373:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 106 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L377:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 107 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L377:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L377:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L378:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L377:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_intvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L378:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L377:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L379:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L377:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_intvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L379:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L377:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L377:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L377:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L377:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 107 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L381:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 108 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L381:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L381:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L382:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L381:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_iotvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L382:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L381:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L383:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L381:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_iotvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L383:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L381:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L381:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L381:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L381:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 108 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L385:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 109 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L385:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L385:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L386:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L385:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_ipkvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L386:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L385:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L387:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L385:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_ipkvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L387:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L385:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L385:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L385:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L385:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 109 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L389:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 110 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L389:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L389:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L390:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L389:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_iprvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L390:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L389:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L391:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L389:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_iprvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L391:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L389:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L389:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L389:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L389:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 110 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L393:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 111 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L393:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L393:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L394:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L393:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_irdvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L394:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L393:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L395:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L393:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_irdvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L395:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L393:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L393:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L393:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L393:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 111 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L397:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 112 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L397:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L397:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L398:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L397:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_irevcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L398:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L397:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L399:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L397:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_irevcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L399:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L397:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L397:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L397:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L397:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 112 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L401:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 113 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L401:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L401:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L402:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L401:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_irrvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L402:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L401:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L403:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L401:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_irrvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L403:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L401:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L401:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L401:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L401:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 113 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L405:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 114 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L405:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L405:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L406:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L405:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_itxvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L406:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L405:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L407:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L405:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_itxvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L407:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L405:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L405:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L405:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L405:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 114 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L409:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 115 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L409:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L409:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L410:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L409:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_iuwvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L410:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L409:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L411:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L409:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_iuwvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L411:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L409:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L409:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L409:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L409:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 115 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L413:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 116 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L413:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L413:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L414:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L413:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_nopvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L414:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L413:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L415:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L413:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_nopvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L415:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L413:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L413:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L413:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L413:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 116 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L417:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 117 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L417:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L417:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L418:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L417:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_othvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L418:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L417:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L419:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L417:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_othvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L419:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L417:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L417:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L417:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L417:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 117 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L421:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 118 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L421:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L421:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L422:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L421:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_output)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L422:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L421:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L423:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L421:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_output") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L423:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L421:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L421:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L421:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L421:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 118 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L425:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 119 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L425:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L425:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L426:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L425:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_rdnvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L426:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L425:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L427:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L425:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_rdnvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L427:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L425:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L425:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L425:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L425:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 119 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L429:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 120 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L429:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L429:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L430:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L429:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_renvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L430:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L429:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L431:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L429:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_renvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L431:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L429:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L429:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L429:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L429:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 120 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L433:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 121 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L433:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L433:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L434:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L433:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_rimvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L434:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L433:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L435:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L433:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_rimvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L435:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L433:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L433:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L433:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L433:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 121 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L437:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 122 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L437:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L437:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L438:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L437:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_rtlvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L438:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L437:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L439:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L437:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_rtlvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L439:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L437:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L437:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L437:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L437:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 122 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L441:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 123 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L441:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L441:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L442:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L441:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_sfbvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L442:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L441:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L443:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L441:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_sfbvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L443:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L441:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L441:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L441:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L441:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 123 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L445:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 124 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L445:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L445:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L446:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L445:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_sfcvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L446:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L445:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L447:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L445:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_sfcvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L447:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L445:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L445:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L445:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L445:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 124 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L449:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 125 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L449:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L449:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L450:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L449:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_sfdvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L450:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L449:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L451:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L449:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_sfdvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L451:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L449:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L449:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L449:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L449:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 125 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L453:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 126 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L453:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L453:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L454:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L453:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_sfgvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L454:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L453:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L455:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L453:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_sfgvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L455:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L453:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L453:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L453:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L453:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 126 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L457:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 127 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L457:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L457:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L458:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L457:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_sfjvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L458:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L457:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L459:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L457:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_sfjvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L459:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L457:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L457:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L457:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L457:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 127 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L461:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 128 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L461:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L461:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L462:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L461:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_sfkvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L462:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L461:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L463:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L461:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_sfkvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L463:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L461:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L461:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L461:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L461:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 128 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L465:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 129 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L465:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L465:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L466:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L465:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_sfnvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L466:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L465:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L467:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L465:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_sfnvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L467:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L465:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L465:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L465:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L465:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 129 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L469:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 130 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L469:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L469:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L470:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L469:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_sfovcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L470:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L469:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L471:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L469:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_sfovcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L471:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L469:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L469:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L469:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L469:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 130 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L473:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 131 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L473:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L473:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L474:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L473:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_sfrvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L474:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L473:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L475:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L473:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_sfrvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L475:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L473:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L473:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L473:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L473:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 131 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L477:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 132 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L477:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L477:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L478:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L477:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_sfsvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L478:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L477:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L479:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L477:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_sfsvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L479:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L477:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L477:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L477:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L477:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 132 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L481:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 133 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L481:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L481:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L482:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L481:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_sfuvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L482:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L481:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L483:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L481:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_sfuvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L483:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L481:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L481:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L481:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L481:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 133 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L485:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 134 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L485:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L485:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L486:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L485:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_shdvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L486:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L485:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L487:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L485:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_shdvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L487:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L485:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L485:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L485:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L485:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 134 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L489:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 135 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L489:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L489:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L490:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L489:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_shfvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L490:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L489:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L491:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L489:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_shfvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L491:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L489:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L489:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L489:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L489:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 135 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L493:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 136 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L493:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L493:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L494:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L493:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_shjvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L494:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L493:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L495:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L493:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_shjvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L495:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L493:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L493:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L493:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L493:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 136 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L497:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 137 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L497:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L497:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L498:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L497:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_srdvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L498:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L497:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L499:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L497:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_srdvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L499:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L497:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L497:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L497:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L497:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 137 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L501:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 138 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L501:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L501:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L502:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L501:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_srjvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L502:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L501:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L503:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L501:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_srjvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L503:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L501:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L501:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L501:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L501:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 138 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L505:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 139 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L505:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L505:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L506:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L505:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_srmvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L506:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L505:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L507:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L505:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_srmvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L507:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L505:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L505:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L505:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L505:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 139 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L509:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 140 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L509:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L509:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L510:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L509:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_stdvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L510:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L509:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L511:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L509:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_stdvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L511:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L509:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L509:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L509:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L509:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 140 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L513:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 141 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L513:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L513:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L514:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L513:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_stjvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L514:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L513:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L515:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L513:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_stjvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L515:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L513:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L513:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L513:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L513:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 141 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L517:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 142 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L517:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L517:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L518:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L517:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_stlvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L518:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L517:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L519:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L517:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_stlvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L519:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L517:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L517:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L517:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L517:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 142 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L521:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 143 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L521:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L521:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L522:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L521:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_vtlvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L522:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L521:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L523:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L521:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_vtlvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L523:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L521:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L521:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L521:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L521:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 143 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L525:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 144 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L525:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L525:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L526:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L525:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_yelvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L526:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L525:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L527:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L525:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_yelvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L527:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L525:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L525:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L525:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L525:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 144 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L529:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 145 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L529:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L529:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L530:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L529:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_yisvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L530:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L529:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L531:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L529:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_yisvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L531:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L529:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L529:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L529:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L529:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 145 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L533:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 146 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L533:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L533:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L534:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L533:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_yisvdo)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L534:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L533:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L535:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L533:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_yisvdo") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L535:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L533:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L533:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L533:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L533:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 146 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L537:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 147 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L537:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L537:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L538:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L537:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_yisvfo)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L538:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L537:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L539:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L537:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_yisvfo") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L539:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L537:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L537:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L537:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L537:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 147 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L541:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 148 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L541:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L541:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L542:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L541:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_ykdvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L542:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L541:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L543:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L541:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_ykdvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L543:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L541:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L541:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L541:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L541:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 148 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L545:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 149 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L545:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L545:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L546:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L545:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_ykfvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L546:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L545:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L547:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L545:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_ykfvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L547:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L545:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L545:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L545:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L545:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 149 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L549:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 150 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L549:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L549:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L550:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L549:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_ykivcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L550:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L549:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L551:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L549:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_ykivcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L551:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L549:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L549:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L549:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L549:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 150 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L553:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 151 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L553:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L553:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L554:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L553:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_yprvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L554:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L553:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L555:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L553:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_yprvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L555:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L553:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L553:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L553:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L553:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 151 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L557:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 152 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L557:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L557:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L558:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L557:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_yrnvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L558:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L557:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L559:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L557:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_yrnvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L559:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L557:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L557:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L557:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L557:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 152 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L561:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 153 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L561:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L561:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L562:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L561:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_yrsvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L562:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L561:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L563:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L561:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_yrsvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L563:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L561:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L561:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L561:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L561:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 153 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L565:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 154 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L565:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L565:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L566:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L565:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_ysnvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L566:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L565:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L567:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L565:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_ysnvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L567:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L565:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L565:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L565:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L565:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 154 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L569:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 155 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L569:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L569:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L570:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L569:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_ytovcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L570:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L569:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L571:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L569:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_ytovcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L571:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L569:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L569:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L569:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L569:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 155 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L573:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 156 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L573:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L573:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L574:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L573:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_znavcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L574:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L573:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L575:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L573:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_znavcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L575:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L573:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L573:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L573:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L573:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 156 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L577:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 157 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L577:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L577:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L578:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L577:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_zndvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L578:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L577:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L579:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L577:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_zndvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L579:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L577:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L577:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L577:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L577:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 157 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L581:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 158 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L581:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L581:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L582:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L581:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_znevcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L582:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L581:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L583:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L581:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_znevcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L583:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L581:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L581:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L581:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L581:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 158 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L585:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 159 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L585:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L585:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L586:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L585:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_znhvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L586:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L585:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L587:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L585:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_znhvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L587:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L585:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L585:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L585:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L585:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 159 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L589:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 160 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L589:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L589:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L590:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L589:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_znivcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L590:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L589:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L591:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L589:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_znivcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L591:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L589:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L589:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L589:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L589:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 160 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L593:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 161 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L593:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L593:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L594:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L593:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_znovcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L594:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L593:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L595:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L593:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_znovcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L595:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L593:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L593:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L593:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L593:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 161 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L597:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 162 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L597:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L597:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L598:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L597:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_znpvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L598:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L597:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L599:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L597:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_znpvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L599:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L597:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L597:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L597:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L597:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 162 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L601:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 163 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L601:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L601:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L602:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L601:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_znrvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L602:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L601:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L603:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L601:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_znrvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L603:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L601:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L601:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L601:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L601:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 163 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L605:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 164 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L605:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L605:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L606:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L605:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_znsvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L606:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L605:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L607:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L605:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_znsvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L607:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L605:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L605:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L605:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L605:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 164 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L609:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 165 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L609:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L609:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L610:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L609:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_zntvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L610:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L609:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L611:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L609:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_zntvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L611:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L609:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L609:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L609:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L609:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 165 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L613:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 166 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L613:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L613:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L614:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L613:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_zpavcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L614:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L613:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L615:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L613:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_zpavcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L615:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L613:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L613:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L613:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L613:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 166 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L617:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 167 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L617:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L617:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L618:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L617:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_zpdvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L618:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L617:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L619:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L617:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_zpdvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L619:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L617:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L617:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L617:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L617:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 167 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L621:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 168 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L621:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L621:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L622:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L621:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_zpevcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L622:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L621:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L623:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L621:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_zpevcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L623:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L621:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L621:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L621:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L621:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 168 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L625:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 169 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L625:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L625:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L626:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L625:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_zphvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L626:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L625:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L627:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L625:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_zphvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L627:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L625:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L625:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L625:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L625:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 169 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L629:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 170 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L629:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L629:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L630:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L629:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_zpivcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L630:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L629:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L631:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L629:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_zpivcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L631:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L629:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L629:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L629:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L629:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 170 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L633:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 171 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L633:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L633:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L634:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L633:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_zpovcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L634:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L633:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L635:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L633:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_zpovcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L635:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L633:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L633:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L633:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L633:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 171 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L637:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 172 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L637:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L637:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L638:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L637:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_zppvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L638:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L637:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L639:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L637:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_zppvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L639:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L637:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L637:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L637:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L637:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 172 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L641:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 173 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L641:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L641:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L642:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L641:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_zprvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L642:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L641:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L643:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L641:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_zprvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L643:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L641:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L641:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L641:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L641:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 173 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L645:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 174 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L645:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L645:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L646:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L645:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_zpsvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L646:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L645:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L647:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L645:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_zpsvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L647:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L645:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L645:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L645:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L645:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 174 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L649:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 175 183 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L649:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L649:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L650:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L649:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(r_pw_val_zptvcu)
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L650:step-count" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L649:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L651:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L649:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    post `p' (`y') ("r_pw_val_zptvcu") (r(N))
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L651:step-post" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L649:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L649:iteration-body" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L649:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L649:step-foreach" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "loop" 175 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L653:step-postclose" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 176 183 `=_rc' // WFLOG-INJECTED
postclose `p'
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L653:step-postclose" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 176 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L654:step-use" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 177 183 `=_rc' // WFLOG-INJECTED
use "corrections/reports/__worker_ratio_domains.dta", clear
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L654:step-use" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 177 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L655:step-merge" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 178 183 `=_rc' // WFLOG-INJECTED
merge m:1 source_year using `worker_domains', assert(match) nogen
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L655:step-merge" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 178 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L656:step-assert" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 179 183 `=_rc' // WFLOG-INJECTED
assert ratio_eligible_n<=positive_workers_n
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L656:step-assert" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 179 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L657:step-isid" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 180 183 `=_rc' // WFLOG-INJECTED
isid source_year ratio
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L657:step-isid" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 180 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L658:step-save" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 181 183 `=_rc' // WFLOG-INJECTED
save "corrections/reports/worker_denominator_domains.dta", replace
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L658:step-save" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 181 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L659:step-display" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 182 183 `=_rc' // WFLOG-INJECTED
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X08"
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L659:step-display" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 182 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X08_worker_denominator_domains.do:L660:step-log" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 183 183 `=_rc' // WFLOG-INJECTED
capture log close G0CHILD
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L660:step-log" "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "statement" 183 183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X08_worker_denominator_domains.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
