* Tujuan: Bandingkan statistik nilai tambah bertanda dengan/ tanpa nilai di atas 10 kali ambang persentil ke-99 per tahun. // WFDOC-INJECTED
* Input: data/analysis/signed_thresholds.dta; data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: corrections/reports/outlier_signed_thresholds.dta; corrections/reports/__outlier.dta; dan 1 masukan lain // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:step-version" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "statement" 1 24 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:step-version" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "statement" 1 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L2:step-do" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "statement" 2 24 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L2:step-do" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "statement" 2 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L3:step-g0c_begin" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "statement" 3 24 `=_rc' // WFLOG-INJECTED
g0c_begin "G0-X11"
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L3:step-g0c_begin" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "statement" 3 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L4:step-use" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "statement" 4 24 `=_rc' // WFLOG-INJECTED
use "data/analysis/signed_thresholds.dta", clear
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L4:step-use" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "statement" 4 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L5:step-save" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "statement" 5 24 `=_rc' // WFLOG-INJECTED
save "corrections/reports/outlier_signed_thresholds.dta", replace
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L5:step-save" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "statement" 5 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L6:step-use" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "statement" 6 24 `=_rc' // WFLOG-INJECTED
use "data/analysis/G0_analysis_ready.dta", clear
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L6:step-use" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "statement" 6 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L7:step-merge" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "statement" 7 24 `=_rc' // WFLOG-INJECTED
* Pasangkan satu ambang p99 nilai absolut untuk tiap tahun ke baris master pada tahun sama. // WFDOC-INJECTED
merge m:1 source_year using "data/analysis/signed_thresholds.dta", assert(match) nogen keepusing(p99_abs_va)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L7:step-merge" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "statement" 7 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L8:step-tempname" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "statement" 8 24 `=_rc' // WFLOG-INJECTED
tempname p
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L8:step-tempname" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "statement" 8 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L9:step-postfile" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "statement" 9 24 `=_rc' // WFLOG-INJECTED
* Siapkan tabel ringkasan; perintah post di bawah menambahkan hitungan atau hasil per kelompok. // WFDOC-INJECTED
postfile `p' int source_year str32 variable str40 variant long n double mean double p1 double p25 double p50 double p75 double p99 double min double max double threshold long flagged_n long missing_flag_n using "corrections/reports/__outlier.dta", replace
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L9:step-postfile" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "statement" 9 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L10:step-foreach" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "loop" 10 24 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L10:iteration-body" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L10:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L11:step-count" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L10:iteration-body" "statement" 1 9 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & out_checked_va==1
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L11:step-count" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L10:iteration-body" "statement" 1 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L12:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L10:iteration-body" "statement" 2 9 `=_rc' // WFLOG-INJECTED
    local flagged=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L12:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L10:iteration-body" "statement" 2 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L13:step-count" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L10:iteration-body" "statement" 3 9 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & missing(out_checked_va)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L13:step-count" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L10:iteration-body" "statement" 3 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L14:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L10:iteration-body" "statement" 4 9 `=_rc' // WFLOG-INJECTED
    local flagmissing=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L14:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L10:iteration-body" "statement" 4 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L15:step-summarize" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L10:iteration-body" "statement" 5 9 `=_rc' // WFLOG-INJECTED
    quietly summarize p99_econ_va if source_year==`y', meanonly
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L15:step-summarize" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L10:iteration-body" "statement" 5 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L16:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L10:iteration-body" "statement" 6 9 `=_rc' // WFLOG-INJECTED
    local cutoff=10*r(mean)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L16:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L10:iteration-body" "statement" 6 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L17:step-summarize" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L10:iteration-body" "statement" 7 9 `=_rc' // WFLOG-INJECTED
    quietly summarize value_added_nominal if source_year==`y', detail
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L17:step-summarize" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L10:iteration-body" "statement" 7 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L18:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L10:iteration-body" "statement" 8 9 `=_rc' // WFLOG-INJECTED
    local n=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L18:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L10:iteration-body" "statement" 8 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L19:step-post" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L10:iteration-body" "statement" 9 9 `=_rc' // WFLOG-INJECTED
