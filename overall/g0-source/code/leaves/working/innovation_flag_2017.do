* Tujuan: Tambahkan empat flag inovasi untuk wave 2017 dari hasil tunnel, setelah mengosongkan salinan lama dengan nama sama. // WFDOC-INJECTED
* Input: verified_wave_2017.dta serta empat tabel tunnel product/process/marketing/organization yang dipasangkan per source_year/source_row. // WFDOC-INJECTED
* Output: wave 2017 dengan empat flag dan status masing-masing, plus ringkasan teramati/verified-only/provisional. // WFDOC-INJECTED
* Jika satu pasangan kunci tidak ditemukan, merge berhenti dan wave belum siap. // WFDOC-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
* Muat wave terverifikasi tahun 2017; nilai ini menjadi master yang menerima empat flag inovasi dari do-file tunnel. // WFDOC-INJECTED
use "data/intermediate/verified_wave_2017.dta", clear
* Pastikan semua baris milik tahun 2017. // WFDOC-INJECTED
assert source_year==2017
* Pastikan satu pasangan source_year/source_row hanya muncul sekali; kunci ini bukan firmID. // WFDOC-INJECTED
isid source_year source_row
* Hapus salinan lama innovation_product_flag dan statusnya agar hasil tunnel tahun ini dapat dimasukkan tanpa nama kolom ganda. // WFDOC-INJECTED
capture drop innovation_product_flag
capture drop vs_innovation_product_flag
* Tambahkan innovation_product_flag beserta statusnya menurut source_year/source_row; assert(match) menghentikan merge jika ada baris tanpa pasangan. // WFDOC-INJECTED
merge 1:1 source_year source_row using "dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_product_flag_2017.dta", assert(match) nogen keepusing(innovation_product_flag vs_innovation_product_flag)
* Hapus salinan lama innovation_process_flag dan statusnya agar hasil tunnel tahun ini dapat dimasukkan tanpa nama kolom ganda. // WFDOC-INJECTED
capture drop innovation_process_flag
capture drop vs_innovation_process_flag
* Tambahkan innovation_process_flag beserta statusnya menurut source_year/source_row; assert(match) menghentikan merge jika ada baris tanpa pasangan. // WFDOC-INJECTED
merge 1:1 source_year source_row using "dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_process_flag_2017.dta", assert(match) nogen keepusing(innovation_process_flag vs_innovation_process_flag)
* Hapus salinan lama innovation_marketing_flag dan statusnya agar hasil tunnel tahun ini dapat dimasukkan tanpa nama kolom ganda. // WFDOC-INJECTED
capture drop innovation_marketing_flag
capture drop vs_innovation_marketing_flag
* Tambahkan innovation_marketing_flag beserta statusnya menurut source_year/source_row; assert(match) menghentikan merge jika ada baris tanpa pasangan. // WFDOC-INJECTED
merge 1:1 source_year source_row using "dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_marketing_flag_2017.dta", assert(match) nogen keepusing(innovation_marketing_flag vs_innovation_marketing_flag)
* Hapus salinan lama innovation_org_flag dan statusnya agar hasil tunnel tahun ini dapat dimasukkan tanpa nama kolom ganda. // WFDOC-INJECTED
capture drop innovation_org_flag
capture drop vs_innovation_org_flag
* Tambahkan innovation_org_flag beserta statusnya menurut source_year/source_row; assert(match) menghentikan merge jika ada baris tanpa pasangan. // WFDOC-INJECTED
merge 1:1 source_year source_row using "dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_org_flag_2017.dta", assert(match) nogen keepusing(innovation_org_flag vs_innovation_org_flag)
tempfile metrics
capture postclose counts
* Siapkan ringkasan per variabel: seluruh baris, nilai teramati, nilai dari sumber terverifikasi saja, dan nilai provisional. // WFDOC-INJECTED
postfile counts int source_year str32 variable long rows observed verified_only provisional using `metrics', replace
* Jalankan pengisian flag inovasi untuk wave 2017; metode mempertahankan nilai lama dan hanya mengisi yang kosong sesuai syarat di anaknya. // WFDOC-INJECTED
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do"
* Tutup tabel hitungan setelah semua flag diperiksa. // WFDOC-INJECTED
postclose counts
