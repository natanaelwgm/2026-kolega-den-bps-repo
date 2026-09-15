* Tujuan: Hitung r_rd_cost_per_worker_nominal sebagai rd_cost_nominal per pekerja (dibagi workers) untuk tahun yang memiliki baris perintah; syaratnya pembilang harus nol atau lebih dan jumlah pekerja harus positif. Nilai di luar syarat tetap kosong. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. Tahun 2010, 2011, 2012, 2013, 2014, 2015 tidak punya baris hitung; r_rd_cost_per_worker_nominal tetap kosong dan file memberi status 9: 2010, 2011, 2012, 2013, 2014, 2015. // WFDOC-INJECTED
* Input: corrections/data/C010.dta // WFDOC-INJECTED
* Output: corrections/data/CR005.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L1:step-version" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 1 43 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L1:step-version" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 1 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L2:step-do" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 2 43 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L2:step-do" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 2 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L3:step-g0c_begin" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 3 43 `=_rc' // WFLOG-INJECTED
g0c_begin "CR005_per_worker"
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L3:step-g0c_begin" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 3 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L4:step-use" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 4 43 `=_rc' // WFLOG-INJECTED
* Ambil source_year, source_row, rd_cost_nominal, dan kolom lain yang disebut di baris ini dari corrections/data/C010.dta; pasangan tahun dan nomor baris mengenali satu baris, bukan firmID. // WFDOC-INJECTED
use source_year source_row rd_cost_nominal using "corrections/data/C010.dta", clear
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L4:step-use" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 4 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L5:step-merge" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 5 43 `=_rc' // WFLOG-INJECTED
* Pasangkan baris pada kunci tahun dan nomor baris; `1:1` menolak kunci ganda dan `assert(match)` menghentikan proses jika pasangan baris tidak lengkap. Kunci ini bukan firmID. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/C010.dta", assert(match) nogen keepusing(workers)
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L5:step-merge" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 5 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L6:step-generate" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 6 43 `=_rc' // WFLOG-INJECTED
* Mulai r_rd_cost_per_worker_nominal sebagai missing; hanya rumus dan syarat tahun di bawah yang dapat mengisinya. // WFDOC-INJECTED
generate double r_rd_cost_per_worker_nominal=.
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L6:step-generate" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 6 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L7:step-generate" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 7 43 `=_rc' // WFLOG-INJECTED
* Nilai awal cr005_state hanya menjadi titik mulai; baris per tahun berikut menentukan status akhir. Tahun yang tertahan gerbang sumber tetap memakai kode 9. // WFDOC-INJECTED
generate byte cr005_state=9
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L7:step-generate" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 7 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L8:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 8 43 `=_rc' // WFLOG-INJECTED
* Tahun 2010: status 9 dipasang tanpa rumus karena Daftar aturan belum menerima sumber dan domain untuk menghitung variabel ini. r_rd_cost_per_worker_nominal tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace cr005_state=9 if source_year==2010
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L8:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 8 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L9:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 9 43 `=_rc' // WFLOG-INJECTED
* Tahun 2011: status 9 dipasang tanpa rumus karena Daftar aturan belum menerima sumber dan domain untuk menghitung variabel ini. r_rd_cost_per_worker_nominal tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace cr005_state=9 if source_year==2011
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L9:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 9 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L10:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 10 43 `=_rc' // WFLOG-INJECTED
* Tahun 2012: status 9 dipasang tanpa rumus karena Daftar aturan belum menerima sumber dan domain untuk menghitung variabel ini. r_rd_cost_per_worker_nominal tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace cr005_state=9 if source_year==2012
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L10:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 10 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L11:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 11 43 `=_rc' // WFLOG-INJECTED
* Tahun 2013: status 9 dipasang tanpa rumus karena Daftar aturan belum menerima sumber dan domain untuk menghitung variabel ini. r_rd_cost_per_worker_nominal tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace cr005_state=9 if source_year==2013
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L11:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 11 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L12:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 12 43 `=_rc' // WFLOG-INJECTED
* Tahun 2014: status 9 dipasang tanpa rumus karena Daftar aturan belum menerima sumber dan domain untuk menghitung variabel ini. r_rd_cost_per_worker_nominal tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace cr005_state=9 if source_year==2014
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L12:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 12 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L13:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 13 43 `=_rc' // WFLOG-INJECTED
* Tahun 2015: status 9 dipasang tanpa rumus karena Daftar aturan belum menerima sumber dan domain untuk menghitung variabel ini. r_rd_cost_per_worker_nominal tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace cr005_state=9 if source_year==2015
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L13:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 13 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L14:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 14 43 `=_rc' // WFLOG-INJECTED
* Tahun 2017: status awal mencatat 3 bila rd_cost_nominal kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace cr005_state=cond(missing(rd_cost_nominal),3,cond(rd_cost_nominal<0,2,cond(rd_cost_nominal==0,1,0))) if source_year==2017
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L14:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 14 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L15:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 15 43 `=_rc' // WFLOG-INJECTED
* Tahun 2017: tandai status 4 jika jumlah pekerja nol, negatif, atau kosong; pembagi itu tidak dipakai. // WFDOC-INJECTED
replace cr005_state=4 if source_year==2017 & (workers<=0 | missing(workers))
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L15:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 15 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L16:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 16 43 `=_rc' // WFLOG-INJECTED
* Tahun 2017: hitung r_rd_cost_per_worker_nominal = rd_cost_nominal / workers hanya bila workers > 0 agar pembagi tidak nol atau negatif dan rd_cost_nominal dan workers harus terisi dan rd_cost_nominal harus nol atau positif. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_rd_cost_per_worker_nominal=rd_cost_nominal/workers if source_year==2017 & workers>0 & !missing(workers,rd_cost_nominal) & rd_cost_nominal>=0
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L16:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 16 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L17:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 17 43 `=_rc' // WFLOG-INJECTED
* Tahun 2017: bila r_rd_cost_per_worker_nominal terisi (hasil terisi setelah pembilang lolos syarat nonnegatif), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace cr005_state=0 if source_year==2017 & !missing(r_rd_cost_per_worker_nominal)
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L17:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 17 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L18:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 18 43 `=_rc' // WFLOG-INJECTED
* Tahun 2018: status awal mencatat 3 bila rd_cost_nominal kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace cr005_state=cond(missing(rd_cost_nominal),3,cond(rd_cost_nominal<0,2,cond(rd_cost_nominal==0,1,0))) if source_year==2018
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L18:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 18 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L19:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 19 43 `=_rc' // WFLOG-INJECTED
* Tahun 2018: tandai status 4 jika jumlah pekerja nol, negatif, atau kosong; pembagi itu tidak dipakai. // WFDOC-INJECTED
replace cr005_state=4 if source_year==2018 & (workers<=0 | missing(workers))
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L19:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 19 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L20:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 20 43 `=_rc' // WFLOG-INJECTED
* Tahun 2018: hitung r_rd_cost_per_worker_nominal = rd_cost_nominal / workers hanya bila workers > 0 agar pembagi tidak nol atau negatif dan rd_cost_nominal dan workers harus terisi dan rd_cost_nominal harus nol atau positif. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_rd_cost_per_worker_nominal=rd_cost_nominal/workers if source_year==2018 & workers>0 & !missing(workers,rd_cost_nominal) & rd_cost_nominal>=0
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L20:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 20 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L21:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 21 43 `=_rc' // WFLOG-INJECTED
* Tahun 2018: bila r_rd_cost_per_worker_nominal terisi (hasil terisi setelah pembilang lolos syarat nonnegatif), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace cr005_state=0 if source_year==2018 & !missing(r_rd_cost_per_worker_nominal)
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L21:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 21 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L22:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 22 43 `=_rc' // WFLOG-INJECTED
* Tahun 2019: status awal mencatat 3 bila rd_cost_nominal kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace cr005_state=cond(missing(rd_cost_nominal),3,cond(rd_cost_nominal<0,2,cond(rd_cost_nominal==0,1,0))) if source_year==2019
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L22:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 22 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L23:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 23 43 `=_rc' // WFLOG-INJECTED
* Tahun 2019: tandai status 4 jika jumlah pekerja nol, negatif, atau kosong; pembagi itu tidak dipakai. // WFDOC-INJECTED
replace cr005_state=4 if source_year==2019 & (workers<=0 | missing(workers))
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L23:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 23 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L24:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 24 43 `=_rc' // WFLOG-INJECTED
* Tahun 2019: hitung r_rd_cost_per_worker_nominal = rd_cost_nominal / workers hanya bila workers > 0 agar pembagi tidak nol atau negatif dan rd_cost_nominal dan workers harus terisi dan rd_cost_nominal harus nol atau positif. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_rd_cost_per_worker_nominal=rd_cost_nominal/workers if source_year==2019 & workers>0 & !missing(workers,rd_cost_nominal) & rd_cost_nominal>=0
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L24:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 24 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L25:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 25 43 `=_rc' // WFLOG-INJECTED
* Tahun 2019: bila r_rd_cost_per_worker_nominal terisi (hasil terisi setelah pembilang lolos syarat nonnegatif), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace cr005_state=0 if source_year==2019 & !missing(r_rd_cost_per_worker_nominal)
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L25:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 25 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L26:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 26 43 `=_rc' // WFLOG-INJECTED
* Tahun 2020: status awal mencatat 3 bila rd_cost_nominal kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace cr005_state=cond(missing(rd_cost_nominal),3,cond(rd_cost_nominal<0,2,cond(rd_cost_nominal==0,1,0))) if source_year==2020
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L26:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 26 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L27:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 27 43 `=_rc' // WFLOG-INJECTED
* Tahun 2020: tandai status 4 jika jumlah pekerja nol, negatif, atau kosong; pembagi itu tidak dipakai. // WFDOC-INJECTED
replace cr005_state=4 if source_year==2020 & (workers<=0 | missing(workers))
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L27:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 27 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L28:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 28 43 `=_rc' // WFLOG-INJECTED
* Tahun 2020: hitung r_rd_cost_per_worker_nominal = rd_cost_nominal / workers hanya bila workers > 0 agar pembagi tidak nol atau negatif dan rd_cost_nominal dan workers harus terisi dan rd_cost_nominal harus nol atau positif. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_rd_cost_per_worker_nominal=rd_cost_nominal/workers if source_year==2020 & workers>0 & !missing(workers,rd_cost_nominal) & rd_cost_nominal>=0
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L28:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 28 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L29:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 29 43 `=_rc' // WFLOG-INJECTED
* Tahun 2020: bila r_rd_cost_per_worker_nominal terisi (hasil terisi setelah pembilang lolos syarat nonnegatif), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace cr005_state=0 if source_year==2020 & !missing(r_rd_cost_per_worker_nominal)
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L29:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 29 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L30:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 30 43 `=_rc' // WFLOG-INJECTED
* Tahun 2021: status awal mencatat 3 bila rd_cost_nominal kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace cr005_state=cond(missing(rd_cost_nominal),3,cond(rd_cost_nominal<0,2,cond(rd_cost_nominal==0,1,0))) if source_year==2021
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L30:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 30 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L31:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 31 43 `=_rc' // WFLOG-INJECTED
* Tahun 2021: tandai status 4 jika jumlah pekerja nol, negatif, atau kosong; pembagi itu tidak dipakai. // WFDOC-INJECTED
replace cr005_state=4 if source_year==2021 & (workers<=0 | missing(workers))
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L31:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 31 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L32:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 32 43 `=_rc' // WFLOG-INJECTED
* Tahun 2021: hitung r_rd_cost_per_worker_nominal = rd_cost_nominal / workers hanya bila workers > 0 agar pembagi tidak nol atau negatif dan rd_cost_nominal dan workers harus terisi dan rd_cost_nominal harus nol atau positif. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_rd_cost_per_worker_nominal=rd_cost_nominal/workers if source_year==2021 & workers>0 & !missing(workers,rd_cost_nominal) & rd_cost_nominal>=0
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L32:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 32 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L33:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 33 43 `=_rc' // WFLOG-INJECTED
* Tahun 2021: bila r_rd_cost_per_worker_nominal terisi (hasil terisi setelah pembilang lolos syarat nonnegatif), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace cr005_state=0 if source_year==2021 & !missing(r_rd_cost_per_worker_nominal)
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L33:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 33 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L34:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 34 43 `=_rc' // WFLOG-INJECTED
* Tahun 2022: status awal mencatat 3 bila rd_cost_nominal kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace cr005_state=cond(missing(rd_cost_nominal),3,cond(rd_cost_nominal<0,2,cond(rd_cost_nominal==0,1,0))) if source_year==2022
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L34:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 34 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L35:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 35 43 `=_rc' // WFLOG-INJECTED
* Tahun 2022: tandai status 4 jika jumlah pekerja nol, negatif, atau kosong; pembagi itu tidak dipakai. // WFDOC-INJECTED
replace cr005_state=4 if source_year==2022 & (workers<=0 | missing(workers))
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L35:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 35 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L36:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 36 43 `=_rc' // WFLOG-INJECTED
* Tahun 2022: hitung r_rd_cost_per_worker_nominal = rd_cost_nominal / workers hanya bila workers > 0 agar pembagi tidak nol atau negatif dan rd_cost_nominal dan workers harus terisi dan rd_cost_nominal harus nol atau positif. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_rd_cost_per_worker_nominal=rd_cost_nominal/workers if source_year==2022 & workers>0 & !missing(workers,rd_cost_nominal) & rd_cost_nominal>=0
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L36:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 36 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L37:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 37 43 `=_rc' // WFLOG-INJECTED
* Tahun 2022: bila r_rd_cost_per_worker_nominal terisi (hasil terisi setelah pembilang lolos syarat nonnegatif), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace cr005_state=0 if source_year==2022 & !missing(r_rd_cost_per_worker_nominal)
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L37:step-replace" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 37 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L38:step-assert" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 38 43 `=_rc' // WFLOG-INJECTED
* Pastikan r_rd_cost_per_worker_nominal tetap kosong di Stata (missing) pada status 8/9; kode ini menangkap angka yang terisi tanpa dasar hitung. // WFDOC-INJECTED
assert missing(r_rd_cost_per_worker_nominal) if inlist(cr005_state,8,9)
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L38:step-assert" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 38 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L39:step-keep" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 39 43 `=_rc' // WFLOG-INJECTED
* Simpan hanya kunci baris, r_rd_cost_per_worker_nominal, dan statusnya agar keluaran tidak membawa kolom sumber lain. // WFDOC-INJECTED
keep source_year source_row r_rd_cost_per_worker_nominal cr005_state
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L39:step-keep" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 39 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L40:step-order" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 40 43 `=_rc' // WFLOG-INJECTED
order source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L40:step-order" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 40 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L41:step-isid" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 41 43 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L41:step-isid" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 41 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L42:step-assert" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 42 43 `=_rc' // WFLOG-INJECTED
assert _N==33049
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L42:step-assert" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 42 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR005_per_worker.do:L43:step-g0c_finish" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 43 43 `=_rc' // WFLOG-INJECTED
* Tutup log, simpan tabel koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "CR005_per_worker" "CR005"
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L43:step-g0c_finish" "rows/G0/corrections/CR005_per_worker.do:L1:file" "statement" 43 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/CR005_per_worker.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
