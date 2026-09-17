* Tujuan: Jalankan perintah yang tercantum di file ini pada data atau argumen yang disediakan pemanggilnya. // WFDOC-INJECTED
* Input: Data atau argumen yang disediakan pemanggil; lihat perintah di file ini. // WFDOC-INJECTED
* Output: Hasil atau perubahan data yang disebut oleh perintah di file ini. // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* Shared by production and adversarial fixtures. No row deletion or source mutation.
capture program drop g0_economic_clean
* Definisikan perintah bantu g0_economic_clean; isi blok berjalan saat perintah ini dipanggil. // WFDOC-INJECTED
program define g0_economic_clean
    local inputs "gross_output_nominal value_added_nominal capital_stock_nominal capital_additions_nominal workers"
    local names "output va stock additions workers"
* Ulangi blok untuk setiap i dari 1 sampai 5. // WFDOC-INJECTED
    forvalues i=1/5 {
        local v: word `i' of `inputs'
        local n: word `i' of `names'
        bysort source_year: egen double p99_econ_`n'=pctile(cond(`v'>=0,`v',.)), p(99)
        generate byte out_checked_`n'=(`v'<0 | (`v'>10*p99_econ_`n' & p99_econ_`n'>0 & !missing(p99_econ_`n'))) if !missing(`v')
        generate double clean_`n'_nominal=`v' if out_checked_`n'==0
        label variable out_checked_`n' "Sensitivity exclusion: negative or >10 times within-year p99; missing stays missing"
        label variable clean_`n'_nominal "Sensitivity companion only; source kept; negatives/extreme tails excluded"
    }
    rename clean_workers_nominal clean_workers_count
    label variable clean_workers_count "Sensitivity worker COUNT; excludes negatives and annual extreme tails"
    generate double clean_output_per_worker=clean_output_nominal/clean_workers_count if clean_workers_count>0 & !missing(clean_workers_count)
    generate double clean_va_per_worker=clean_va_nominal/clean_workers_count if clean_workers_count>0 & !missing(clean_workers_count)
    generate double clean_stock_per_worker=clean_stock_nominal/clean_workers_count if clean_workers_count>0 & !missing(clean_workers_count)
end
