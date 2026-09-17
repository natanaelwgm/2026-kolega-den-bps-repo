* Tujuan: Jalankan perintah yang tercantum di file ini pada data atau argumen yang disediakan pemanggilnya. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: corrections/reports/dictionary_all_columns.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
* Schema comparison state: one row per original variable, in original order.
args output_path
tempname schema
postfile `schema' int position str32 variable_name str12 storage_type str49 display_format str80 variable_label str32 value_label using "`output_path'", replace
local j=0
* Ulangi blok sesuai rentang atau daftar yang ditetapkan di baris ini. // WFDOC-INJECTED
foreach v of varlist _all {
    local ++j
    local storage : type `v'
    local fmt : format `v'
    local lab : variable label `v'
    local vl : value label `v'
    post `schema' (`j') ("`v'") ("`storage'") ("`fmt'") (`"`lab'"') ("`vl'")
}
postclose `schema'
