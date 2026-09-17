* Tujuan: Hitung r_ln_energy_expenditure = ln(energy_exp_observed_repaired) hanya untuk input positif dan terisi pada tahun yang memiliki baris perintah; input nol, negatif, atau kosong tidak menghasilkan angka. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
* Input: corrections/data/C061.dta // WFDOC-INJECTED
* Output: corrections/data/CR167.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "CR167_log"
* Ambil source_year, source_row, energy_expenditure_rp000, dan kolom lain yang disebut di baris ini dari corrections/data/C061.dta; pasangan tahun dan nomor baris mengenali satu baris, bukan firmID. // WFDOC-INJECTED
use source_year source_row energy_exp_observed_repaired using "corrections/data/C061.dta", clear
* Mulai r_ln_energy_expenditure sebagai missing; hanya rumus dan syarat tahun di bawah yang dapat mengisinya. // WFDOC-INJECTED
generate double r_ln_energy_expenditure=.
* Nilai awal r_ln_energy_expenditure_state hanya menjadi titik mulai; baris per tahun berikut menentukan status akhir. Tahun yang tertahan gerbang sumber tetap memakai kode 9. // WFDOC-INJECTED
generate byte r_ln_energy_expenditure_state=9
* Tahun 2010: status awal mencatat 3 bila energy_exp_observed_repaired kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace r_ln_energy_expenditure_state=cond(missing(energy_exp_observed_repaired),3,cond(energy_exp_observed_repaired<0,2,cond(energy_exp_observed_repaired==0,1,0))) if source_year==2010
* Tahun 2010: hitung log natural r_ln_energy_expenditure dari energy_exp_observed_repaired hanya saat energy_exp_observed_repaired > 0 dan terisi; nilai nol, negatif, atau kosong dibiarkan missing. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_ln_energy_expenditure=ln(energy_exp_observed_repaired) if source_year==2010 & energy_exp_observed_repaired>0 & !missing(energy_exp_observed_repaired)
* Tahun 2010: bila r_ln_energy_expenditure terisi (inputnya positif dan log berhasil dihitung), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace r_ln_energy_expenditure_state=0 if source_year==2010 & !missing(r_ln_energy_expenditure)
* Tahun 2011: status awal mencatat 3 bila energy_exp_observed_repaired kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace r_ln_energy_expenditure_state=cond(missing(energy_exp_observed_repaired),3,cond(energy_exp_observed_repaired<0,2,cond(energy_exp_observed_repaired==0,1,0))) if source_year==2011
* Tahun 2011: hitung log natural r_ln_energy_expenditure dari energy_exp_observed_repaired hanya saat energy_exp_observed_repaired > 0 dan terisi; nilai nol, negatif, atau kosong dibiarkan missing. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_ln_energy_expenditure=ln(energy_exp_observed_repaired) if source_year==2011 & energy_exp_observed_repaired>0 & !missing(energy_exp_observed_repaired)
* Tahun 2011: bila r_ln_energy_expenditure terisi (inputnya positif dan log berhasil dihitung), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace r_ln_energy_expenditure_state=0 if source_year==2011 & !missing(r_ln_energy_expenditure)
* Tahun 2012: status awal mencatat 3 bila energy_exp_observed_repaired kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace r_ln_energy_expenditure_state=cond(missing(energy_exp_observed_repaired),3,cond(energy_exp_observed_repaired<0,2,cond(energy_exp_observed_repaired==0,1,0))) if source_year==2012
* Tahun 2012: hitung log natural r_ln_energy_expenditure dari energy_exp_observed_repaired hanya saat energy_exp_observed_repaired > 0 dan terisi; nilai nol, negatif, atau kosong dibiarkan missing. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_ln_energy_expenditure=ln(energy_exp_observed_repaired) if source_year==2012 & energy_exp_observed_repaired>0 & !missing(energy_exp_observed_repaired)
* Tahun 2012: bila r_ln_energy_expenditure terisi (inputnya positif dan log berhasil dihitung), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace r_ln_energy_expenditure_state=0 if source_year==2012 & !missing(r_ln_energy_expenditure)
* Tahun 2013: status awal mencatat 3 bila energy_exp_observed_repaired kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace r_ln_energy_expenditure_state=cond(missing(energy_exp_observed_repaired),3,cond(energy_exp_observed_repaired<0,2,cond(energy_exp_observed_repaired==0,1,0))) if source_year==2013
* Tahun 2013: hitung log natural r_ln_energy_expenditure dari energy_exp_observed_repaired hanya saat energy_exp_observed_repaired > 0 dan terisi; nilai nol, negatif, atau kosong dibiarkan missing. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_ln_energy_expenditure=ln(energy_exp_observed_repaired) if source_year==2013 & energy_exp_observed_repaired>0 & !missing(energy_exp_observed_repaired)
* Tahun 2013: bila r_ln_energy_expenditure terisi (inputnya positif dan log berhasil dihitung), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace r_ln_energy_expenditure_state=0 if source_year==2013 & !missing(r_ln_energy_expenditure)
* Tahun 2014: status awal mencatat 3 bila energy_exp_observed_repaired kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace r_ln_energy_expenditure_state=cond(missing(energy_exp_observed_repaired),3,cond(energy_exp_observed_repaired<0,2,cond(energy_exp_observed_repaired==0,1,0))) if source_year==2014
* Tahun 2014: hitung log natural r_ln_energy_expenditure dari energy_exp_observed_repaired hanya saat energy_exp_observed_repaired > 0 dan terisi; nilai nol, negatif, atau kosong dibiarkan missing. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_ln_energy_expenditure=ln(energy_exp_observed_repaired) if source_year==2014 & energy_exp_observed_repaired>0 & !missing(energy_exp_observed_repaired)
* Tahun 2014: bila r_ln_energy_expenditure terisi (inputnya positif dan log berhasil dihitung), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace r_ln_energy_expenditure_state=0 if source_year==2014 & !missing(r_ln_energy_expenditure)
* Tahun 2015: status awal mencatat 3 bila energy_exp_observed_repaired kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace r_ln_energy_expenditure_state=cond(missing(energy_exp_observed_repaired),3,cond(energy_exp_observed_repaired<0,2,cond(energy_exp_observed_repaired==0,1,0))) if source_year==2015
* Tahun 2015: hitung log natural r_ln_energy_expenditure dari energy_exp_observed_repaired hanya saat energy_exp_observed_repaired > 0 dan terisi; nilai nol, negatif, atau kosong dibiarkan missing. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_ln_energy_expenditure=ln(energy_exp_observed_repaired) if source_year==2015 & energy_exp_observed_repaired>0 & !missing(energy_exp_observed_repaired)
* Tahun 2015: bila r_ln_energy_expenditure terisi (inputnya positif dan log berhasil dihitung), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace r_ln_energy_expenditure_state=0 if source_year==2015 & !missing(r_ln_energy_expenditure)
* Tahun 2017: status awal mencatat 3 bila energy_exp_observed_repaired kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace r_ln_energy_expenditure_state=cond(missing(energy_exp_observed_repaired),3,cond(energy_exp_observed_repaired<0,2,cond(energy_exp_observed_repaired==0,1,0))) if source_year==2017
* Tahun 2017: hitung log natural r_ln_energy_expenditure dari energy_exp_observed_repaired hanya saat energy_exp_observed_repaired > 0 dan terisi; nilai nol, negatif, atau kosong dibiarkan missing. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_ln_energy_expenditure=ln(energy_exp_observed_repaired) if source_year==2017 & energy_exp_observed_repaired>0 & !missing(energy_exp_observed_repaired)
* Tahun 2017: bila r_ln_energy_expenditure terisi (inputnya positif dan log berhasil dihitung), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace r_ln_energy_expenditure_state=0 if source_year==2017 & !missing(r_ln_energy_expenditure)
* Tahun 2018: status awal mencatat 3 bila energy_exp_observed_repaired kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace r_ln_energy_expenditure_state=cond(missing(energy_exp_observed_repaired),3,cond(energy_exp_observed_repaired<0,2,cond(energy_exp_observed_repaired==0,1,0))) if source_year==2018
* Tahun 2018: hitung log natural r_ln_energy_expenditure dari energy_exp_observed_repaired hanya saat energy_exp_observed_repaired > 0 dan terisi; nilai nol, negatif, atau kosong dibiarkan missing. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_ln_energy_expenditure=ln(energy_exp_observed_repaired) if source_year==2018 & energy_exp_observed_repaired>0 & !missing(energy_exp_observed_repaired)
* Tahun 2018: bila r_ln_energy_expenditure terisi (inputnya positif dan log berhasil dihitung), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace r_ln_energy_expenditure_state=0 if source_year==2018 & !missing(r_ln_energy_expenditure)
* Tahun 2019: status awal mencatat 3 bila energy_exp_observed_repaired kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace r_ln_energy_expenditure_state=cond(missing(energy_exp_observed_repaired),3,cond(energy_exp_observed_repaired<0,2,cond(energy_exp_observed_repaired==0,1,0))) if source_year==2019
* Tahun 2019: hitung log natural r_ln_energy_expenditure dari energy_exp_observed_repaired hanya saat energy_exp_observed_repaired > 0 dan terisi; nilai nol, negatif, atau kosong dibiarkan missing. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_ln_energy_expenditure=ln(energy_exp_observed_repaired) if source_year==2019 & energy_exp_observed_repaired>0 & !missing(energy_exp_observed_repaired)
* Tahun 2019: bila r_ln_energy_expenditure terisi (inputnya positif dan log berhasil dihitung), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace r_ln_energy_expenditure_state=0 if source_year==2019 & !missing(r_ln_energy_expenditure)
* Tahun 2020: status awal mencatat 3 bila energy_exp_observed_repaired kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace r_ln_energy_expenditure_state=cond(missing(energy_exp_observed_repaired),3,cond(energy_exp_observed_repaired<0,2,cond(energy_exp_observed_repaired==0,1,0))) if source_year==2020
* Tahun 2020: hitung log natural r_ln_energy_expenditure dari energy_exp_observed_repaired hanya saat energy_exp_observed_repaired > 0 dan terisi; nilai nol, negatif, atau kosong dibiarkan missing. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_ln_energy_expenditure=ln(energy_exp_observed_repaired) if source_year==2020 & energy_exp_observed_repaired>0 & !missing(energy_exp_observed_repaired)
* Tahun 2020: bila r_ln_energy_expenditure terisi (inputnya positif dan log berhasil dihitung), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace r_ln_energy_expenditure_state=0 if source_year==2020 & !missing(r_ln_energy_expenditure)
* Tahun 2021: status awal mencatat 3 bila energy_exp_observed_repaired kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace r_ln_energy_expenditure_state=cond(missing(energy_exp_observed_repaired),3,cond(energy_exp_observed_repaired<0,2,cond(energy_exp_observed_repaired==0,1,0))) if source_year==2021
* Tahun 2021: hitung log natural r_ln_energy_expenditure dari energy_exp_observed_repaired hanya saat energy_exp_observed_repaired > 0 dan terisi; nilai nol, negatif, atau kosong dibiarkan missing. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_ln_energy_expenditure=ln(energy_exp_observed_repaired) if source_year==2021 & energy_exp_observed_repaired>0 & !missing(energy_exp_observed_repaired)
* Tahun 2021: bila r_ln_energy_expenditure terisi (inputnya positif dan log berhasil dihitung), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace r_ln_energy_expenditure_state=0 if source_year==2021 & !missing(r_ln_energy_expenditure)
* Tahun 2022: status awal mencatat 3 bila energy_exp_observed_repaired kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace r_ln_energy_expenditure_state=cond(missing(energy_exp_observed_repaired),3,cond(energy_exp_observed_repaired<0,2,cond(energy_exp_observed_repaired==0,1,0))) if source_year==2022
* Tahun 2022: hitung log natural r_ln_energy_expenditure dari energy_exp_observed_repaired hanya saat energy_exp_observed_repaired > 0 dan terisi; nilai nol, negatif, atau kosong dibiarkan missing. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_ln_energy_expenditure=ln(energy_exp_observed_repaired) if source_year==2022 & energy_exp_observed_repaired>0 & !missing(energy_exp_observed_repaired)
* Tahun 2022: bila r_ln_energy_expenditure terisi (inputnya positif dan log berhasil dihitung), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace r_ln_energy_expenditure_state=0 if source_year==2022 & !missing(r_ln_energy_expenditure)
* Pastikan r_ln_energy_expenditure tetap kosong di Stata (missing) pada status 8/9; kode ini menangkap angka yang terisi tanpa dasar hitung. // WFDOC-INJECTED
assert missing(r_ln_energy_expenditure) if inlist(r_ln_energy_expenditure_state,8,9)
* Simpan hanya kunci baris, r_ln_energy_expenditure, dan statusnya agar keluaran tidak membawa kolom sumber lain. // WFDOC-INJECTED
keep source_year source_row r_ln_energy_expenditure r_ln_energy_expenditure_state
order source_year source_row
isid source_year source_row
assert _N==33049
* Tutup log, simpan tabel koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "CR167_log" "CR167"
