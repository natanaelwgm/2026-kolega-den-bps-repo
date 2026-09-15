* Tujuan: Hitung ya, tidak, dan unknown per tahun; bagian positif memakai penyebut ya+tidak, sedangkan bagian unknown memakai semua baris. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: corrections/reports/flag_rates.dta; corrections/data/C170.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L1:step-version" "rows/G0/corrections/C170_flag_rates.do:L1:file" "statement" 1 17 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L1:step-version" "rows/G0/corrections/C170_flag_rates.do:L1:file" "statement" 1 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L2:step-do" "rows/G0/corrections/C170_flag_rates.do:L1:file" "statement" 2 17 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L2:step-do" "rows/G0/corrections/C170_flag_rates.do:L1:file" "statement" 2 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L3:step-g0c_begin" "rows/G0/corrections/C170_flag_rates.do:L1:file" "statement" 3 17 `=_rc' // WFLOG-INJECTED
g0c_begin "C170_flag_rates"
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L3:step-g0c_begin" "rows/G0/corrections/C170_flag_rates.do:L1:file" "statement" 3 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L4:step-use" "rows/G0/corrections/C170_flag_rates.do:L1:file" "statement" 4 17 `=_rc' // WFLOG-INJECTED
* Hitung jumlah ya, tidak, dan tidak diketahui; persentase memakai penyebut jawaban ya+tidak, bukan seluruh baris. // WFDOC-INJECTED
use  using "data/analysis/G0_analysis_ready.dta", clear
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L4:step-use" "rows/G0/corrections/C170_flag_rates.do:L1:file" "statement" 4 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L5:step-tempname" "rows/G0/corrections/C170_flag_rates.do:L1:file" "statement" 5 17 `=_rc' // WFLOG-INJECTED
tempname p
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L5:step-tempname" "rows/G0/corrections/C170_flag_rates.do:L1:file" "statement" 5 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L6:step-postfile" "rows/G0/corrections/C170_flag_rates.do:L1:file" "statement" 6 17 `=_rc' // WFLOG-INJECTED
postfile `p' int source_year str32 variable long n_positive long n_zero long n_unknown long n_observed double share_positive_observed double share_unknown_all using "corrections/reports/flag_rates.dta", replace
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L6:step-postfile" "rows/G0/corrections/C170_flag_rates.do:L1:file" "statement" 6 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L7:step-foreach" "rows/G0/corrections/C170_flag_rates.do:L1:file" "loop" 7 17 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L7:iteration-body" "rows/G0/corrections/C170_flag_rates.do:L7:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L8:step-count" "rows/G0/corrections/C170_flag_rates.do:L7:iteration-body" "statement" 1 11 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y'
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L8:step-count" "rows/G0/corrections/C170_flag_rates.do:L7:iteration-body" "statement" 1 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L9:step-local" "rows/G0/corrections/C170_flag_rates.do:L7:iteration-body" "statement" 2 11 `=_rc' // WFLOG-INJECTED
    local total=r(N)
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L9:step-local" "rows/G0/corrections/C170_flag_rates.do:L7:iteration-body" "statement" 2 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L10:step-count" "rows/G0/corrections/C170_flag_rates.do:L7:iteration-body" "statement" 3 11 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & own_gen_positive_reported==1
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L10:step-count" "rows/G0/corrections/C170_flag_rates.do:L7:iteration-body" "statement" 3 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L11:step-local" "rows/G0/corrections/C170_flag_rates.do:L7:iteration-body" "statement" 4 11 `=_rc' // WFLOG-INJECTED
    local yes=r(N)
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L11:step-local" "rows/G0/corrections/C170_flag_rates.do:L7:iteration-body" "statement" 4 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L12:step-count" "rows/G0/corrections/C170_flag_rates.do:L7:iteration-body" "statement" 5 11 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & own_gen_positive_reported==0
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L12:step-count" "rows/G0/corrections/C170_flag_rates.do:L7:iteration-body" "statement" 5 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L13:step-local" "rows/G0/corrections/C170_flag_rates.do:L7:iteration-body" "statement" 6 11 `=_rc' // WFLOG-INJECTED
    local no=r(N)
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L13:step-local" "rows/G0/corrections/C170_flag_rates.do:L7:iteration-body" "statement" 6 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L14:step-count" "rows/G0/corrections/C170_flag_rates.do:L7:iteration-body" "statement" 7 11 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & missing(own_gen_positive_reported)
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L14:step-count" "rows/G0/corrections/C170_flag_rates.do:L7:iteration-body" "statement" 7 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L15:step-local" "rows/G0/corrections/C170_flag_rates.do:L7:iteration-body" "statement" 8 11 `=_rc' // WFLOG-INJECTED
    local unknown=r(N)
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L15:step-local" "rows/G0/corrections/C170_flag_rates.do:L7:iteration-body" "statement" 8 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L16:step-assert" "rows/G0/corrections/C170_flag_rates.do:L7:iteration-body" "statement" 9 11 `=_rc' // WFLOG-INJECTED
    assert `yes'+`no'+`unknown'==`total'
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L16:step-assert" "rows/G0/corrections/C170_flag_rates.do:L7:iteration-body" "statement" 9 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L17:step-local" "rows/G0/corrections/C170_flag_rates.do:L7:iteration-body" "statement" 10 11 `=_rc' // WFLOG-INJECTED
* Penyebut share teramati hanya menjumlahkan jawaban ya+tidak; unknown dikeluarkan dari share itu. // WFDOC-INJECTED
    local n=`yes'+`no'
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L17:step-local" "rows/G0/corrections/C170_flag_rates.do:L7:iteration-body" "statement" 10 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L18:step-post" "rows/G0/corrections/C170_flag_rates.do:L7:iteration-body" "statement" 11 11 `=_rc' // WFLOG-INJECTED
* Simpan share ya di antara jawaban teramati dan share unknown di antara semua baris tahun ini. // WFDOC-INJECTED
    post `p' (`y') ("own_gen_positive_reported") (`yes') (`no') (`unknown') (`n') (cond(`n'>0,`yes'/`n',.)) (`unknown'/`total')
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L18:step-post" "rows/G0/corrections/C170_flag_rates.do:L7:iteration-body" "statement" 11 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L7:iteration-body" "rows/G0/corrections/C170_flag_rates.do:L7:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L7:step-foreach" "rows/G0/corrections/C170_flag_rates.do:L1:file" "loop" 7 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L20:step-foreach" "rows/G0/corrections/C170_flag_rates.do:L1:file" "loop" 8 17 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L20:iteration-body" "rows/G0/corrections/C170_flag_rates.do:L20:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L21:step-count" "rows/G0/corrections/C170_flag_rates.do:L20:iteration-body" "statement" 1 11 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y'
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L21:step-count" "rows/G0/corrections/C170_flag_rates.do:L20:iteration-body" "statement" 1 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L22:step-local" "rows/G0/corrections/C170_flag_rates.do:L20:iteration-body" "statement" 2 11 `=_rc' // WFLOG-INJECTED
    local total=r(N)
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L22:step-local" "rows/G0/corrections/C170_flag_rates.do:L20:iteration-body" "statement" 2 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L23:step-count" "rows/G0/corrections/C170_flag_rates.do:L20:iteration-body" "statement" 3 11 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & any_negative_observed==1
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L23:step-count" "rows/G0/corrections/C170_flag_rates.do:L20:iteration-body" "statement" 3 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L24:step-local" "rows/G0/corrections/C170_flag_rates.do:L20:iteration-body" "statement" 4 11 `=_rc' // WFLOG-INJECTED
    local yes=r(N)
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L24:step-local" "rows/G0/corrections/C170_flag_rates.do:L20:iteration-body" "statement" 4 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L25:step-count" "rows/G0/corrections/C170_flag_rates.do:L20:iteration-body" "statement" 5 11 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & any_negative_observed==0
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L25:step-count" "rows/G0/corrections/C170_flag_rates.do:L20:iteration-body" "statement" 5 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L26:step-local" "rows/G0/corrections/C170_flag_rates.do:L20:iteration-body" "statement" 6 11 `=_rc' // WFLOG-INJECTED
    local no=r(N)
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L26:step-local" "rows/G0/corrections/C170_flag_rates.do:L20:iteration-body" "statement" 6 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L27:step-count" "rows/G0/corrections/C170_flag_rates.do:L20:iteration-body" "statement" 7 11 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & missing(any_negative_observed)
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L27:step-count" "rows/G0/corrections/C170_flag_rates.do:L20:iteration-body" "statement" 7 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L28:step-local" "rows/G0/corrections/C170_flag_rates.do:L20:iteration-body" "statement" 8 11 `=_rc' // WFLOG-INJECTED
    local unknown=r(N)
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L28:step-local" "rows/G0/corrections/C170_flag_rates.do:L20:iteration-body" "statement" 8 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L29:step-assert" "rows/G0/corrections/C170_flag_rates.do:L20:iteration-body" "statement" 9 11 `=_rc' // WFLOG-INJECTED
    assert `yes'+`no'+`unknown'==`total'
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L29:step-assert" "rows/G0/corrections/C170_flag_rates.do:L20:iteration-body" "statement" 9 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L30:step-local" "rows/G0/corrections/C170_flag_rates.do:L20:iteration-body" "statement" 10 11 `=_rc' // WFLOG-INJECTED
* Penyebut share teramati hanya menjumlahkan jawaban ya+tidak; unknown dikeluarkan dari share itu. // WFDOC-INJECTED
    local n=`yes'+`no'
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L30:step-local" "rows/G0/corrections/C170_flag_rates.do:L20:iteration-body" "statement" 10 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L31:step-post" "rows/G0/corrections/C170_flag_rates.do:L20:iteration-body" "statement" 11 11 `=_rc' // WFLOG-INJECTED
* Simpan share ya di antara jawaban teramati dan share unknown di antara semua baris tahun ini. // WFDOC-INJECTED
    post `p' (`y') ("any_negative_observed") (`yes') (`no') (`unknown') (`n') (cond(`n'>0,`yes'/`n',.)) (`unknown'/`total')
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L31:step-post" "rows/G0/corrections/C170_flag_rates.do:L20:iteration-body" "statement" 11 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L20:iteration-body" "rows/G0/corrections/C170_flag_rates.do:L20:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L20:step-foreach" "rows/G0/corrections/C170_flag_rates.do:L1:file" "loop" 8 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L33:step-foreach" "rows/G0/corrections/C170_flag_rates.do:L1:file" "loop" 9 17 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L33:iteration-body" "rows/G0/corrections/C170_flag_rates.do:L33:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L34:step-count" "rows/G0/corrections/C170_flag_rates.do:L33:iteration-body" "statement" 1 11 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y'
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L34:step-count" "rows/G0/corrections/C170_flag_rates.do:L33:iteration-body" "statement" 1 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L35:step-local" "rows/G0/corrections/C170_flag_rates.do:L33:iteration-body" "statement" 2 11 `=_rc' // WFLOG-INJECTED
    local total=r(N)
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L35:step-local" "rows/G0/corrections/C170_flag_rates.do:L33:iteration-body" "statement" 2 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L36:step-count" "rows/G0/corrections/C170_flag_rates.do:L33:iteration-body" "statement" 3 11 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & any_negative_decision==1
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L36:step-count" "rows/G0/corrections/C170_flag_rates.do:L33:iteration-body" "statement" 3 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L37:step-local" "rows/G0/corrections/C170_flag_rates.do:L33:iteration-body" "statement" 4 11 `=_rc' // WFLOG-INJECTED
    local yes=r(N)
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L37:step-local" "rows/G0/corrections/C170_flag_rates.do:L33:iteration-body" "statement" 4 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L38:step-count" "rows/G0/corrections/C170_flag_rates.do:L33:iteration-body" "statement" 5 11 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & any_negative_decision==0
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L38:step-count" "rows/G0/corrections/C170_flag_rates.do:L33:iteration-body" "statement" 5 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L39:step-local" "rows/G0/corrections/C170_flag_rates.do:L33:iteration-body" "statement" 6 11 `=_rc' // WFLOG-INJECTED
    local no=r(N)
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L39:step-local" "rows/G0/corrections/C170_flag_rates.do:L33:iteration-body" "statement" 6 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L40:step-count" "rows/G0/corrections/C170_flag_rates.do:L33:iteration-body" "statement" 7 11 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & missing(any_negative_decision)
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L40:step-count" "rows/G0/corrections/C170_flag_rates.do:L33:iteration-body" "statement" 7 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L41:step-local" "rows/G0/corrections/C170_flag_rates.do:L33:iteration-body" "statement" 8 11 `=_rc' // WFLOG-INJECTED
    local unknown=r(N)
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L41:step-local" "rows/G0/corrections/C170_flag_rates.do:L33:iteration-body" "statement" 8 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L42:step-assert" "rows/G0/corrections/C170_flag_rates.do:L33:iteration-body" "statement" 9 11 `=_rc' // WFLOG-INJECTED
    assert `yes'+`no'+`unknown'==`total'
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L42:step-assert" "rows/G0/corrections/C170_flag_rates.do:L33:iteration-body" "statement" 9 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L43:step-local" "rows/G0/corrections/C170_flag_rates.do:L33:iteration-body" "statement" 10 11 `=_rc' // WFLOG-INJECTED
* Penyebut share teramati hanya menjumlahkan jawaban ya+tidak; unknown dikeluarkan dari share itu. // WFDOC-INJECTED
    local n=`yes'+`no'
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L43:step-local" "rows/G0/corrections/C170_flag_rates.do:L33:iteration-body" "statement" 10 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L44:step-post" "rows/G0/corrections/C170_flag_rates.do:L33:iteration-body" "statement" 11 11 `=_rc' // WFLOG-INJECTED
* Simpan share ya di antara jawaban teramati dan share unknown di antara semua baris tahun ini. // WFDOC-INJECTED
    post `p' (`y') ("any_negative_decision") (`yes') (`no') (`unknown') (`n') (cond(`n'>0,`yes'/`n',.)) (`unknown'/`total')
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L44:step-post" "rows/G0/corrections/C170_flag_rates.do:L33:iteration-body" "statement" 11 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L33:iteration-body" "rows/G0/corrections/C170_flag_rates.do:L33:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L33:step-foreach" "rows/G0/corrections/C170_flag_rates.do:L1:file" "loop" 9 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L46:step-foreach" "rows/G0/corrections/C170_flag_rates.do:L1:file" "loop" 10 17 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L46:iteration-body" "rows/G0/corrections/C170_flag_rates.do:L46:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L47:step-count" "rows/G0/corrections/C170_flag_rates.do:L46:iteration-body" "statement" 1 11 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y'
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L47:step-count" "rows/G0/corrections/C170_flag_rates.do:L46:iteration-body" "statement" 1 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L48:step-local" "rows/G0/corrections/C170_flag_rates.do:L46:iteration-body" "statement" 2 11 `=_rc' // WFLOG-INJECTED
    local total=r(N)
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L48:step-local" "rows/G0/corrections/C170_flag_rates.do:L46:iteration-body" "statement" 2 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L49:step-count" "rows/G0/corrections/C170_flag_rates.do:L46:iteration-body" "statement" 3 11 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & all_applicable_tests_observed==1
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L49:step-count" "rows/G0/corrections/C170_flag_rates.do:L46:iteration-body" "statement" 3 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L50:step-local" "rows/G0/corrections/C170_flag_rates.do:L46:iteration-body" "statement" 4 11 `=_rc' // WFLOG-INJECTED
    local yes=r(N)
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L50:step-local" "rows/G0/corrections/C170_flag_rates.do:L46:iteration-body" "statement" 4 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L51:step-count" "rows/G0/corrections/C170_flag_rates.do:L46:iteration-body" "statement" 5 11 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & all_applicable_tests_observed==0
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L51:step-count" "rows/G0/corrections/C170_flag_rates.do:L46:iteration-body" "statement" 5 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L52:step-local" "rows/G0/corrections/C170_flag_rates.do:L46:iteration-body" "statement" 6 11 `=_rc' // WFLOG-INJECTED
    local no=r(N)
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L52:step-local" "rows/G0/corrections/C170_flag_rates.do:L46:iteration-body" "statement" 6 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L53:step-count" "rows/G0/corrections/C170_flag_rates.do:L46:iteration-body" "statement" 7 11 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & missing(all_applicable_tests_observed)
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L53:step-count" "rows/G0/corrections/C170_flag_rates.do:L46:iteration-body" "statement" 7 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L54:step-local" "rows/G0/corrections/C170_flag_rates.do:L46:iteration-body" "statement" 8 11 `=_rc' // WFLOG-INJECTED
    local unknown=r(N)
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L54:step-local" "rows/G0/corrections/C170_flag_rates.do:L46:iteration-body" "statement" 8 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L55:step-assert" "rows/G0/corrections/C170_flag_rates.do:L46:iteration-body" "statement" 9 11 `=_rc' // WFLOG-INJECTED
    assert `yes'+`no'+`unknown'==`total'
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L55:step-assert" "rows/G0/corrections/C170_flag_rates.do:L46:iteration-body" "statement" 9 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L56:step-local" "rows/G0/corrections/C170_flag_rates.do:L46:iteration-body" "statement" 10 11 `=_rc' // WFLOG-INJECTED
* Penyebut share teramati hanya menjumlahkan jawaban ya+tidak; unknown dikeluarkan dari share itu. // WFDOC-INJECTED
    local n=`yes'+`no'
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L56:step-local" "rows/G0/corrections/C170_flag_rates.do:L46:iteration-body" "statement" 10 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L57:step-post" "rows/G0/corrections/C170_flag_rates.do:L46:iteration-body" "statement" 11 11 `=_rc' // WFLOG-INJECTED
* Simpan share ya di antara jawaban teramati dan share unknown di antara semua baris tahun ini. // WFDOC-INJECTED
    post `p' (`y') ("all_applicable_tests_observed") (`yes') (`no') (`unknown') (`n') (cond(`n'>0,`yes'/`n',.)) (`unknown'/`total')
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L57:step-post" "rows/G0/corrections/C170_flag_rates.do:L46:iteration-body" "statement" 11 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L46:iteration-body" "rows/G0/corrections/C170_flag_rates.do:L46:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L46:step-foreach" "rows/G0/corrections/C170_flag_rates.do:L1:file" "loop" 10 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L59:step-foreach" "rows/G0/corrections/C170_flag_rates.do:L1:file" "loop" 11 17 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L59:iteration-body" "rows/G0/corrections/C170_flag_rates.do:L59:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L60:step-count" "rows/G0/corrections/C170_flag_rates.do:L59:iteration-body" "statement" 1 11 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y'
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L60:step-count" "rows/G0/corrections/C170_flag_rates.do:L59:iteration-body" "statement" 1 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L61:step-local" "rows/G0/corrections/C170_flag_rates.do:L59:iteration-body" "statement" 2 11 `=_rc' // WFLOG-INJECTED
    local total=r(N)
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L61:step-local" "rows/G0/corrections/C170_flag_rates.do:L59:iteration-body" "statement" 2 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L62:step-count" "rows/G0/corrections/C170_flag_rates.do:L59:iteration-body" "statement" 3 11 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & va_abs_tail_flag==1
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L62:step-count" "rows/G0/corrections/C170_flag_rates.do:L59:iteration-body" "statement" 3 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L63:step-local" "rows/G0/corrections/C170_flag_rates.do:L59:iteration-body" "statement" 4 11 `=_rc' // WFLOG-INJECTED
    local yes=r(N)
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L63:step-local" "rows/G0/corrections/C170_flag_rates.do:L59:iteration-body" "statement" 4 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L64:step-count" "rows/G0/corrections/C170_flag_rates.do:L59:iteration-body" "statement" 5 11 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & va_abs_tail_flag==0
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L64:step-count" "rows/G0/corrections/C170_flag_rates.do:L59:iteration-body" "statement" 5 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L65:step-local" "rows/G0/corrections/C170_flag_rates.do:L59:iteration-body" "statement" 6 11 `=_rc' // WFLOG-INJECTED
    local no=r(N)
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L65:step-local" "rows/G0/corrections/C170_flag_rates.do:L59:iteration-body" "statement" 6 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L66:step-count" "rows/G0/corrections/C170_flag_rates.do:L59:iteration-body" "statement" 7 11 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & missing(va_abs_tail_flag)
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L66:step-count" "rows/G0/corrections/C170_flag_rates.do:L59:iteration-body" "statement" 7 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L67:step-local" "rows/G0/corrections/C170_flag_rates.do:L59:iteration-body" "statement" 8 11 `=_rc' // WFLOG-INJECTED
    local unknown=r(N)
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L67:step-local" "rows/G0/corrections/C170_flag_rates.do:L59:iteration-body" "statement" 8 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L68:step-assert" "rows/G0/corrections/C170_flag_rates.do:L59:iteration-body" "statement" 9 11 `=_rc' // WFLOG-INJECTED
    assert `yes'+`no'+`unknown'==`total'
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L68:step-assert" "rows/G0/corrections/C170_flag_rates.do:L59:iteration-body" "statement" 9 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L69:step-local" "rows/G0/corrections/C170_flag_rates.do:L59:iteration-body" "statement" 10 11 `=_rc' // WFLOG-INJECTED
* Penyebut share teramati hanya menjumlahkan jawaban ya+tidak; unknown dikeluarkan dari share itu. // WFDOC-INJECTED
    local n=`yes'+`no'
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L69:step-local" "rows/G0/corrections/C170_flag_rates.do:L59:iteration-body" "statement" 10 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L70:step-post" "rows/G0/corrections/C170_flag_rates.do:L59:iteration-body" "statement" 11 11 `=_rc' // WFLOG-INJECTED
* Simpan share ya di antara jawaban teramati dan share unknown di antara semua baris tahun ini. // WFDOC-INJECTED
    post `p' (`y') ("va_abs_tail_flag") (`yes') (`no') (`unknown') (`n') (cond(`n'>0,`yes'/`n',.)) (`unknown'/`total')
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L70:step-post" "rows/G0/corrections/C170_flag_rates.do:L59:iteration-body" "statement" 11 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L59:iteration-body" "rows/G0/corrections/C170_flag_rates.do:L59:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L59:step-foreach" "rows/G0/corrections/C170_flag_rates.do:L1:file" "loop" 11 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L72:step-postclose" "rows/G0/corrections/C170_flag_rates.do:L1:file" "statement" 12 17 `=_rc' // WFLOG-INJECTED
postclose `p'
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L72:step-postclose" "rows/G0/corrections/C170_flag_rates.do:L1:file" "statement" 12 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L73:step-use" "rows/G0/corrections/C170_flag_rates.do:L1:file" "statement" 13 17 `=_rc' // WFLOG-INJECTED
use "corrections/reports/flag_rates.dta", clear
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L73:step-use" "rows/G0/corrections/C170_flag_rates.do:L1:file" "statement" 13 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L74:step-isid" "rows/G0/corrections/C170_flag_rates.do:L1:file" "statement" 14 17 `=_rc' // WFLOG-INJECTED
isid source_year variable
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L74:step-isid" "rows/G0/corrections/C170_flag_rates.do:L1:file" "statement" 14 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L75:step-keep" "rows/G0/corrections/C170_flag_rates.do:L1:file" "statement" 15 17 `=_rc' // WFLOG-INJECTED
keep source_year variable n_positive n_zero n_unknown n_observed share_positive_observed share_unknown_all
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L75:step-keep" "rows/G0/corrections/C170_flag_rates.do:L1:file" "statement" 15 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L76:step-order" "rows/G0/corrections/C170_flag_rates.do:L1:file" "statement" 16 17 `=_rc' // WFLOG-INJECTED
order source_year variable
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L76:step-order" "rows/G0/corrections/C170_flag_rates.do:L1:file" "statement" 16 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C170_flag_rates.do:L77:step-g0c_finish" "rows/G0/corrections/C170_flag_rates.do:L1:file" "statement" 17 17 `=_rc' // WFLOG-INJECTED
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C170_flag_rates" "C170"
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L77:step-g0c_finish" "rows/G0/corrections/C170_flag_rates.do:L1:file" "statement" 17 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/C170_flag_rates.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
