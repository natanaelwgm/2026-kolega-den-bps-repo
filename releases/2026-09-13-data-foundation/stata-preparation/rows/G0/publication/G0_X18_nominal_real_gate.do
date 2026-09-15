* Tujuan: Periksa bahwa belum ada deflator diterapkan dan nilai riil masih kosong; laporkan jumlah nominal, yang layak harga, dan nilai riil per tahun. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: corrections/reports/__real_gates.dta; corrections/reports/nominal_real_gate.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:step-version" "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "statement" 1 18 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:step-version" "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "statement" 1 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X18_nominal_real_gate.do:L2:step-do" "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "statement" 2 18 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/publication/G0_X18_nominal_real_gate.do:L2:step-do" "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "statement" 2 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X18_nominal_real_gate.do:L3:step-g0c_begin" "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "statement" 3 18 `=_rc' // WFLOG-INJECTED
g0c_begin "G0-X18"
capture noisily __wf_progress end "rows/G0/publication/G0_X18_nominal_real_gate.do:L3:step-g0c_begin" "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "statement" 3 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X18_nominal_real_gate.do:L4:step-use" "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "statement" 4 18 `=_rc' // WFLOG-INJECTED
use source_year source_row gross_output_nominal value_added_nominal capital_stock_nominal capital_additions_nominal gross_output_real value_added_real capital_real deflator_applied using "data/analysis/G0_analysis_ready.dta", clear
capture noisily __wf_progress end "rows/G0/publication/G0_X18_nominal_real_gate.do:L4:step-use" "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "statement" 4 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X18_nominal_real_gate.do:L5:step-assert" "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "statement" 5 18 `=_rc' // WFLOG-INJECTED
* Pastikan nilai riil tetap kosong dan flag deflator nol; laporan ini memeriksa gerbang, bukan mengubah nominal menjadi riil. // WFDOC-INJECTED
assert deflator_applied==0 & missing(gross_output_real) & missing(value_added_real) & missing(capital_real)
capture noisily __wf_progress end "rows/G0/publication/G0_X18_nominal_real_gate.do:L5:step-assert" "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "statement" 5 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X18_nominal_real_gate.do:L6:step-tempname" "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "statement" 6 18 `=_rc' // WFLOG-INJECTED
tempname p
capture noisily __wf_progress end "rows/G0/publication/G0_X18_nominal_real_gate.do:L6:step-tempname" "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "statement" 6 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X18_nominal_real_gate.do:L7:step-postfile" "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "statement" 7 18 `=_rc' // WFLOG-INJECTED
* Siapkan tabel ringkasan; perintah post di bawah menambahkan hitungan atau hasil per kelompok. // WFDOC-INJECTED
postfile `p' int source_year str32 concept long nominal_n long price_eligible_n long real_n double index_value str100 gate_status using "corrections/reports/__real_gates.dta", replace
capture noisily __wf_progress end "rows/G0/publication/G0_X18_nominal_real_gate.do:L7:step-postfile" "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "statement" 7 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X18_nominal_real_gate.do:L8:step-foreach" "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "loop" 8 18 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X18_nominal_real_gate.do:L8:iteration-body" "rows/G0/publication/G0_X18_nominal_real_gate.do:L8:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X18_nominal_real_gate.do:L9:step-count" "rows/G0/publication/G0_X18_nominal_real_gate.do:L8:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(gross_output_nominal)
capture noisily __wf_progress end "rows/G0/publication/G0_X18_nominal_real_gate.do:L9:step-count" "rows/G0/publication/G0_X18_nominal_real_gate.do:L8:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X18_nominal_real_gate.do:L10:step-post" "rows/G0/publication/G0_X18_nominal_real_gate.do:L8:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
* Catat nilai nominal, jumlah yang layak harga, nilai riil, indeks, dan alasan gerbang per tahun. // WFDOC-INJECTED
    post `p' (`y') ("reported_output_income") (r(N)) (0) (0) (.) ("No accepted price concept/link; no real series constructed; nominal concept remains candidate")
capture noisily __wf_progress end "rows/G0/publication/G0_X18_nominal_real_gate.do:L10:step-post" "rows/G0/publication/G0_X18_nominal_real_gate.do:L8:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X18_nominal_real_gate.do:L8:iteration-body" "rows/G0/publication/G0_X18_nominal_real_gate.do:L8:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X18_nominal_real_gate.do:L8:step-foreach" "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "loop" 8 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X18_nominal_real_gate.do:L12:step-foreach" "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "loop" 9 18 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X18_nominal_real_gate.do:L12:iteration-body" "rows/G0/publication/G0_X18_nominal_real_gate.do:L12:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X18_nominal_real_gate.do:L13:step-count" "rows/G0/publication/G0_X18_nominal_real_gate.do:L12:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(value_added_nominal)
capture noisily __wf_progress end "rows/G0/publication/G0_X18_nominal_real_gate.do:L13:step-count" "rows/G0/publication/G0_X18_nominal_real_gate.do:L12:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X18_nominal_real_gate.do:L14:step-post" "rows/G0/publication/G0_X18_nominal_real_gate.do:L12:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
* Catat nilai nominal, jumlah yang layak harga, nilai riil, indeks, dan alasan gerbang per tahun. // WFDOC-INJECTED
    post `p' (`y') ("reported_value_added") (r(N)) (0) (0) (.) ("No accepted price concept/link; no real series constructed; nominal concept remains candidate")