* Simpan statistik pada kelompok pembanding yang sedang dihitung bersama ambang dan jumlah baris bertanda. // WFDOC-INJECTED
    post `p' (`y') ("value_added_nominal") ("reported_signed") (`n') (r(mean)) (r(p1)) (r(p25)) (r(p50)) (r(p75)) (r(p99)) (r(min)) (r(max)) (`cutoff') (`flagged') (`flagmissing')
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L19:step-post" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L10:iteration-body" "statement" 9 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L10:iteration-body" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L10:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L10:step-foreach" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "loop" 10 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L21:step-foreach" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "loop" 11 24 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L21:iteration-body" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L21:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L22:step-count" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L21:iteration-body" "statement" 1 9 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & out_checked_va==1
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L22:step-count" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L21:iteration-body" "statement" 1 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L23:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L21:iteration-body" "statement" 2 9 `=_rc' // WFLOG-INJECTED
    local flagged=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L23:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L21:iteration-body" "statement" 2 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L24:step-count" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L21:iteration-body" "statement" 3 9 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & missing(out_checked_va)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L24:step-count" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L21:iteration-body" "statement" 3 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L25:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L21:iteration-body" "statement" 4 9 `=_rc' // WFLOG-INJECTED
    local flagmissing=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L25:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L21:iteration-body" "statement" 4 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L26:step-summarize" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L21:iteration-body" "statement" 5 9 `=_rc' // WFLOG-INJECTED
    quietly summarize p99_econ_va if source_year==`y', meanonly
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L26:step-summarize" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L21:iteration-body" "statement" 5 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L27:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L21:iteration-body" "statement" 6 9 `=_rc' // WFLOG-INJECTED
    local cutoff=10*r(mean)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L27:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L21:iteration-body" "statement" 6 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L28:step-summarize" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L21:iteration-body" "statement" 7 9 `=_rc' // WFLOG-INJECTED
    quietly summarize clean_va_nominal if source_year==`y', detail
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L28:step-summarize" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L21:iteration-body" "statement" 7 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L29:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L21:iteration-body" "statement" 8 9 `=_rc' // WFLOG-INJECTED
    local n=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L29:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L21:iteration-body" "statement" 8 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L30:step-post" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L21:iteration-body" "statement" 9 9 `=_rc' // WFLOG-INJECTED
* Simpan statistik pada kelompok pembanding yang sedang dihitung bersama ambang dan jumlah baris bertanda. // WFDOC-INJECTED
    post `p' (`y') ("clean_va_nominal") ("inherited_negative_exclusion") (`n') (r(mean)) (r(p1)) (r(p25)) (r(p50)) (r(p75)) (r(p99)) (r(min)) (r(max)) (`cutoff') (`flagged') (`flagmissing')
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L30:step-post" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L21:iteration-body" "statement" 9 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L21:iteration-body" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L21:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L21:step-foreach" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "loop" 11 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L32:step-foreach" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "loop" 12 24 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L32:iteration-body" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L32:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L33:step-count" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L32:iteration-body" "statement" 1 9 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & va_abs_tail_flag==1
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L33:step-count" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L32:iteration-body" "statement" 1 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L34:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L32:iteration-body" "statement" 2 9 `=_rc' // WFLOG-INJECTED
    local flagged=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L34:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L32:iteration-body" "statement" 2 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L35:step-count" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L32:iteration-body" "statement" 3 9 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & missing(va_abs_tail_flag)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L35:step-count" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L32:iteration-body" "statement" 3 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L36:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L32:iteration-body" "statement" 4 9 `=_rc' // WFLOG-INJECTED
    local flagmissing=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L36:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L32:iteration-body" "statement" 4 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L37:step-summarize" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L32:iteration-body" "statement" 5 9 `=_rc' // WFLOG-INJECTED
    quietly summarize p99_abs_va if source_year==`y', meanonly
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L37:step-summarize" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L32:iteration-body" "statement" 5 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L38:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L32:iteration-body" "statement" 6 9 `=_rc' // WFLOG-INJECTED
    local cutoff=10*r(mean)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L38:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L32:iteration-body" "statement" 6 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L39:step-summarize" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L32:iteration-body" "statement" 7 9 `=_rc' // WFLOG-INJECTED
    quietly summarize va_signed_nominal if source_year==`y', detail
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L39:step-summarize" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L32:iteration-body" "statement" 7 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L40:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L32:iteration-body" "statement" 8 9 `=_rc' // WFLOG-INJECTED
    local n=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L40:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L32:iteration-body" "statement" 8 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L41:step-post" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L32:iteration-body" "statement" 9 9 `=_rc' // WFLOG-INJECTED
