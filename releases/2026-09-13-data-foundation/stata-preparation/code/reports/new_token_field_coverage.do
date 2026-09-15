* Tujuan: Hitung ringkasan yang didefinisikan di file ini dan tulis tabel keluaran pada nama/path yang tercantum di perintah ekspor. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: report/tables/new_token_field_coverage.dta; report/tables/new_token_field_coverage.csv // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "code/reports/new_token_field_coverage.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/new_token_field_coverage.do:L1:step-do" "code/reports/new_token_field_coverage.do:L1:file" "statement" 1 10 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
capture noisily __wf_progress end "code/reports/new_token_field_coverage.do:L1:step-do" "code/reports/new_token_field_coverage.do:L1:file" "statement" 1 10 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/new_token_field_coverage.do:L2:step-use" "code/reports/new_token_field_coverage.do:L1:file" "statement" 2 10 `=_rc' // WFLOG-INJECTED
use source_year source_row rd17_own_token_class rd17_external_token_class using "data/analysis/G0_analysis_ready.dta", clear
capture noisily __wf_progress end "code/reports/new_token_field_coverage.do:L2:step-use" "code/reports/new_token_field_coverage.do:L1:file" "statement" 2 10 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/new_token_field_coverage.do:L3:step-tempname" "code/reports/new_token_field_coverage.do:L1:file" "statement" 3 10 `=_rc' // WFLOG-INJECTED
tempname q
capture noisily __wf_progress end "code/reports/new_token_field_coverage.do:L3:step-tempname" "code/reports/new_token_field_coverage.do:L1:file" "statement" 3 10 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/new_token_field_coverage.do:L4:step-postfile" "code/reports/new_token_field_coverage.do:L1:file" "statement" 4 10 `=_rc' // WFLOG-INJECTED
* Siapkan tabel ringkasan; perintah post di bawah menambahkan hitungan atau hasil per kelompok. // WFDOC-INJECTED
postfile `q' str32 variable int source_year long rows observed missing_rows using "report/tables/new_token_field_coverage.dta", replace
capture noisily __wf_progress end "code/reports/new_token_field_coverage.do:L4:step-postfile" "code/reports/new_token_field_coverage.do:L1:file" "statement" 4 10 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/new_token_field_coverage.do:L5:step-foreach" "code/reports/new_token_field_coverage.do:L1:file" "loop" 5 10 `=_rc' "in" `"rd17_own_token_class rd17_external_token_class"' // WFLOG-INJECTED
* Ulangi blok untuk v: rd17_own_token_class, rd17_external_token_class. // WFDOC-INJECTED
foreach v in rd17_own_token_class rd17_external_token_class {
capture noisily __wf_progress start "code/reports/new_token_field_coverage.do:L5:iteration-body" "code/reports/new_token_field_coverage.do:L5:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/new_token_field_coverage.do:L6:step-foreach" "code/reports/new_token_field_coverage.do:L5:iteration-body" "loop" 1 1 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
 foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "code/reports/new_token_field_coverage.do:L6:iteration-body" "code/reports/new_token_field_coverage.do:L6:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/new_token_field_coverage.do:L7:step-count" "code/reports/new_token_field_coverage.do:L6:iteration-body" "statement" 1 4 `=_rc' // WFLOG-INJECTED
  quietly count if source_year==`y'
capture noisily __wf_progress end "code/reports/new_token_field_coverage.do:L7:step-count" "code/reports/new_token_field_coverage.do:L6:iteration-body" "statement" 1 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/new_token_field_coverage.do:L8:step-local" "code/reports/new_token_field_coverage.do:L6:iteration-body" "statement" 2 4 `=_rc' // WFLOG-INJECTED
  local n=r(N)
capture noisily __wf_progress end "code/reports/new_token_field_coverage.do:L8:step-local" "code/reports/new_token_field_coverage.do:L6:iteration-body" "statement" 2 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/new_token_field_coverage.do:L9:step-count" "code/reports/new_token_field_coverage.do:L6:iteration-body" "statement" 3 4 `=_rc' // WFLOG-INJECTED
  quietly count if source_year==`y' & !missing(`v')
capture noisily __wf_progress end "code/reports/new_token_field_coverage.do:L9:step-count" "code/reports/new_token_field_coverage.do:L6:iteration-body" "statement" 3 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/new_token_field_coverage.do:L10:step-post" "code/reports/new_token_field_coverage.do:L6:iteration-body" "statement" 4 4 `=_rc' // WFLOG-INJECTED
  post `q' ("`v'") (`y') (`n') (r(N)) (`n'-r(N))
capture noisily __wf_progress end "code/reports/new_token_field_coverage.do:L10:step-post" "code/reports/new_token_field_coverage.do:L6:iteration-body" "statement" 4 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/reports/new_token_field_coverage.do:L6:iteration-body" "code/reports/new_token_field_coverage.do:L6:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress end "code/reports/new_token_field_coverage.do:L6:step-foreach" "code/reports/new_token_field_coverage.do:L5:iteration-body" "loop" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/reports/new_token_field_coverage.do:L5:iteration-body" "code/reports/new_token_field_coverage.do:L5:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "code/reports/new_token_field_coverage.do:L5:step-foreach" "code/reports/new_token_field_coverage.do:L1:file" "loop" 5 10 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/new_token_field_coverage.do:L13:step-postclose" "code/reports/new_token_field_coverage.do:L1:file" "statement" 6 10 `=_rc' // WFLOG-INJECTED
postclose `q'
capture noisily __wf_progress end "code/reports/new_token_field_coverage.do:L13:step-postclose" "code/reports/new_token_field_coverage.do:L1:file" "statement" 6 10 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/new_token_field_coverage.do:L14:step-use" "code/reports/new_token_field_coverage.do:L1:file" "statement" 7 10 `=_rc' // WFLOG-INJECTED
use "report/tables/new_token_field_coverage.dta", clear
capture noisily __wf_progress end "code/reports/new_token_field_coverage.do:L14:step-use" "code/reports/new_token_field_coverage.do:L1:file" "statement" 7 10 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/new_token_field_coverage.do:L15:step-isid" "code/reports/new_token_field_coverage.do:L1:file" "statement" 8 10 `=_rc' // WFLOG-INJECTED
isid variable source_year
capture noisily __wf_progress end "code/reports/new_token_field_coverage.do:L15:step-isid" "code/reports/new_token_field_coverage.do:L1:file" "statement" 8 10 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/new_token_field_coverage.do:L16:step-assert" "code/reports/new_token_field_coverage.do:L1:file" "statement" 9 10 `=_rc' // WFLOG-INJECTED
assert _N==24
capture noisily __wf_progress end "code/reports/new_token_field_coverage.do:L16:step-assert" "code/reports/new_token_field_coverage.do:L1:file" "statement" 9 10 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/new_token_field_coverage.do:L17:step-export" "code/reports/new_token_field_coverage.do:L1:file" "statement" 10 10 `=_rc' // WFLOG-INJECTED
* Tulis tabel yang sedang terbuka ke CSV pada nama file di perintah ini. // WFDOC-INJECTED
export delimited using "report/tables/new_token_field_coverage.csv", datafmt quote replace
capture noisily __wf_progress end "code/reports/new_token_field_coverage.do:L17:step-export" "code/reports/new_token_field_coverage.do:L1:file" "statement" 10 10 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/reports/new_token_field_coverage.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
