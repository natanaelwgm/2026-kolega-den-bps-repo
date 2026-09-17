* Tujuan: Jalankan koreksi yang tertulis di berkas ini; setiap perubahan dibatasi oleh kondisi pada barisnya. // WFDOC-INJECTED
* Input: `input'; `output' // WFDOC-INJECTED
* Output: Hasil atau perubahan data yang disebut oleh perintah di file ini. // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
set more off
set varabbrev off
* Isi blok hanya dijalankan bila c(maxvar) kurang dari 10000. // WFDOC-INJECTED
if c(maxvar)<10000 {
    clear
    set maxvar 10000
}
cd "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2"
assert `"`c(pwd)'"'=="/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2"
assert strpos(`"`c(tmpdir)'"',"/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/scratch")==1
capture program drop g0c_begin
* Definisikan pembuka log anak koreksi; id menentukan nama berkas log agar langkah berikut bisa dilacak. // WFDOC-INJECTED
* Definisikan perintah bantu g0c_begin; isi blok berjalan saat perintah ini dipanggil. // WFDOC-INJECTED
program define g0c_begin
    args id
    capture log close G0CHILD
    log using "corrections/logs/`id'.log", name(G0CHILD) text replace
    display "G0C_CHILD_START `id'"
end
capture program drop g0c_finish
* Definisikan penutup koreksi; id/state menentukan nama berkas data keluaran dan pesan jumlah baris/kolom. // WFDOC-INJECTED
* Definisikan perintah bantu g0c_finish; isi blok berjalan saat perintah ini dipanggil. // WFDOC-INJECTED
program define g0c_finish
    args id state
    save "corrections/data/`state'.dta", replace
    display "G0C_CHILD_PASS `id' state=`state' rows=" _N " columns=" c(k)
    capture log close G0CHILD
end
capture program drop g0c_ratio
* Definisikan pembagian dua angka: hasil mula-mula missing dan hanya terisi bila input ada serta pembagi positif. // WFDOC-INJECTED
* Definisikan perintah bantu g0c_ratio; isi blok berjalan saat perintah ini dipanggil. // WFDOC-INJECTED
program define g0c_ratio
    syntax varlist(min=2 max=2 numeric), Generate(name) [SIGNED]
    gettoken numerator denominator : varlist
    generate double `generate'=.
* Dengan opsi signed, izinkan pembilang positif, nol, atau negatif; pembagi tetap harus positif. // WFDOC-INJECTED
    if "`signed'"!="" replace `generate'=`numerator'/`denominator' if !missing(`numerator',`denominator') & `denominator'>0
* Tanpa signed, hitung rasio hanya bila pembilang tidak negatif; pembagi positif mencegah pembagian nol/negatif. // WFDOC-INJECTED
    else replace `generate'=`numerator'/`denominator' if !missing(`numerator',`denominator') & `denominator'>0 & `numerator'>=0
end
capture program drop g0c_log
* Definisikan log natural untuk angka positif yang terisi; nilai nol, negatif, dan missing tetap missing. // WFDOC-INJECTED
* Definisikan perintah bantu g0c_log; isi blok berjalan saat perintah ini dipanggil. // WFDOC-INJECTED
program define g0c_log
    syntax varname(numeric), Generate(name)
    generate double `generate'=.
    replace `generate'=ln(`varlist') if `varlist'>0 & !missing(`varlist')
end
capture program drop g0c_roundtrip
* Definisikan perintah bantu g0c_roundtrip; isi blok berjalan saat perintah ini dipanggil. // WFDOC-INJECTED
* Definisikan uji ekspor-impor yang bekerja pada salinan data dan mengembalikan tabel awal saat selesai. // WFDOC-INJECTED
program define g0c_roundtrip, rclass
    syntax, INPUT(string) OUTPUT(string)
    preserve
    use "`input'", clear
    unab oldorder : _all
    quietly ds, has(type numeric)
    local numeric `r(varlist)'
    local rows=_N
    local columns=c(k)
* Ulangi blok untuk tiap v dalam daftar local numeric. // WFDOC-INJECTED
    foreach v of local numeric {
        format `v' %24.17g
    }
* Tulis salinan CSV dengan format angka yang diminta agar nilai dapat dibandingkan setelah impor. // WFDOC-INJECTED
    export delimited using "`output'", datafmt nolabel quote replace
* Baca kembali CSV sebagai teks dahulu; angka akan dipulihkan lalu dibandingkan dengan input. // WFDOC-INJECTED
    import delimited using "`output'", varnames(1) case(preserve) stringcols(_all) bindquote(strict) clear encoding("UTF-8")
* Ulangi blok untuk tiap v dalam daftar local numeric. // WFDOC-INJECTED
    foreach v of local numeric {
        rename `v' __text_value
        generate double `v'=real(strtrim(__text_value))
        drop __text_value
    }
    order `oldorder'
    assert _N==`rows' & c(k)==`columns'
* Bandingkan setiap kolom hasil round-trip dengan input awal; perbedaan membuat uji gagal. // WFDOC-INJECTED
    cf _all using "`input'"
    restore
    return scalar rows=`rows'
    return scalar columns=`columns'
end
