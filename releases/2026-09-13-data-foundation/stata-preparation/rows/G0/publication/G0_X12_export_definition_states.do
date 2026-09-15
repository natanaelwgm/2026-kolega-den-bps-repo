* Tujuan: Pisahkan jawaban ya, tidak, dan unknown untuk beberapa definisi ekspor; persentase memakai penyebut ya+tidak, dan definisi langsung tetap terpisah dari definisi any. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: corrections/reports/__binary.dta; corrections/reports/export_definition_states.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L1:step-version" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "statement" 1 23 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L1:step-version" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "statement" 1 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L2:step-do" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "statement" 2 23 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L2:step-do" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "statement" 2 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L3:step-g0c_begin" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "statement" 3 23 `=_rc' // WFLOG-INJECTED
g0c_begin "G0-X12"
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L3:step-g0c_begin" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "statement" 3 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L4:step-use" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "statement" 4 23 `=_rc' // WFLOG-INJECTED
use "data/analysis/G0_analysis_ready.dta", clear
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L4:step-use" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "statement" 4 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L5:step-tempname" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "statement" 5 23 `=_rc' // WFLOG-INJECTED
tempname p
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L5:step-tempname" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "statement" 5 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L6:step-postfile" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "statement" 6 23 `=_rc' // WFLOG-INJECTED
* Siapkan tabel ringkasan; perintah post di bawah menambahkan hitungan atau hasil per kelompok. // WFDOC-INJECTED
postfile `p' int source_year str32 variable long rows long yes long no long unknown double positive_share using "corrections/reports/__binary.dta", replace
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L6:step-postfile" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "statement" 6 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L7:step-foreach" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "loop" 7 23 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L7:iteration-body" "rows/G0/publication/G0_X12_export_definition_states.do:L7:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L8:step-count" "rows/G0/publication/G0_X12_export_definition_states.do:L7:iteration-body" "statement" 1 8 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y'
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L8:step-count" "rows/G0/publication/G0_X12_export_definition_states.do:L7:iteration-body" "statement" 1 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L9:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L7:iteration-body" "statement" 2 8 `=_rc' // WFLOG-INJECTED
    local total=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L9:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L7:iteration-body" "statement" 2 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L10:step-count" "rows/G0/publication/G0_X12_export_definition_states.do:L7:iteration-body" "statement" 3 8 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & export_flag==1
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L10:step-count" "rows/G0/publication/G0_X12_export_definition_states.do:L7:iteration-body" "statement" 3 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L11:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L7:iteration-body" "statement" 4 8 `=_rc' // WFLOG-INJECTED
    local yes=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L11:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L7:iteration-body" "statement" 4 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L12:step-count" "rows/G0/publication/G0_X12_export_definition_states.do:L7:iteration-body" "statement" 5 8 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & export_flag==0
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L12:step-count" "rows/G0/publication/G0_X12_export_definition_states.do:L7:iteration-body" "statement" 5 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L13:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L7:iteration-body" "statement" 6 8 `=_rc' // WFLOG-INJECTED
    local no=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L13:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L7:iteration-body" "statement" 6 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L14:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L7:iteration-body" "statement" 7 8 `=_rc' // WFLOG-INJECTED
