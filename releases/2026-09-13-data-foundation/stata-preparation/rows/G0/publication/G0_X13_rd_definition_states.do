* Tujuan: Pisahkan status jawaban R&D dari statistik uang; kode pertanyaan bukan biaya, dan kategori COSTRD tidak diperlakukan sebagai jumlah uang. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta; corrections/reports/__binary.dta; dan 1 masukan lain // WFDOC-INJECTED
* Output: corrections/reports/__binary.dta; corrections/reports/__rd_amount.dta; dan 1 masukan lain // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L1:step-version" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 1 47 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L1:step-version" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 1 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L2:step-do" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 2 47 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L2:step-do" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 2 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L3:step-g0c_begin" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 3 47 `=_rc' // WFLOG-INJECTED
g0c_begin "G0-X13"
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L3:step-g0c_begin" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 3 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L4:step-use" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 4 47 `=_rc' // WFLOG-INJECTED
use "data/analysis/G0_analysis_ready.dta", clear
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L4:step-use" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 4 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L5:step-tempname" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 5 47 `=_rc' // WFLOG-INJECTED
tempname p
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L5:step-tempname" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 5 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L6:step-postfile" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 6 47 `=_rc' // WFLOG-INJECTED
* Siapkan tabel ringkasan; perintah post di bawah menambahkan hitungan atau hasil per kelompok. // WFDOC-INJECTED
postfile `p' int source_year str32 variable long rows long yes long no long unknown double positive_share using "corrections/reports/__binary.dta", replace
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L6:step-postfile" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 6 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L7:step-foreach" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "loop" 7 47 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L7:iteration-body" "rows/G0/publication/G0_X13_rd_definition_states.do:L7:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L8:step-count" "rows/G0/publication/G0_X13_rd_definition_states.do:L7:iteration-body" "statement" 1 8 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y'
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L8:step-count" "rows/G0/publication/G0_X13_rd_definition_states.do:L7:iteration-body" "statement" 1 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L9:step-local" "rows/G0/publication/G0_X13_rd_definition_states.do:L7:iteration-body" "statement" 2 8 `=_rc' // WFLOG-INJECTED
    local total=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L9:step-local" "rows/G0/publication/G0_X13_rd_definition_states.do:L7:iteration-body" "statement" 2 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L10:step-count" "rows/G0/publication/G0_X13_rd_definition_states.do:L7:iteration-body" "statement" 3 8 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & rd_activity_flag==1
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L10:step-count" "rows/G0/publication/G0_X13_rd_definition_states.do:L7:iteration-body" "statement" 3 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L11:step-local" "rows/G0/publication/G0_X13_rd_definition_states.do:L7:iteration-body" "statement" 4 8 `=_rc' // WFLOG-INJECTED
    local yes=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L11:step-local" "rows/G0/publication/G0_X13_rd_definition_states.do:L7:iteration-body" "statement" 4 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L12:step-count" "rows/G0/publication/G0_X13_rd_definition_states.do:L7:iteration-body" "statement" 5 8 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & rd_activity_flag==0
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L12:step-count" "rows/G0/publication/G0_X13_rd_definition_states.do:L7:iteration-body" "statement" 5 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L13:step-local" "rows/G0/publication/G0_X13_rd_definition_states.do:L7:iteration-body" "statement" 6 8 `=_rc' // WFLOG-INJECTED
    local no=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L13:step-local" "rows/G0/publication/G0_X13_rd_definition_states.do:L7:iteration-body" "statement" 6 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L14:step-local" "rows/G0/publication/G0_X13_rd_definition_states.do:L7:iteration-body" "statement" 7 8 `=_rc' // WFLOG-INJECTED
