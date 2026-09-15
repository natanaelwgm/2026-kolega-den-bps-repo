* Tujuan: Jalankan perintah yang tercantum di file ini pada data atau argumen yang disediakan pemanggilnya. // WFDOC-INJECTED
* Input: dag/data/word_data/G0/G0_energy_fields.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/G0_energy_emissions.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
* Adapt E006-E017 onto provenance key, preserving inputs and explicit missingness.
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L2:step-use" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 1 63 `=_rc' // WFLOG-INJECTED
use "$G0D/G0_energy_fields.dta", clear
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L2:step-use" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 1 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L3:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 2 63 `=_rc' // WFLOG-INJECTED
generate byte any_negative_quantity=0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L3:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 2 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L4:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 3 63 `=_rc' // WFLOG-INJECTED
generate byte any_implausible_price=0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L4:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 3 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L5:step-foreach" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "loop" 4 63 `=_rc' "varlist" `"fuel_* elec_*"' // WFLOG-INJECTED
* Ulangi blok sesuai rentang atau daftar yang ditetapkan di baris ini. // WFDOC-INJECTED
foreach v of varlist fuel_* elec_* {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L5:iteration-body" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L5:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L6:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L5:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
    generate double cl_`v'=`v' if `v'>=0 & !missing(`v')
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L6:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L5:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L5:iteration-body" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L5:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L5:step-foreach" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "loop" 4 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L8:step-foreach" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "loop" 5 63 `=_rc' "in" `"diesel petrol kerosene coal lpg citygas othergas coalbriq coke firewood charcoal dieseloil fueloil lubricant biodiesel natgas"' // WFLOG-INJECTED
* Ulangi blok untuk setiap f yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach f in diesel petrol kerosene coal lpg citygas othergas coalbriq coke firewood charcoal dieseloil fueloil lubricant biodiesel natgas {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L8:iteration-body" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L8:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L9:step-local" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L8:iteration-body" "statement" 1 7 `=_rc' // WFLOG-INJECTED
    local unit ltr
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L9:step-local" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L8:iteration-body" "statement" 1 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L10:step-if" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L8:iteration-body" "statement" 2 7 `=_rc' // WFLOG-INJECTED
    if inlist("`f'","coal","lpg","coalbriq","coke","firewood","charcoal","natgas") local unit kg
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L10:step-if" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L8:iteration-body" "statement" 2 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L11:step-if" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L8:iteration-body" "statement" 3 7 `=_rc' // WFLOG-INJECTED
    if inlist("`f'","citygas","othergas") local unit m3
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L11:step-if" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L8:iteration-body" "statement" 3 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L12:step-replace" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L8:iteration-body" "statement" 4 7 `=_rc' // WFLOG-INJECTED
    replace any_negative_quantity=1 if fuel_`f'_`unit'<0 & !missing(fuel_`f'_`unit')
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L12:step-replace" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L8:iteration-body" "statement" 4 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L13:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L8:iteration-body" "statement" 5 7 `=_rc' // WFLOG-INJECTED
    generate double price_`f'=fuel_`f'_rp000/fuel_`f'_`unit' if fuel_`f'_`unit'>0 & !missing(fuel_`f'_`unit',fuel_`f'_rp000) & fuel_`f'_rp000>=0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L13:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L8:iteration-body" "statement" 5 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L14:step-bysort" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L8:iteration-body" "statement" 6 7 `=_rc' // WFLOG-INJECTED
    bysort source_year: egen double p99_`f'=pctile(price_`f'), p(99)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L14:step-bysort" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L8:iteration-body" "statement" 6 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L15:step-replace" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L8:iteration-body" "statement" 7 7 `=_rc' // WFLOG-INJECTED
    replace any_implausible_price=1 if price_`f'>10*p99_`f' & !missing(price_`f',p99_`f') & p99_`f'>0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L15:step-replace" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L8:iteration-body" "statement" 7 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L8:iteration-body" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L8:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L8:step-foreach" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "loop" 5 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L17:step-foreach" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "loop" 6 63 `=_rc' "in" `"pln nonpln owngen"' // WFLOG-INJECTED
* Ulangi blok untuk f: pln, nonpln, owngen. // WFDOC-INJECTED
foreach f in pln nonpln owngen {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L17:iteration-body" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L17:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L18:step-replace" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L17:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
    replace any_negative_quantity=1 if elec_`f'_kwh<0 & !missing(elec_`f'_kwh)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L18:step-replace" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L17:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L17:iteration-body" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L17:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L17:step-foreach" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "loop" 6 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L20:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 7 63 `=_rc' // WFLOG-INJECTED
generate double price_elec=elec_pln_rp000/elec_pln_kwh if elec_pln_kwh>0 & !missing(elec_pln_kwh,elec_pln_rp000) & elec_pln_rp000>=0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L20:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 7 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L21:step-bysort" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 8 63 `=_rc' // WFLOG-INJECTED
bysort source_year: egen double p99_elec=pctile(price_elec), p(99)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L21:step-bysort" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 8 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L22:step-replace" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 9 63 `=_rc' // WFLOG-INJECTED
replace any_implausible_price=1 if price_elec>10*p99_elec & !missing(price_elec,p99_elec) & p99_elec>0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L22:step-replace" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 9 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L23:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 10 63 `=_rc' // WFLOG-INJECTED
generate byte energy_outlier_flag=any_negative_quantity | any_implausible_price
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L23:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 10 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L24:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 11 63 `=_rc' // WFLOG-INJECTED
generate byte energy_outlier_flag_legacy=0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L24:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 11 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L25:step-foreach" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "loop" 12 63 `=_rc' "in" `"diesel petrol kerosene coal lpg citygas othergas coalbriq coke elec"' // WFLOG-INJECTED
* Ulangi blok untuk setiap f yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach f in diesel petrol kerosene coal lpg citygas othergas coalbriq coke elec {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L25:iteration-body" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L25:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L26:step-replace" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L25:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
    replace energy_outlier_flag_legacy=1 if price_`f'>10*p99_`f' & !missing(price_`f',p99_`f') & p99_`f'>0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L26:step-replace" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L25:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L25:iteration-body" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L25:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L25:step-foreach" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "loop" 12 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L28:step-foreach" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "loop" 13 63 `=_rc' "in" `"fuel_diesel_ltr fuel_petrol_ltr fuel_kerosene_ltr fuel_coal_kg fuel_lpg_kg fuel_citygas_m3 fuel_othergas_m3 fuel_coalbriq_kg fuel_coke_kg fuel_firewood_kg fuel_charcoal_kg fuel_dieseloil_ltr fuel_fueloil_ltr fuel_lubricant_ltr elec_pln_kwh elec_nonpln_kwh elec_owngen_kwh"' // WFLOG-INJECTED
* Ulangi blok untuk setiap v yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach v in fuel_diesel_ltr fuel_petrol_ltr fuel_kerosene_ltr fuel_coal_kg fuel_lpg_kg fuel_citygas_m3 fuel_othergas_m3 fuel_coalbriq_kg fuel_coke_kg fuel_firewood_kg fuel_charcoal_kg fuel_dieseloil_ltr fuel_fueloil_ltr fuel_lubricant_ltr elec_pln_kwh elec_nonpln_kwh elec_owngen_kwh {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L28:iteration-body" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L28:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L29:step-replace" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L28:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
    replace energy_outlier_flag_legacy=1 if `v'<0 & !missing(`v')
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L29:step-replace" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L28:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L28:iteration-body" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L28:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L28:step-foreach" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "loop" 13 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L31:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 14 63 `=_rc' // WFLOG-INJECTED
generate str80 outlier_rule="negative_or_gt10x_year_p99; all_mapped_prices; legacy_flag_separate"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L31:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 14 63 `=_rc' // WFLOG-INJECTED

capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L33:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 15 63 `=_rc' // WFLOG-INJECTED
generate str48 cleaning_status="retained_all_rows; negatives_excluded_in_cl_fields"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L33:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 15 63 `=_rc' // WFLOG-INJECTED
* Legacy 9-fuel factors. Original source quantity remains untouched.
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L35:step-local" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 16 63 `=_rc' // WFLOG-INJECTED
local fuels "diesel petrol kerosene coal lpg citygas othergas coalbriq coke"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L35:step-local" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 16 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L36:step-local" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 17 63 `=_rc' // WFLOG-INJECTED
local units "ltr ltr ltr kg kg m3 m3 kg kg"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L36:step-local" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 17 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L37:step-local" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 18 63 `=_rc' // WFLOG-INJECTED
local c1 ".002654 .00231 .002494 .002496 .002876 .002695 .002695 .002877 .00284"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L37:step-local" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 18 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L38:step-local" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 19 63 `=_rc' // WFLOG-INJECTED
local c2 ".002978 .002479 .002616 .002448 .003293 .00219 .00219 .002032 .002907"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L38:step-local" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 19 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L39:step-local" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 20 63 `=_rc' // WFLOG-INJECTED
local gj ".035697 .033225 .034559 .0262 .045544 .048 .048 .029308 .026377"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L39:step-local" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 20 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L40:step-forvalues" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "loop" 21 63 `=_rc' "forvalues" `"1/9"' // WFLOG-INJECTED
* Ulangi blok untuk setiap i dari 1 sampai 9. // WFDOC-INJECTED
forvalues i=1/9 {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L40:iteration-body" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L40:step-forvalues" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L41:step-local" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L40:iteration-body" "statement" 1 8 `=_rc' // WFLOG-INJECTED
    local f: word `i' of `fuels'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L41:step-local" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L40:iteration-body" "statement" 1 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L42:step-local" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L40:iteration-body" "statement" 2 8 `=_rc' // WFLOG-INJECTED
    local u: word `i' of `units'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L42:step-local" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L40:iteration-body" "statement" 2 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L43:step-local" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L40:iteration-body" "statement" 3 8 `=_rc' // WFLOG-INJECTED
    local a: word `i' of `c1'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L43:step-local" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L40:iteration-body" "statement" 3 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L44:step-local" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L40:iteration-body" "statement" 4 8 `=_rc' // WFLOG-INJECTED
    local b: word `i' of `c2'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L44:step-local" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L40:iteration-body" "statement" 4 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L45:step-local" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L40:iteration-body" "statement" 5 8 `=_rc' // WFLOG-INJECTED
    local c: word `i' of `gj'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L45:step-local" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L40:iteration-body" "statement" 5 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L46:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L40:iteration-body" "statement" 6 8 `=_rc' // WFLOG-INJECTED
    generate double co2_`f'_s1=cl_fuel_`f'_`u'*`a'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L46:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L40:iteration-body" "statement" 6 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L47:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L40:iteration-body" "statement" 7 8 `=_rc' // WFLOG-INJECTED
    generate double co2_`f'_s2=cl_fuel_`f'_`u'*`b'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L47:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L40:iteration-body" "statement" 7 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L48:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L40:iteration-body" "statement" 8 8 `=_rc' // WFLOG-INJECTED
    generate double gj_`f'=cl_fuel_`f'_`u'*`c'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L48:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L40:iteration-body" "statement" 8 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L40:iteration-body" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L40:step-forvalues" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L40:step-forvalues" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "loop" 21 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L50:step-egen" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 22 63 `=_rc' // WFLOG-INJECTED
egen byte co2_scope1_nfuels_s1=rownonmiss(co2_diesel_s1 co2_petrol_s1 co2_kerosene_s1 co2_coal_s1 co2_lpg_s1 co2_citygas_s1 co2_othergas_s1 co2_coalbriq_s1 co2_coke_s1)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L50:step-egen" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 22 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L51:step-egen" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 23 63 `=_rc' // WFLOG-INJECTED
egen double co2_scope1_s1=rowtotal(co2_diesel_s1 co2_petrol_s1 co2_kerosene_s1 co2_coal_s1 co2_lpg_s1 co2_citygas_s1 co2_othergas_s1 co2_coalbriq_s1 co2_coke_s1), missing
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L51:step-egen" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 23 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L52:step-egen" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 24 63 `=_rc' // WFLOG-INJECTED
egen double co2_scope1_s2=rowtotal(co2_diesel_s2 co2_petrol_s2 co2_kerosene_s2 co2_coal_s2 co2_lpg_s2 co2_citygas_s2 co2_othergas_s2 co2_coalbriq_s2 co2_coke_s2), missing
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L52:step-egen" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 24 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L53:step-egen" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 25 63 `=_rc' // WFLOG-INJECTED
egen double gj_fuel_s1=rowtotal(gj_diesel gj_petrol gj_kerosene gj_coal gj_lpg gj_citygas gj_othergas gj_coalbriq gj_coke), missing
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L53:step-egen" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 25 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L54:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 26 63 `=_rc' // WFLOG-INJECTED
generate byte nine_fuels_complete=co2_scope1_nfuels_s1==9
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L54:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 26 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L55:step-egen" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 27 63 `=_rc' // WFLOG-INJECTED
egen byte electricity_n_observed=rownonmiss(cl_elec_pln_kwh cl_elec_nonpln_kwh)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L55:step-egen" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 27 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L56:step-egen" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 28 63 `=_rc' // WFLOG-INJECTED
egen double elec_purchased_kwh=rowtotal(cl_elec_pln_kwh cl_elec_nonpln_kwh), missing
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L56:step-egen" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 28 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L57:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 29 63 `=_rc' // WFLOG-INJECTED
generate double gj_electricity=elec_purchased_kwh*.0036
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L57:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 29 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L58:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 30 63 `=_rc' // WFLOG-INJECTED
generate double co2_scope2_s1=elec_purchased_kwh*grid_factor_s1
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L58:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 30 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L59:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 31 63 `=_rc' // WFLOG-INJECTED
generate double co2_scope2_s2=elec_purchased_kwh*grid_factor_s2
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L59:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 31 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L60:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 32 63 `=_rc' // WFLOG-INJECTED
generate double co2_total_s1=co2_scope1_s1+co2_scope2_s1
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L60:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 32 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L61:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 33 63 `=_rc' // WFLOG-INJECTED
generate double co2_total_s2=co2_scope1_s2+co2_scope2_s2
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L61:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 33 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L62:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 34 63 `=_rc' // WFLOG-INJECTED
generate double total_gj_s1=gj_fuel_s1+gj_electricity
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L62:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 34 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L63:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 35 63 `=_rc' // WFLOG-INJECTED
generate double co2_scope1_complete=co2_scope1_s1 if nine_fuels_complete
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L63:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 35 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L64:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 36 63 `=_rc' // WFLOG-INJECTED
generate double co2_scope2_complete=co2_scope2_s1 if electricity_n_observed==2
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L64:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 36 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L65:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 37 63 `=_rc' // WFLOG-INJECTED
generate double co2_total_complete=co2_scope1_complete+co2_scope2_complete
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L65:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 37 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L66:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 38 63 `=_rc' // WFLOG-INJECTED
generate double total_gj_complete=total_gj_s1 if nine_fuels_complete & electricity_n_observed==2
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L66:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 38 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L67:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 39 63 `=_rc' // WFLOG-INJECTED
generate double co2_variant_static_grid=co2_scope1_s1+co2_scope2_s2
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L67:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 39 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L68:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 40 63 `=_rc' // WFLOG-INJECTED
generate byte own_generation_reported=cl_elec_owngen_kwh>0 & !missing(cl_elec_owngen_kwh)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L68:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 40 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L69:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 41 63 `=_rc' // WFLOG-INJECTED
generate byte own_generation_added=0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L69:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 41 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L70:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 42 63 `=_rc' // WFLOG-INJECTED
generate byte extra_fuel_positive=0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L70:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 42 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L71:step-foreach" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "loop" 43 63 `=_rc' "in" `"fuel_firewood_kg fuel_charcoal_kg fuel_dieseloil_ltr fuel_fueloil_ltr fuel_lubricant_ltr fuel_biodiesel_ltr fuel_natgas_kg"' // WFLOG-INJECTED
* Ulangi blok untuk setiap v yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach v in fuel_firewood_kg fuel_charcoal_kg fuel_dieseloil_ltr fuel_fueloil_ltr fuel_lubricant_ltr fuel_biodiesel_ltr fuel_natgas_kg {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L71:iteration-body" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L71:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L72:step-replace" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L71:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
    replace extra_fuel_positive=1 if `v'>0 & !missing(`v')
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L72:step-replace" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L71:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L71:iteration-body" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L71:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L71:step-foreach" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "loop" 43 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L74:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 44 63 `=_rc' // WFLOG-INJECTED
generate str80 energy_coverage_status="observed_components_only; absent_fuels_not_assumed_zero"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L74:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 44 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L75:step-replace" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 45 63 `=_rc' // WFLOG-INJECTED
replace energy_coverage_status="nine_fuels_complete; additional_fuels_and_heat_not_certified" if nine_fuels_complete
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L75:step-replace" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 45 63 `=_rc' // WFLOG-INJECTED
* E017 corrected alternative bases; extended component reconciliation adds mapped new fuels.
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L77:step-egen" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 46 63 `=_rc' // WFLOG-INJECTED
egen double fuel_components_rp000=rowtotal(cl_fuel_diesel_rp000 cl_fuel_petrol_rp000 cl_fuel_kerosene_rp000 cl_fuel_coal_rp000 cl_fuel_lpg_rp000 cl_fuel_citygas_rp000 cl_fuel_othergas_rp000 cl_fuel_coalbriq_rp000 cl_fuel_coke_rp000 cl_fuel_firewood_rp000 cl_fuel_charcoal_rp000 cl_fuel_dieseloil_rp000 cl_fuel_fueloil_rp000 cl_fuel_lubricant_rp000 cl_fuel_other_rp000), missing
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L77:step-egen" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 46 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L78:step-egen" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 47 63 `=_rc' // WFLOG-INJECTED
egen double fuel_components_extended=rowtotal(fuel_components_rp000 cl_fuel_biodiesel_rp000 cl_fuel_natgas_rp000), missing
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L78:step-egen" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 47 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L79:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 48 63 `=_rc' // WFLOG-INJECTED
generate double fuel_expenditure_rp000=cl_fuel_total_reported_rp000
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L79:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 48 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L80:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 49 63 `=_rc' // WFLOG-INJECTED
generate str40 fuel_expenditure_basis="reported_total"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L80:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 49 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L81:step-replace" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 50 63 `=_rc' // WFLOG-INJECTED
replace fuel_expenditure_rp000=fuel_components_extended if missing(fuel_expenditure_rp000)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L81:step-replace" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 50 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L82:step-replace" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 51 63 `=_rc' // WFLOG-INJECTED
replace fuel_expenditure_basis="observed_components_fallback" if missing(cl_fuel_total_reported_rp000) & !missing(fuel_components_extended)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L82:step-replace" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 51 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L83:step-replace" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 52 63 `=_rc' // WFLOG-INJECTED
replace fuel_expenditure_basis="unavailable" if missing(fuel_expenditure_rp000)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L83:step-replace" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 52 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L84:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 53 63 `=_rc' // WFLOG-INJECTED
generate double fuel_reconciliation_gap=cl_fuel_total_reported_rp000-fuel_components_rp000
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L84:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 53 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L85:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 54 63 `=_rc' // WFLOG-INJECTED
generate double fuel_reconciliation_gap_extended=cl_fuel_total_reported_rp000-fuel_components_extended
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L85:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 54 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L86:step-egen" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 55 63 `=_rc' // WFLOG-INJECTED
egen double electricity_expenditure_rp000=rowtotal(cl_elec_pln_rp000 cl_elec_nonpln_rp000), missing
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L86:step-egen" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 55 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L87:step-egen" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 56 63 `=_rc' // WFLOG-INJECTED
egen byte electricity_cost_n_observed=rownonmiss(cl_elec_pln_rp000 cl_elec_nonpln_rp000)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L87:step-egen" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 56 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L88:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 57 63 `=_rc' // WFLOG-INJECTED
generate double energy_expenditure_rp000=fuel_expenditure_rp000+electricity_expenditure_rp000
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L88:step-generate" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 57 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L89:step-assert" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 58 63 `=_rc' // WFLOG-INJECTED
assert co2_total_s1==co2_scope1_s1+co2_scope2_s1
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L89:step-assert" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 58 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L90:step-assert" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 59 63 `=_rc' // WFLOG-INJECTED
assert total_gj_s1==gj_fuel_s1+gj_electricity
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L90:step-assert" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 59 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L91:step-assert" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 60 63 `=_rc' // WFLOG-INJECTED
assert energy_expenditure_rp000==fuel_expenditure_rp000+electricity_expenditure_rp000
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L91:step-assert" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 60 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L92:step-assert" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 61 63 `=_rc' // WFLOG-INJECTED
assert own_generation_added==0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L92:step-assert" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 61 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L93:step-isid" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 62 63 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L93:step-isid" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 62 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L94:step-save" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 63 63 `=_rc' // WFLOG-INJECTED
save "$G0D/G0_energy_emissions.dta", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L94:step-save" "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "statement" 63 63 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