* Unknown adalah sisa dari seluruh baris setelah jawaban ya dan tidak dihitung; missing tidak diubah menjadi tidak. // WFDOC-INJECTED
    local unknown=`total'-`yes'-`no'
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L14:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L7:iteration-body" "statement" 7 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L15:step-post" "rows/G0/publication/G0_X12_export_definition_states.do:L7:iteration-body" "statement" 8 8 `=_rc' // WFLOG-INJECTED
* Catat jumlah ya/tidak/unknown dan share ya di antara jawaban yang diketahui; penyebut share tidak memasukkan unknown. // WFDOC-INJECTED
    post `p' (`y') ("export_flag") (`total') (`yes') (`no') (`unknown') (cond(`yes'+`no'>0,`yes'/(`yes'+`no'),.))
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L15:step-post" "rows/G0/publication/G0_X12_export_definition_states.do:L7:iteration-body" "statement" 8 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L7:iteration-body" "rows/G0/publication/G0_X12_export_definition_states.do:L7:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L7:step-foreach" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "loop" 7 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L17:step-foreach" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "loop" 8 23 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L17:iteration-body" "rows/G0/publication/G0_X12_export_definition_states.do:L17:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L18:step-count" "rows/G0/publication/G0_X12_export_definition_states.do:L17:iteration-body" "statement" 1 8 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y'
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L18:step-count" "rows/G0/publication/G0_X12_export_definition_states.do:L17:iteration-body" "statement" 1 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L19:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L17:iteration-body" "statement" 2 8 `=_rc' // WFLOG-INJECTED
    local total=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L19:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L17:iteration-body" "statement" 2 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L20:step-count" "rows/G0/publication/G0_X12_export_definition_states.do:L17:iteration-body" "statement" 3 8 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & export_any_binary==1
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L20:step-count" "rows/G0/publication/G0_X12_export_definition_states.do:L17:iteration-body" "statement" 3 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L21:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L17:iteration-body" "statement" 4 8 `=_rc' // WFLOG-INJECTED
    local yes=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L21:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L17:iteration-body" "statement" 4 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L22:step-count" "rows/G0/publication/G0_X12_export_definition_states.do:L17:iteration-body" "statement" 5 8 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & export_any_binary==0
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L22:step-count" "rows/G0/publication/G0_X12_export_definition_states.do:L17:iteration-body" "statement" 5 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L23:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L17:iteration-body" "statement" 6 8 `=_rc' // WFLOG-INJECTED
    local no=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L23:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L17:iteration-body" "statement" 6 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L24:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L17:iteration-body" "statement" 7 8 `=_rc' // WFLOG-INJECTED
* Unknown adalah sisa dari seluruh baris setelah jawaban ya dan tidak dihitung; missing tidak diubah menjadi tidak. // WFDOC-INJECTED
    local unknown=`total'-`yes'-`no'
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L24:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L17:iteration-body" "statement" 7 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L25:step-post" "rows/G0/publication/G0_X12_export_definition_states.do:L17:iteration-body" "statement" 8 8 `=_rc' // WFLOG-INJECTED
* Catat jumlah ya/tidak/unknown dan share ya di antara jawaban yang diketahui; penyebut share tidak memasukkan unknown. // WFDOC-INJECTED
    post `p' (`y') ("export_any_binary") (`total') (`yes') (`no') (`unknown') (cond(`yes'+`no'>0,`yes'/(`yes'+`no'),.))
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L25:step-post" "rows/G0/publication/G0_X12_export_definition_states.do:L17:iteration-body" "statement" 8 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L17:iteration-body" "rows/G0/publication/G0_X12_export_definition_states.do:L17:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L17:step-foreach" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "loop" 8 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L27:step-foreach" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "loop" 9 23 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L27:iteration-body" "rows/G0/publication/G0_X12_export_definition_states.do:L27:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L28:step-count" "rows/G0/publication/G0_X12_export_definition_states.do:L27:iteration-body" "statement" 1 8 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y'
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L28:step-count" "rows/G0/publication/G0_X12_export_definition_states.do:L27:iteration-body" "statement" 1 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L29:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L27:iteration-body" "statement" 2 8 `=_rc' // WFLOG-INJECTED
    local total=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L29:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L27:iteration-body" "statement" 2 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L30:step-count" "rows/G0/publication/G0_X12_export_definition_states.do:L27:iteration-body" "statement" 3 8 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & v_export_any_binary==1
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L30:step-count" "rows/G0/publication/G0_X12_export_definition_states.do:L27:iteration-body" "statement" 3 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L31:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L27:iteration-body" "statement" 4 8 `=_rc' // WFLOG-INJECTED
    local yes=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L31:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L27:iteration-body" "statement" 4 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L32:step-count" "rows/G0/publication/G0_X12_export_definition_states.do:L27:iteration-body" "statement" 5 8 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & v_export_any_binary==0
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L32:step-count" "rows/G0/publication/G0_X12_export_definition_states.do:L27:iteration-body" "statement" 5 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L33:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L27:iteration-body" "statement" 6 8 `=_rc' // WFLOG-INJECTED
    local no=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L33:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L27:iteration-body" "statement" 6 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L34:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L27:iteration-body" "statement" 7 8 `=_rc' // WFLOG-INJECTED
