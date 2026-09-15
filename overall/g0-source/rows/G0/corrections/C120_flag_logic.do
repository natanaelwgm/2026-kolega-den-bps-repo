* Tujuan: Hitung pemeriksaan yang berlaku, teramati, tidak diketahui, dan negatif; gunakan hitungan itu untuk membentuk keputusan ringkas. // WFDOC-INJECTED
* Input: corrections/data/C110.dta // WFDOC-INJECTED
* Output: corrections/data/C120.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "C120_flag_logic"
* Hitung jumlah pemeriksaan kuantitas yang berlaku, teramati, belum diketahui, dan bertanda negatif sebelum membentuk flag ringkas. // WFDOC-INJECTED
use  using "corrections/data/C110.dta", clear
generate byte n_quantity_tests=0
generate byte n_quantity_unknown=0
generate byte __n_applicable=0
generate byte __n_negative=0
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq001_applicable
replace n_quantity_tests=n_quantity_tests+(cq001_applicable==1 & !missing(qn_fuel_diesel_ltr))
replace n_quantity_unknown=n_quantity_unknown+(cq001_applicable==1 & missing(qn_fuel_diesel_ltr))
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq001_applicable==1 & qn_fuel_diesel_ltr==1)
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq002_applicable
replace n_quantity_tests=n_quantity_tests+(cq002_applicable==1 & !missing(qn_fuel_petrol_ltr))
replace n_quantity_unknown=n_quantity_unknown+(cq002_applicable==1 & missing(qn_fuel_petrol_ltr))
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq002_applicable==1 & qn_fuel_petrol_ltr==1)
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq003_applicable
replace n_quantity_tests=n_quantity_tests+(cq003_applicable==1 & !missing(qn_fuel_kerosene_ltr))
replace n_quantity_unknown=n_quantity_unknown+(cq003_applicable==1 & missing(qn_fuel_kerosene_ltr))
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq003_applicable==1 & qn_fuel_kerosene_ltr==1)
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq004_applicable
replace n_quantity_tests=n_quantity_tests+(cq004_applicable==1 & !missing(qn_fuel_coal_kg))
replace n_quantity_unknown=n_quantity_unknown+(cq004_applicable==1 & missing(qn_fuel_coal_kg))
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq004_applicable==1 & qn_fuel_coal_kg==1)
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq005_applicable
replace n_quantity_tests=n_quantity_tests+(cq005_applicable==1 & !missing(qn_fuel_lpg_kg))
replace n_quantity_unknown=n_quantity_unknown+(cq005_applicable==1 & missing(qn_fuel_lpg_kg))
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq005_applicable==1 & qn_fuel_lpg_kg==1)
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq006_applicable
replace n_quantity_tests=n_quantity_tests+(cq006_applicable==1 & !missing(qn_fuel_citygas_m3))
replace n_quantity_unknown=n_quantity_unknown+(cq006_applicable==1 & missing(qn_fuel_citygas_m3))
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq006_applicable==1 & qn_fuel_citygas_m3==1)
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq007_applicable
replace n_quantity_tests=n_quantity_tests+(cq007_applicable==1 & !missing(qn_fuel_othergas_m3))
replace n_quantity_unknown=n_quantity_unknown+(cq007_applicable==1 & missing(qn_fuel_othergas_m3))
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq007_applicable==1 & qn_fuel_othergas_m3==1)
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq008_applicable
replace n_quantity_tests=n_quantity_tests+(cq008_applicable==1 & !missing(qn_fuel_coalbriq_kg))
replace n_quantity_unknown=n_quantity_unknown+(cq008_applicable==1 & missing(qn_fuel_coalbriq_kg))
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq008_applicable==1 & qn_fuel_coalbriq_kg==1)
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq009_applicable
replace n_quantity_tests=n_quantity_tests+(cq009_applicable==1 & !missing(qn_fuel_coke_kg))
replace n_quantity_unknown=n_quantity_unknown+(cq009_applicable==1 & missing(qn_fuel_coke_kg))
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq009_applicable==1 & qn_fuel_coke_kg==1)
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq010_applicable
replace n_quantity_tests=n_quantity_tests+(cq010_applicable==1 & !missing(qn_fuel_firewood_kg))
replace n_quantity_unknown=n_quantity_unknown+(cq010_applicable==1 & missing(qn_fuel_firewood_kg))
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq010_applicable==1 & qn_fuel_firewood_kg==1)
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq011_applicable
replace n_quantity_tests=n_quantity_tests+(cq011_applicable==1 & !missing(qn_fuel_charcoal_kg))
replace n_quantity_unknown=n_quantity_unknown+(cq011_applicable==1 & missing(qn_fuel_charcoal_kg))
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq011_applicable==1 & qn_fuel_charcoal_kg==1)
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq012_applicable
replace n_quantity_tests=n_quantity_tests+(cq012_applicable==1 & !missing(qn_fuel_dieseloil_ltr))
replace n_quantity_unknown=n_quantity_unknown+(cq012_applicable==1 & missing(qn_fuel_dieseloil_ltr))
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq012_applicable==1 & qn_fuel_dieseloil_ltr==1)
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq013_applicable
replace n_quantity_tests=n_quantity_tests+(cq013_applicable==1 & !missing(qn_fuel_fueloil_ltr))
replace n_quantity_unknown=n_quantity_unknown+(cq013_applicable==1 & missing(qn_fuel_fueloil_ltr))
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq013_applicable==1 & qn_fuel_fueloil_ltr==1)
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq014_applicable
replace n_quantity_tests=n_quantity_tests+(cq014_applicable==1 & !missing(qn_fuel_lubricant_ltr))
replace n_quantity_unknown=n_quantity_unknown+(cq014_applicable==1 & missing(qn_fuel_lubricant_ltr))
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq014_applicable==1 & qn_fuel_lubricant_ltr==1)
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq015_applicable
replace n_quantity_tests=n_quantity_tests+(cq015_applicable==1 & !missing(qn_fuel_biodiesel_ltr))
replace n_quantity_unknown=n_quantity_unknown+(cq015_applicable==1 & missing(qn_fuel_biodiesel_ltr))
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq015_applicable==1 & qn_fuel_biodiesel_ltr==1)
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq016_applicable
replace n_quantity_tests=n_quantity_tests+(cq016_applicable==1 & !missing(qn_fuel_natgas_kg))
replace n_quantity_unknown=n_quantity_unknown+(cq016_applicable==1 & missing(qn_fuel_natgas_kg))
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq016_applicable==1 & qn_fuel_natgas_kg==1)
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq017_applicable
replace n_quantity_tests=n_quantity_tests+(cq017_applicable==1 & !missing(qn_fuel_natgas_mmbtu))
replace n_quantity_unknown=n_quantity_unknown+(cq017_applicable==1 & missing(qn_fuel_natgas_mmbtu))
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq017_applicable==1 & qn_fuel_natgas_mmbtu==1)
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq018_applicable
replace n_quantity_tests=n_quantity_tests+(cq018_applicable==1 & !missing(qn_fuel_biomass_kg))
replace n_quantity_unknown=n_quantity_unknown+(cq018_applicable==1 & missing(qn_fuel_biomass_kg))
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq018_applicable==1 & qn_fuel_biomass_kg==1)
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq019_applicable
replace n_quantity_tests=n_quantity_tests+(cq019_applicable==1 & !missing(qn_elec_pln_kwh))
replace n_quantity_unknown=n_quantity_unknown+(cq019_applicable==1 & missing(qn_elec_pln_kwh))
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq019_applicable==1 & qn_elec_pln_kwh==1)
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq020_applicable
replace n_quantity_tests=n_quantity_tests+(cq020_applicable==1 & !missing(qn_elec_nonpln_kwh))
replace n_quantity_unknown=n_quantity_unknown+(cq020_applicable==1 & missing(qn_elec_nonpln_kwh))
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq020_applicable==1 & qn_elec_nonpln_kwh==1)
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_applicable=__n_applicable+cq021_applicable
replace n_quantity_tests=n_quantity_tests+(cq021_applicable==1 & !missing(qn_elec_owngen_kwh))
replace n_quantity_unknown=n_quantity_unknown+(cq021_applicable==1 & missing(qn_elec_owngen_kwh))
* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif. // WFDOC-INJECTED
replace __n_negative=__n_negative+(cq021_applicable==1 & qn_elec_owngen_kwh==1)
assert n_quantity_tests+n_quantity_unknown==__n_applicable
generate byte any_negative_observed=__n_negative>0 if n_quantity_tests>0
generate byte any_negative_decision=1 if __n_negative>0
replace any_negative_decision=0 if __n_negative==0 & n_quantity_unknown==0 & __n_applicable>0
generate byte all_applicable_tests_observed=n_quantity_unknown==0 if __n_applicable>0
assert all_applicable_tests_observed==0 if n_quantity_unknown>0
keep source_year source_row n_quantity_tests n_quantity_unknown any_negative_observed any_negative_decision all_applicable_tests_observed
order source_year source_row
isid source_year source_row
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C120_flag_logic" "C120"
