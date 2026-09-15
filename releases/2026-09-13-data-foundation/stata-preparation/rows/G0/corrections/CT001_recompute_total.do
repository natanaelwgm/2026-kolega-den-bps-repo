* Tujuan: Jumlahkan komponen bahan bakar GJ yang ada dan tidak negatif; simpan berapa komponen yang tersedia agar total parsial dapat dibedakan dari total lengkap. // WFDOC-INJECTED
* Input: corrections/data/C010.dta // WFDOC-INJECTED
* Output: corrections/data/CT001.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT001_recompute_total.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT001_recompute_total.do:L1:step-version" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 1 21 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/corrections/CT001_recompute_total.do:L1:step-version" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 1 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT001_recompute_total.do:L2:step-do" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 2 21 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/corrections/CT001_recompute_total.do:L2:step-do" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 2 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT001_recompute_total.do:L3:step-g0c_begin" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 3 21 `=_rc' // WFLOG-INJECTED
g0c_begin "CT001_recompute_total"
capture noisily __wf_progress end "rows/G0/corrections/CT001_recompute_total.do:L3:step-g0c_begin" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 3 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT001_recompute_total.do:L4:step-use" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 4 21 `=_rc' // WFLOG-INJECTED
use source_year source_row gj_diesel gj_petrol gj_kerosene gj_coal gj_lpg gj_citygas gj_othergas gj_coalbriq gj_coke using "corrections/data/C010.dta", clear
capture noisily __wf_progress end "rows/G0/corrections/CT001_recompute_total.do:L4:step-use" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 4 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT001_recompute_total.do:L5:step-generate" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 5 21 `=_rc' // WFLOG-INJECTED
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component0=gj_diesel if gj_diesel>=0 & !missing(gj_diesel)
capture noisily __wf_progress end "rows/G0/corrections/CT001_recompute_total.do:L5:step-generate" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 5 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT001_recompute_total.do:L6:step-generate" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 6 21 `=_rc' // WFLOG-INJECTED
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component1=gj_petrol if gj_petrol>=0 & !missing(gj_petrol)
capture noisily __wf_progress end "rows/G0/corrections/CT001_recompute_total.do:L6:step-generate" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 6 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT001_recompute_total.do:L7:step-generate" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 7 21 `=_rc' // WFLOG-INJECTED
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component2=gj_kerosene if gj_kerosene>=0 & !missing(gj_kerosene)
capture noisily __wf_progress end "rows/G0/corrections/CT001_recompute_total.do:L7:step-generate" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 7 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT001_recompute_total.do:L8:step-generate" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 8 21 `=_rc' // WFLOG-INJECTED
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component3=gj_coal if gj_coal>=0 & !missing(gj_coal)
capture noisily __wf_progress end "rows/G0/corrections/CT001_recompute_total.do:L8:step-generate" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 8 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT001_recompute_total.do:L9:step-generate" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 9 21 `=_rc' // WFLOG-INJECTED
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component4=gj_lpg if gj_lpg>=0 & !missing(gj_lpg)
capture noisily __wf_progress end "rows/G0/corrections/CT001_recompute_total.do:L9:step-generate" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 9 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT001_recompute_total.do:L10:step-generate" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 10 21 `=_rc' // WFLOG-INJECTED
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component5=gj_citygas if gj_citygas>=0 & !missing(gj_citygas)
capture noisily __wf_progress end "rows/G0/corrections/CT001_recompute_total.do:L10:step-generate" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 10 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT001_recompute_total.do:L11:step-generate" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 11 21 `=_rc' // WFLOG-INJECTED
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component6=gj_othergas if gj_othergas>=0 & !missing(gj_othergas)
capture noisily __wf_progress end "rows/G0/corrections/CT001_recompute_total.do:L11:step-generate" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 11 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT001_recompute_total.do:L12:step-generate" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 12 21 `=_rc' // WFLOG-INJECTED
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component7=gj_coalbriq if gj_coalbriq>=0 & !missing(gj_coalbriq)
capture noisily __wf_progress end "rows/G0/corrections/CT001_recompute_total.do:L12:step-generate" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 12 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT001_recompute_total.do:L13:step-generate" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 13 21 `=_rc' // WFLOG-INJECTED
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component8=gj_coke if gj_coke>=0 & !missing(gj_coke)
capture noisily __wf_progress end "rows/G0/corrections/CT001_recompute_total.do:L13:step-generate" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 13 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT001_recompute_total.do:L14:step-egen" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 14 21 `=_rc' // WFLOG-INJECTED
egen byte r_gj_fuel_s1_n=rownonmiss(__component0 __component1 __component2 __component3 __component4 __component5 __component6 __component7 __component8)
capture noisily __wf_progress end "rows/G0/corrections/CT001_recompute_total.do:L14:step-egen" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 14 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT001_recompute_total.do:L15:step-egen" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 15 21 `=_rc' // WFLOG-INJECTED
egen double r_gj_fuel_s1=rowtotal(__component0 __component1 __component2 __component3 __component4 __component5 __component6 __component7 __component8), missing
capture noisily __wf_progress end "rows/G0/corrections/CT001_recompute_total.do:L15:step-egen" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 15 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT001_recompute_total.do:L16:step-assert" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 16 21 `=_rc' // WFLOG-INJECTED
assert missing(r_gj_fuel_s1) if r_gj_fuel_s1_n==0
capture noisily __wf_progress end "rows/G0/corrections/CT001_recompute_total.do:L16:step-assert" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 16 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT001_recompute_total.do:L17:step-keep" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 17 21 `=_rc' // WFLOG-INJECTED
keep source_year source_row r_gj_fuel_s1 r_gj_fuel_s1_n
capture noisily __wf_progress end "rows/G0/corrections/CT001_recompute_total.do:L17:step-keep" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 17 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT001_recompute_total.do:L18:step-order" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 18 21 `=_rc' // WFLOG-INJECTED
order source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/CT001_recompute_total.do:L18:step-order" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 18 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT001_recompute_total.do:L19:step-isid" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 19 21 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/CT001_recompute_total.do:L19:step-isid" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 19 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT001_recompute_total.do:L20:step-assert" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 20 21 `=_rc' // WFLOG-INJECTED
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
capture noisily __wf_progress end "rows/G0/corrections/CT001_recompute_total.do:L20:step-assert" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 20 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT001_recompute_total.do:L21:step-g0c_finish" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 21 21 `=_rc' // WFLOG-INJECTED
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "CT001_recompute_total" "CT001"
capture noisily __wf_progress end "rows/G0/corrections/CT001_recompute_total.do:L21:step-g0c_finish" "rows/G0/corrections/CT001_recompute_total.do:L1:file" "statement" 21 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/CT001_recompute_total.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
