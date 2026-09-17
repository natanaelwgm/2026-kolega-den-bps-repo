* Tujuan: Hitung r_ln_rd_cost_nominal = ln(rd_cost_nominal) hanya untuk input positif dan terisi pada tahun yang memiliki baris perintah; input nol, negatif, atau kosong tidak menghasilkan angka. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. Tahun 2010, 2011, 2012, 2013, 2014, 2015 tidak punya baris hitung; r_ln_rd_cost_nominal tetap kosong dan file memberi status 9: 2010, 2011, 2012, 2013, 2014, 2015. // WFDOC-INJECTED
* Input: corrections/data/C010.dta // WFDOC-INJECTED
* Output: corrections/data/CR169.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "CR169_log"
* Ambil source_year, source_row, rd_cost_nominal, dan kolom lain yang disebut di baris ini dari corrections/data/C010.dta; pasangan tahun dan nomor baris mengenali satu baris, bukan firmID. // WFDOC-INJECTED
use source_year source_row rd_cost_nominal using "corrections/data/C010.dta", clear
* Mulai r_ln_rd_cost_nominal sebagai missing; hanya rumus dan syarat tahun di bawah yang dapat mengisinya. // WFDOC-INJECTED
generate double r_ln_rd_cost_nominal=.
* Nilai awal r_ln_rd_cost_nominal_state hanya menjadi titik mulai; baris per tahun berikut menentukan status akhir. Tahun yang tertahan gerbang sumber tetap memakai kode 9. // WFDOC-INJECTED
generate byte r_ln_rd_cost_nominal_state=9
* Tahun 2010: status 9 dipasang tanpa rumus karena Daftar aturan belum menerima sumber dan domain untuk menghitung variabel ini. r_ln_rd_cost_nominal tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_ln_rd_cost_nominal_state=9 if source_year==2010
* Tahun 2011: status 9 dipasang tanpa rumus karena Daftar aturan belum menerima sumber dan domain untuk menghitung variabel ini. r_ln_rd_cost_nominal tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_ln_rd_cost_nominal_state=9 if source_year==2011
* Tahun 2012: status 9 dipasang tanpa rumus karena Daftar aturan belum menerima sumber dan domain untuk menghitung variabel ini. r_ln_rd_cost_nominal tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_ln_rd_cost_nominal_state=9 if source_year==2012
* Tahun 2013: status 9 dipasang tanpa rumus karena Daftar aturan belum menerima sumber dan domain untuk menghitung variabel ini. r_ln_rd_cost_nominal tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_ln_rd_cost_nominal_state=9 if source_year==2013
* Tahun 2014: status 9 dipasang tanpa rumus karena Daftar aturan belum menerima sumber dan domain untuk menghitung variabel ini. r_ln_rd_cost_nominal tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_ln_rd_cost_nominal_state=9 if source_year==2014
* Tahun 2015: status 9 dipasang tanpa rumus karena Daftar aturan belum menerima sumber dan domain untuk menghitung variabel ini. r_ln_rd_cost_nominal tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace r_ln_rd_cost_nominal_state=9 if source_year==2015
* Tahun 2017: status awal mencatat 3 bila rd_cost_nominal kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace r_ln_rd_cost_nominal_state=cond(missing(rd_cost_nominal),3,cond(rd_cost_nominal<0,2,cond(rd_cost_nominal==0,1,0))) if source_year==2017
* Tahun 2017: hitung log natural r_ln_rd_cost_nominal dari rd_cost_nominal hanya saat rd_cost_nominal > 0 dan terisi; nilai nol, negatif, atau kosong dibiarkan missing. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_ln_rd_cost_nominal=ln(rd_cost_nominal) if source_year==2017 & rd_cost_nominal>0 & !missing(rd_cost_nominal)
* Tahun 2017: bila r_ln_rd_cost_nominal terisi (inputnya positif dan log berhasil dihitung), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace r_ln_rd_cost_nominal_state=0 if source_year==2017 & !missing(r_ln_rd_cost_nominal)
* Tahun 2018: status awal mencatat 3 bila rd_cost_nominal kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace r_ln_rd_cost_nominal_state=cond(missing(rd_cost_nominal),3,cond(rd_cost_nominal<0,2,cond(rd_cost_nominal==0,1,0))) if source_year==2018
* Tahun 2018: hitung log natural r_ln_rd_cost_nominal dari rd_cost_nominal hanya saat rd_cost_nominal > 0 dan terisi; nilai nol, negatif, atau kosong dibiarkan missing. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_ln_rd_cost_nominal=ln(rd_cost_nominal) if source_year==2018 & rd_cost_nominal>0 & !missing(rd_cost_nominal)
* Tahun 2018: bila r_ln_rd_cost_nominal terisi (inputnya positif dan log berhasil dihitung), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace r_ln_rd_cost_nominal_state=0 if source_year==2018 & !missing(r_ln_rd_cost_nominal)
* Tahun 2019: status awal mencatat 3 bila rd_cost_nominal kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace r_ln_rd_cost_nominal_state=cond(missing(rd_cost_nominal),3,cond(rd_cost_nominal<0,2,cond(rd_cost_nominal==0,1,0))) if source_year==2019
* Tahun 2019: hitung log natural r_ln_rd_cost_nominal dari rd_cost_nominal hanya saat rd_cost_nominal > 0 dan terisi; nilai nol, negatif, atau kosong dibiarkan missing. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_ln_rd_cost_nominal=ln(rd_cost_nominal) if source_year==2019 & rd_cost_nominal>0 & !missing(rd_cost_nominal)
* Tahun 2019: bila r_ln_rd_cost_nominal terisi (inputnya positif dan log berhasil dihitung), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace r_ln_rd_cost_nominal_state=0 if source_year==2019 & !missing(r_ln_rd_cost_nominal)
* Tahun 2020: status awal mencatat 3 bila rd_cost_nominal kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace r_ln_rd_cost_nominal_state=cond(missing(rd_cost_nominal),3,cond(rd_cost_nominal<0,2,cond(rd_cost_nominal==0,1,0))) if source_year==2020
* Tahun 2020: hitung log natural r_ln_rd_cost_nominal dari rd_cost_nominal hanya saat rd_cost_nominal > 0 dan terisi; nilai nol, negatif, atau kosong dibiarkan missing. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_ln_rd_cost_nominal=ln(rd_cost_nominal) if source_year==2020 & rd_cost_nominal>0 & !missing(rd_cost_nominal)
* Tahun 2020: bila r_ln_rd_cost_nominal terisi (inputnya positif dan log berhasil dihitung), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace r_ln_rd_cost_nominal_state=0 if source_year==2020 & !missing(r_ln_rd_cost_nominal)
* Tahun 2021: status awal mencatat 3 bila rd_cost_nominal kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace r_ln_rd_cost_nominal_state=cond(missing(rd_cost_nominal),3,cond(rd_cost_nominal<0,2,cond(rd_cost_nominal==0,1,0))) if source_year==2021
* Tahun 2021: hitung log natural r_ln_rd_cost_nominal dari rd_cost_nominal hanya saat rd_cost_nominal > 0 dan terisi; nilai nol, negatif, atau kosong dibiarkan missing. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_ln_rd_cost_nominal=ln(rd_cost_nominal) if source_year==2021 & rd_cost_nominal>0 & !missing(rd_cost_nominal)
* Tahun 2021: bila r_ln_rd_cost_nominal terisi (inputnya positif dan log berhasil dihitung), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace r_ln_rd_cost_nominal_state=0 if source_year==2021 & !missing(r_ln_rd_cost_nominal)
* Tahun 2022: status awal mencatat 3 bila rd_cost_nominal kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace r_ln_rd_cost_nominal_state=cond(missing(rd_cost_nominal),3,cond(rd_cost_nominal<0,2,cond(rd_cost_nominal==0,1,0))) if source_year==2022
* Tahun 2022: hitung log natural r_ln_rd_cost_nominal dari rd_cost_nominal hanya saat rd_cost_nominal > 0 dan terisi; nilai nol, negatif, atau kosong dibiarkan missing. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_ln_rd_cost_nominal=ln(rd_cost_nominal) if source_year==2022 & rd_cost_nominal>0 & !missing(rd_cost_nominal)
* Tahun 2022: bila r_ln_rd_cost_nominal terisi (inputnya positif dan log berhasil dihitung), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace r_ln_rd_cost_nominal_state=0 if source_year==2022 & !missing(r_ln_rd_cost_nominal)
* Pastikan r_ln_rd_cost_nominal tetap kosong di Stata (missing) pada status 8/9; kode ini menangkap angka yang terisi tanpa dasar hitung. // WFDOC-INJECTED
assert missing(r_ln_rd_cost_nominal) if inlist(r_ln_rd_cost_nominal_state,8,9)
* Simpan hanya kunci baris, r_ln_rd_cost_nominal, dan statusnya agar keluaran tidak membawa kolom sumber lain. // WFDOC-INJECTED
keep source_year source_row r_ln_rd_cost_nominal r_ln_rd_cost_nominal_state
order source_year source_row
isid source_year source_row
assert _N==33049
* Tutup log, simpan tabel koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "CR169_log" "CR169"