capture noisily __wf_progress end "rows/G0/publication/G0_X18_nominal_real_gate.do:L14:step-post" "rows/G0/publication/G0_X18_nominal_real_gate.do:L12:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X18_nominal_real_gate.do:L12:iteration-body" "rows/G0/publication/G0_X18_nominal_real_gate.do:L12:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X18_nominal_real_gate.do:L12:step-foreach" "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "loop" 9 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X18_nominal_real_gate.do:L16:step-foreach" "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "loop" 10 18 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X18_nominal_real_gate.do:L16:iteration-body" "rows/G0/publication/G0_X18_nominal_real_gate.do:L16:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X18_nominal_real_gate.do:L17:step-count" "rows/G0/publication/G0_X18_nominal_real_gate.do:L16:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(capital_stock_nominal)
capture noisily __wf_progress end "rows/G0/publication/G0_X18_nominal_real_gate.do:L17:step-count" "rows/G0/publication/G0_X18_nominal_real_gate.do:L16:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X18_nominal_real_gate.do:L18:step-post" "rows/G0/publication/G0_X18_nominal_real_gate.do:L16:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
* Catat nilai nominal, jumlah yang layak harga, nilai riil, indeks, dan alasan gerbang per tahun. // WFDOC-INJECTED
    post `p' (`y') ("capital_stock_candidate") (r(N)) (0) (0) (.) ("No accepted price concept/link; no real series constructed; nominal concept remains candidate")
capture noisily __wf_progress end "rows/G0/publication/G0_X18_nominal_real_gate.do:L18:step-post" "rows/G0/publication/G0_X18_nominal_real_gate.do:L16:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X18_nominal_real_gate.do:L16:iteration-body" "rows/G0/publication/G0_X18_nominal_real_gate.do:L16:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X18_nominal_real_gate.do:L16:step-foreach" "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "loop" 10 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X18_nominal_real_gate.do:L20:step-foreach" "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "loop" 11 18 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X18_nominal_real_gate.do:L20:iteration-body" "rows/G0/publication/G0_X18_nominal_real_gate.do:L20:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X18_nominal_real_gate.do:L21:step-count" "rows/G0/publication/G0_X18_nominal_real_gate.do:L20:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & !missing(capital_additions_nominal)
capture noisily __wf_progress end "rows/G0/publication/G0_X18_nominal_real_gate.do:L21:step-count" "rows/G0/publication/G0_X18_nominal_real_gate.do:L20:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X18_nominal_real_gate.do:L22:step-post" "rows/G0/publication/G0_X18_nominal_real_gate.do:L20:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
* Catat nilai nominal, jumlah yang layak harga, nilai riil, indeks, dan alasan gerbang per tahun. // WFDOC-INJECTED
    post `p' (`y') ("capital_additions_candidate") (r(N)) (0) (0) (.) ("No accepted price concept/link; no real series constructed; nominal concept remains candidate")
capture noisily __wf_progress end "rows/G0/publication/G0_X18_nominal_real_gate.do:L22:step-post" "rows/G0/publication/G0_X18_nominal_real_gate.do:L20:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X18_nominal_real_gate.do:L20:iteration-body" "rows/G0/publication/G0_X18_nominal_real_gate.do:L20:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X18_nominal_real_gate.do:L20:step-foreach" "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "loop" 11 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X18_nominal_real_gate.do:L24:step-postclose" "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "statement" 12 18 `=_rc' // WFLOG-INJECTED
postclose `p'
capture noisily __wf_progress end "rows/G0/publication/G0_X18_nominal_real_gate.do:L24:step-postclose" "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "statement" 12 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X18_nominal_real_gate.do:L25:step-use" "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "statement" 13 18 `=_rc' // WFLOG-INJECTED
use "corrections/reports/__real_gates.dta", clear
capture noisily __wf_progress end "rows/G0/publication/G0_X18_nominal_real_gate.do:L25:step-use" "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "statement" 13 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X18_nominal_real_gate.do:L26:step-isid" "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "statement" 14 18 `=_rc' // WFLOG-INJECTED
isid source_year concept
capture noisily __wf_progress end "rows/G0/publication/G0_X18_nominal_real_gate.do:L26:step-isid" "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "statement" 14 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X18_nominal_real_gate.do:L27:step-generate" "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "statement" 15 18 `=_rc' // WFLOG-INJECTED
generate str70 approximation="No real approximation constructed; candidate nominal amounts only"
capture noisily __wf_progress end "rows/G0/publication/G0_X18_nominal_real_gate.do:L27:step-generate" "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "statement" 15 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X18_nominal_real_gate.do:L28:step-save" "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "statement" 16 18 `=_rc' // WFLOG-INJECTED
save "corrections/reports/nominal_real_gate.dta", replace
capture noisily __wf_progress end "rows/G0/publication/G0_X18_nominal_real_gate.do:L28:step-save" "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "statement" 16 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X18_nominal_real_gate.do:L29:step-display" "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "statement" 17 18 `=_rc' // WFLOG-INJECTED
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X18"
capture noisily __wf_progress end "rows/G0/publication/G0_X18_nominal_real_gate.do:L29:step-display" "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "statement" 17 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X18_nominal_real_gate.do:L30:step-log" "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "statement" 18 18 `=_rc' // WFLOG-INJECTED
capture log close G0CHILD
capture noisily __wf_progress end "rows/G0/publication/G0_X18_nominal_real_gate.do:L30:step-log" "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "statement" 18 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X18_nominal_real_gate.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
