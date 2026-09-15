* Tujuan: Hitung r_energy_cost_per_worker sebagai energy_exp_observed_repaired per pekerja (dibagi workers) untuk tahun yang memiliki baris perintah; syaratnya pembilang harus nol atau lebih dan jumlah pekerja harus positif. Nilai di luar syarat tetap kosong. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
* Input: corrections/data/C061.dta; corrections/data/C010.dta // WFDOC-INJECTED
* Output: corrections/data/CR006.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "CR006_per_worker"
* Ambil source_year, source_row, energy_expenditure_rp000, dan kolom lain yang disebut di baris ini dari corrections/data/C061.dta; pasangan tahun dan nomor baris mengenali satu baris, bukan firmID. // WFDOC-INJECTED
use source_year source_row energy_exp_observed_repaired using "corrections/data/C061.dta", clear
* Pasangkan baris pada kunci tahun dan nomor baris; `1:1` menolak kunci ganda dan `assert(match)` menghentikan proses jika pasangan baris tidak lengkap. Kunci ini bukan firmID. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/C010.dta", assert(match) nogen keepusing(workers)
* Mulai r_energy_cost_per_worker sebagai missing; hanya rumus dan syarat tahun di bawah yang dapat mengisinya. // WFDOC-INJECTED
generate double r_energy_cost_per_worker=.
* Nilai awal r_energy_cost_per_worker_state hanya menjadi titik mulai; baris per tahun berikut menentukan status akhir. Tahun yang tertahan gerbang sumber tetap memakai kode 9. // WFDOC-INJECTED
generate byte r_energy_cost_per_worker_state=9
* Tahun 2010: status awal mencatat 3 bila energy_exp_observed_repaired kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace r_energy_cost_per_worker_state=cond(missing(energy_exp_observed_repaired),3,cond(energy_exp_observed_repaired<0,2,cond(energy_exp_observed_repaired==0,1,0))) if source_year==2010
* Tahun 2010: tandai status 4 jika jumlah pekerja nol, negatif, atau kosong; pembagi itu tidak dipakai. // WFDOC-INJECTED
replace r_energy_cost_per_worker_state=4 if source_year==2010 & (workers<=0 | missing(workers))
* Tahun 2010: hitung r_energy_cost_per_worker = energy_exp_observed_repaired / workers hanya bila workers > 0 agar pembagi tidak nol atau negatif dan energy_exp_observed_repaired dan workers harus terisi dan energy_exp_observed_repaired harus nol atau positif. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_energy_cost_per_worker=energy_exp_observed_repaired/workers if source_year==2010 & workers>0 & !missing(workers,energy_exp_observed_repaired) & energy_exp_observed_repaired>=0
* Tahun 2010: bila r_energy_cost_per_worker terisi (hasil terisi setelah pembilang lolos syarat nonnegatif), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace r_energy_cost_per_worker_state=0 if source_year==2010 & !missing(r_energy_cost_per_worker)
* Tahun 2011: status awal mencatat 3 bila energy_exp_observed_repaired kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace r_energy_cost_per_worker_state=cond(missing(energy_exp_observed_repaired),3,cond(energy_exp_observed_repaired<0,2,cond(energy_exp_observed_repaired==0,1,0))) if source_year==2011
* Tahun 2011: tandai status 4 jika jumlah pekerja nol, negatif, atau kosong; pembagi itu tidak dipakai. // WFDOC-INJECTED
replace r_energy_cost_per_worker_state=4 if source_year==2011 & (workers<=0 | missing(workers))
* Tahun 2011: hitung r_energy_cost_per_worker = energy_exp_observed_repaired / workers hanya bila workers > 0 agar pembagi tidak nol atau negatif dan energy_exp_observed_repaired dan workers harus terisi dan energy_exp_observed_repaired harus nol atau positif. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_energy_cost_per_worker=energy_exp_observed_repaired/workers if source_year==2011 & workers>0 & !missing(workers,energy_exp_observed_repaired) & energy_exp_observed_repaired>=0
* Tahun 2011: bila r_energy_cost_per_worker terisi (hasil terisi setelah pembilang lolos syarat nonnegatif), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace r_energy_cost_per_worker_state=0 if source_year==2011 & !missing(r_energy_cost_per_worker)
* Tahun 2012: status awal mencatat 3 bila energy_exp_observed_repaired kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace r_energy_cost_per_worker_state=cond(missing(energy_exp_observed_repaired),3,cond(energy_exp_observed_repaired<0,2,cond(energy_exp_observed_repaired==0,1,0))) if source_year==2012
* Tahun 2012: tandai status 4 jika jumlah pekerja nol, negatif, atau kosong; pembagi itu tidak dipakai. // WFDOC-INJECTED
replace r_energy_cost_per_worker_state=4 if source_year==2012 & (workers<=0 | missing(workers))
* Tahun 2012: hitung r_energy_cost_per_worker = energy_exp_observed_repaired / workers hanya bila workers > 0 agar pembagi tidak nol atau negatif dan energy_exp_observed_repaired dan workers harus terisi dan energy_exp_observed_repaired harus nol atau positif. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_energy_cost_per_worker=energy_exp_observed_repaired/workers if source_year==2012 & workers>0 & !missing(workers,energy_exp_observed_repaired) & energy_exp_observed_repaired>=0
* Tahun 2012: bila r_energy_cost_per_worker terisi (hasil terisi setelah pembilang lolos syarat nonnegatif), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace r_energy_cost_per_worker_state=0 if source_year==2012 & !missing(r_energy_cost_per_worker)
* Tahun 2013: status awal mencatat 3 bila energy_exp_observed_repaired kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace r_energy_cost_per_worker_state=cond(missing(energy_exp_observed_repaired),3,cond(energy_exp_observed_repaired<0,2,cond(energy_exp_observed_repaired==0,1,0))) if source_year==2013
* Tahun 2013: tandai status 4 jika jumlah pekerja nol, negatif, atau kosong; pembagi itu tidak dipakai. // WFDOC-INJECTED
replace r_energy_cost_per_worker_state=4 if source_year==2013 & (workers<=0 | missing(workers))
* Tahun 2013: hitung r_energy_cost_per_worker = energy_exp_observed_repaired / workers hanya bila workers > 0 agar pembagi tidak nol atau negatif dan energy_exp_observed_repaired dan workers harus terisi dan energy_exp_observed_repaired harus nol atau positif. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_energy_cost_per_worker=energy_exp_observed_repaired/workers if source_year==2013 & workers>0 & !missing(workers,energy_exp_observed_repaired) & energy_exp_observed_repaired>=0
* Tahun 2013: bila r_energy_cost_per_worker terisi (hasil terisi setelah pembilang lolos syarat nonnegatif), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace r_energy_cost_per_worker_state=0 if source_year==2013 & !missing(r_energy_cost_per_worker)
* Tahun 2014: status awal mencatat 3 bila energy_exp_observed_repaired kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace r_energy_cost_per_worker_state=cond(missing(energy_exp_observed_repaired),3,cond(energy_exp_observed_repaired<0,2,cond(energy_exp_observed_repaired==0,1,0))) if source_year==2014
* Tahun 2014: tandai status 4 jika jumlah pekerja nol, negatif, atau kosong; pembagi itu tidak dipakai. // WFDOC-INJECTED
replace r_energy_cost_per_worker_state=4 if source_year==2014 & (workers<=0 | missing(workers))
* Tahun 2014: hitung r_energy_cost_per_worker = energy_exp_observed_repaired / workers hanya bila workers > 0 agar pembagi tidak nol atau negatif dan energy_exp_observed_repaired dan workers harus terisi dan energy_exp_observed_repaired harus nol atau positif. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_energy_cost_per_worker=energy_exp_observed_repaired/workers if source_year==2014 & workers>0 & !missing(workers,energy_exp_observed_repaired) & energy_exp_observed_repaired>=0
* Tahun 2014: bila r_energy_cost_per_worker terisi (hasil terisi setelah pembilang lolos syarat nonnegatif), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace r_energy_cost_per_worker_state=0 if source_year==2014 & !missing(r_energy_cost_per_worker)
* Tahun 2015: status awal mencatat 3 bila energy_exp_observed_repaired kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace r_energy_cost_per_worker_state=cond(missing(energy_exp_observed_repaired),3,cond(energy_exp_observed_repaired<0,2,cond(energy_exp_observed_repaired==0,1,0))) if source_year==2015
* Tahun 2015: tandai status 4 jika jumlah pekerja nol, negatif, atau kosong; pembagi itu tidak dipakai. // WFDOC-INJECTED
replace r_energy_cost_per_worker_state=4 if source_year==2015 & (workers<=0 | missing(workers))
* Tahun 2015: hitung r_energy_cost_per_worker = energy_exp_observed_repaired / workers hanya bila workers > 0 agar pembagi tidak nol atau negatif dan energy_exp_observed_repaired dan workers harus terisi dan energy_exp_observed_repaired harus nol atau positif. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_energy_cost_per_worker=energy_exp_observed_repaired/workers if source_year==2015 & workers>0 & !missing(workers,energy_exp_observed_repaired) & energy_exp_observed_repaired>=0
* Tahun 2015: bila r_energy_cost_per_worker terisi (hasil terisi setelah pembilang lolos syarat nonnegatif), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace r_energy_cost_per_worker_state=0 if source_year==2015 & !missing(r_energy_cost_per_worker)
* Tahun 2017: status awal mencatat 3 bila energy_exp_observed_repaired kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace r_energy_cost_per_worker_state=cond(missing(energy_exp_observed_repaired),3,cond(energy_exp_observed_repaired<0,2,cond(energy_exp_observed_repaired==0,1,0))) if source_year==2017
* Tahun 2017: tandai status 4 jika jumlah pekerja nol, negatif, atau kosong; pembagi itu tidak dipakai. // WFDOC-INJECTED
replace r_energy_cost_per_worker_state=4 if source_year==2017 & (workers<=0 | missing(workers))
* Tahun 2017: hitung r_energy_cost_per_worker = energy_exp_observed_repaired / workers hanya bila workers > 0 agar pembagi tidak nol atau negatif dan energy_exp_observed_repaired dan workers harus terisi dan energy_exp_observed_repaired harus nol atau positif. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_energy_cost_per_worker=energy_exp_observed_repaired/workers if source_year==2017 & workers>0 & !missing(workers,energy_exp_observed_repaired) & energy_exp_observed_repaired>=0
* Tahun 2017: bila r_energy_cost_per_worker terisi (hasil terisi setelah pembilang lolos syarat nonnegatif), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace r_energy_cost_per_worker_state=0 if source_year==2017 & !missing(r_energy_cost_per_worker)
* Tahun 2018: status awal mencatat 3 bila energy_exp_observed_repaired kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace r_energy_cost_per_worker_state=cond(missing(energy_exp_observed_repaired),3,cond(energy_exp_observed_repaired<0,2,cond(energy_exp_observed_repaired==0,1,0))) if source_year==2018
* Tahun 2018: tandai status 4 jika jumlah pekerja nol, negatif, atau kosong; pembagi itu tidak dipakai. // WFDOC-INJECTED
replace r_energy_cost_per_worker_state=4 if source_year==2018 & (workers<=0 | missing(workers))
* Tahun 2018: hitung r_energy_cost_per_worker = energy_exp_observed_repaired / workers hanya bila workers > 0 agar pembagi tidak nol atau negatif dan energy_exp_observed_repaired dan workers harus terisi dan energy_exp_observed_repaired harus nol atau positif. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_energy_cost_per_worker=energy_exp_observed_repaired/workers if source_year==2018 & workers>0 & !missing(workers,energy_exp_observed_repaired) & energy_exp_observed_repaired>=0
* Tahun 2018: bila r_energy_cost_per_worker terisi (hasil terisi setelah pembilang lolos syarat nonnegatif), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace r_energy_cost_per_worker_state=0 if source_year==2018 & !missing(r_energy_cost_per_worker)
* Tahun 2019: status awal mencatat 3 bila energy_exp_observed_repaired kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace r_energy_cost_per_worker_state=cond(missing(energy_exp_observed_repaired),3,cond(energy_exp_observed_repaired<0,2,cond(energy_exp_observed_repaired==0,1,0))) if source_year==2019
* Tahun 2019: tandai status 4 jika jumlah pekerja nol, negatif, atau kosong; pembagi itu tidak dipakai. // WFDOC-INJECTED
replace r_energy_cost_per_worker_state=4 if source_year==2019 & (workers<=0 | missing(workers))
* Tahun 2019: hitung r_energy_cost_per_worker = energy_exp_observed_repaired / workers hanya bila workers > 0 agar pembagi tidak nol atau negatif dan energy_exp_observed_repaired dan workers harus terisi dan energy_exp_observed_repaired harus nol atau positif. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_energy_cost_per_worker=energy_exp_observed_repaired/workers if source_year==2019 & workers>0 & !missing(workers,energy_exp_observed_repaired) & energy_exp_observed_repaired>=0
* Tahun 2019: bila r_energy_cost_per_worker terisi (hasil terisi setelah pembilang lolos syarat nonnegatif), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace r_energy_cost_per_worker_state=0 if source_year==2019 & !missing(r_energy_cost_per_worker)
* Tahun 2020: status awal mencatat 3 bila energy_exp_observed_repaired kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace r_energy_cost_per_worker_state=cond(missing(energy_exp_observed_repaired),3,cond(energy_exp_observed_repaired<0,2,cond(energy_exp_observed_repaired==0,1,0))) if source_year==2020
* Tahun 2020: tandai status 4 jika jumlah pekerja nol, negatif, atau kosong; pembagi itu tidak dipakai. // WFDOC-INJECTED
replace r_energy_cost_per_worker_state=4 if source_year==2020 & (workers<=0 | missing(workers))
* Tahun 2020: hitung r_energy_cost_per_worker = energy_exp_observed_repaired / workers hanya bila workers > 0 agar pembagi tidak nol atau negatif dan energy_exp_observed_repaired dan workers harus terisi dan energy_exp_observed_repaired harus nol atau positif. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_energy_cost_per_worker=energy_exp_observed_repaired/workers if source_year==2020 & workers>0 & !missing(workers,energy_exp_observed_repaired) & energy_exp_observed_repaired>=0
* Tahun 2020: bila r_energy_cost_per_worker terisi (hasil terisi setelah pembilang lolos syarat nonnegatif), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace r_energy_cost_per_worker_state=0 if source_year==2020 & !missing(r_energy_cost_per_worker)
* Tahun 2021: status awal mencatat 3 bila energy_exp_observed_repaired kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace r_energy_cost_per_worker_state=cond(missing(energy_exp_observed_repaired),3,cond(energy_exp_observed_repaired<0,2,cond(energy_exp_observed_repaired==0,1,0))) if source_year==2021
* Tahun 2021: tandai status 4 jika jumlah pekerja nol, negatif, atau kosong; pembagi itu tidak dipakai. // WFDOC-INJECTED
replace r_energy_cost_per_worker_state=4 if source_year==2021 & (workers<=0 | missing(workers))
* Tahun 2021: hitung r_energy_cost_per_worker = energy_exp_observed_repaired / workers hanya bila workers > 0 agar pembagi tidak nol atau negatif dan energy_exp_observed_repaired dan workers harus terisi dan energy_exp_observed_repaired harus nol atau positif. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_energy_cost_per_worker=energy_exp_observed_repaired/workers if source_year==2021 & workers>0 & !missing(workers,energy_exp_observed_repaired) & energy_exp_observed_repaired>=0
* Tahun 2021: bila r_energy_cost_per_worker terisi (hasil terisi setelah pembilang lolos syarat nonnegatif), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace r_energy_cost_per_worker_state=0 if source_year==2021 & !missing(r_energy_cost_per_worker)
* Tahun 2022: status awal mencatat 3 bila energy_exp_observed_repaired kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace r_energy_cost_per_worker_state=cond(missing(energy_exp_observed_repaired),3,cond(energy_exp_observed_repaired<0,2,cond(energy_exp_observed_repaired==0,1,0))) if source_year==2022
* Tahun 2022: tandai status 4 jika jumlah pekerja nol, negatif, atau kosong; pembagi itu tidak dipakai. // WFDOC-INJECTED
replace r_energy_cost_per_worker_state=4 if source_year==2022 & (workers<=0 | missing(workers))
* Tahun 2022: hitung r_energy_cost_per_worker = energy_exp_observed_repaired / workers hanya bila workers > 0 agar pembagi tidak nol atau negatif dan energy_exp_observed_repaired dan workers harus terisi dan energy_exp_observed_repaired harus nol atau positif. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_energy_cost_per_worker=energy_exp_observed_repaired/workers if source_year==2022 & workers>0 & !missing(workers,energy_exp_observed_repaired) & energy_exp_observed_repaired>=0
* Tahun 2022: bila r_energy_cost_per_worker terisi (hasil terisi setelah pembilang lolos syarat nonnegatif), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace r_energy_cost_per_worker_state=0 if source_year==2022 & !missing(r_energy_cost_per_worker)
* Pastikan r_energy_cost_per_worker tetap kosong di Stata (missing) pada status 8/9; kode ini menangkap angka yang terisi tanpa dasar hitung. // WFDOC-INJECTED
assert missing(r_energy_cost_per_worker) if inlist(r_energy_cost_per_worker_state,8,9)
* Simpan hanya kunci baris, r_energy_cost_per_worker, dan statusnya agar keluaran tidak membawa kolom sumber lain. // WFDOC-INJECTED
keep source_year source_row r_energy_cost_per_worker r_energy_cost_per_worker_state
order source_year source_row
isid source_year source_row
assert _N==33049
* Tutup log, simpan tabel koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "CR006_per_worker" "CR006"
