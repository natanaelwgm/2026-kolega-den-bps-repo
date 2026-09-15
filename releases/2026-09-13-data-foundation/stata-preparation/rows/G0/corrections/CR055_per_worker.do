* Tujuan: Tidak membuat nilai per pekerja dari val_efuvcu: Daftar aturan menandai val_efuvcu ambigu; arti atau satuannya belum diterima. r_pw_val_efuvcu tetap kosong di Stata (missing) dan file menetapkan kode status r_pw_val_efuvcu_state=9 untuk tiap tahun. Nilai kosong bukan angka nol. // WFDOC-INJECTED
* Input: corrections/data/C010.dta // WFDOC-INJECTED
* Output: corrections/data/CR055.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR055_per_worker.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR055_per_worker.do:L1:step-version" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 1 25 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/corrections/CR055_per_worker.do:L1:step-version" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 1 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR055_per_worker.do:L2:step-do" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 2 25 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/corrections/CR055_per_worker.do:L2:step-do" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 2 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR055_per_worker.do:L3:step-g0c_begin" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 3 25 `=_rc' // WFLOG-INJECTED
g0c_begin "CR055_per_worker"
capture noisily __wf_progress end "rows/G0/corrections/CR055_per_worker.do:L3:step-g0c_begin" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 3 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR055_per_worker.do:L4:step-use" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 4 25 `=_rc' // WFLOG-INJECTED
* Ambil source_year, source_row, val_efuvcu, dan kolom lain yang disebut di baris ini dari corrections/data/C010.dta; pasangan tahun dan nomor baris mengenali satu baris, bukan firmID. // WFDOC-INJECTED
use source_year source_row val_efuvcu using "corrections/data/C010.dta", clear
capture noisily __wf_progress end "rows/G0/corrections/CR055_per_worker.do:L4:step-use" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 4 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR055_per_worker.do:L5:step-merge" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 5 25 `=_rc' // WFLOG-INJECTED
* Pasangkan baris pada kunci tahun dan nomor baris; `1:1` menolak kunci ganda dan `assert(match)` menghentikan proses jika pasangan baris tidak lengkap. Kunci ini bukan firmID. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/C010.dta", assert(match) nogen keepusing(workers)
capture noisily __wf_progress end "rows/G0/corrections/CR055_per_worker.do:L5:step-merge" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 5 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR055_per_worker.do:L6:step-generate" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 6 25 `=_rc' // WFLOG-INJECTED
* Mulai r_pw_val_efuvcu sebagai missing; file ini tidak berisi rumus yang mengisinya. // WFDOC-INJECTED
generate double r_pw_val_efuvcu=.
capture noisily __wf_progress end "rows/G0/corrections/CR055_per_worker.do:L6:step-generate" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 6 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR055_per_worker.do:L7:step-generate" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 7 25 `=_rc' // WFLOG-INJECTED
* Daftar aturan menandai val_efuvcu ambigu; arti atau satuannya belum diterima. File ini tidak menghitung turunan; nilai tetap kosong di Stata (missing) dan status per tahun ditetapkan di bawah. // WFDOC-INJECTED
generate byte r_pw_val_efuvcu_state=9
capture noisily __wf_progress end "rows/G0/corrections/CR055_per_worker.do:L7:step-generate" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 7 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR055_per_worker.do:L8:step-replace" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 8 25 `=_rc' // WFLOG-INJECTED
* Tahun 2010: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_efuvcu ambigu; arti atau satuannya belum diterima. r_pw_val_efuvcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_pw_val_efuvcu_state=9 if source_year==2010
capture noisily __wf_progress end "rows/G0/corrections/CR055_per_worker.do:L8:step-replace" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 8 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR055_per_worker.do:L9:step-replace" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 9 25 `=_rc' // WFLOG-INJECTED
* Tahun 2011: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_efuvcu ambigu; arti atau satuannya belum diterima. r_pw_val_efuvcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_pw_val_efuvcu_state=9 if source_year==2011
capture noisily __wf_progress end "rows/G0/corrections/CR055_per_worker.do:L9:step-replace" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 9 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR055_per_worker.do:L10:step-replace" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 10 25 `=_rc' // WFLOG-INJECTED
* Tahun 2012: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_efuvcu ambigu; arti atau satuannya belum diterima. r_pw_val_efuvcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_pw_val_efuvcu_state=9 if source_year==2012
capture noisily __wf_progress end "rows/G0/corrections/CR055_per_worker.do:L10:step-replace" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 10 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR055_per_worker.do:L11:step-replace" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 11 25 `=_rc' // WFLOG-INJECTED
* Tahun 2013: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_efuvcu ambigu; arti atau satuannya belum diterima. r_pw_val_efuvcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_pw_val_efuvcu_state=9 if source_year==2013
capture noisily __wf_progress end "rows/G0/corrections/CR055_per_worker.do:L11:step-replace" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 11 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR055_per_worker.do:L12:step-replace" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 12 25 `=_rc' // WFLOG-INJECTED
* Tahun 2014: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_efuvcu ambigu; arti atau satuannya belum diterima. r_pw_val_efuvcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_pw_val_efuvcu_state=9 if source_year==2014
capture noisily __wf_progress end "rows/G0/corrections/CR055_per_worker.do:L12:step-replace" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 12 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR055_per_worker.do:L13:step-replace" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 13 25 `=_rc' // WFLOG-INJECTED
* Tahun 2015: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_efuvcu ambigu; arti atau satuannya belum diterima. r_pw_val_efuvcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_pw_val_efuvcu_state=9 if source_year==2015
capture noisily __wf_progress end "rows/G0/corrections/CR055_per_worker.do:L13:step-replace" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 13 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR055_per_worker.do:L14:step-replace" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 14 25 `=_rc' // WFLOG-INJECTED
* Tahun 2017: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_efuvcu ambigu; arti atau satuannya belum diterima. r_pw_val_efuvcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_pw_val_efuvcu_state=9 if source_year==2017
capture noisily __wf_progress end "rows/G0/corrections/CR055_per_worker.do:L14:step-replace" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 14 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR055_per_worker.do:L15:step-replace" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 15 25 `=_rc' // WFLOG-INJECTED
* Tahun 2018: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_efuvcu ambigu; arti atau satuannya belum diterima. r_pw_val_efuvcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_pw_val_efuvcu_state=9 if source_year==2018
capture noisily __wf_progress end "rows/G0/corrections/CR055_per_worker.do:L15:step-replace" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 15 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR055_per_worker.do:L16:step-replace" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 16 25 `=_rc' // WFLOG-INJECTED
* Tahun 2019: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_efuvcu ambigu; arti atau satuannya belum diterima. r_pw_val_efuvcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_pw_val_efuvcu_state=9 if source_year==2019
capture noisily __wf_progress end "rows/G0/corrections/CR055_per_worker.do:L16:step-replace" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 16 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR055_per_worker.do:L17:step-replace" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 17 25 `=_rc' // WFLOG-INJECTED
* Tahun 2020: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_efuvcu ambigu; arti atau satuannya belum diterima. r_pw_val_efuvcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_pw_val_efuvcu_state=9 if source_year==2020
capture noisily __wf_progress end "rows/G0/corrections/CR055_per_worker.do:L17:step-replace" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 17 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR055_per_worker.do:L18:step-replace" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 18 25 `=_rc' // WFLOG-INJECTED
* Tahun 2021: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_efuvcu ambigu; arti atau satuannya belum diterima. r_pw_val_efuvcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_pw_val_efuvcu_state=9 if source_year==2021
capture noisily __wf_progress end "rows/G0/corrections/CR055_per_worker.do:L18:step-replace" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 18 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR055_per_worker.do:L19:step-replace" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 19 25 `=_rc' // WFLOG-INJECTED
* Tahun 2022: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_efuvcu ambigu; arti atau satuannya belum diterima. r_pw_val_efuvcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_pw_val_efuvcu_state=9 if source_year==2022
capture noisily __wf_progress end "rows/G0/corrections/CR055_per_worker.do:L19:step-replace" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 19 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR055_per_worker.do:L20:step-assert" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 20 25 `=_rc' // WFLOG-INJECTED
* Pastikan r_pw_val_efuvcu tetap kosong di Stata (missing) pada status 8/9; kode ini menangkap angka yang terisi tanpa dasar hitung. // WFDOC-INJECTED
assert missing(r_pw_val_efuvcu) if inlist(r_pw_val_efuvcu_state,8,9)
capture noisily __wf_progress end "rows/G0/corrections/CR055_per_worker.do:L20:step-assert" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 20 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR055_per_worker.do:L21:step-keep" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 21 25 `=_rc' // WFLOG-INJECTED
* Simpan hanya kunci baris, r_pw_val_efuvcu, dan statusnya agar keluaran tidak membawa kolom sumber lain. // WFDOC-INJECTED
keep source_year source_row r_pw_val_efuvcu r_pw_val_efuvcu_state
capture noisily __wf_progress end "rows/G0/corrections/CR055_per_worker.do:L21:step-keep" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 21 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR055_per_worker.do:L22:step-order" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 22 25 `=_rc' // WFLOG-INJECTED
order source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/CR055_per_worker.do:L22:step-order" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 22 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR055_per_worker.do:L23:step-isid" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 23 25 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/CR055_per_worker.do:L23:step-isid" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 23 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR055_per_worker.do:L24:step-assert" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 24 25 `=_rc' // WFLOG-INJECTED
assert _N==33049
capture noisily __wf_progress end "rows/G0/corrections/CR055_per_worker.do:L24:step-assert" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 24 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR055_per_worker.do:L25:step-g0c_finish" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 25 25 `=_rc' // WFLOG-INJECTED
* Tutup log, simpan tabel koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "CR055_per_worker" "CR055"
capture noisily __wf_progress end "rows/G0/corrections/CR055_per_worker.do:L25:step-g0c_finish" "rows/G0/corrections/CR055_per_worker.do:L1:file" "statement" 25 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/CR055_per_worker.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
