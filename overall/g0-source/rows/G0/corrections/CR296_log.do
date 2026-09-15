* Tujuan: Tidak membuat log natural dari val_yprvcu: Daftar aturan menandai val_yprvcu ambigu; arti atau satuannya belum diterima. r_ln_val_yprvcu tetap kosong di Stata (missing) dan file menetapkan kode status r_ln_val_yprvcu_state=9 untuk tiap tahun. Nilai kosong bukan angka nol. // WFDOC-INJECTED
* Input: corrections/data/C010.dta // WFDOC-INJECTED
* Output: corrections/data/CR296.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "CR296_log"
* Ambil source_year, source_row, val_yprvcu, dan kolom lain yang disebut di baris ini dari corrections/data/C010.dta; pasangan tahun dan nomor baris mengenali satu baris, bukan firmID. // WFDOC-INJECTED
use source_year source_row val_yprvcu using "corrections/data/C010.dta", clear
* Mulai r_ln_val_yprvcu sebagai missing; file ini tidak berisi rumus yang mengisinya. // WFDOC-INJECTED
generate double r_ln_val_yprvcu=.
* Daftar aturan menandai val_yprvcu ambigu; arti atau satuannya belum diterima. File ini tidak menghitung turunan; nilai tetap kosong di Stata (missing) dan status per tahun ditetapkan di bawah. // WFDOC-INJECTED
generate byte r_ln_val_yprvcu_state=9
* Tahun 2010: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_yprvcu ambigu; arti atau satuannya belum diterima. r_ln_val_yprvcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_ln_val_yprvcu_state=9 if source_year==2010
* Tahun 2011: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_yprvcu ambigu; arti atau satuannya belum diterima. r_ln_val_yprvcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_ln_val_yprvcu_state=9 if source_year==2011
* Tahun 2012: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_yprvcu ambigu; arti atau satuannya belum diterima. r_ln_val_yprvcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_ln_val_yprvcu_state=9 if source_year==2012
* Tahun 2013: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_yprvcu ambigu; arti atau satuannya belum diterima. r_ln_val_yprvcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_ln_val_yprvcu_state=9 if source_year==2013
* Tahun 2014: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_yprvcu ambigu; arti atau satuannya belum diterima. r_ln_val_yprvcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_ln_val_yprvcu_state=9 if source_year==2014
* Tahun 2015: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_yprvcu ambigu; arti atau satuannya belum diterima. r_ln_val_yprvcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_ln_val_yprvcu_state=9 if source_year==2015
* Tahun 2017: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_yprvcu ambigu; arti atau satuannya belum diterima. r_ln_val_yprvcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_ln_val_yprvcu_state=9 if source_year==2017
* Tahun 2018: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_yprvcu ambigu; arti atau satuannya belum diterima. r_ln_val_yprvcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_ln_val_yprvcu_state=9 if source_year==2018
* Tahun 2019: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_yprvcu ambigu; arti atau satuannya belum diterima. r_ln_val_yprvcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_ln_val_yprvcu_state=9 if source_year==2019
* Tahun 2020: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_yprvcu ambigu; arti atau satuannya belum diterima. r_ln_val_yprvcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_ln_val_yprvcu_state=9 if source_year==2020
* Tahun 2021: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_yprvcu ambigu; arti atau satuannya belum diterima. r_ln_val_yprvcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_ln_val_yprvcu_state=9 if source_year==2021
* Tahun 2022: status 9 dipasang tanpa rumus karena Daftar aturan menandai val_yprvcu ambigu; arti atau satuannya belum diterima. r_ln_val_yprvcu tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_ln_val_yprvcu_state=9 if source_year==2022
* Pastikan r_ln_val_yprvcu tetap kosong di Stata (missing) pada status 8/9; kode ini menangkap angka yang terisi tanpa dasar hitung. // WFDOC-INJECTED
assert missing(r_ln_val_yprvcu) if inlist(r_ln_val_yprvcu_state,8,9)
* Simpan hanya kunci baris, r_ln_val_yprvcu, dan statusnya agar keluaran tidak membawa kolom sumber lain. // WFDOC-INJECTED
keep source_year source_row r_ln_val_yprvcu r_ln_val_yprvcu_state
order source_year source_row
isid source_year source_row
assert _N==33049
* Tutup log, simpan tabel koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "CR296_log" "CR296"
