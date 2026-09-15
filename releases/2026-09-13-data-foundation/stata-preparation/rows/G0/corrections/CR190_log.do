* Tujuan: Tidak membuat log natural dari val_csfpcu: Daftar aturan menandai val_csfpcu ambigu; arti atau satuannya belum diterima. r_ln_val_csfpcu tetap kosong di Stata (missing) dan file menetapkan kode status r_ln_val_csfpcu_state=9 untuk tiap tahun. Nilai kosong bukan angka nol. // WFDOC-INJECTED
* Input: corrections/data/C010.dta // WFDOC-INJECTED
* Output: corrections/data/CR190.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR190_log.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR190_log.do:L1:step-version" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 1 24 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/corrections/CR190_log.do:L1:step-version" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 1 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR190_log.do:L2:step-do" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 2 24 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/corrections/CR190_log.do:L2:step-do" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 2 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR190_log.do:L3:step-g0c_begin" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 3 24 `=_rc' // WFLOG-INJECTED
g0c_begin "CR190_log"
capture noisily __wf_progress end "rows/G0/corrections/CR190_log.do:L3:step-g0c_begin" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 3 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR190_log.do:L4:step-use" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 4 24 `=_rc' // WFLOG-INJECTED
* Ambil source_year, source_row, val_csfpcu, dan kolom lain yang disebut di baris ini dari corrections/data/C010.dta; pasangan tahun dan nomor baris mengenali satu baris, bukan firmID. // WFDOC-INJECTED
use source_year source_row val_csfpcu using "corrections/data/C010.dta", clear
capture noisily __wf_progress end "rows/G0/corrections/CR190_log.do:L4:step-use" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 4 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR190_log.do:L5:step-generate" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 5 24 `=_rc' // WFLOG-INJECTED
* Mulai r_ln_val_csfpcu sebagai missing; file ini tidak berisi rumus yang mengisinya. // WFDOC-INJECTED
generate double r_ln_val_csfpcu=.
capture noisily __wf_progress end "rows/G0/corrections/CR190_log.do:L5:step-generate" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 5 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR190_log.do:L6:step-generate" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 6 24 `=_rc' // WFLOG-INJECTED
* Daftar aturan menandai val_csfpcu ambigu; arti atau satuannya belum diterima. File ini tidak menghitung turunan; nilai tetap kosong di Stata (missing) dan status per tahun ditetapkan di bawah. // WFDOC-INJECTED
generate byte r_ln_val_csfpcu_state=9
capture noisily __wf_progress end "rows/G0/corrections/CR190_log.do:L6:step-generate" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 6 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR190_log.do:L7:step-replace" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 7 24 `=_rc' // WFLOG-INJECTED
* Tahun 2010: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_csfpcu ambigu; arti atau satuannya belum diterima. r_ln_val_csfpcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_ln_val_csfpcu_state=9 if source_year==2010
capture noisily __wf_progress end "rows/G0/corrections/CR190_log.do:L7:step-replace" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 7 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR190_log.do:L8:step-replace" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 8 24 `=_rc' // WFLOG-INJECTED
* Tahun 2011: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_csfpcu ambigu; arti atau satuannya belum diterima. r_ln_val_csfpcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_ln_val_csfpcu_state=9 if source_year==2011
capture noisily __wf_progress end "rows/G0/corrections/CR190_log.do:L8:step-replace" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 8 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR190_log.do:L9:step-replace" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 9 24 `=_rc' // WFLOG-INJECTED
* Tahun 2012: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_csfpcu ambigu; arti atau satuannya belum diterima. r_ln_val_csfpcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_ln_val_csfpcu_state=9 if source_year==2012
capture noisily __wf_progress end "rows/G0/corrections/CR190_log.do:L9:step-replace" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 9 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR190_log.do:L10:step-replace" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 10 24 `=_rc' // WFLOG-INJECTED
* Tahun 2013: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_csfpcu ambigu; arti atau satuannya belum diterima. r_ln_val_csfpcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_ln_val_csfpcu_state=9 if source_year==2013
capture noisily __wf_progress end "rows/G0/corrections/CR190_log.do:L10:step-replace" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 10 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR190_log.do:L11:step-replace" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 11 24 `=_rc' // WFLOG-INJECTED
* Tahun 2014: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_csfpcu ambigu; arti atau satuannya belum diterima. r_ln_val_csfpcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_ln_val_csfpcu_state=9 if source_year==2014
capture noisily __wf_progress end "rows/G0/corrections/CR190_log.do:L11:step-replace" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 11 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR190_log.do:L12:step-replace" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 12 24 `=_rc' // WFLOG-INJECTED
* Tahun 2015: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_csfpcu ambigu; arti atau satuannya belum diterima. r_ln_val_csfpcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_ln_val_csfpcu_state=9 if source_year==2015
capture noisily __wf_progress end "rows/G0/corrections/CR190_log.do:L12:step-replace" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 12 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR190_log.do:L13:step-replace" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 13 24 `=_rc' // WFLOG-INJECTED
* Tahun 2017: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_csfpcu ambigu; arti atau satuannya belum diterima. r_ln_val_csfpcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_ln_val_csfpcu_state=9 if source_year==2017
capture noisily __wf_progress end "rows/G0/corrections/CR190_log.do:L13:step-replace" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 13 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR190_log.do:L14:step-replace" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 14 24 `=_rc' // WFLOG-INJECTED
* Tahun 2018: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_csfpcu ambigu; arti atau satuannya belum diterima. r_ln_val_csfpcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_ln_val_csfpcu_state=9 if source_year==2018
capture noisily __wf_progress end "rows/G0/corrections/CR190_log.do:L14:step-replace" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 14 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR190_log.do:L15:step-replace" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 15 24 `=_rc' // WFLOG-INJECTED
* Tahun 2019: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_csfpcu ambigu; arti atau satuannya belum diterima. r_ln_val_csfpcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_ln_val_csfpcu_state=9 if source_year==2019
capture noisily __wf_progress end "rows/G0/corrections/CR190_log.do:L15:step-replace" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 15 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR190_log.do:L16:step-replace" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 16 24 `=_rc' // WFLOG-INJECTED
* Tahun 2020: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_csfpcu ambigu; arti atau satuannya belum diterima. r_ln_val_csfpcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_ln_val_csfpcu_state=9 if source_year==2020
capture noisily __wf_progress end "rows/G0/corrections/CR190_log.do:L16:step-replace" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 16 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR190_log.do:L17:step-replace" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 17 24 `=_rc' // WFLOG-INJECTED
* Tahun 2021: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_csfpcu ambigu; arti atau satuannya belum diterima. r_ln_val_csfpcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_ln_val_csfpcu_state=9 if source_year==2021
capture noisily __wf_progress end "rows/G0/corrections/CR190_log.do:L17:step-replace" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 17 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR190_log.do:L18:step-replace" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 18 24 `=_rc' // WFLOG-INJECTED
* Tahun 2022: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_csfpcu ambigu; arti atau satuannya belum diterima. r_ln_val_csfpcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_ln_val_csfpcu_state=9 if source_year==2022
capture noisily __wf_progress end "rows/G0/corrections/CR190_log.do:L18:step-replace" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 18 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR190_log.do:L19:step-assert" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 19 24 `=_rc' // WFLOG-INJECTED
* Pastikan r_ln_val_csfpcu tetap kosong di Stata (missing) pada status 8/9; kode ini menangkap angka yang terisi tanpa dasar hitung. // WFDOC-INJECTED
assert missing(r_ln_val_csfpcu) if inlist(r_ln_val_csfpcu_state,8,9)
capture noisily __wf_progress end "rows/G0/corrections/CR190_log.do:L19:step-assert" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 19 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR190_log.do:L20:step-keep" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 20 24 `=_rc' // WFLOG-INJECTED
* Simpan hanya kunci baris, r_ln_val_csfpcu, dan statusnya agar keluaran tidak membawa kolom sumber lain. // WFDOC-INJECTED
keep source_year source_row r_ln_val_csfpcu r_ln_val_csfpcu_state
capture noisily __wf_progress end "rows/G0/corrections/CR190_log.do:L20:step-keep" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 20 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR190_log.do:L21:step-order" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 21 24 `=_rc' // WFLOG-INJECTED
order source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/CR190_log.do:L21:step-order" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 21 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR190_log.do:L22:step-isid" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 22 24 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/CR190_log.do:L22:step-isid" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 22 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR190_log.do:L23:step-assert" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 23 24 `=_rc' // WFLOG-INJECTED
assert _N==33049
capture noisily __wf_progress end "rows/G0/corrections/CR190_log.do:L23:step-assert" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 23 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR190_log.do:L24:step-g0c_finish" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 24 24 `=_rc' // WFLOG-INJECTED
* Tutup log, simpan tabel koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "CR190_log" "CR190"
capture noisily __wf_progress end "rows/G0/corrections/CR190_log.do:L24:step-g0c_finish" "rows/G0/corrections/CR190_log.do:L1:file" "statement" 24 24 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/CR190_log.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
