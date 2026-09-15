* Tujuan: Jalankan perintah yang tercantum di file ini pada data atau argumen yang disediakan pemanggilnya. // WFDOC-INJECTED
* Input: dag/edges/G0_economic_clean_program.do // WFDOC-INJECTED
* Output: Hasil atau perubahan data yang disebut oleh perintah di file ini. // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
* Reused verbatim analytical body from the completed synthetic preparation edge; no fixture identity/industry mapping.
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L2:step-do" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 1 48 `=_rc' // WFLOG-INJECTED
do "dag/edges/G0_economic_clean_program.do"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L2:step-do" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 1 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L3:step-g0_economic_clean" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 2 48 `=_rc' // WFLOG-INJECTED
g0_economic_clean
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L3:step-g0_economic_clean" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 2 48 `=_rc' // WFLOG-INJECTED
* Recompute every affected ratio/log after final annual field mapping. Clear stale domains.
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L5:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 3 48 `=_rc' // WFLOG-INJECTED
replace worker_denominator_state=cond(missing(workers),3,cond(workers==0,1,cond(workers<0,2,0)))
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L5:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 3 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L6:step-local" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 4 48 `=_rc' // WFLOG-INJECTED
local nums "value_added_nominal gross_output_nominal capital_nominal intermediate_inputs_nominal rd_cost_nominal energy_expenditure_rp000 total_gj_s1 co2_total_s1 capital_stock_nominal capital_additions_nominal"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L6:step-local" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 4 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L7:step-local" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 5 48 `=_rc' // WFLOG-INJECTED
local outs "labor_productivity_nominal output_per_worker_nominal capital_per_worker_nominal inputs_per_worker_nominal rd_cost_per_worker_nominal energy_cost_per_worker total_gj_per_worker co2_per_worker capital_stock_per_worker capital_additions_per_worker"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L7:step-local" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 5 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L8:step-forvalues" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "loop" 6 48 `=_rc' "forvalues" `"1/10"' // WFLOG-INJECTED
* Ulangi blok untuk setiap i dari 1 sampai 10. // WFDOC-INJECTED
forvalues i=1/10 {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L8:iteration-body" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L8:step-forvalues" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L9:step-local" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L8:iteration-body" "statement" 1 4 `=_rc' // WFLOG-INJECTED
 local v: word `i' of `nums'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L9:step-local" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L8:iteration-body" "statement" 1 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L10:step-local" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L8:iteration-body" "statement" 2 4 `=_rc' // WFLOG-INJECTED
 local z: word `i' of `outs'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L10:step-local" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L8:iteration-body" "statement" 2 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L11:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L8:iteration-body" "statement" 3 4 `=_rc' // WFLOG-INJECTED
 replace `z'=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L11:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L8:iteration-body" "statement" 3 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L12:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L8:iteration-body" "statement" 4 4 `=_rc' // WFLOG-INJECTED
 replace `z'=`v'/workers if workers>0 & !missing(workers,`v')
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L12:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L8:iteration-body" "statement" 4 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L8:iteration-body" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L8:step-forvalues" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L8:step-forvalues" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "loop" 6 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L14:step-local" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 7 48 `=_rc' // WFLOG-INJECTED
local vals "gross_output_nominal value_added_nominal capital_nominal intermediate_inputs_nominal workers total_gj_s1 co2_total_s1 energy_expenditure_rp000 import_value_nominal rd_cost_nominal capital_stock_nominal capital_additions_nominal"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L14:step-local" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 7 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L15:step-local" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 8 48 `=_rc' // WFLOG-INJECTED
local logs "ln_output_nominal ln_va_nominal ln_capital_nominal ln_inputs_nominal ln_workers ln_total_gj_s1 ln_co2_total_s1 ln_energy_expenditure ln_import_nominal ln_rd_cost_nominal ln_capital_stock_nominal ln_capital_additions_nominal"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L15:step-local" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 8 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L16:step-forvalues" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "loop" 9 48 `=_rc' "forvalues" `"1/12"' // WFLOG-INJECTED
* Ulangi blok untuk setiap i dari 1 sampai 12. // WFDOC-INJECTED
forvalues i=1/12 {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L16:iteration-body" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L16:step-forvalues" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L17:step-local" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L16:iteration-body" "statement" 1 4 `=_rc' // WFLOG-INJECTED
 local v: word `i' of `vals'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L17:step-local" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L16:iteration-body" "statement" 1 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L18:step-local" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L16:iteration-body" "statement" 2 4 `=_rc' // WFLOG-INJECTED
 local z: word `i' of `logs'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L18:step-local" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L16:iteration-body" "statement" 2 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L19:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L16:iteration-body" "statement" 3 4 `=_rc' // WFLOG-INJECTED
 replace `z'=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L19:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L16:iteration-body" "statement" 3 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L20:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L16:iteration-body" "statement" 4 4 `=_rc' // WFLOG-INJECTED
 replace `z'=ln(`v') if `v'>0 & !missing(`v')
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L20:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L16:iteration-body" "statement" 4 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L16:iteration-body" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L16:step-forvalues" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L16:step-forvalues" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "loop" 9 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L22:step-foreach" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "loop" 10 48 `=_rc' "varlist" `"val_*"' // WFLOG-INJECTED
* Ulangi blok sesuai rentang atau daftar yang ditetapkan di baris ini. // WFDOC-INJECTED
foreach v of varlist val_* {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L22:iteration-body" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L22:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L23:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L22:iteration-body" "statement" 1 4 `=_rc' // WFLOG-INJECTED
 replace ln_`v'=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L23:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L22:iteration-body" "statement" 1 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L24:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L22:iteration-body" "statement" 2 4 `=_rc' // WFLOG-INJECTED
 replace ln_`v'=ln(`v') if `v'>0 & !missing(`v')
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L24:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L22:iteration-body" "statement" 2 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L25:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L22:iteration-body" "statement" 3 4 `=_rc' // WFLOG-INJECTED
 replace pw_`v'=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L25:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L22:iteration-body" "statement" 3 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L26:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L22:iteration-body" "statement" 4 4 `=_rc' // WFLOG-INJECTED
 replace pw_`v'=`v'/workers if workers>0 & !missing(workers,`v')
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L26:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L22:iteration-body" "statement" 4 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L22:iteration-body" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L22:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L22:step-foreach" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "loop" 10 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L28:step-label" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 11 48 `=_rc' // WFLOG-INJECTED
label variable capital_nominal "LEGACY mixed capital alias; use capital_stock_nominal or capital_additions_nominal"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L28:step-label" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 11 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L29:step-label" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 12 48 `=_rc' // WFLOG-INJECTED
label variable capital_per_worker_nominal "LEGACY mixed alias/worker; primary stock measure is capital_stock_per_worker"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L29:step-label" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 12 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L30:step-label" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 13 48 `=_rc' // WFLOG-INJECTED
label variable ln_capital_nominal "LEGACY mixed alias log; primary stock log is ln_capital_stock_nominal"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L30:step-label" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 13 48 `=_rc' // WFLOG-INJECTED
* Refresh energy diagnostics after unit corrections (old flag used pre-conversion prices).
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L32:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 14 48 `=_rc' // WFLOG-INJECTED
replace any_negative_quantity=0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L32:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 14 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L33:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 15 48 `=_rc' // WFLOG-INJECTED
replace any_implausible_price=0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L33:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 15 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L34:step-foreach" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "loop" 16 48 `=_rc' "in" `"diesel petrol kerosene coal lpg citygas othergas coalbriq coke firewood charcoal dieseloil fueloil lubricant biodiesel natgas"' // WFLOG-INJECTED
* Ulangi blok untuk setiap f yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach f in diesel petrol kerosene coal lpg citygas othergas coalbriq coke firewood charcoal dieseloil fueloil lubricant biodiesel natgas {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L34:iteration-body" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L34:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L35:step-local" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L34:iteration-body" "statement" 1 9 `=_rc' // WFLOG-INJECTED
 local unit ltr
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L35:step-local" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L34:iteration-body" "statement" 1 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L36:step-if" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L34:iteration-body" "statement" 2 9 `=_rc' // WFLOG-INJECTED
 if inlist("`f'","coal","lpg","coalbriq","coke","firewood","charcoal","natgas") local unit kg
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L36:step-if" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L34:iteration-body" "statement" 2 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L37:step-if" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L34:iteration-body" "statement" 3 9 `=_rc' // WFLOG-INJECTED
 if inlist("`f'","citygas","othergas") local unit m3
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L37:step-if" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L34:iteration-body" "statement" 3 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L38:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L34:iteration-body" "statement" 4 9 `=_rc' // WFLOG-INJECTED
 replace any_negative_quantity=1 if fuel_`f'_`unit'<0 & !missing(fuel_`f'_`unit')
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L38:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L34:iteration-body" "statement" 4 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L39:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L34:iteration-body" "statement" 5 9 `=_rc' // WFLOG-INJECTED
 replace price_`f'=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L39:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L34:iteration-body" "statement" 5 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L40:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L34:iteration-body" "statement" 6 9 `=_rc' // WFLOG-INJECTED
 replace price_`f'=fuel_`f'_rp000/fuel_`f'_`unit' if fuel_`f'_`unit'>0 & !missing(fuel_`f'_`unit',fuel_`f'_rp000) & fuel_`f'_rp000>=0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L40:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L34:iteration-body" "statement" 6 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L41:step-drop" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L34:iteration-body" "statement" 7 9 `=_rc' // WFLOG-INJECTED
 drop p99_`f'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L41:step-drop" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L34:iteration-body" "statement" 7 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L42:step-bysort" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L34:iteration-body" "statement" 8 9 `=_rc' // WFLOG-INJECTED
 bysort source_year: egen double p99_`f'=pctile(price_`f'), p(99)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L42:step-bysort" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L34:iteration-body" "statement" 8 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L43:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L34:iteration-body" "statement" 9 9 `=_rc' // WFLOG-INJECTED
 replace any_implausible_price=1 if price_`f'>10*p99_`f' & !missing(price_`f',p99_`f') & p99_`f'>0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L43:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L34:iteration-body" "statement" 9 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L34:iteration-body" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L34:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L34:step-foreach" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "loop" 16 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L45:step-foreach" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "loop" 17 48 `=_rc' "in" `"pln nonpln owngen"' // WFLOG-INJECTED
* Ulangi blok untuk f: pln, nonpln, owngen. // WFDOC-INJECTED
foreach f in pln nonpln owngen {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L45:iteration-body" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L45:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L46:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L45:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
 replace any_negative_quantity=1 if elec_`f'_kwh<0 & !missing(elec_`f'_kwh)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L46:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L45:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L45:iteration-body" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L45:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L45:step-foreach" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "loop" 17 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L48:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 18 48 `=_rc' // WFLOG-INJECTED
replace any_implausible_price=1 if price_elec>10*p99_elec & !missing(price_elec,p99_elec) & p99_elec>0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L48:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 18 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L49:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 19 48 `=_rc' // WFLOG-INJECTED
replace energy_outlier_flag=any_negative_quantity | any_implausible_price
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L49:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 19 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L50:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 20 48 `=_rc' // WFLOG-INJECTED
replace cleaning_status="all_rows_kept; clean_*_sensitivity_excludes_flags"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L50:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 20 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L51:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 21 48 `=_rc' // WFLOG-INJECTED
replace extra_fuel_positive=0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L51:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 21 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L52:step-foreach" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "loop" 22 48 `=_rc' "in" `"fuel_firewood_kg fuel_charcoal_kg fuel_dieseloil_ltr fuel_fueloil_ltr fuel_lubricant_ltr fuel_biodiesel_ltr fuel_natgas_kg fuel_natgas_mmbtu fuel_biomass_kg"' // WFLOG-INJECTED
* Ulangi blok untuk setiap v yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach v in fuel_firewood_kg fuel_charcoal_kg fuel_dieseloil_ltr fuel_fueloil_ltr fuel_lubricant_ltr fuel_biodiesel_ltr fuel_natgas_kg fuel_natgas_mmbtu fuel_biomass_kg {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L52:iteration-body" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L52:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L53:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L52:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
 replace extra_fuel_positive=1 if `v'>0 & !missing(`v')
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L53:step-replace" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L52:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L52:iteration-body" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L52:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L52:step-foreach" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "loop" 22 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L55:step-generate" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 23 48 `=_rc' // WFLOG-INJECTED
generate byte energy_all_sources_complete=0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L55:step-generate" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 23 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L56:step-label" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 24 48 `=_rc' // WFLOG-INJECTED
label variable energy_all_sources_complete "0: additional fuels/heat, unit and factor evidence not complete; not zero use"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L56:step-label" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 24 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L57:step-generate" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 25 48 `=_rc' // WFLOG-INJECTED
generate byte energy_unit_gap_2018_19=inlist(source_year,2018,2019)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L57:step-generate" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 25 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L58:step-generate" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 26 48 `=_rc' // WFLOG-INJECTED
generate byte grid_factor_is_carried=source_year>2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L58:step-generate" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 26 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L59:step-label" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 27 48 `=_rc' // WFLOG-INJECTED
label variable grid_factor_is_carried "1: inherited post-2014 grid factor carry; not observed annual grid factor"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L59:step-label" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 27 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L60:step-generate" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 28 48 `=_rc' // WFLOG-INJECTED
generate double gj_scope1_complete9=gj_fuel_s1 if nine_fuels_complete & !energy_unit_gap_2018_19
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L60:step-generate" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 28 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L61:step-generate" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 29 48 `=_rc' // WFLOG-INJECTED
generate double gj_scope2_complete=gj_electricity if electricity_n_observed==2
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L61:step-generate" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 29 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L62:step-generate" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 30 48 `=_rc' // WFLOG-INJECTED
generate double co2_scope2_no_grid_carry=co2_scope2_complete if !grid_factor_is_carried
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L62:step-generate" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 30 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L63:step-generate" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 31 48 `=_rc' // WFLOG-INJECTED
generate double total_gj_clean_sensitivity=total_gj_s1 if energy_outlier_flag==0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L63:step-generate" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 31 48 `=_rc' // WFLOG-INJECTED
* Reuse LUDI 16_energy_intensity.do reference heat factors; keep outside main totals.
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L65:step-generate" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 32 48 `=_rc' // WFLOG-INJECTED
generate double gj_firewood_reference=fuel_firewood_kg*.0156 if fuel_firewood_kg>=0 & !missing(fuel_firewood_kg)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L65:step-generate" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 32 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L66:step-generate" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 33 48 `=_rc' // WFLOG-INJECTED
generate double gj_charcoal_reference=fuel_charcoal_kg*.0295 if fuel_charcoal_kg>=0 & !missing(fuel_charcoal_kg)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L66:step-generate" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 33 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L67:step-generate" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 34 48 `=_rc' // WFLOG-INJECTED
generate double gj_lubricant_potential=fuel_lubricant_ltr*.03538 if fuel_lubricant_ltr>=0 & !missing(fuel_lubricant_ltr)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L67:step-generate" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 34 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L68:step-label" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 35 48 `=_rc' // WFLOG-INJECTED
label variable gj_scope1_complete9 "Nine-fuel GJ only; all nine observed; excludes 2018/19 unit gap; factors conditional"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L68:step-label" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 35 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L69:step-label" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 36 48 `=_rc' // WFLOG-INJECTED
label variable gj_scope2_complete "Purchased electricity GJ; both PLN/non-PLN observed; own generation excluded"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L69:step-label" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 36 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L70:step-label" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 37 48 `=_rc' // WFLOG-INJECTED
label variable co2_scope2_no_grid_carry "Purchased-electricity CO2 subset with inherited observed-period grid factors"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L70:step-label" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 37 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L71:step-label" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 38 48 `=_rc' // WFLOG-INJECTED
label variable gj_firewood_reference "Reference wood GJ, IPCC 15.6 GJ/t; excluded from legacy total; units conditional"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L71:step-label" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 38 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L72:step-label" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 39 48 `=_rc' // WFLOG-INJECTED
label variable gj_charcoal_reference "Reference charcoal GJ, IPCC 29.5 GJ/t; excludes mixed biomass; units conditional"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L72:step-label" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 39 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L73:step-label" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 40 48 `=_rc' // WFLOG-INJECTED
label variable gj_lubricant_potential "Potential heat only, NOT actual combustion: LUDI .03538 GJ/litre"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L73:step-label" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 40 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L74:step-label" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 41 48 `=_rc' // WFLOG-INJECTED
label variable co2_scope1_complete "Complete NINE-FUEL subtotal only; not all Scope1 sources; factor assumptions"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L74:step-label" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 41 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L75:step-label" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 42 48 `=_rc' // WFLOG-INJECTED
label variable co2_total_complete "NINE-FUEL + purchased-electricity subtotal; not comprehensive emissions"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L75:step-label" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 42 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L76:step-label" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 43 48 `=_rc' // WFLOG-INJECTED
label variable total_gj_complete "NINE-FUEL + purchased-electricity subtotal; extra fuels/heat not certified"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L76:step-label" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 43 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L77:step-label" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 44 48 `=_rc' // WFLOG-INJECTED
label variable co2_scope1_s1 "Observed nine-fuel combustion CO2 tonnes, partial, factor scenario1; not CO2e"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L77:step-label" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 44 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L78:step-label" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 45 48 `=_rc' // WFLOG-INJECTED
label variable co2_scope2_s1 "Purchased-electricity CO2 tonnes, partial and grid carry scenario1"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L78:step-label" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 45 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L79:step-label" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 46 48 `=_rc' // WFLOG-INJECTED
label variable co2_total_s1 "Partial nine-fuel + purchased-electricity CO2 tonnes; no own-generation addition"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L79:step-label" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 46 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L80:step-assert" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 47 48 `=_rc' // WFLOG-INJECTED
assert own_generation_added==0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L80:step-assert" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 47 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L81:step-isid" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 48 48 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L81:step-isid" "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "statement" 48 48 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
