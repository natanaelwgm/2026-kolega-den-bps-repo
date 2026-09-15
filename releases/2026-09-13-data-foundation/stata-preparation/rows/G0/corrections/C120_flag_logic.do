* Tujuan: Hitung pemeriksaan yang berlaku, teramati, tidak diketahui, dan negatif; gunakan hitungan itu untuk membentuk keputusan ringkas. // WFDOC-INJECTED
* Input: corrections/data/C110.dta // WFDOC-INJECTED
* Output: corrections/data/C120.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L1:step-version" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 1 103 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L1:step-version" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 1 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L2:step-do" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 2 103 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L2:step-do" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 2 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L3:step-g0c_begin" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 3 103 `=_rc' // WFLOG-INJECTED
g0c_begin "C120_flag_logic"
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L3:step-g0c_begin" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 3 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L4:step-use" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 4 103 `=_rc' // WFLOG-INJECTED
* Hitung jumlah pemeriksaan kuantitas yang berlaku, teramati, belum diketahui, dan bertanda negatif sebelum membentuk flag ringkas. // WFDOC-INJECTED
use  using "corrections/data/C110.dta", clear
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L4:step-use" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 4 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L5:step-generate" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 5 103 `=_rc' // WFLOG-INJECTED
generate byte n_quantity_tests=0
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L5:step-generate" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 5 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L6:step-generate" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 6 103 `=_rc' // WFLOG-INJECTED
generate byte n_quantity_unknown=0
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L6:step-generate" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 6 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L7:step-generate" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 7 103 `=_rc' // WFLOG-INJECTED
generate byte __n_applicable=0
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L7:step-generate" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 7 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L8:step-generate" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 8 103 `=_rc' // WFLOG-INJECTED
generate byte __n_negative=0
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L8:step-generate" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 8 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L9:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 9 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq001_applicable
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L9:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 9 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L10:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 10 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_tests=n_quantity_tests+(cq001_applicable==1 & !missing(qn_fuel_diesel_ltr))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L10:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 10 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L11:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 11 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_unknown=n_quantity_unknown+(cq001_applicable==1 & missing(qn_fuel_diesel_ltr))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L11:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 11 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L12:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 12 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq001_applicable==1 & qn_fuel_diesel_ltr==1)
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L12:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 12 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L13:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 13 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq002_applicable
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L13:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 13 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L14:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 14 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_tests=n_quantity_tests+(cq002_applicable==1 & !missing(qn_fuel_petrol_ltr))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L14:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 14 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L15:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 15 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_unknown=n_quantity_unknown+(cq002_applicable==1 & missing(qn_fuel_petrol_ltr))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L15:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 15 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L16:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 16 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq002_applicable==1 & qn_fuel_petrol_ltr==1)
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L16:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 16 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L17:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 17 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq003_applicable
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L17:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 17 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L18:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 18 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_tests=n_quantity_tests+(cq003_applicable==1 & !missing(qn_fuel_kerosene_ltr))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L18:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 18 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L19:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 19 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_unknown=n_quantity_unknown+(cq003_applicable==1 & missing(qn_fuel_kerosene_ltr))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L19:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 19 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L20:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 20 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq003_applicable==1 & qn_fuel_kerosene_ltr==1)
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L20:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 20 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L21:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 21 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq004_applicable
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L21:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 21 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L22:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 22 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_tests=n_quantity_tests+(cq004_applicable==1 & !missing(qn_fuel_coal_kg))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L22:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 22 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L23:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 23 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_unknown=n_quantity_unknown+(cq004_applicable==1 & missing(qn_fuel_coal_kg))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L23:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 23 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L24:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 24 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq004_applicable==1 & qn_fuel_coal_kg==1)
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L24:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 24 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L25:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 25 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq005_applicable
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L25:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 25 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L26:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 26 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_tests=n_quantity_tests+(cq005_applicable==1 & !missing(qn_fuel_lpg_kg))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L26:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 26 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L27:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 27 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_unknown=n_quantity_unknown+(cq005_applicable==1 & missing(qn_fuel_lpg_kg))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L27:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 27 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L28:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 28 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq005_applicable==1 & qn_fuel_lpg_kg==1)
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L28:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 28 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L29:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 29 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq006_applicable
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L29:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 29 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L30:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 30 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_tests=n_quantity_tests+(cq006_applicable==1 & !missing(qn_fuel_citygas_m3))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L30:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 30 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L31:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 31 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_unknown=n_quantity_unknown+(cq006_applicable==1 & missing(qn_fuel_citygas_m3))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L31:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 31 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L32:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 32 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq006_applicable==1 & qn_fuel_citygas_m3==1)
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L32:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 32 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L33:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 33 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq007_applicable
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L33:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 33 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L34:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 34 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_tests=n_quantity_tests+(cq007_applicable==1 & !missing(qn_fuel_othergas_m3))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L34:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 34 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L35:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 35 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_unknown=n_quantity_unknown+(cq007_applicable==1 & missing(qn_fuel_othergas_m3))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L35:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 35 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L36:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 36 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq007_applicable==1 & qn_fuel_othergas_m3==1)
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L36:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 36 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L37:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 37 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq008_applicable
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L37:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 37 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L38:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 38 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_tests=n_quantity_tests+(cq008_applicable==1 & !missing(qn_fuel_coalbriq_kg))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L38:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 38 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L39:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 39 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_unknown=n_quantity_unknown+(cq008_applicable==1 & missing(qn_fuel_coalbriq_kg))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L39:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 39 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L40:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 40 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq008_applicable==1 & qn_fuel_coalbriq_kg==1)
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L40:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 40 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L41:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 41 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq009_applicable
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L41:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 41 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L42:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 42 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_tests=n_quantity_tests+(cq009_applicable==1 & !missing(qn_fuel_coke_kg))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L42:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 42 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L43:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 43 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_unknown=n_quantity_unknown+(cq009_applicable==1 & missing(qn_fuel_coke_kg))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L43:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 43 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L44:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 44 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq009_applicable==1 & qn_fuel_coke_kg==1)
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L44:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 44 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L45:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 45 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq010_applicable
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L45:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 45 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L46:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 46 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_tests=n_quantity_tests+(cq010_applicable==1 & !missing(qn_fuel_firewood_kg))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L46:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 46 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L47:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 47 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_unknown=n_quantity_unknown+(cq010_applicable==1 & missing(qn_fuel_firewood_kg))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L47:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 47 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L48:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 48 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq010_applicable==1 & qn_fuel_firewood_kg==1)
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L48:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 48 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L49:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 49 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq011_applicable
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L49:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 49 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L50:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 50 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_tests=n_quantity_tests+(cq011_applicable==1 & !missing(qn_fuel_charcoal_kg))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L50:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 50 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L51:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 51 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_unknown=n_quantity_unknown+(cq011_applicable==1 & missing(qn_fuel_charcoal_kg))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L51:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 51 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L52:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 52 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq011_applicable==1 & qn_fuel_charcoal_kg==1)
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L52:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 52 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L53:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 53 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq012_applicable
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L53:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 53 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L54:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 54 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_tests=n_quantity_tests+(cq012_applicable==1 & !missing(qn_fuel_dieseloil_ltr))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L54:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 54 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L55:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 55 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_unknown=n_quantity_unknown+(cq012_applicable==1 & missing(qn_fuel_dieseloil_ltr))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L55:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 55 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L56:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 56 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq012_applicable==1 & qn_fuel_dieseloil_ltr==1)
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L56:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 56 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L57:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 57 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq013_applicable
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L57:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 57 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L58:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 58 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_tests=n_quantity_tests+(cq013_applicable==1 & !missing(qn_fuel_fueloil_ltr))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L58:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 58 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L59:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 59 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_unknown=n_quantity_unknown+(cq013_applicable==1 & missing(qn_fuel_fueloil_ltr))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L59:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 59 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L60:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 60 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq013_applicable==1 & qn_fuel_fueloil_ltr==1)
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L60:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 60 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L61:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 61 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq014_applicable
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L61:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 61 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L62:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 62 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_tests=n_quantity_tests+(cq014_applicable==1 & !missing(qn_fuel_lubricant_ltr))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L62:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 62 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L63:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 63 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_unknown=n_quantity_unknown+(cq014_applicable==1 & missing(qn_fuel_lubricant_ltr))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L63:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 63 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L64:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 64 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq014_applicable==1 & qn_fuel_lubricant_ltr==1)
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L64:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 64 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L65:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 65 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq015_applicable
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L65:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 65 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L66:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 66 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_tests=n_quantity_tests+(cq015_applicable==1 & !missing(qn_fuel_biodiesel_ltr))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L66:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 66 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L67:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 67 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_unknown=n_quantity_unknown+(cq015_applicable==1 & missing(qn_fuel_biodiesel_ltr))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L67:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 67 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L68:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 68 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq015_applicable==1 & qn_fuel_biodiesel_ltr==1)
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L68:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 68 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L69:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 69 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq016_applicable
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L69:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 69 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L70:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 70 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_tests=n_quantity_tests+(cq016_applicable==1 & !missing(qn_fuel_natgas_kg))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L70:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 70 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L71:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 71 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_unknown=n_quantity_unknown+(cq016_applicable==1 & missing(qn_fuel_natgas_kg))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L71:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 71 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L72:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 72 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq016_applicable==1 & qn_fuel_natgas_kg==1)
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L72:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 72 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L73:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 73 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq017_applicable
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L73:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 73 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L74:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 74 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_tests=n_quantity_tests+(cq017_applicable==1 & !missing(qn_fuel_natgas_mmbtu))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L74:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 74 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L75:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 75 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_unknown=n_quantity_unknown+(cq017_applicable==1 & missing(qn_fuel_natgas_mmbtu))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L75:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 75 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L76:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 76 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq017_applicable==1 & qn_fuel_natgas_mmbtu==1)
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L76:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 76 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L77:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 77 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq018_applicable
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L77:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 77 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L78:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 78 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_tests=n_quantity_tests+(cq018_applicable==1 & !missing(qn_fuel_biomass_kg))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L78:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 78 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L79:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 79 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_unknown=n_quantity_unknown+(cq018_applicable==1 & missing(qn_fuel_biomass_kg))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L79:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 79 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L80:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 80 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq018_applicable==1 & qn_fuel_biomass_kg==1)
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L80:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 80 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L81:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 81 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq019_applicable
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L81:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 81 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L82:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 82 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_tests=n_quantity_tests+(cq019_applicable==1 & !missing(qn_elec_pln_kwh))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L82:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 82 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L83:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 83 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_unknown=n_quantity_unknown+(cq019_applicable==1 & missing(qn_elec_pln_kwh))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L83:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 83 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L84:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 84 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq019_applicable==1 & qn_elec_pln_kwh==1)
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L84:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 84 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L85:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 85 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq020_applicable
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L85:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 85 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L86:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 86 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_tests=n_quantity_tests+(cq020_applicable==1 & !missing(qn_elec_nonpln_kwh))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L86:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 86 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L87:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 87 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_unknown=n_quantity_unknown+(cq020_applicable==1 & missing(qn_elec_nonpln_kwh))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L87:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 87 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L88:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 88 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq020_applicable==1 & qn_elec_nonpln_kwh==1)
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L88:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 88 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L89:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 89 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq021_applicable
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L89:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 89 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L90:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 90 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_tests=n_quantity_tests+(cq021_applicable==1 & !missing(qn_elec_owngen_kwh))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L90:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 90 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L91:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 91 103 `=_rc' // WFLOG-INJECTED
replace n_quantity_unknown=n_quantity_unknown+(cq021_applicable==1 & missing(qn_elec_owngen_kwh))
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L91:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 91 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L92:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 92 103 `=_rc' // WFLOG-INJECTED
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq021_applicable==1 & qn_elec_owngen_kwh==1)
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L92:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 92 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L93:step-assert" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 93 103 `=_rc' // WFLOG-INJECTED
assert n_quantity_tests+n_quantity_unknown==__n_applicable
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L93:step-assert" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 93 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L94:step-generate" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 94 103 `=_rc' // WFLOG-INJECTED
generate byte any_negative_observed=__n_negative>0 if n_quantity_tests>0
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L94:step-generate" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 94 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L95:step-generate" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 95 103 `=_rc' // WFLOG-INJECTED
generate byte any_negative_decision=1 if __n_negative>0
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L95:step-generate" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 95 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L96:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 96 103 `=_rc' // WFLOG-INJECTED
replace any_negative_decision=0 if __n_negative==0 & n_quantity_unknown==0 & __n_applicable>0
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L96:step-replace" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 96 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L97:step-generate" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 97 103 `=_rc' // WFLOG-INJECTED
generate byte all_applicable_tests_observed=n_quantity_unknown==0 if __n_applicable>0
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L97:step-generate" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 97 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L98:step-assert" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 98 103 `=_rc' // WFLOG-INJECTED
assert all_applicable_tests_observed==0 if n_quantity_unknown>0
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L98:step-assert" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 98 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L99:step-keep" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 99 103 `=_rc' // WFLOG-INJECTED
keep source_year source_row n_quantity_tests n_quantity_unknown any_negative_observed any_negative_decision all_applicable_tests_observed
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L99:step-keep" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 99 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L100:step-order" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 100 103 `=_rc' // WFLOG-INJECTED
order source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L100:step-order" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 100 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L101:step-isid" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 101 103 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L101:step-isid" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 101 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L102:step-assert" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 102 103 `=_rc' // WFLOG-INJECTED
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L102:step-assert" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 102 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C120_flag_logic.do:L103:step-g0c_finish" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 103 103 `=_rc' // WFLOG-INJECTED
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C120_flag_logic" "C120"
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L103:step-g0c_finish" "rows/G0/corrections/C120_flag_logic.do:L1:file" "statement" 103 103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/C120_flag_logic.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
