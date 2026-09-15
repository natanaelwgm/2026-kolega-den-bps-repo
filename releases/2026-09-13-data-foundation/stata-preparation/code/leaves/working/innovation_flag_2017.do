* Tujuan: Tambahkan empat flag inovasi untuk wave 2017 dari hasil tunnel, setelah mengosongkan salinan lama dengan nama sama. // WFDOC-INJECTED
* Input: verified_wave_2017.dta serta empat tabel tunnel product/process/marketing/organization yang dipasangkan per source_year/source_row. // WFDOC-INJECTED
* Output: wave 2017 dengan empat flag dan status masing-masing, plus ringkasan teramati/verified-only/provisional. // WFDOC-INJECTED
* Jika satu pasangan kunci tidak ditemukan, merge berhenti dan wave belum siap. // WFDOC-INJECTED
capture noisily __wf_progress start "code/leaves/working/innovation_flag_2017.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/working/innovation_flag_2017.do:L1:step-do" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 1 21 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
capture noisily __wf_progress end "code/leaves/working/innovation_flag_2017.do:L1:step-do" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 1 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/working/innovation_flag_2017.do:L2:step-use" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 2 21 `=_rc' // WFLOG-INJECTED
* Muat wave terverifikasi tahun 2017; nilai ini menjadi master yang menerima empat flag inovasi dari do-file tunnel. // WFDOC-INJECTED
use "data/intermediate/verified_wave_2017.dta", clear
capture noisily __wf_progress end "code/leaves/working/innovation_flag_2017.do:L2:step-use" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 2 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/working/innovation_flag_2017.do:L3:step-assert" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 3 21 `=_rc' // WFLOG-INJECTED
* Pastikan semua baris milik tahun 2017. // WFDOC-INJECTED
assert source_year==2017
capture noisily __wf_progress end "code/leaves/working/innovation_flag_2017.do:L3:step-assert" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 3 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/working/innovation_flag_2017.do:L4:step-isid" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 4 21 `=_rc' // WFLOG-INJECTED
* Pastikan satu pasangan source_year/source_row hanya muncul sekali; kunci ini bukan firmID. // WFDOC-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/leaves/working/innovation_flag_2017.do:L4:step-isid" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 4 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/working/innovation_flag_2017.do:L5:step-drop" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 5 21 `=_rc' // WFLOG-INJECTED
* Hapus salinan lama innovation_product_flag dan statusnya agar hasil tunnel tahun ini dapat dimasukkan tanpa nama kolom ganda. // WFDOC-INJECTED
capture drop innovation_product_flag
capture noisily __wf_progress end "code/leaves/working/innovation_flag_2017.do:L5:step-drop" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 5 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/working/innovation_flag_2017.do:L6:step-drop" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 6 21 `=_rc' // WFLOG-INJECTED
capture drop vs_innovation_product_flag
capture noisily __wf_progress end "code/leaves/working/innovation_flag_2017.do:L6:step-drop" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 6 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/working/innovation_flag_2017.do:L7:step-merge" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 7 21 `=_rc' // WFLOG-INJECTED
* Tambahkan innovation_product_flag beserta statusnya menurut source_year/source_row; assert(match) menghentikan merge jika ada baris tanpa pasangan. // WFDOC-INJECTED
merge 1:1 source_year source_row using "dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_product_flag_2017.dta", assert(match) nogen keepusing(innovation_product_flag vs_innovation_product_flag)
capture noisily __wf_progress end "code/leaves/working/innovation_flag_2017.do:L7:step-merge" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 7 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/working/innovation_flag_2017.do:L8:step-drop" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 8 21 `=_rc' // WFLOG-INJECTED
* Hapus salinan lama innovation_process_flag dan statusnya agar hasil tunnel tahun ini dapat dimasukkan tanpa nama kolom ganda. // WFDOC-INJECTED
capture drop innovation_process_flag
capture noisily __wf_progress end "code/leaves/working/innovation_flag_2017.do:L8:step-drop" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 8 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/working/innovation_flag_2017.do:L9:step-drop" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 9 21 `=_rc' // WFLOG-INJECTED
capture drop vs_innovation_process_flag
capture noisily __wf_progress end "code/leaves/working/innovation_flag_2017.do:L9:step-drop" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 9 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/working/innovation_flag_2017.do:L10:step-merge" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 10 21 `=_rc' // WFLOG-INJECTED
* Tambahkan innovation_process_flag beserta statusnya menurut source_year/source_row; assert(match) menghentikan merge jika ada baris tanpa pasangan. // WFDOC-INJECTED
merge 1:1 source_year source_row using "dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_process_flag_2017.dta", assert(match) nogen keepusing(innovation_process_flag vs_innovation_process_flag)
capture noisily __wf_progress end "code/leaves/working/innovation_flag_2017.do:L10:step-merge" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 10 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/working/innovation_flag_2017.do:L11:step-drop" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 11 21 `=_rc' // WFLOG-INJECTED
* Hapus salinan lama innovation_marketing_flag dan statusnya agar hasil tunnel tahun ini dapat dimasukkan tanpa nama kolom ganda. // WFDOC-INJECTED
capture drop innovation_marketing_flag
capture noisily __wf_progress end "code/leaves/working/innovation_flag_2017.do:L11:step-drop" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 11 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/working/innovation_flag_2017.do:L12:step-drop" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 12 21 `=_rc' // WFLOG-INJECTED
capture drop vs_innovation_marketing_flag
capture noisily __wf_progress end "code/leaves/working/innovation_flag_2017.do:L12:step-drop" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 12 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/working/innovation_flag_2017.do:L13:step-merge" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 13 21 `=_rc' // WFLOG-INJECTED
* Tambahkan innovation_marketing_flag beserta statusnya menurut source_year/source_row; assert(match) menghentikan merge jika ada baris tanpa pasangan. // WFDOC-INJECTED
merge 1:1 source_year source_row using "dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_marketing_flag_2017.dta", assert(match) nogen keepusing(innovation_marketing_flag vs_innovation_marketing_flag)
capture noisily __wf_progress end "code/leaves/working/innovation_flag_2017.do:L13:step-merge" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 13 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/working/innovation_flag_2017.do:L14:step-drop" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 14 21 `=_rc' // WFLOG-INJECTED
* Hapus salinan lama innovation_org_flag dan statusnya agar hasil tunnel tahun ini dapat dimasukkan tanpa nama kolom ganda. // WFDOC-INJECTED
capture drop innovation_org_flag
capture noisily __wf_progress end "code/leaves/working/innovation_flag_2017.do:L14:step-drop" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 14 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/working/innovation_flag_2017.do:L15:step-drop" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 15 21 `=_rc' // WFLOG-INJECTED
capture drop vs_innovation_org_flag
capture noisily __wf_progress end "code/leaves/working/innovation_flag_2017.do:L15:step-drop" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 15 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/working/innovation_flag_2017.do:L16:step-merge" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 16 21 `=_rc' // WFLOG-INJECTED
* Tambahkan innovation_org_flag beserta statusnya menurut source_year/source_row; assert(match) menghentikan merge jika ada baris tanpa pasangan. // WFDOC-INJECTED
merge 1:1 source_year source_row using "dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_org_flag_2017.dta", assert(match) nogen keepusing(innovation_org_flag vs_innovation_org_flag)
capture noisily __wf_progress end "code/leaves/working/innovation_flag_2017.do:L16:step-merge" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 16 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/working/innovation_flag_2017.do:L17:step-tempfile" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 17 21 `=_rc' // WFLOG-INJECTED
tempfile metrics
capture noisily __wf_progress end "code/leaves/working/innovation_flag_2017.do:L17:step-tempfile" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 17 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/working/innovation_flag_2017.do:L18:step-postclose" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 18 21 `=_rc' // WFLOG-INJECTED
capture postclose counts
capture noisily __wf_progress end "code/leaves/working/innovation_flag_2017.do:L18:step-postclose" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 18 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/working/innovation_flag_2017.do:L19:step-postfile" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 19 21 `=_rc' // WFLOG-INJECTED
* Siapkan ringkasan per variabel: seluruh baris, nilai teramati, nilai dari sumber terverifikasi saja, dan nilai provisional. // WFDOC-INJECTED
postfile counts int source_year str32 variable long rows observed verified_only provisional using `metrics', replace
capture noisily __wf_progress end "code/leaves/working/innovation_flag_2017.do:L19:step-postfile" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 19 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/working/innovation_flag_2017.do:L20:step-do" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 20 21 `=_rc' // WFLOG-INJECTED
* Jalankan pengisian flag inovasi untuk wave 2017; metode mempertahankan nilai lama dan hanya mengisi yang kosong sesuai syarat di anaknya. // WFDOC-INJECTED
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do"
capture noisily __wf_progress end "code/leaves/working/innovation_flag_2017.do:L20:step-do" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 20 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/working/innovation_flag_2017.do:L21:step-postclose" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 21 21 `=_rc' // WFLOG-INJECTED
* Tutup tabel hitungan setelah semua flag diperiksa. // WFDOC-INJECTED
postclose counts
capture noisily __wf_progress end "code/leaves/working/innovation_flag_2017.do:L21:step-postclose" "code/leaves/working/innovation_flag_2017.do:L1:file" "statement" 21 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/leaves/working/innovation_flag_2017.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