* Unknown adalah sisa dari seluruh baris setelah jawaban ya dan tidak dihitung; missing tidak diubah menjadi tidak. // WFDOC-INJECTED
    local unknown=`total'-`yes'-`no'
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L14:step-local" "rows/G0/publication/G0_X13_rd_definition_states.do:L7:iteration-body" "statement" 7 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L15:step-post" "rows/G0/publication/G0_X13_rd_definition_states.do:L7:iteration-body" "statement" 8 8 `=_rc' // WFLOG-INJECTED
* Catat jumlah ya/tidak/unknown dan share ya di antara jawaban yang diketahui; penyebut share tidak memasukkan unknown. // WFDOC-INJECTED
    post `p' (`y') ("rd_activity_flag") (`total') (`yes') (`no') (`unknown') (cond(`yes'+`no'>0,`yes'/(`yes'+`no'),.))
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L15:step-post" "rows/G0/publication/G0_X13_rd_definition_states.do:L7:iteration-body" "statement" 8 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L7:iteration-body" "rows/G0/publication/G0_X13_rd_definition_states.do:L7:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L7:step-foreach" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "loop" 7 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L17:step-foreach" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "loop" 8 47 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L17:iteration-body" "rows/G0/publication/G0_X13_rd_definition_states.do:L17:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L18:step-count" "rows/G0/publication/G0_X13_rd_definition_states.do:L17:iteration-body" "statement" 1 8 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y'
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L18:step-count" "rows/G0/publication/G0_X13_rd_definition_states.do:L17:iteration-body" "statement" 1 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L19:step-local" "rows/G0/publication/G0_X13_rd_definition_states.do:L17:iteration-body" "statement" 2 8 `=_rc' // WFLOG-INJECTED
    local total=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L19:step-local" "rows/G0/publication/G0_X13_rd_definition_states.do:L17:iteration-body" "statement" 2 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L20:step-count" "rows/G0/publication/G0_X13_rd_definition_states.do:L17:iteration-body" "statement" 3 8 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & rd_external_funding_flag==1
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L20:step-count" "rows/G0/publication/G0_X13_rd_definition_states.do:L17:iteration-body" "statement" 3 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L21:step-local" "rows/G0/publication/G0_X13_rd_definition_states.do:L17:iteration-body" "statement" 4 8 `=_rc' // WFLOG-INJECTED
    local yes=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L21:step-local" "rows/G0/publication/G0_X13_rd_definition_states.do:L17:iteration-body" "statement" 4 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L22:step-count" "rows/G0/publication/G0_X13_rd_definition_states.do:L17:iteration-body" "statement" 5 8 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y' & rd_external_funding_flag==0
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L22:step-count" "rows/G0/publication/G0_X13_rd_definition_states.do:L17:iteration-body" "statement" 5 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L23:step-local" "rows/G0/publication/G0_X13_rd_definition_states.do:L17:iteration-body" "statement" 6 8 `=_rc' // WFLOG-INJECTED
    local no=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L23:step-local" "rows/G0/publication/G0_X13_rd_definition_states.do:L17:iteration-body" "statement" 6 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L24:step-local" "rows/G0/publication/G0_X13_rd_definition_states.do:L17:iteration-body" "statement" 7 8 `=_rc' // WFLOG-INJECTED