* Simpan statistik pada kelompok pembanding yang sedang dihitung bersama ambang dan jumlah baris bertanda. // WFDOC-INJECTED
    post `p' (`y') ("va_signed_nominal") ("signed_preserved") (`n') (r(mean)) (r(p1)) (r(p25)) (r(p50)) (r(p75)) (r(p99)) (r(min)) (r(max)) (`cutoff') (`flagged') (`flagmissing')
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L41:step-post" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L32:iteration-body" "statement" 9 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L32:iteration-body" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L32:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L32:step-foreach" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "loop" 12 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L43:step-foreach" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "loop" 13 24 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L43:iteration-body" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L43:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L44:step-count" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L43:iteration-body" "statement" 1 9 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & va_abs_tail_flag==1
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L44:step-count" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L43:iteration-body" "statement" 1 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L45:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L43:iteration-body" "statement" 2 9 `=_rc' // WFLOG-INJECTED
    local flagged=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L45:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L43:iteration-body" "statement" 2 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L46:step-count" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L43:iteration-body" "statement" 3 9 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & missing(va_abs_tail_flag)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L46:step-count" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L43:iteration-body" "statement" 3 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L47:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L43:iteration-body" "statement" 4 9 `=_rc' // WFLOG-INJECTED
    local flagmissing=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L47:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L43:iteration-body" "statement" 4 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L48:step-summarize" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L43:iteration-body" "statement" 5 9 `=_rc' // WFLOG-INJECTED
    quietly summarize p99_abs_va if source_year==`y', meanonly
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L48:step-summarize" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L43:iteration-body" "statement" 5 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L49:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L43:iteration-body" "statement" 6 9 `=_rc' // WFLOG-INJECTED
    local cutoff=10*r(mean)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L49:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L43:iteration-body" "statement" 6 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L50:step-summarize" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L43:iteration-body" "statement" 7 9 `=_rc' // WFLOG-INJECTED
    quietly summarize va_signed_tail_sensitivity if source_year==`y', detail
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L50:step-summarize" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L43:iteration-body" "statement" 7 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L51:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L43:iteration-body" "statement" 8 9 `=_rc' // WFLOG-INJECTED
    local n=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L51:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L43:iteration-body" "statement" 8 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L52:step-post" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L43:iteration-body" "statement" 9 9 `=_rc' // WFLOG-INJECTED
* Simpan statistik pada kelompok pembanding yang sedang dihitung bersama ambang dan jumlah baris bertanda. // WFDOC-INJECTED
    post `p' (`y') ("va_signed_tail_sensitivity") ("absolute_tail_sensitivity") (`n') (r(mean)) (r(p1)) (r(p25)) (r(p50)) (r(p75)) (r(p99)) (r(min)) (r(max)) (`cutoff') (`flagged') (`flagmissing')
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L52:step-post" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L43:iteration-body" "statement" 9 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L43:iteration-body" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L43:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L43:step-foreach" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "loop" 13 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L54:step-foreach" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "loop" 14 24 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L54:iteration-body" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L54:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L55:step-count" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L54:iteration-body" "statement" 1 9 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & out_checked_workers==1
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L55:step-count" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L54:iteration-body" "statement" 1 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L56:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L54:iteration-body" "statement" 2 9 `=_rc' // WFLOG-INJECTED
    local flagged=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L56:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L54:iteration-body" "statement" 2 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L57:step-count" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L54:iteration-body" "statement" 3 9 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & missing(out_checked_workers)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L57:step-count" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L54:iteration-body" "statement" 3 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L58:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L54:iteration-body" "statement" 4 9 `=_rc' // WFLOG-INJECTED
    local flagmissing=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L58:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L54:iteration-body" "statement" 4 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L59:step-summarize" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L54:iteration-body" "statement" 5 9 `=_rc' // WFLOG-INJECTED
    quietly summarize p99_econ_workers if source_year==`y', meanonly
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L59:step-summarize" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L54:iteration-body" "statement" 5 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L60:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L54:iteration-body" "statement" 6 9 `=_rc' // WFLOG-INJECTED
    local cutoff=10*r(mean)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L60:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L54:iteration-body" "statement" 6 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L61:step-summarize" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L54:iteration-body" "statement" 7 9 `=_rc' // WFLOG-INJECTED
    quietly summarize workers if source_year==`y', detail
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L61:step-summarize" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L54:iteration-body" "statement" 7 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L62:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L54:iteration-body" "statement" 8 9 `=_rc' // WFLOG-INJECTED
    local n=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L62:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L54:iteration-body" "statement" 8 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L63:step-post" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L54:iteration-body" "statement" 9 9 `=_rc' // WFLOG-INJECTED
