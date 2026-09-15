* Tujuan: Jalankan perintah yang tercantum di file ini pada data atau argumen yang disediakan pemanggilnya. // WFDOC-INJECTED
* Input: Data atau argumen yang disediakan pemanggil; lihat perintah di file ini. // WFDOC-INJECTED
* Output: Hasil atau perubahan data yang disebut oleh perintah di file ini. // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "dag/edges/G0_economic_clean_program.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
* Shared by production and adversarial fixtures. No row deletion or source mutation.
capture noisily __wf_progress start "dag/edges/G0_economic_clean_program.do:L2:step-program" "dag/edges/G0_economic_clean_program.do:L1:file" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture program drop g0_economic_clean
capture noisily __wf_progress end "dag/edges/G0_economic_clean_program.do:L2:step-program" "dag/edges/G0_economic_clean_program.do:L1:file" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/G0_economic_clean_program.do:L3:step-program" "dag/edges/G0_economic_clean_program.do:L1:file" "statement" 2 2 `=_rc' // WFLOG-INJECTED
* Definisikan perintah bantu g0_economic_clean; isi blok berjalan saat perintah ini dipanggil. // WFDOC-INJECTED
program define g0_economic_clean
capture noisily __wf_progress start "dag/edges/G0_economic_clean_program.do:L3:program-body" "" "program" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/G0_economic_clean_program.do:L4:step-local" "dag/edges/G0_economic_clean_program.do:L3:program-body" "statement" 1 8 `=_rc' // WFLOG-INJECTED
    local inputs "gross_output_nominal value_added_nominal capital_stock_nominal capital_additions_nominal workers"
capture noisily __wf_progress end "dag/edges/G0_economic_clean_program.do:L4:step-local" "dag/edges/G0_economic_clean_program.do:L3:program-body" "statement" 1 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/G0_economic_clean_program.do:L5:step-local" "dag/edges/G0_economic_clean_program.do:L3:program-body" "statement" 2 8 `=_rc' // WFLOG-INJECTED
    local names "output va stock additions workers"
capture noisily __wf_progress end "dag/edges/G0_economic_clean_program.do:L5:step-local" "dag/edges/G0_economic_clean_program.do:L3:program-body" "statement" 2 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/G0_economic_clean_program.do:L6:step-forvalues" "dag/edges/G0_economic_clean_program.do:L3:program-body" "loop" 3 8 `=_rc' "forvalues" `"1/5"' // WFLOG-INJECTED
* Ulangi blok untuk setiap i dari 1 sampai 5. // WFDOC-INJECTED
    forvalues i=1/5 {
capture noisily __wf_progress start "dag/edges/G0_economic_clean_program.do:L6:iteration-body" "dag/edges/G0_economic_clean_program.do:L6:step-forvalues" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/G0_economic_clean_program.do:L7:step-local" "dag/edges/G0_economic_clean_program.do:L6:iteration-body" "statement" 1 7 `=_rc' // WFLOG-INJECTED
        local v: word `i' of `inputs'
capture noisily __wf_progress end "dag/edges/G0_economic_clean_program.do:L7:step-local" "dag/edges/G0_economic_clean_program.do:L6:iteration-body" "statement" 1 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/G0_economic_clean_program.do:L8:step-local" "dag/edges/G0_economic_clean_program.do:L6:iteration-body" "statement" 2 7 `=_rc' // WFLOG-INJECTED
        local n: word `i' of `names'
capture noisily __wf_progress end "dag/edges/G0_economic_clean_program.do:L8:step-local" "dag/edges/G0_economic_clean_program.do:L6:iteration-body" "statement" 2 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/G0_economic_clean_program.do:L9:step-bysort" "dag/edges/G0_economic_clean_program.do:L6:iteration-body" "statement" 3 7 `=_rc' // WFLOG-INJECTED
        bysort source_year: egen double p99_econ_`n'=pctile(cond(`v'>=0,`v',.)), p(99)
