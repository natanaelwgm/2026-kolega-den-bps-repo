* Tujuan: Jumlahkan komponen emisi bahan bakar yang tersedia dan tidak negatif untuk membentuk total cakupan 1; jumlah komponen tetap dicatat. // WFDOC-INJECTED
* Input: corrections/data/C010.dta // WFDOC-INJECTED
* Output: corrections/data/CT004.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT004_recompute_total.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT004_recompute_total.do:L1:step-version" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 1 21 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/corrections/CT004_recompute_total.do:L1:step-version" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 1 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT004_recompute_total.do:L2:step-do" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 2 21 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/corrections/CT004_recompute_total.do:L2:step-do" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 2 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT004_recompute_total.do:L3:step-g0c_begin" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 3 21 `=_rc' // WFLOG-INJECTED
g0c_begin "CT004_recompute_total"
capture noisily __wf_progress end "rows/G0/corrections/CT004_recompute_total.do:L3:step-g0c_begin" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 3 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT004_recompute_total.do:L4:step-use" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 4 21 `=_rc' // WFLOG-INJECTED
use source_year source_row co2_diesel_s1 co2_petrol_s1 co2_kerosene_s1 co2_coal_s1 co2_lpg_s1 co2_citygas_s1 co2_othergas_s1 co2_coalbriq_s1 co2_coke_s1 using "corrections/data/C010.dta", clear
capture noisily __wf_progress end "rows/G0/corrections/CT004_recompute_total.do:L4:step-use" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 4 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT004_recompute_total.do:L5:step-generate" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 5 21 `=_rc' // WFLOG-INJECTED
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component0=co2_diesel_s1 if co2_diesel_s1>=0 & !missing(co2_diesel_s1)
capture noisily __wf_progress end "rows/G0/corrections/CT004_recompute_total.do:L5:step-generate" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 5 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT004_recompute_total.do:L6:step-generate" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 6 21 `=_rc' // WFLOG-INJECTED
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component1=co2_petrol_s1 if co2_petrol_s1>=0 & !missing(co2_petrol_s1)
capture noisily __wf_progress end "rows/G0/corrections/CT004_recompute_total.do:L6:step-generate" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 6 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT004_recompute_total.do:L7:step-generate" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 7 21 `=_rc' // WFLOG-INJECTED
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component2=co2_kerosene_s1 if co2_kerosene_s1>=0 & !missing(co2_kerosene_s1)
capture noisily __wf_progress end "rows/G0/corrections/CT004_recompute_total.do:L7:step-generate" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 7 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT004_recompute_total.do:L8:step-generate" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 8 21 `=_rc' // WFLOG-INJECTED
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component3=co2_coal_s1 if co2_coal_s1>=0 & !missing(co2_coal_s1)
capture noisily __wf_progress end "rows/G0/corrections/CT004_recompute_total.do:L8:step-generate" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 8 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT004_recompute_total.do:L9:step-generate" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 9 21 `=_rc' // WFLOG-INJECTED
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component4=co2_lpg_s1 if co2_lpg_s1>=0 & !missing(co2_lpg_s1)
capture noisily __wf_progress end "rows/G0/corrections/CT004_recompute_total.do:L9:step-generate" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 9 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT004_recompute_total.do:L10:step-generate" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 10 21 `=_rc' // WFLOG-INJECTED
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component5=co2_citygas_s1 if co2_citygas_s1>=0 & !missing(co2_citygas_s1)
capture noisily __wf_progress end "rows/G0/corrections/CT004_recompute_total.do:L10:step-generate" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 10 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT004_recompute_total.do:L11:step-generate" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 11 21 `=_rc' // WFLOG-INJECTED
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component6=co2_othergas_s1 if co2_othergas_s1>=0 & !missing(co2_othergas_s1)
capture noisily __wf_progress end "rows/G0/corrections/CT004_recompute_total.do:L11:step-generate" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 11 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT004_recompute_total.do:L12:step-generate" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 12 21 `=_rc' // WFLOG-INJECTED
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component7=co2_coalbriq_s1 if co2_coalbriq_s1>=0 & !missing(co2_coalbriq_s1)
capture noisily __wf_progress end "rows/G0/corrections/CT004_recompute_total.do:L12:step-generate" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 12 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT004_recompute_total.do:L13:step-generate" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 13 21 `=_rc' // WFLOG-INJECTED
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component8=co2_coke_s1 if co2_coke_s1>=0 & !missing(co2_coke_s1)
capture noisily __wf_progress end "rows/G0/corrections/CT004_recompute_total.do:L13:step-generate" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 13 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT004_recompute_total.do:L14:step-egen" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 14 21 `=_rc' // WFLOG-INJECTED
egen byte r_co2_scope1_s1_n=rownonmiss(__component0 __component1 __component2 __component3 __component4 __component5 __component6 __component7 __component8)
capture noisily __wf_progress end "rows/G0/corrections/CT004_recompute_total.do:L14:step-egen" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 14 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT004_recompute_total.do:L15:step-egen" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 15 21 `=_rc' // WFLOG-INJECTED
egen double r_co2_scope1_s1=rowtotal(__component0 __component1 __component2 __component3 __component4 __component5 __component6 __component7 __component8), missing
capture noisily __wf_progress end "rows/G0/corrections/CT004_recompute_total.do:L15:step-egen" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 15 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT004_recompute_total.do:L16:step-assert" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 16 21 `=_rc' // WFLOG-INJECTED
assert missing(r_co2_scope1_s1) if r_co2_scope1_s1_n==0
capture noisily __wf_progress end "rows/G0/corrections/CT004_recompute_total.do:L16:step-assert" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 16 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT004_recompute_total.do:L17:step-keep" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 17 21 `=_rc' // WFLOG-INJECTED
keep source_year source_row r_co2_scope1_s1 r_co2_scope1_s1_n
capture noisily __wf_progress end "rows/G0/corrections/CT004_recompute_total.do:L17:step-keep" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 17 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT004_recompute_total.do:L18:step-order" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 18 21 `=_rc' // WFLOG-INJECTED
order source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/CT004_recompute_total.do:L18:step-order" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 18 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT004_recompute_total.do:L19:step-isid" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 19 21 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/CT004_recompute_total.do:L19:step-isid" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 19 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT004_recompute_total.do:L20:step-assert" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 20 21 `=_rc' // WFLOG-INJECTED
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
capture noisily __wf_progress end "rows/G0/corrections/CT004_recompute_total.do:L20:step-assert" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 20 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT004_recompute_total.do:L21:step-g0c_finish" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 21 21 `=_rc' // WFLOG-INJECTED
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "CT004_recompute_total" "CT004"
capture noisily __wf_progress end "rows/G0/corrections/CT004_recompute_total.do:L21:step-g0c_finish" "rows/G0/corrections/CT004_recompute_total.do:L1:file" "statement" 21 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/CT004_recompute_total.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
