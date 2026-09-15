* WFDOC: deep_stats merangkum nilai numerik terpilih dari satu domain; pemanggil menetapkan sampel dan penyebut lebih dulu.
* WFDOC: Ringkasan memakai mean, simpangan baku sampel, kuantil empiris, min/max, dan pagar IQR; nilai tidak dipotong atau diimputasi.
capture program drop deep_stats
program define deep_stats
    syntax varname(numeric) [if]
    marksample touse
    quietly summarize `varlist' if `touse', detail
    global D_N = r(N)
    foreach s in mean sd min p1 p5 p25 p50 p75 p95 p99 max {
        global D_`s' : display %24.17g r(`s')
    }
    * WFDOC: Pagar bawah/atas adalah Q1/Q3 ±1,5×IQR dan ±3×IQR; pelanggaran dihitung dengan pertidaksamaan ketat.
    global D_iqr = $D_p75-$D_p25
    global D_fence_lo15 = $D_p25-1.5*$D_iqr
    global D_fence_hi15 = $D_p75+1.5*$D_iqr
    global D_fence_lo3 = $D_p25-3*$D_iqr
    global D_fence_hi3 = $D_p75+3*$D_iqr
    foreach f in lo15 hi15 lo3 hi3 {
        local op "<"
        local name "below"
        if substr("`f'",1,2)=="hi" {
            local op ">"
            local name "above"
        }
        local mult=substr("`f'",3,.)
        quietly count if `touse' & !missing(`varlist') & `varlist' `op' ${D_fence_`f'}
        global D_N_`name'`mult'=r(N)
    }
    * WFDOC: N<5 tetap memberi hitungan N dan pelanggaran pagar, tetapi statistik numerik tepat disembunyikan sebagai missing.
    global D_numeric_released=($D_N>=5)
    if $D_N<5 {
        foreach s in mean sd min p1 p5 p25 p50 p75 p95 p99 max iqr fence_lo15 fence_hi15 fence_lo3 fence_hi3 {
            global D_`s' .
        }
    }
    global D_POST "(${D_N}) (${D_mean}) (${D_sd}) (${D_min}) (${D_p1}) (${D_p5}) (${D_p25}) (${D_p50}) (${D_p75}) (${D_p95}) (${D_p99}) (${D_max}) (${D_iqr}) (${D_fence_lo15}) (${D_fence_hi15}) (${D_fence_lo3}) (${D_fence_hi3}) (${D_N_below15}) (${D_N_above15}) (${D_N_below3}) (${D_N_above3}) (${D_numeric_released})"
end