capture noisily __wf_progress end "dag/edges/G0_economic_clean_program.do:L9:step-bysort" "dag/edges/G0_economic_clean_program.do:L6:iteration-body" "statement" 3 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/G0_economic_clean_program.do:L10:step-generate" "dag/edges/G0_economic_clean_program.do:L6:iteration-body" "statement" 4 7 `=_rc' // WFLOG-INJECTED
        generate byte out_checked_`n'=(`v'<0 | (`v'>10*p99_econ_`n' & p99_econ_`n'>0 & !missing(p99_econ_`n'))) if !missing(`v')
capture noisily __wf_progress end "dag/edges/G0_economic_clean_program.do:L10:step-generate" "dag/edges/G0_economic_clean_program.do:L6:iteration-body" "statement" 4 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/G0_economic_clean_program.do:L11:step-generate" "dag/edges/G0_economic_clean_program.do:L6:iteration-body" "statement" 5 7 `=_rc' // WFLOG-INJECTED
        generate double clean_`n'_nominal=`v' if out_checked_`n'==0
capture noisily __wf_progress end "dag/edges/G0_economic_clean_program.do:L11:step-generate" "dag/edges/G0_economic_clean_program.do:L6:iteration-body" "statement" 5 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/G0_economic_clean_program.do:L12:step-label" "dag/edges/G0_economic_clean_program.do:L6:iteration-body" "statement" 6 7 `=_rc' // WFLOG-INJECTED
        label variable out_checked_`n' "Sensitivity exclusion: negative or >10 times within-year p99; missing stays missing"
capture noisily __wf_progress end "dag/edges/G0_economic_clean_program.do:L12:step-label" "dag/edges/G0_economic_clean_program.do:L6:iteration-body" "statement" 6 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/G0_economic_clean_program.do:L13:step-label" "dag/edges/G0_economic_clean_program.do:L6:iteration-body" "statement" 7 7 `=_rc' // WFLOG-INJECTED
        label variable clean_`n'_nominal "Sensitivity companion only; source kept; negatives/extreme tails excluded"
capture noisily __wf_progress end "dag/edges/G0_economic_clean_program.do:L13:step-label" "dag/edges/G0_economic_clean_program.do:L6:iteration-body" "statement" 7 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/G0_economic_clean_program.do:L6:iteration-body" "dag/edges/G0_economic_clean_program.do:L6:step-forvalues" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
    }
capture noisily __wf_progress end "dag/edges/G0_economic_clean_program.do:L6:step-forvalues" "dag/edges/G0_economic_clean_program.do:L3:program-body" "loop" 3 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/G0_economic_clean_program.do:L15:step-rename" "dag/edges/G0_economic_clean_program.do:L3:program-body" "statement" 4 8 `=_rc' // WFLOG-INJECTED
    rename clean_workers_nominal clean_workers_count
capture noisily __wf_progress end "dag/edges/G0_economic_clean_program.do:L15:step-rename" "dag/edges/G0_economic_clean_program.do:L3:program-body" "statement" 4 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/G0_economic_clean_program.do:L16:step-label" "dag/edges/G0_economic_clean_program.do:L3:program-body" "statement" 5 8 `=_rc' // WFLOG-INJECTED
    label variable clean_workers_count "Sensitivity worker COUNT; excludes negatives and annual extreme tails"
capture noisily __wf_progress end "dag/edges/G0_economic_clean_program.do:L16:step-label" "dag/edges/G0_economic_clean_program.do:L3:program-body" "statement" 5 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/G0_economic_clean_program.do:L17:step-generate" "dag/edges/G0_economic_clean_program.do:L3:program-body" "statement" 6 8 `=_rc' // WFLOG-INJECTED
    generate double clean_output_per_worker=clean_output_nominal/clean_workers_count if clean_workers_count>0 & !missing(clean_workers_count)
capture noisily __wf_progress end "dag/edges/G0_economic_clean_program.do:L17:step-generate" "dag/edges/G0_economic_clean_program.do:L3:program-body" "statement" 6 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/G0_economic_clean_program.do:L18:step-generate" "dag/edges/G0_economic_clean_program.do:L3:program-body" "statement" 7 8 `=_rc' // WFLOG-INJECTED
    generate double clean_va_per_worker=clean_va_nominal/clean_workers_count if clean_workers_count>0 & !missing(clean_workers_count)
capture noisily __wf_progress end "dag/edges/G0_economic_clean_program.do:L18:step-generate" "dag/edges/G0_economic_clean_program.do:L3:program-body" "statement" 7 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/G0_economic_clean_program.do:L19:step-generate" "dag/edges/G0_economic_clean_program.do:L3:program-body" "statement" 8 8 `=_rc' // WFLOG-INJECTED
    generate double clean_stock_per_worker=clean_stock_nominal/clean_workers_count if clean_workers_count>0 & !missing(clean_workers_count)
capture noisily __wf_progress end "dag/edges/G0_economic_clean_program.do:L19:step-generate" "dag/edges/G0_economic_clean_program.do:L3:program-body" "statement" 8 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/G0_economic_clean_program.do:L3:program-body" "" "program" 1 1 `=_rc' // WFLOG-INJECTED
end
capture noisily __wf_progress end "dag/edges/G0_economic_clean_program.do:L3:step-program" "dag/edges/G0_economic_clean_program.do:L1:file" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/G0_economic_clean_program.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