* Unknown adalah sisa dari seluruh baris setelah jawaban ya dan tidak dihitung; missing tidak diubah menjadi tidak. // WFDOC-INJECTED
    local unknown=`total'-`yes'-`no'
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L24:step-local" "rows/G0/publication/G0_X13_rd_definition_states.do:L17:iteration-body" "statement" 7 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L25:step-post" "rows/G0/publication/G0_X13_rd_definition_states.do:L17:iteration-body" "statement" 8 8 `=_rc' // WFLOG-INJECTED
* Catat jumlah ya/tidak/unknown dan share ya di antara jawaban yang diketahui; penyebut share tidak memasukkan unknown. // WFDOC-INJECTED
    post `p' (`y') ("rd_external_funding_flag") (`total') (`yes') (`no') (`unknown') (cond(`yes'+`no'>0,`yes'/(`yes'+`no'),.))
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L25:step-post" "rows/G0/publication/G0_X13_rd_definition_states.do:L17:iteration-body" "statement" 8 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L17:iteration-body" "rows/G0/publication/G0_X13_rd_definition_states.do:L17:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L17:step-foreach" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "loop" 8 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L27:step-postclose" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 9 47 `=_rc' // WFLOG-INJECTED
postclose `p'
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L27:step-postclose" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 9 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L28:step-use" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 10 47 `=_rc' // WFLOG-INJECTED
use "corrections/reports/__binary.dta", clear
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L28:step-use" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 10 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L29:step-isid" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 11 47 `=_rc' // WFLOG-INJECTED
isid source_year variable
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L29:step-isid" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 11 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L30:step-rename" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 12 47 `=_rc' // WFLOG-INJECTED
rename variable measure
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L30:step-rename" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 12 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L31:step-rename" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 13 47 `=_rc' // WFLOG-INJECTED
rename yes yes_n
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L31:step-rename" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 13 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L32:step-rename" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 14 47 `=_rc' // WFLOG-INJECTED
rename no no_n
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L32:step-rename" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 14 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L33:step-rename" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 15 47 `=_rc' // WFLOG-INJECTED
rename unknown unknown_n
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L33:step-rename" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 15 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L34:step-rename" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 16 47 `=_rc' // WFLOG-INJECTED
rename positive_share legacy_positive_share
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L34:step-rename" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 16 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L35:step-generate" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 17 47 `=_rc' // WFLOG-INJECTED
generate long value_n=yes_n+no_n
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L35:step-generate" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 17 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L36:step-generate" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 18 47 `=_rc' // WFLOG-INJECTED
generate str32 measure_kind="legacy_binary_diagnostic"
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L36:step-generate" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 18 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L37:step-tempfile" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 19 47 `=_rc' // WFLOG-INJECTED
tempfile rd_binary
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L37:step-tempfile" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 19 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L38:step-save" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 20 47 `=_rc' // WFLOG-INJECTED
save `rd_binary'
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L38:step-save" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 20 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L39:step-use" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 21 47 `=_rc' // WFLOG-INJECTED
use source_year source_row rd_cost_nominal val_costrd using "data/analysis/G0_analysis_ready.dta", clear
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L39:step-use" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 21 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L40:step-tempname" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 22 47 `=_rc' // WFLOG-INJECTED
tempname p
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L40:step-tempname" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 22 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L41:step-postfile" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 23 47 `=_rc' // WFLOG-INJECTED
* Siapkan tabel ringkasan; perintah post di bawah menambahkan hitungan atau hasil per kelompok. // WFDOC-INJECTED
postfile `p' int source_year str32 measure str32 measure_kind long rows long value_n long unknown_n double mean double p50 using "corrections/reports/__rd_amount.dta", replace
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L41:step-postfile" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 23 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L42:step-foreach" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "loop" 24 47 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L42:iteration-body" "rows/G0/publication/G0_X13_rd_definition_states.do:L42:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L43:step-count" "rows/G0/publication/G0_X13_rd_definition_states.do:L42:iteration-body" "statement" 1 5 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y'
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L43:step-count" "rows/G0/publication/G0_X13_rd_definition_states.do:L42:iteration-body" "statement" 1 5 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L44:step-local" "rows/G0/publication/G0_X13_rd_definition_states.do:L42:iteration-body" "statement" 2 5 `=_rc' // WFLOG-INJECTED
    local total=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L44:step-local" "rows/G0/publication/G0_X13_rd_definition_states.do:L42:iteration-body" "statement" 2 5 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L45:step-summarize" "rows/G0/publication/G0_X13_rd_definition_states.do:L42:iteration-body" "statement" 3 5 `=_rc' // WFLOG-INJECTED
    quietly summarize rd_cost_nominal if source_year==`y', detail
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L45:step-summarize" "rows/G0/publication/G0_X13_rd_definition_states.do:L42:iteration-body" "statement" 3 5 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L46:step-local" "rows/G0/publication/G0_X13_rd_definition_states.do:L42:iteration-body" "statement" 4 5 `=_rc' // WFLOG-INJECTED
    local n=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L46:step-local" "rows/G0/publication/G0_X13_rd_definition_states.do:L42:iteration-body" "statement" 4 5 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L47:step-post" "rows/G0/publication/G0_X13_rd_definition_states.do:L42:iteration-body" "statement" 5 5 `=_rc' // WFLOG-INJECTED
