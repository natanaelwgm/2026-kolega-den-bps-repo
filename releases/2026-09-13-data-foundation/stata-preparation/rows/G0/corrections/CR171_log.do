* Tujuan: Hitung r_ln_capital_additions_nominal = ln(capital_additions_nominal) hanya untuk input positif dan terisi pada tahun yang memiliki baris perintah; input nol, negatif, atau kosong tidak menghasilkan angka. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. Tahun 2015 tidak punya baris hitung; r_ln_capital_additions_nominal tetap kosong dan file memberi status 9: 2015. // WFDOC-INJECTED
* Input: corrections/data/C010.dta // WFDOC-INJECTED
* Output: corrections/data/CR171.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L1:step-version" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 1 46 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L1:step-version" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 1 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L2:step-do" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 2 46 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L2:step-do" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 2 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L3:step-g0c_begin" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 3 46 `=_rc' // WFLOG-INJECTED
g0c_begin "CR171_log"
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L3:step-g0c_begin" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 3 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L4:step-use" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 4 46 `=_rc' // WFLOG-INJECTED
* Ambil source_year, source_row, capital_additions_nominal, dan kolom lain yang disebut di baris ini dari corrections/data/C010.dta; pasangan tahun dan nomor baris mengenali satu baris, bukan firmID. // WFDOC-INJECTED
use source_year source_row capital_additions_nominal using "corrections/data/C010.dta", clear
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L4:step-use" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 4 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L5:step-generate" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 5 46 `=_rc' // WFLOG-INJECTED
* Mulai r_ln_capital_additions_nominal sebagai missing; hanya rumus dan syarat tahun di bawah yang dapat mengisinya. // WFDOC-INJECTED
generate double r_ln_capital_additions_nominal=.
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L5:step-generate" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 5 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L6:step-generate" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 6 46 `=_rc' // WFLOG-INJECTED
* Nilai awal cr171_state hanya menjadi titik mulai; baris per tahun berikut menentukan status akhir. Tahun yang tertahan gerbang sumber tetap memakai kode 9. // WFDOC-INJECTED
generate byte cr171_state=9
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L6:step-generate" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 6 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L7:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 7 46 `=_rc' // WFLOG-INJECTED
* Tahun 2010: status awal mencatat 3 bila capital_additions_nominal kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace cr171_state=cond(missing(capital_additions_nominal),3,cond(capital_additions_nominal<0,2,cond(capital_additions_nominal==0,1,0))) if source_year==2010
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L7:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 7 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L8:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 8 46 `=_rc' // WFLOG-INJECTED
* Tahun 2010: hitung log natural r_ln_capital_additions_nominal dari capital_additions_nominal hanya saat capital_additions_nominal > 0 dan terisi; nilai nol, negatif, atau kosong dibiarkan missing. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_ln_capital_additions_nominal=ln(capital_additions_nominal) if source_year==2010 & capital_additions_nominal>0 & !missing(capital_additions_nominal)
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L8:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 8 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L9:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 9 46 `=_rc' // WFLOG-INJECTED
* Tahun 2010: bila r_ln_capital_additions_nominal terisi (inputnya positif dan log berhasil dihitung), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace cr171_state=0 if source_year==2010 & !missing(r_ln_capital_additions_nominal)
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L9:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 9 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L10:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 10 46 `=_rc' // WFLOG-INJECTED
* Tahun 2011: status awal mencatat 3 bila capital_additions_nominal kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace cr171_state=cond(missing(capital_additions_nominal),3,cond(capital_additions_nominal<0,2,cond(capital_additions_nominal==0,1,0))) if source_year==2011
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L10:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 10 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L11:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 11 46 `=_rc' // WFLOG-INJECTED
* Tahun 2011: hitung log natural r_ln_capital_additions_nominal dari capital_additions_nominal hanya saat capital_additions_nominal > 0 dan terisi; nilai nol, negatif, atau kosong dibiarkan missing. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_ln_capital_additions_nominal=ln(capital_additions_nominal) if source_year==2011 & capital_additions_nominal>0 & !missing(capital_additions_nominal)
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L11:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 11 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L12:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 12 46 `=_rc' // WFLOG-INJECTED
* Tahun 2011: bila r_ln_capital_additions_nominal terisi (inputnya positif dan log berhasil dihitung), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace cr171_state=0 if source_year==2011 & !missing(r_ln_capital_additions_nominal)
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L12:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 12 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L13:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 13 46 `=_rc' // WFLOG-INJECTED
* Tahun 2012: status awal mencatat 3 bila capital_additions_nominal kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace cr171_state=cond(missing(capital_additions_nominal),3,cond(capital_additions_nominal<0,2,cond(capital_additions_nominal==0,1,0))) if source_year==2012
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L13:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 13 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L14:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 14 46 `=_rc' // WFLOG-INJECTED
* Tahun 2012: hitung log natural r_ln_capital_additions_nominal dari capital_additions_nominal hanya saat capital_additions_nominal > 0 dan terisi; nilai nol, negatif, atau kosong dibiarkan missing. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_ln_capital_additions_nominal=ln(capital_additions_nominal) if source_year==2012 & capital_additions_nominal>0 & !missing(capital_additions_nominal)
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L14:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 14 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L15:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 15 46 `=_rc' // WFLOG-INJECTED
* Tahun 2012: bila r_ln_capital_additions_nominal terisi (inputnya positif dan log berhasil dihitung), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace cr171_state=0 if source_year==2012 & !missing(r_ln_capital_additions_nominal)
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L15:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 15 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L16:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 16 46 `=_rc' // WFLOG-INJECTED
* Tahun 2013: status awal mencatat 3 bila capital_additions_nominal kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace cr171_state=cond(missing(capital_additions_nominal),3,cond(capital_additions_nominal<0,2,cond(capital_additions_nominal==0,1,0))) if source_year==2013
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L16:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 16 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L17:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 17 46 `=_rc' // WFLOG-INJECTED
* Tahun 2013: hitung log natural r_ln_capital_additions_nominal dari capital_additions_nominal hanya saat capital_additions_nominal > 0 dan terisi; nilai nol, negatif, atau kosong dibiarkan missing. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_ln_capital_additions_nominal=ln(capital_additions_nominal) if source_year==2013 & capital_additions_nominal>0 & !missing(capital_additions_nominal)
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L17:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 17 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L18:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 18 46 `=_rc' // WFLOG-INJECTED
* Tahun 2013: bila r_ln_capital_additions_nominal terisi (inputnya positif dan log berhasil dihitung), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace cr171_state=0 if source_year==2013 & !missing(r_ln_capital_additions_nominal)
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L18:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 18 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L19:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 19 46 `=_rc' // WFLOG-INJECTED
* Tahun 2014: status awal mencatat 3 bila capital_additions_nominal kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace cr171_state=cond(missing(capital_additions_nominal),3,cond(capital_additions_nominal<0,2,cond(capital_additions_nominal==0,1,0))) if source_year==2014
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L19:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 19 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L20:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 20 46 `=_rc' // WFLOG-INJECTED
* Tahun 2014: hitung log natural r_ln_capital_additions_nominal dari capital_additions_nominal hanya saat capital_additions_nominal > 0 dan terisi; nilai nol, negatif, atau kosong dibiarkan missing. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_ln_capital_additions_nominal=ln(capital_additions_nominal) if source_year==2014 & capital_additions_nominal>0 & !missing(capital_additions_nominal)
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L20:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 20 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L21:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 21 46 `=_rc' // WFLOG-INJECTED
* Tahun 2014: bila r_ln_capital_additions_nominal terisi (inputnya positif dan log berhasil dihitung), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace cr171_state=0 if source_year==2014 & !missing(r_ln_capital_additions_nominal)
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L21:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 21 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L22:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 22 46 `=_rc' // WFLOG-INJECTED
* Tahun 2015: status 9 dipasang tanpa rumus karena Daftar aturan belum menerima sumber dan domain untuk menghitung variabel ini. r_ln_capital_additions_nominal tetap kosong di Stata (missing); ini bukan nilai nol. // WFDOC-INJECTED
replace cr171_state=9 if source_year==2015
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L22:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 22 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L23:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 23 46 `=_rc' // WFLOG-INJECTED
* Tahun 2017: status awal mencatat 3 bila capital_additions_nominal kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace cr171_state=cond(missing(capital_additions_nominal),3,cond(capital_additions_nominal<0,2,cond(capital_additions_nominal==0,1,0))) if source_year==2017
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L23:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 23 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L24:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 24 46 `=_rc' // WFLOG-INJECTED
* Tahun 2017: hitung log natural r_ln_capital_additions_nominal dari capital_additions_nominal hanya saat capital_additions_nominal > 0 dan terisi; nilai nol, negatif, atau kosong dibiarkan missing. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_ln_capital_additions_nominal=ln(capital_additions_nominal) if source_year==2017 & capital_additions_nominal>0 & !missing(capital_additions_nominal)
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L24:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 24 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L25:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 25 46 `=_rc' // WFLOG-INJECTED
* Tahun 2017: bila r_ln_capital_additions_nominal terisi (inputnya positif dan log berhasil dihitung), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace cr171_state=0 if source_year==2017 & !missing(r_ln_capital_additions_nominal)
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L25:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 25 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L26:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 26 46 `=_rc' // WFLOG-INJECTED
* Tahun 2018: status awal mencatat 3 bila capital_additions_nominal kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace cr171_state=cond(missing(capital_additions_nominal),3,cond(capital_additions_nominal<0,2,cond(capital_additions_nominal==0,1,0))) if source_year==2018
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L26:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 26 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L27:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 27 46 `=_rc' // WFLOG-INJECTED
* Tahun 2018: hitung log natural r_ln_capital_additions_nominal dari capital_additions_nominal hanya saat capital_additions_nominal > 0 dan terisi; nilai nol, negatif, atau kosong dibiarkan missing. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_ln_capital_additions_nominal=ln(capital_additions_nominal) if source_year==2018 & capital_additions_nominal>0 & !missing(capital_additions_nominal)
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L27:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 27 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L28:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 28 46 `=_rc' // WFLOG-INJECTED
* Tahun 2018: bila r_ln_capital_additions_nominal terisi (inputnya positif dan log berhasil dihitung), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace cr171_state=0 if source_year==2018 & !missing(r_ln_capital_additions_nominal)
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L28:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 28 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L29:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 29 46 `=_rc' // WFLOG-INJECTED
* Tahun 2019: status awal mencatat 3 bila capital_additions_nominal kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace cr171_state=cond(missing(capital_additions_nominal),3,cond(capital_additions_nominal<0,2,cond(capital_additions_nominal==0,1,0))) if source_year==2019
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L29:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 29 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L30:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 30 46 `=_rc' // WFLOG-INJECTED
* Tahun 2019: hitung log natural r_ln_capital_additions_nominal dari capital_additions_nominal hanya saat capital_additions_nominal > 0 dan terisi; nilai nol, negatif, atau kosong dibiarkan missing. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_ln_capital_additions_nominal=ln(capital_additions_nominal) if source_year==2019 & capital_additions_nominal>0 & !missing(capital_additions_nominal)
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L30:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 30 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L31:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 31 46 `=_rc' // WFLOG-INJECTED
* Tahun 2019: bila r_ln_capital_additions_nominal terisi (inputnya positif dan log berhasil dihitung), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace cr171_state=0 if source_year==2019 & !missing(r_ln_capital_additions_nominal)
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L31:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 31 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L32:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 32 46 `=_rc' // WFLOG-INJECTED
* Tahun 2020: status awal mencatat 3 bila capital_additions_nominal kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace cr171_state=cond(missing(capital_additions_nominal),3,cond(capital_additions_nominal<0,2,cond(capital_additions_nominal==0,1,0))) if source_year==2020
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L32:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 32 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L33:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 33 46 `=_rc' // WFLOG-INJECTED
* Tahun 2020: hitung log natural r_ln_capital_additions_nominal dari capital_additions_nominal hanya saat capital_additions_nominal > 0 dan terisi; nilai nol, negatif, atau kosong dibiarkan missing. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_ln_capital_additions_nominal=ln(capital_additions_nominal) if source_year==2020 & capital_additions_nominal>0 & !missing(capital_additions_nominal)
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L33:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 33 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L34:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 34 46 `=_rc' // WFLOG-INJECTED
* Tahun 2020: bila r_ln_capital_additions_nominal terisi (inputnya positif dan log berhasil dihitung), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace cr171_state=0 if source_year==2020 & !missing(r_ln_capital_additions_nominal)
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L34:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 34 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L35:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 35 46 `=_rc' // WFLOG-INJECTED
* Tahun 2021: status awal mencatat 3 bila capital_additions_nominal kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace cr171_state=cond(missing(capital_additions_nominal),3,cond(capital_additions_nominal<0,2,cond(capital_additions_nominal==0,1,0))) if source_year==2021
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L35:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 35 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L36:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 36 46 `=_rc' // WFLOG-INJECTED
* Tahun 2021: hitung log natural r_ln_capital_additions_nominal dari capital_additions_nominal hanya saat capital_additions_nominal > 0 dan terisi; nilai nol, negatif, atau kosong dibiarkan missing. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_ln_capital_additions_nominal=ln(capital_additions_nominal) if source_year==2021 & capital_additions_nominal>0 & !missing(capital_additions_nominal)
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L36:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 36 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L37:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 37 46 `=_rc' // WFLOG-INJECTED
* Tahun 2021: bila r_ln_capital_additions_nominal terisi (inputnya positif dan log berhasil dihitung), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace cr171_state=0 if source_year==2021 & !missing(r_ln_capital_additions_nominal)
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L37:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 37 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L38:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 38 46 `=_rc' // WFLOG-INJECTED
* Tahun 2022: status awal mencatat 3 bila capital_additions_nominal kosong, 2 bila negatif, 1 bila nol, dan 0 bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung. // WFDOC-INJECTED
replace cr171_state=cond(missing(capital_additions_nominal),3,cond(capital_additions_nominal<0,2,cond(capital_additions_nominal==0,1,0))) if source_year==2022
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L38:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 38 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L39:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 39 46 `=_rc' // WFLOG-INJECTED
* Tahun 2022: hitung log natural r_ln_capital_additions_nominal dari capital_additions_nominal hanya saat capital_additions_nominal > 0 dan terisi; nilai nol, negatif, atau kosong dibiarkan missing. Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya. // WFDOC-INJECTED
replace r_ln_capital_additions_nominal=ln(capital_additions_nominal) if source_year==2022 & capital_additions_nominal>0 & !missing(capital_additions_nominal)
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L39:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 39 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L40:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 40 46 `=_rc' // WFLOG-INJECTED
* Tahun 2022: bila r_ln_capital_additions_nominal terisi (inputnya positif dan log berhasil dihitung), kode status akhir diubah menjadi 0. // WFDOC-INJECTED
replace cr171_state=0 if source_year==2022 & !missing(r_ln_capital_additions_nominal)
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L40:step-replace" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 40 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L41:step-assert" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 41 46 `=_rc' // WFLOG-INJECTED
* Pastikan r_ln_capital_additions_nominal tetap kosong di Stata (missing) pada status 8/9; kode ini menangkap angka yang terisi tanpa dasar hitung. // WFDOC-INJECTED
assert missing(r_ln_capital_additions_nominal) if inlist(cr171_state,8,9)
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L41:step-assert" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 41 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L42:step-keep" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 42 46 `=_rc' // WFLOG-INJECTED
* Simpan hanya kunci baris, r_ln_capital_additions_nominal, dan statusnya agar keluaran tidak membawa kolom sumber lain. // WFDOC-INJECTED
keep source_year source_row r_ln_capital_additions_nominal cr171_state
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L42:step-keep" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 42 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L43:step-order" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 43 46 `=_rc' // WFLOG-INJECTED
order source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L43:step-order" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 43 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L44:step-isid" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 44 46 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L44:step-isid" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 44 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L45:step-assert" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 45 46 `=_rc' // WFLOG-INJECTED
assert _N==33049
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L45:step-assert" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 45 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CR171_log.do:L46:step-g0c_finish" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 46 46 `=_rc' // WFLOG-INJECTED
* Tutup log, simpan tabel koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "CR171_log" "CR171"
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L46:step-g0c_finish" "rows/G0/corrections/CR171_log.do:L1:file" "statement" 46 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/CR171_log.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
