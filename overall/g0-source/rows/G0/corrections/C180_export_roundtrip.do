* Tujuan: Uji ekspor-impor CSV dengan memeriksa jumlah baris/kolom dan membandingkan kembali semua nilai sebelum memulihkan data awal. // WFDOC-INJECTED
* Input: corrections/reports/annual_sample.dta; corrections/reports/annual_schema_mapping.dta; dan 28 masukan lain // WFDOC-INJECTED
* Output: corrections/reports/annual_sample.csv; corrections/reports/annual_schema_mapping.csv; dan 30 masukan lain // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "C180_export_roundtrip"
local datasets : dir "corrections/reports" files "*.dta"
tempname p
postfile `p' str120 artifact long rows double numeric_cells double different_cells byte all_keys_exact byte roundtrip_pass using "corrections/data/C180.dta", replace
* Ulangi blok untuk tiap f dalam daftar local datasets. // WFDOC-INJECTED
foreach f of local datasets {
    if substr("`f'",1,2)=="__" continue
    local stem=subinstr("`f'",".dta","",.)
* Uji round-trip CSV: ekspor lalu impor kembali, kemudian bandingkan jumlah baris/kolom dan nilai sebelum data asli dipulihkan. // WFDOC-INJECTED
    use "corrections/reports/`f'", clear
    quietly ds, has(type numeric)
    local numeric `r(varlist)'
    local k : word count `numeric'
    local n=_N
* Jalankan uji tulis-baca CSV, cek dimensi dan nilai, lalu pulihkan data yang tersimpan sebelum uji. // WFDOC-INJECTED
    g0c_roundtrip, input("corrections/reports/`f'") output("corrections/reports/`stem'.csv")
    post `p' ("`f'") (`n') (`n'*`k') (0) (1) (1)
}
postclose `p'
use "corrections/data/C180.dta", clear
isid artifact
export delimited using "corrections/reports/csv_roundtrip_validation.csv", datafmt nolabel quote replace
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C180_export_roundtrip" "C180"
