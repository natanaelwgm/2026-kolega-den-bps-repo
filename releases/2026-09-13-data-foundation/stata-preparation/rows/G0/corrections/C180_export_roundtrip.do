* Tujuan: Uji ekspor-impor CSV dengan memeriksa jumlah baris/kolom dan membandingkan kembali semua nilai sebelum memulihkan data awal. // WFDOC-INJECTED
* Input: corrections/reports/annual_sample.dta; corrections/reports/annual_schema_mapping.dta; dan 28 masukan lain // WFDOC-INJECTED
* Output: corrections/reports/annual_sample.csv; corrections/reports/annual_schema_mapping.csv; dan 30 masukan lain // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C180_export_roundtrip.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C180_export_roundtrip.do:L1:step-version" "rows/G0/corrections/C180_export_roundtrip.do:L1:file" "statement" 1 12 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/corrections/C180_export_roundtrip.do:L1:step-version" "rows/G0/corrections/C180_export_roundtrip.do:L1:file" "statement" 1 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C180_export_roundtrip.do:L2:step-do" "rows/G0/corrections/C180_export_roundtrip.do:L1:file" "statement" 2 12 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/corrections/C180_export_roundtrip.do:L2:step-do" "rows/G0/corrections/C180_export_roundtrip.do:L1:file" "statement" 2 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C180_export_roundtrip.do:L3:step-g0c_begin" "rows/G0/corrections/C180_export_roundtrip.do:L1:file" "statement" 3 12 `=_rc' // WFLOG-INJECTED
g0c_begin "C180_export_roundtrip"
capture noisily __wf_progress end "rows/G0/corrections/C180_export_roundtrip.do:L3:step-g0c_begin" "rows/G0/corrections/C180_export_roundtrip.do:L1:file" "statement" 3 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C180_export_roundtrip.do:L4:step-local" "rows/G0/corrections/C180_export_roundtrip.do:L1:file" "statement" 4 12 `=_rc' // WFLOG-INJECTED
local datasets : dir "corrections/reports" files "*.dta"
capture noisily __wf_progress end "rows/G0/corrections/C180_export_roundtrip.do:L4:step-local" "rows/G0/corrections/C180_export_roundtrip.do:L1:file" "statement" 4 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C180_export_roundtrip.do:L5:step-tempname" "rows/G0/corrections/C180_export_roundtrip.do:L1:file" "statement" 5 12 `=_rc' // WFLOG-INJECTED
tempname p
capture noisily __wf_progress end "rows/G0/corrections/C180_export_roundtrip.do:L5:step-tempname" "rows/G0/corrections/C180_export_roundtrip.do:L1:file" "statement" 5 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C180_export_roundtrip.do:L6:step-postfile" "rows/G0/corrections/C180_export_roundtrip.do:L1:file" "statement" 6 12 `=_rc' // WFLOG-INJECTED
postfile `p' str120 artifact long rows double numeric_cells double different_cells byte all_keys_exact byte roundtrip_pass using "corrections/data/C180.dta", replace
capture noisily __wf_progress end "rows/G0/corrections/C180_export_roundtrip.do:L6:step-postfile" "rows/G0/corrections/C180_export_roundtrip.do:L1:file" "statement" 6 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C180_export_roundtrip.do:L7:step-foreach" "rows/G0/corrections/C180_export_roundtrip.do:L1:file" "loop" 7 12 `=_rc' "local-expanded" `"`datasets'"' // WFLOG-INJECTED
* Ulangi blok untuk tiap f dalam daftar local datasets. // WFDOC-INJECTED
foreach f of local datasets {
capture noisily __wf_progress start "rows/G0/corrections/C180_export_roundtrip.do:L7:iteration-body" "rows/G0/corrections/C180_export_roundtrip.do:L7:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C180_export_roundtrip.do:L8:step-if" "rows/G0/corrections/C180_export_roundtrip.do:L7:iteration-body" "statement" 1 9 `=_rc' // WFLOG-INJECTED
    if substr("`f'",1,2)=="__" continue
capture noisily __wf_progress end "rows/G0/corrections/C180_export_roundtrip.do:L8:step-if" "rows/G0/corrections/C180_export_roundtrip.do:L7:iteration-body" "statement" 1 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C180_export_roundtrip.do:L9:step-local" "rows/G0/corrections/C180_export_roundtrip.do:L7:iteration-body" "statement" 2 9 `=_rc' // WFLOG-INJECTED
    local stem=subinstr("`f'",".dta","",.)
capture noisily __wf_progress end "rows/G0/corrections/C180_export_roundtrip.do:L9:step-local" "rows/G0/corrections/C180_export_roundtrip.do:L7:iteration-body" "statement" 2 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C180_export_roundtrip.do:L10:step-use" "rows/G0/corrections/C180_export_roundtrip.do:L7:iteration-body" "statement" 3 9 `=_rc' // WFLOG-INJECTED
* Uji round-trip CSV: ekspor lalu impor kembali, kemudian bandingkan jumlah baris/kolom dan nilai sebelum data asli dipulihkan. // WFDOC-INJECTED
    use "corrections/reports/`f'", clear
capture noisily __wf_progress end "rows/G0/corrections/C180_export_roundtrip.do:L10:step-use" "rows/G0/corrections/C180_export_roundtrip.do:L7:iteration-body" "statement" 3 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C180_export_roundtrip.do:L11:step-ds" "rows/G0/corrections/C180_export_roundtrip.do:L7:iteration-body" "statement" 4 9 `=_rc' // WFLOG-INJECTED
    quietly ds, has(type numeric)
capture noisily __wf_progress end "rows/G0/corrections/C180_export_roundtrip.do:L11:step-ds" "rows/G0/corrections/C180_export_roundtrip.do:L7:iteration-body" "statement" 4 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C180_export_roundtrip.do:L12:step-local" "rows/G0/corrections/C180_export_roundtrip.do:L7:iteration-body" "statement" 5 9 `=_rc' // WFLOG-INJECTED
    local numeric `r(varlist)'
capture noisily __wf_progress end "rows/G0/corrections/C180_export_roundtrip.do:L12:step-local" "rows/G0/corrections/C180_export_roundtrip.do:L7:iteration-body" "statement" 5 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C180_export_roundtrip.do:L13:step-local" "rows/G0/corrections/C180_export_roundtrip.do:L7:iteration-body" "statement" 6 9 `=_rc' // WFLOG-INJECTED
    local k : word count `numeric'
capture noisily __wf_progress end "rows/G0/corrections/C180_export_roundtrip.do:L13:step-local" "rows/G0/corrections/C180_export_roundtrip.do:L7:iteration-body" "statement" 6 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C180_export_roundtrip.do:L14:step-local" "rows/G0/corrections/C180_export_roundtrip.do:L7:iteration-body" "statement" 7 9 `=_rc' // WFLOG-INJECTED
    local n=_N
capture noisily __wf_progress end "rows/G0/corrections/C180_export_roundtrip.do:L14:step-local" "rows/G0/corrections/C180_export_roundtrip.do:L7:iteration-body" "statement" 7 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C180_export_roundtrip.do:L15:step-g0c_roundtrip" "rows/G0/corrections/C180_export_roundtrip.do:L7:iteration-body" "statement" 8 9 `=_rc' // WFLOG-INJECTED
* Jalankan uji tulis-baca CSV, cek dimensi dan nilai, lalu pulihkan data yang tersimpan sebelum uji. // WFDOC-INJECTED
    g0c_roundtrip, input("corrections/reports/`f'") output("corrections/reports/`stem'.csv")
capture noisily __wf_progress end "rows/G0/corrections/C180_export_roundtrip.do:L15:step-g0c_roundtrip" "rows/G0/corrections/C180_export_roundtrip.do:L7:iteration-body" "statement" 8 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C180_export_roundtrip.do:L16:step-post" "rows/G0/corrections/C180_export_roundtrip.do:L7:iteration-body" "statement" 9 9 `=_rc' // WFLOG-INJECTED
    post `p' ("`f'") (`n') (`n'*`k') (0) (1) (1)
capture noisily __wf_progress end "rows/G0/corrections/C180_export_roundtrip.do:L16:step-post" "rows/G0/corrections/C180_export_roundtrip.do:L7:iteration-body" "statement" 9 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/C180_export_roundtrip.do:L7:iteration-body" "rows/G0/corrections/C180_export_roundtrip.do:L7:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/corrections/C180_export_roundtrip.do:L7:step-foreach" "rows/G0/corrections/C180_export_roundtrip.do:L1:file" "loop" 7 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C180_export_roundtrip.do:L18:step-postclose" "rows/G0/corrections/C180_export_roundtrip.do:L1:file" "statement" 8 12 `=_rc' // WFLOG-INJECTED
postclose `p'
capture noisily __wf_progress end "rows/G0/corrections/C180_export_roundtrip.do:L18:step-postclose" "rows/G0/corrections/C180_export_roundtrip.do:L1:file" "statement" 8 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C180_export_roundtrip.do:L19:step-use" "rows/G0/corrections/C180_export_roundtrip.do:L1:file" "statement" 9 12 `=_rc' // WFLOG-INJECTED
use "corrections/data/C180.dta", clear
capture noisily __wf_progress end "rows/G0/corrections/C180_export_roundtrip.do:L19:step-use" "rows/G0/corrections/C180_export_roundtrip.do:L1:file" "statement" 9 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C180_export_roundtrip.do:L20:step-isid" "rows/G0/corrections/C180_export_roundtrip.do:L1:file" "statement" 10 12 `=_rc' // WFLOG-INJECTED
isid artifact
capture noisily __wf_progress end "rows/G0/corrections/C180_export_roundtrip.do:L20:step-isid" "rows/G0/corrections/C180_export_roundtrip.do:L1:file" "statement" 10 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C180_export_roundtrip.do:L21:step-export" "rows/G0/corrections/C180_export_roundtrip.do:L1:file" "statement" 11 12 `=_rc' // WFLOG-INJECTED
export delimited using "corrections/reports/csv_roundtrip_validation.csv", datafmt nolabel quote replace
capture noisily __wf_progress end "rows/G0/corrections/C180_export_roundtrip.do:L21:step-export" "rows/G0/corrections/C180_export_roundtrip.do:L1:file" "statement" 11 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C180_export_roundtrip.do:L22:step-g0c_finish" "rows/G0/corrections/C180_export_roundtrip.do:L1:file" "statement" 12 12 `=_rc' // WFLOG-INJECTED
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C180_export_roundtrip" "C180"
capture noisily __wf_progress end "rows/G0/corrections/C180_export_roundtrip.do:L22:step-g0c_finish" "rows/G0/corrections/C180_export_roundtrip.do:L1:file" "statement" 12 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/C180_export_roundtrip.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