* Untuk rd_cost_nominal, catat jumlah baris, nilai terisi/kosong, rerata, dan p50; ukurannya tetap berlabel kandidat nominal lama, bukan persentase jawaban R&D. // WFDOC-INJECTED
    post `p' (`y') ("rd_cost_nominal") ("legacy_nominal_amount_candidate") (`total') (`n') (`total'-`n') (r(mean)) (r(p50))
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L47:step-post" "rows/G0/publication/G0_X13_rd_definition_states.do:L42:iteration-body" "statement" 5 5 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L42:iteration-body" "rows/G0/publication/G0_X13_rd_definition_states.do:L42:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L42:step-foreach" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "loop" 24 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L49:step-foreach" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "loop" 25 47 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L49:iteration-body" "rows/G0/publication/G0_X13_rd_definition_states.do:L49:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L50:step-count" "rows/G0/publication/G0_X13_rd_definition_states.do:L49:iteration-body" "statement" 1 5 `=_rc' // WFLOG-INJECTED
    quietly count if source_year==`y'
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L50:step-count" "rows/G0/publication/G0_X13_rd_definition_states.do:L49:iteration-body" "statement" 1 5 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L51:step-local" "rows/G0/publication/G0_X13_rd_definition_states.do:L49:iteration-body" "statement" 2 5 `=_rc' // WFLOG-INJECTED
    local total=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L51:step-local" "rows/G0/publication/G0_X13_rd_definition_states.do:L49:iteration-body" "statement" 2 5 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L52:step-summarize" "rows/G0/publication/G0_X13_rd_definition_states.do:L49:iteration-body" "statement" 3 5 `=_rc' // WFLOG-INJECTED
    quietly summarize val_costrd if source_year==`y', detail
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L52:step-summarize" "rows/G0/publication/G0_X13_rd_definition_states.do:L49:iteration-body" "statement" 3 5 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L53:step-local" "rows/G0/publication/G0_X13_rd_definition_states.do:L49:iteration-body" "statement" 4 5 `=_rc' // WFLOG-INJECTED
    local n=r(N)
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L53:step-local" "rows/G0/publication/G0_X13_rd_definition_states.do:L49:iteration-body" "statement" 4 5 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L54:step-post" "rows/G0/publication/G0_X13_rd_definition_states.do:L49:iteration-body" "statement" 5 5 `=_rc' // WFLOG-INJECTED
* Untuk val_costrd, catat hanya keberadaan kategori; nilai mean/p50 dikosongkan karena kategori bukan nominal uang. // WFDOC-INJECTED
    post `p' (`y') ("val_costrd") ("raw_category_presence_only") (`total') (`n') (`total'-`n') (.) (.)
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L54:step-post" "rows/G0/publication/G0_X13_rd_definition_states.do:L49:iteration-body" "statement" 5 5 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L49:iteration-body" "rows/G0/publication/G0_X13_rd_definition_states.do:L49:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L49:step-foreach" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "loop" 25 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L56:step-postclose" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 26 47 `=_rc' // WFLOG-INJECTED
postclose `p'
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L56:step-postclose" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 26 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L57:step-use" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 27 47 `=_rc' // WFLOG-INJECTED
use "corrections/reports/__rd_amount.dta", clear
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L57:step-use" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 27 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L58:step-drop" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 28 47 `=_rc' // WFLOG-INJECTED
drop if measure=="rd_cost_nominal"
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L58:step-drop" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 28 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L59:step-tempfile" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 29 47 `=_rc' // WFLOG-INJECTED
tempfile rd_categories
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L59:step-tempfile" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 29 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L60:step-save" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 30 47 `=_rc' // WFLOG-INJECTED
save `rd_categories'
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L60:step-save" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 30 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L61:step-use" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 31 47 `=_rc' // WFLOG-INJECTED
use "corrections/reports/core_descriptive_statistics.dta", clear
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L61:step-use" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 31 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L62:step-keep" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 32 47 `=_rc' // WFLOG-INJECTED
keep if variable=="rd_cost_nominal"
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L62:step-keep" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 32 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L63:step-rename" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 33 47 `=_rc' // WFLOG-INJECTED
rename variable measure
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L63:step-rename" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 33 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L64:step-rename" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 34 47 `=_rc' // WFLOG-INJECTED
rename n value_n
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L64:step-rename" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 34 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L65:step-rename" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 35 47 `=_rc' // WFLOG-INJECTED
rename missing_rows unknown_n
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L65:step-rename" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 35 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L66:step-generate" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 36 47 `=_rc' // WFLOG-INJECTED
generate str32 measure_kind="legacy_nominal_amount_candidate"
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L66:step-generate" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 36 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L67:step-keep" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 37 47 `=_rc' // WFLOG-INJECTED
keep source_year measure measure_kind rows value_n unknown_n mean p50 release_status
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L67:step-keep" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 37 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L68:step-append" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 38 47 `=_rc' // WFLOG-INJECTED
append using `rd_categories'
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L68:step-append" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 38 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L69:step-append" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 39 47 `=_rc' // WFLOG-INJECTED
append using `rd_binary'
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L69:step-append" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 39 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L70:step-generate" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 40 47 `=_rc' // WFLOG-INJECTED
* Bawa batas interpretasi ke tiap baris: kandidat biaya tidak disamakan dengan kode kategori COSTRD atau prevalensi pertanyaan R&D. // WFDOC-INJECTED
generate str150 definition_status="Legacy candidate only; COSTRD category is never an amount; accepted RND17=2 universe and 2017 funding prevalence unavailable"
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L70:step-generate" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 40 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L71:step-generate" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 41 47 `=_rc' // WFLOG-INJECTED
generate long not_asked_n=.
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L71:step-generate" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 41 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L72:step-generate" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 42 47 `=_rc' // WFLOG-INJECTED
generate long accepted_eligible_n=.
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L72:step-generate" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 42 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L73:step-generate" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 43 47 `=_rc' // WFLOG-INJECTED
generate double accepted_positive_share=.
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L73:step-generate" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 43 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L74:step-isid" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 44 47 `=_rc' // WFLOG-INJECTED
isid source_year measure
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L74:step-isid" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 44 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L75:step-save" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 45 47 `=_rc' // WFLOG-INJECTED
save "corrections/reports/rd_definition_states.dta", replace
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L75:step-save" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 45 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L76:step-display" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 46 47 `=_rc' // WFLOG-INJECTED
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X13"
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L76:step-display" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 46 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X13_rd_definition_states.do:L77:step-log" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 47 47 `=_rc' // WFLOG-INJECTED
capture log close G0CHILD
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L77:step-log" "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "statement" 47 47 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X13_rd_definition_states.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