* Simpan statistik pada kelompok pembanding yang sedang dihitung bersama ambang dan jumlah baris bertanda. // WFDOC-INJECTED
    post `p' (`y') ("workers") ("reported_worker_candidate") (`n') (r(mean)) (r(p1)) (r(p25)) (r(p50)) (r(p75)) (r(p99)) (r(min)) (r(max)) (`cutoff') (`flagged') (`flagmissing')
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L63:step-post" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L54:iteration-body" "statement" 9 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L54:iteration-body" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L54:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L54:step-foreach" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "loop" 14 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L65:step-foreach" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "loop" 15 24 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L65:iteration-body" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L65:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L66:step-count" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L65:iteration-body" "statement" 1 9 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & out_checked_workers==1
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L66:step-count" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L65:iteration-body" "statement" 1 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L67:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L65:iteration-body" "statement" 2 9 `=_rc' // WFLOG-INJECTED
    local flagged=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L67:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L65:iteration-body" "statement" 2 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L68:step-count" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L65:iteration-body" "statement" 3 9 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & missing(out_checked_workers)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L68:step-count" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L65:iteration-body" "statement" 3 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L69:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L65:iteration-body" "statement" 4 9 `=_rc' // WFLOG-INJECTED
    local flagmissing=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L69:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L65:iteration-body" "statement" 4 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L70:step-summarize" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L65:iteration-body" "statement" 5 9 `=_rc' // WFLOG-INJECTED
    quietly summarize p99_econ_workers if source_year==`y', meanonly
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L70:step-summarize" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L65:iteration-body" "statement" 5 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L71:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L65:iteration-body" "statement" 6 9 `=_rc' // WFLOG-INJECTED
    local cutoff=10*r(mean)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L71:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L65:iteration-body" "statement" 6 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L72:step-summarize" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L65:iteration-body" "statement" 7 9 `=_rc' // WFLOG-INJECTED
    quietly summarize clean_workers_count if source_year==`y', detail
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L72:step-summarize" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L65:iteration-body" "statement" 7 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L73:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L65:iteration-body" "statement" 8 9 `=_rc' // WFLOG-INJECTED
    local n=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L73:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L65:iteration-body" "statement" 8 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L74:step-post" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L65:iteration-body" "statement" 9 9 `=_rc' // WFLOG-INJECTED
* Simpan statistik pada kelompok pembanding yang sedang dihitung bersama ambang dan jumlah baris bertanda. // WFDOC-INJECTED
    post `p' (`y') ("clean_workers_count") ("inherited_worker_sensitivity") (`n') (r(mean)) (r(p1)) (r(p25)) (r(p50)) (r(p75)) (r(p99)) (r(min)) (r(max)) (`cutoff') (`flagged') (`flagmissing')
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L74:step-post" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L65:iteration-body" "statement" 9 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L65:iteration-body" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L65:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L65:step-foreach" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "loop" 15 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L76:step-foreach" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "loop" 16 24 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L76:iteration-body" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L76:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L77:step-count" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L76:iteration-body" "statement" 1 9 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & out_checked_stock==1
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L77:step-count" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L76:iteration-body" "statement" 1 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L78:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L76:iteration-body" "statement" 2 9 `=_rc' // WFLOG-INJECTED
    local flagged=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L78:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L76:iteration-body" "statement" 2 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L79:step-count" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L76:iteration-body" "statement" 3 9 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & missing(out_checked_stock)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L79:step-count" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L76:iteration-body" "statement" 3 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L80:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L76:iteration-body" "statement" 4 9 `=_rc' // WFLOG-INJECTED
    local flagmissing=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L80:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L76:iteration-body" "statement" 4 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L81:step-summarize" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L76:iteration-body" "statement" 5 9 `=_rc' // WFLOG-INJECTED
    quietly summarize p99_econ_stock if source_year==`y', meanonly
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L81:step-summarize" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L76:iteration-body" "statement" 5 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L82:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L76:iteration-body" "statement" 6 9 `=_rc' // WFLOG-INJECTED
    local cutoff=10*r(mean)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L82:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L76:iteration-body" "statement" 6 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L83:step-summarize" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L76:iteration-body" "statement" 7 9 `=_rc' // WFLOG-INJECTED
    quietly summarize capital_stock_nominal if source_year==`y', detail
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L83:step-summarize" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L76:iteration-body" "statement" 7 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L84:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L76:iteration-body" "statement" 8 9 `=_rc' // WFLOG-INJECTED
    local n=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L84:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L76:iteration-body" "statement" 8 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L85:step-post" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L76:iteration-body" "statement" 9 9 `=_rc' // WFLOG-INJECTED