* Unknown adalah sisa dari seluruh baris setelah jawaban ya dan tidak dihitung; missing tidak diubah menjadi tidak. // WFDOC-INJECTED
    local unknown=`total'-`yes'-`no'
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L34:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L27:iteration-body" "statement" 7 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L35:step-post" "rows/G0/publication/G0_X12_export_definition_states.do:L27:iteration-body" "statement" 8 8 `=_rc' // WFLOG-INJECTED
* Catat jumlah ya/tidak/unknown dan share ya di antara jawaban yang diketahui; penyebut share tidak memasukkan unknown. // WFDOC-INJECTED
    post `p' (`y') ("v_export_any_binary") (`total') (`yes') (`no') (`unknown') (cond(`yes'+`no'>0,`yes'/(`yes'+`no'),.))
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L35:step-post" "rows/G0/publication/G0_X12_export_definition_states.do:L27:iteration-body" "statement" 8 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L27:iteration-body" "rows/G0/publication/G0_X12_export_definition_states.do:L27:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L27:step-foreach" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "loop" 9 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L37:step-foreach" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "loop" 10 23 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L37:iteration-body" "rows/G0/publication/G0_X12_export_definition_states.do:L37:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L38:step-count" "rows/G0/publication/G0_X12_export_definition_states.do:L37:iteration-body" "statement" 1 8 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y'
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L38:step-count" "rows/G0/publication/G0_X12_export_definition_states.do:L37:iteration-body" "statement" 1 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L39:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L37:iteration-body" "statement" 2 8 `=_rc' // WFLOG-INJECTED
    local total=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L39:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L37:iteration-body" "statement" 2 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L40:step-count" "rows/G0/publication/G0_X12_export_definition_states.do:L37:iteration-body" "statement" 3 8 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & export_direct_flag==1
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L40:step-count" "rows/G0/publication/G0_X12_export_definition_states.do:L37:iteration-body" "statement" 3 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L41:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L37:iteration-body" "statement" 4 8 `=_rc' // WFLOG-INJECTED
    local yes=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L41:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L37:iteration-body" "statement" 4 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L42:step-count" "rows/G0/publication/G0_X12_export_definition_states.do:L37:iteration-body" "statement" 5 8 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & export_direct_flag==0
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L42:step-count" "rows/G0/publication/G0_X12_export_definition_states.do:L37:iteration-body" "statement" 5 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L43:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L37:iteration-body" "statement" 6 8 `=_rc' // WFLOG-INJECTED
    local no=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L43:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L37:iteration-body" "statement" 6 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L44:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L37:iteration-body" "statement" 7 8 `=_rc' // WFLOG-INJECTED
* Unknown adalah sisa dari seluruh baris setelah jawaban ya dan tidak dihitung; missing tidak diubah menjadi tidak. // WFDOC-INJECTED
    local unknown=`total'-`yes'-`no'
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L44:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L37:iteration-body" "statement" 7 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L45:step-post" "rows/G0/publication/G0_X12_export_definition_states.do:L37:iteration-body" "statement" 8 8 `=_rc' // WFLOG-INJECTED
* Catat jumlah ya/tidak/unknown dan share ya di antara jawaban yang diketahui; penyebut share tidak memasukkan unknown. // WFDOC-INJECTED
    post `p' (`y') ("export_direct_flag") (`total') (`yes') (`no') (`unknown') (cond(`yes'+`no'>0,`yes'/(`yes'+`no'),.))
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L45:step-post" "rows/G0/publication/G0_X12_export_definition_states.do:L37:iteration-body" "statement" 8 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L37:iteration-body" "rows/G0/publication/G0_X12_export_definition_states.do:L37:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L37:step-foreach" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "loop" 10 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L47:step-foreach" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "loop" 11 23 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L47:iteration-body" "rows/G0/publication/G0_X12_export_definition_states.do:L47:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L48:step-count" "rows/G0/publication/G0_X12_export_definition_states.do:L47:iteration-body" "statement" 1 8 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y'
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L48:step-count" "rows/G0/publication/G0_X12_export_definition_states.do:L47:iteration-body" "statement" 1 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L49:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L47:iteration-body" "statement" 2 8 `=_rc' // WFLOG-INJECTED
    local total=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L49:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L47:iteration-body" "statement" 2 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L50:step-count" "rows/G0/publication/G0_X12_export_definition_states.do:L47:iteration-body" "statement" 3 8 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & export_verified_conflict==1
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L50:step-count" "rows/G0/publication/G0_X12_export_definition_states.do:L47:iteration-body" "statement" 3 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L51:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L47:iteration-body" "statement" 4 8 `=_rc' // WFLOG-INJECTED
    local yes=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L51:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L47:iteration-body" "statement" 4 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L52:step-count" "rows/G0/publication/G0_X12_export_definition_states.do:L47:iteration-body" "statement" 5 8 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & export_verified_conflict==0
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L52:step-count" "rows/G0/publication/G0_X12_export_definition_states.do:L47:iteration-body" "statement" 5 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L53:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L47:iteration-body" "statement" 6 8 `=_rc' // WFLOG-INJECTED
    local no=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L53:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L47:iteration-body" "statement" 6 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L54:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L47:iteration-body" "statement" 7 8 `=_rc' // WFLOG-INJECTED
