* Tujuan: Hitung ringkasan yang didefinisikan di file ini dan tulis tabel keluaran pada nama/path yang tercantum di perintah ekspor. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/G0_source_states.dta; dag/reports/word_data/G0/source_state_counts.csv // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "code/reports/rebuild_source_counts.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/rebuild_source_counts.do:L1:step-do" "code/reports/rebuild_source_counts.do:L1:file" "statement" 1 12 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
capture noisily __wf_progress end "code/reports/rebuild_source_counts.do:L1:step-do" "code/reports/rebuild_source_counts.do:L1:file" "statement" 1 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/rebuild_source_counts.do:L2:step-use" "code/reports/rebuild_source_counts.do:L1:file" "statement" 2 12 `=_rc' // WFLOG-INJECTED
use "data/analysis/G0_analysis_ready.dta", clear
capture noisily __wf_progress end "code/reports/rebuild_source_counts.do:L2:step-use" "code/reports/rebuild_source_counts.do:L1:file" "statement" 2 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/rebuild_source_counts.do:L3:step-tempname" "code/reports/rebuild_source_counts.do:L1:file" "statement" 3 12 `=_rc' // WFLOG-INJECTED
tempname s
capture noisily __wf_progress end "code/reports/rebuild_source_counts.do:L3:step-tempname" "code/reports/rebuild_source_counts.do:L1:file" "statement" 3 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/rebuild_source_counts.do:L4:step-postfile" "code/reports/rebuild_source_counts.do:L1:file" "statement" 4 12 `=_rc' // WFLOG-INJECTED
* Siapkan tabel ringkasan; perintah post di bawah menambahkan hitungan atau hasil per kelompok. // WFDOC-INJECTED
postfile `s' int source_year str32 variable byte source_state long observations using "$G0D/G0_source_states.dta", replace
capture noisily __wf_progress end "code/reports/rebuild_source_counts.do:L4:step-postfile" "code/reports/rebuild_source_counts.do:L1:file" "statement" 4 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/rebuild_source_counts.do:L5:step-ds" "code/reports/rebuild_source_counts.do:L1:file" "statement" 5 12 `=_rc' // WFLOG-INJECTED
ds st_*
capture noisily __wf_progress end "code/reports/rebuild_source_counts.do:L5:step-ds" "code/reports/rebuild_source_counts.do:L1:file" "statement" 5 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/rebuild_source_counts.do:L6:step-local" "code/reports/rebuild_source_counts.do:L1:file" "statement" 6 12 `=_rc' // WFLOG-INJECTED
local states `r(varlist)'
capture noisily __wf_progress end "code/reports/rebuild_source_counts.do:L6:step-local" "code/reports/rebuild_source_counts.do:L1:file" "statement" 6 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/rebuild_source_counts.do:L7:step-foreach" "code/reports/rebuild_source_counts.do:L1:file" "loop" 7 12 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "code/reports/rebuild_source_counts.do:L7:iteration-body" "code/reports/rebuild_source_counts.do:L7:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/rebuild_source_counts.do:L8:step-foreach" "code/reports/rebuild_source_counts.do:L7:iteration-body" "loop" 1 1 `=_rc' "local-expanded" `"`states'"' // WFLOG-INJECTED
* Ulangi blok untuk tiap v dalam daftar local states. // WFDOC-INJECTED
    foreach v of local states {
capture noisily __wf_progress start "code/reports/rebuild_source_counts.do:L8:iteration-body" "code/reports/rebuild_source_counts.do:L8:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/rebuild_source_counts.do:L9:step-forvalues" "code/reports/rebuild_source_counts.do:L8:iteration-body" "loop" 1 1 `=_rc' "forvalues" `"0/10"' // WFLOG-INJECTED
* Ulangi blok untuk setiap k dari 0 sampai 10. // WFDOC-INJECTED
        forvalues k=0/10 {
capture noisily __wf_progress start "code/reports/rebuild_source_counts.do:L9:iteration-body" "code/reports/rebuild_source_counts.do:L9:step-forvalues" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/rebuild_source_counts.do:L10:step-count" "code/reports/rebuild_source_counts.do:L9:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
            quietly count if source_year==`y' & `v'==`k'
capture noisily __wf_progress end "code/reports/rebuild_source_counts.do:L10:step-count" "code/reports/rebuild_source_counts.do:L9:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/rebuild_source_counts.do:L11:step-post" "code/reports/rebuild_source_counts.do:L9:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
            post `s' (`y') ("`v'") (`k') (r(N))
capture noisily __wf_progress end "code/reports/rebuild_source_counts.do:L11:step-post" "code/reports/rebuild_source_counts.do:L9:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/reports/rebuild_source_counts.do:L9:iteration-body" "code/reports/rebuild_source_counts.do:L9:step-forvalues" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
        }
capture noisily __wf_progress end "code/reports/rebuild_source_counts.do:L9:step-forvalues" "code/reports/rebuild_source_counts.do:L8:iteration-body" "loop" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/reports/rebuild_source_counts.do:L8:iteration-body" "code/reports/rebuild_source_counts.do:L8:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
    }
capture noisily __wf_progress end "code/reports/rebuild_source_counts.do:L8:step-foreach" "code/reports/rebuild_source_counts.do:L7:iteration-body" "loop" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/reports/rebuild_source_counts.do:L7:iteration-body" "code/reports/rebuild_source_counts.do:L7:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "code/reports/rebuild_source_counts.do:L7:step-foreach" "code/reports/rebuild_source_counts.do:L1:file" "loop" 7 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/rebuild_source_counts.do:L15:step-postclose" "code/reports/rebuild_source_counts.do:L1:file" "statement" 8 12 `=_rc' // WFLOG-INJECTED
postclose `s'
capture noisily __wf_progress end "code/reports/rebuild_source_counts.do:L15:step-postclose" "code/reports/rebuild_source_counts.do:L1:file" "statement" 8 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/rebuild_source_counts.do:L16:step-preserve" "code/reports/rebuild_source_counts.do:L1:file" "statement" 9 12 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/reports/rebuild_source_counts.do:L16:step-preserve" "code/reports/rebuild_source_counts.do:L1:file" "statement" 9 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/rebuild_source_counts.do:L17:step-use" "code/reports/rebuild_source_counts.do:L1:file" "statement" 10 12 `=_rc' // WFLOG-INJECTED
use "$G0D/G0_source_states.dta", clear
capture noisily __wf_progress end "code/reports/rebuild_source_counts.do:L17:step-use" "code/reports/rebuild_source_counts.do:L1:file" "statement" 10 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/rebuild_source_counts.do:L18:step-export" "code/reports/rebuild_source_counts.do:L1:file" "statement" 11 12 `=_rc' // WFLOG-INJECTED
* Tulis tabel yang sedang terbuka ke CSV pada nama file di perintah ini. // WFDOC-INJECTED
export delimited using "$G0R/source_state_counts.csv", replace
capture noisily __wf_progress end "code/reports/rebuild_source_counts.do:L18:step-export" "code/reports/rebuild_source_counts.do:L1:file" "statement" 11 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/rebuild_source_counts.do:L19:step-restore" "code/reports/rebuild_source_counts.do:L1:file" "statement" 12 12 `=_rc' // WFLOG-INJECTED
restore
capture noisily __wf_progress end "code/reports/rebuild_source_counts.do:L19:step-restore" "code/reports/rebuild_source_counts.do:L1:file" "statement" 12 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/reports/rebuild_source_counts.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