* Simpan statistik pada kelompok pembanding yang sedang dihitung bersama ambang dan jumlah baris bertanda. // WFDOC-INJECTED
    post `p' (`y') ("capital_stock_nominal") ("reported_stock_candidate") (`n') (r(mean)) (r(p1)) (r(p25)) (r(p50)) (r(p75)) (r(p99)) (r(min)) (r(max)) (`cutoff') (`flagged') (`flagmissing')
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L85:step-post" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L76:iteration-body" "statement" 9 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L76:iteration-body" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L76:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L76:step-foreach" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "loop" 16 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L87:step-foreach" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "loop" 17 24 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L87:iteration-body" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L87:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L88:step-count" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L87:iteration-body" "statement" 1 9 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & out_checked_stock==1
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L88:step-count" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L87:iteration-body" "statement" 1 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L89:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L87:iteration-body" "statement" 2 9 `=_rc' // WFLOG-INJECTED
    local flagged=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L89:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L87:iteration-body" "statement" 2 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L90:step-count" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L87:iteration-body" "statement" 3 9 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & missing(out_checked_stock)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L90:step-count" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L87:iteration-body" "statement" 3 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L91:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L87:iteration-body" "statement" 4 9 `=_rc' // WFLOG-INJECTED
    local flagmissing=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L91:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L87:iteration-body" "statement" 4 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L92:step-summarize" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L87:iteration-body" "statement" 5 9 `=_rc' // WFLOG-INJECTED
    quietly summarize p99_econ_stock if source_year==`y', meanonly
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L92:step-summarize" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L87:iteration-body" "statement" 5 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L93:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L87:iteration-body" "statement" 6 9 `=_rc' // WFLOG-INJECTED
    local cutoff=10*r(mean)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L93:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L87:iteration-body" "statement" 6 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L94:step-summarize" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L87:iteration-body" "statement" 7 9 `=_rc' // WFLOG-INJECTED
    quietly summarize clean_stock_nominal if source_year==`y', detail
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L94:step-summarize" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L87:iteration-body" "statement" 7 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L95:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L87:iteration-body" "statement" 8 9 `=_rc' // WFLOG-INJECTED
    local n=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L95:step-local" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L87:iteration-body" "statement" 8 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L96:step-post" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L87:iteration-body" "statement" 9 9 `=_rc' // WFLOG-INJECTED
* Simpan statistik pada kelompok pembanding yang sedang dihitung bersama ambang dan jumlah baris bertanda. // WFDOC-INJECTED
    post `p' (`y') ("clean_stock_nominal") ("inherited_stock_sensitivity") (`n') (r(mean)) (r(p1)) (r(p25)) (r(p50)) (r(p75)) (r(p99)) (r(min)) (r(max)) (`cutoff') (`flagged') (`flagmissing')
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L96:step-post" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L87:iteration-body" "statement" 9 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L87:iteration-body" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L87:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L87:step-foreach" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "loop" 17 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L98:step-postclose" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "statement" 18 24 `=_rc' // WFLOG-INJECTED
postclose `p'
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L98:step-postclose" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "statement" 18 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L99:step-use" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "statement" 19 24 `=_rc' // WFLOG-INJECTED
use "corrections/reports/__outlier.dta", clear
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L99:step-use" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "statement" 19 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L100:step-generate" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "statement" 20 24 `=_rc' // WFLOG-INJECTED
generate str35 release_status="legacy_candidate_display_only"
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L100:step-generate" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "statement" 20 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L101:step-isid" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "statement" 21 24 `=_rc' // WFLOG-INJECTED
isid source_year variable variant
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L101:step-isid" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "statement" 21 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L102:step-save" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "statement" 22 24 `=_rc' // WFLOG-INJECTED
save "corrections/reports/outlier_sensitivity.dta", replace
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L102:step-save" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "statement" 22 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L103:step-display" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "statement" 23 24 `=_rc' // WFLOG-INJECTED
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X11"
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L103:step-display" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "statement" 23 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X11_outlier_sensitivity.do:L104:step-log" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "statement" 24 24 `=_rc' // WFLOG-INJECTED
capture log close G0CHILD
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L104:step-log" "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "statement" 24 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X11_outlier_sensitivity.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
