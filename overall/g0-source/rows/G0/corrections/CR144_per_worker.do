* Tujuan: Tidak membuat nilai per pekerja dari val_znivcu: Daftar aturan menandai val_znivcu ambigu; arti atau satuannya belum diterima. r_pw_val_znivcu tetap kosong di Stata (missing) dan file menetapkan kode status r_pw_val_znivcu_state=9 untuk tiap tahun. Nilai kosong bukan angka nol. // WFDOC-INJECTED
* Input: corrections/data/C010.dta // WFDOC-INJECTED
* Output: corrections/data/CR144.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "CR144_per_worker"
* Ambil source_year, source_row, val_znivcu, dan kolom lain yang disebut di baris ini dari corrections/data/C010.dta; pasangan tahun dan nomor baris mengenali satu baris, bukan firmID. // WFDOC-INJECTED
use source_year source_row val_znivcu using "corrections/data/C010.dta", clear
* Pasangkan baris pada kunci tahun dan nomor baris; `1:1` menolak kunci ganda dan `assert(match)` menghentikan proses jika pasangan baris tidak lengkap. Kunci ini bukan firmID. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/C010.dta", assert(match) nogen keepusing(workers)
* Mulai r_pw_val_znivcu sebagai missing; file ini tidak berisi rumus yang mengisinya. // WFDOC-INJECTED
generate double r_pw_val_znivcu=.
* Daftar aturan menandai val_znivcu ambigu; arti atau satuannya belum diterima. File ini tidak menghitung turunan; nilai tetap kosong di Stata (missing) dan status per tahun ditetapkan di bawah. // WFDOC-INJECTED
generate byte r_pw_val_znivcu_state=9
* Tahun 2010: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_znivcu ambigu; arti atau satuannya belum diterima. r_pw_val_znivcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_pw_val_znivcu_state=9 if source_year==2010
* Tahun 2011: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_znivcu ambigu; arti atau satuannya belum diterima. r_pw_val_znivcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_pw_val_znivcu_state=9 if source_year==2011
* Tahun 2012: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_znivcu ambigu; arti atau satuannya belum diterima. r_pw_val_znivcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_pw_val_znivcu_state=9 if source_year==2012
* Tahun 2013: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_znivcu ambigu; arti atau satuannya belum diterima. r_pw_val_znivcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_pw_val_znivcu_state=9 if source_year==2013
* Tahun 2014: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_znivcu ambigu; arti atau satuannya belum diterima. r_pw_val_znivcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_pw_val_znivcu_state=9 if source_year==2014
* Tahun 2015: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_znivcu ambigu; arti atau satuannya belum diterima. r_pw_val_znivcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_pw_val_znivcu_state=9 if source_year==2015
* Tahun 2017: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_znivcu ambigu; arti atau satuannya belum diterima. r_pw_val_znivcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_pw_val_znivcu_state=9 if source_year==2017
* Tahun 2018: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_znivcu ambigu; arti atau satuannya belum diterima. r_pw_val_znivcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_pw_val_znivcu_state=9 if source_year==2018
* Tahun 2019: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_znivcu ambigu; arti atau satuannya belum diterima. r_pw_val_znivcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_pw_val_znivcu_state=9 if source_year==2019
* Tahun 2020: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_znivcu ambigu; arti atau satuannya belum diterima. r_pw_val_znivcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_pw_val_znivcu_state=9 if source_year==2020
* Tahun 2021: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_znivcu ambigu; arti atau satuannya belum diterima. r_pw_val_znivcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_pw_val_znivcu_state=9 if source_year==2021
* Tahun 2022: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_znivcu ambigu; arti atau satuannya belum diterima. r_pw_val_znivcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_pw_val_znivcu_state=9 if source_year==2022
* Pastikan r_pw_val_znivcu tetap kosong di Stata (missing) pada status 8/9; kode ini menangkap angka yang terisi tanpa dasar hitung. // WFDOC-INJECTED
assert missing(r_pw_val_znivcu) if inlist(r_pw_val_znivcu_state,8,9)
* Simpan hanya kunci baris, r_pw_val_znivcu, dan statusnya agar keluaran tidak membawa kolom sumber lain. // WFDOC-INJECTED
keep source_year source_row r_pw_val_znivcu r_pw_val_znivcu_state
order source_year source_row
isid source_year source_row
assert _N==33049
* Tutup log, simpan tabel koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "CR144_per_worker" "CR144"