* Unknown adalah sisa dari seluruh baris setelah jawaban ya dan tidak dihitung; missing tidak diubah menjadi tidak. // WFDOC-INJECTED
    local unknown=`total'-`yes'-`no'
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L54:step-local" "rows/G0/publication/G0_X12_export_definition_states.do:L47:iteration-body" "statement" 7 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L55:step-post" "rows/G0/publication/G0_X12_export_definition_states.do:L47:iteration-body" "statement" 8 8 `=_rc' // WFLOG-INJECTED
* Catat jumlah ya/tidak/unknown dan share ya di antara jawaban yang diketahui; penyebut share tidak memasukkan unknown. // WFDOC-INJECTED
    post `p' (`y') ("export_verified_conflict") (`total') (`yes') (`no') (`unknown') (cond(`yes'+`no'>0,`yes'/(`yes'+`no'),.))
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L55:step-post" "rows/G0/publication/G0_X12_export_definition_states.do:L47:iteration-body" "statement" 8 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L47:iteration-body" "rows/G0/publication/G0_X12_export_definition_states.do:L47:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L47:step-foreach" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "loop" 11 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L57:step-postclose" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "statement" 12 23 `=_rc' // WFLOG-INJECTED
postclose `p'
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L57:step-postclose" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "statement" 12 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L58:step-use" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "statement" 13 23 `=_rc' // WFLOG-INJECTED
use "corrections/reports/__binary.dta", clear
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L58:step-use" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "statement" 13 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L59:step-isid" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "statement" 14 23 `=_rc' // WFLOG-INJECTED
isid source_year variable
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L59:step-isid" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "statement" 14 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L60:step-generate" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "statement" 15 23 `=_rc' // WFLOG-INJECTED
generate str100 definition_status="Any/direct/working/verified meanings separate; direct-no does not imply any-export-no"
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L60:step-generate" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "statement" 15 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L61:step-rename" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "statement" 16 23 `=_rc' // WFLOG-INJECTED
rename variable measure
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L61:step-rename" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "statement" 16 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L62:step-rename" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "statement" 17 23 `=_rc' // WFLOG-INJECTED
rename yes yes_n
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L62:step-rename" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "statement" 17 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L63:step-rename" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "statement" 18 23 `=_rc' // WFLOG-INJECTED
rename no no_n
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L63:step-rename" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "statement" 18 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L64:step-rename" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "statement" 19 23 `=_rc' // WFLOG-INJECTED
rename unknown unknown_n
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L64:step-rename" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "statement" 19 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L65:step-generate" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "statement" 20 23 `=_rc' // WFLOG-INJECTED
* Penyebut teramati adalah ya+tidak; baris unknown tetap dilaporkan terpisah. // WFDOC-INJECTED
generate long observed_denominator=yes_n+no_n
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L65:step-generate" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "statement" 20 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L66:step-save" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "statement" 21 23 `=_rc' // WFLOG-INJECTED
save "corrections/reports/export_definition_states.dta", replace
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L66:step-save" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "statement" 21 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L67:step-display" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "statement" 22 23 `=_rc' // WFLOG-INJECTED
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X12"
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L67:step-display" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "statement" 22 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X12_export_definition_states.do:L68:step-log" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "statement" 23 23 `=_rc' // WFLOG-INJECTED
capture log close G0CHILD
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L68:step-log" "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "statement" 23 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X12_export_definition_states.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
