* Tujuan: Jalankan koreksi yang tertulis di berkas ini; setiap perubahan dibatasi oleh kondisi pada barisnya. // WFDOC-INJECTED
* Input: `input'; `output' // WFDOC-INJECTED
* Output: Hasil atau perubahan data yang disebut oleh perintah di file ini. // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L1:step-version" "rows/G0/corrections/_utils.do:L1:file" "statement" 1 17 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L1:step-version" "rows/G0/corrections/_utils.do:L1:file" "statement" 1 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L2:step-set" "rows/G0/corrections/_utils.do:L1:file" "statement" 2 17 `=_rc' // WFLOG-INJECTED
set more off
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L2:step-set" "rows/G0/corrections/_utils.do:L1:file" "statement" 2 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L3:step-set" "rows/G0/corrections/_utils.do:L1:file" "statement" 3 17 `=_rc' // WFLOG-INJECTED
set varabbrev off
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L3:step-set" "rows/G0/corrections/_utils.do:L1:file" "statement" 3 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L4:step-if" "rows/G0/corrections/_utils.do:L1:file" "statement" 4 17 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila c(maxvar) kurang dari 10000. // WFDOC-INJECTED
if c(maxvar)<10000 {
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L4:block-body" "rows/G0/corrections/_utils.do:L4:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L5:step-clear" "rows/G0/corrections/_utils.do:L4:block-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    clear
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L5:step-clear" "rows/G0/corrections/_utils.do:L4:block-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L6:step-set" "rows/G0/corrections/_utils.do:L4:block-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    set maxvar 10000
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L6:step-set" "rows/G0/corrections/_utils.do:L4:block-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L4:block-body" "rows/G0/corrections/_utils.do:L4:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L4:step-if" "rows/G0/corrections/_utils.do:L1:file" "statement" 4 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L8:step-cd" "rows/G0/corrections/_utils.do:L1:file" "statement" 5 17 `=_rc' // WFLOG-INJECTED
cd "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2"
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L8:step-cd" "rows/G0/corrections/_utils.do:L1:file" "statement" 5 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L9:step-assert" "rows/G0/corrections/_utils.do:L1:file" "statement" 6 17 `=_rc' // WFLOG-INJECTED
assert `"`c(pwd)'"'=="/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2"
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L9:step-assert" "rows/G0/corrections/_utils.do:L1:file" "statement" 6 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L10:step-assert" "rows/G0/corrections/_utils.do:L1:file" "statement" 7 17 `=_rc' // WFLOG-INJECTED
assert strpos(`"`c(tmpdir)'"',"/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/scratch")==1
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L10:step-assert" "rows/G0/corrections/_utils.do:L1:file" "statement" 7 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L11:step-program" "rows/G0/corrections/_utils.do:L1:file" "statement" 8 17 `=_rc' // WFLOG-INJECTED
capture program drop g0c_begin
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L11:step-program" "rows/G0/corrections/_utils.do:L1:file" "statement" 8 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L12:step-program" "rows/G0/corrections/_utils.do:L1:file" "statement" 9 17 `=_rc' // WFLOG-INJECTED
* Definisikan pembuka log anak koreksi; id menentukan nama berkas log agar langkah berikut bisa dilacak. // WFDOC-INJECTED
* Definisikan perintah bantu g0c_begin; isi blok berjalan saat perintah ini dipanggil. // WFDOC-INJECTED
program define g0c_begin
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L12:program-body" "" "program" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L13:step-args" "rows/G0/corrections/_utils.do:L12:program-body" "statement" 1 4 `=_rc' // WFLOG-INJECTED
    args id
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L13:step-args" "rows/G0/corrections/_utils.do:L12:program-body" "statement" 1 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L14:step-log" "rows/G0/corrections/_utils.do:L12:program-body" "statement" 2 4 `=_rc' // WFLOG-INJECTED
    capture log close G0CHILD
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L14:step-log" "rows/G0/corrections/_utils.do:L12:program-body" "statement" 2 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L15:step-log" "rows/G0/corrections/_utils.do:L12:program-body" "statement" 3 4 `=_rc' // WFLOG-INJECTED
    log using "corrections/logs/`id'.log", name(G0CHILD) text replace
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L15:step-log" "rows/G0/corrections/_utils.do:L12:program-body" "statement" 3 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L16:step-display" "rows/G0/corrections/_utils.do:L12:program-body" "statement" 4 4 `=_rc' // WFLOG-INJECTED
    display "G0C_CHILD_START `id'"
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L16:step-display" "rows/G0/corrections/_utils.do:L12:program-body" "statement" 4 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L12:program-body" "" "program" 1 1 `=_rc' // WFLOG-INJECTED
end
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L12:step-program" "rows/G0/corrections/_utils.do:L1:file" "statement" 9 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L18:step-program" "rows/G0/corrections/_utils.do:L1:file" "statement" 10 17 `=_rc' // WFLOG-INJECTED
capture program drop g0c_finish
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L18:step-program" "rows/G0/corrections/_utils.do:L1:file" "statement" 10 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L19:step-program" "rows/G0/corrections/_utils.do:L1:file" "statement" 11 17 `=_rc' // WFLOG-INJECTED
* Definisikan penutup koreksi; id/state menentukan nama berkas data keluaran dan pesan jumlah baris/kolom. // WFDOC-INJECTED
* Definisikan perintah bantu g0c_finish; isi blok berjalan saat perintah ini dipanggil. // WFDOC-INJECTED
program define g0c_finish
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L19:program-body" "" "program" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L20:step-args" "rows/G0/corrections/_utils.do:L19:program-body" "statement" 1 4 `=_rc' // WFLOG-INJECTED
    args id state
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L20:step-args" "rows/G0/corrections/_utils.do:L19:program-body" "statement" 1 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L21:step-save" "rows/G0/corrections/_utils.do:L19:program-body" "statement" 2 4 `=_rc' // WFLOG-INJECTED
    save "corrections/data/`state'.dta", replace
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L21:step-save" "rows/G0/corrections/_utils.do:L19:program-body" "statement" 2 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L22:step-display" "rows/G0/corrections/_utils.do:L19:program-body" "statement" 3 4 `=_rc' // WFLOG-INJECTED
    display "G0C_CHILD_PASS `id' state=`state' rows=" _N " columns=" c(k)
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L22:step-display" "rows/G0/corrections/_utils.do:L19:program-body" "statement" 3 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L23:step-log" "rows/G0/corrections/_utils.do:L19:program-body" "statement" 4 4 `=_rc' // WFLOG-INJECTED
    capture log close G0CHILD
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L23:step-log" "rows/G0/corrections/_utils.do:L19:program-body" "statement" 4 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L19:program-body" "" "program" 1 1 `=_rc' // WFLOG-INJECTED
end
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L19:step-program" "rows/G0/corrections/_utils.do:L1:file" "statement" 11 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L25:step-program" "rows/G0/corrections/_utils.do:L1:file" "statement" 12 17 `=_rc' // WFLOG-INJECTED
capture program drop g0c_ratio
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L25:step-program" "rows/G0/corrections/_utils.do:L1:file" "statement" 12 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L26:step-program" "rows/G0/corrections/_utils.do:L1:file" "statement" 13 17 `=_rc' // WFLOG-INJECTED
* Definisikan pembagian dua angka: hasil mula-mula missing dan hanya terisi bila input ada serta pembagi positif. // WFDOC-INJECTED
* Definisikan perintah bantu g0c_ratio; isi blok berjalan saat perintah ini dipanggil. // WFDOC-INJECTED
program define g0c_ratio
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L26:program-body" "" "program" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L27:step-syntax" "rows/G0/corrections/_utils.do:L26:program-body" "statement" 1 4 `=_rc' // WFLOG-INJECTED
    syntax varlist(min=2 max=2 numeric), Generate(name) [SIGNED]
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L27:step-syntax" "rows/G0/corrections/_utils.do:L26:program-body" "statement" 1 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L28:step-gettoken" "rows/G0/corrections/_utils.do:L26:program-body" "statement" 2 4 `=_rc' // WFLOG-INJECTED
    gettoken numerator denominator : varlist
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L28:step-gettoken" "rows/G0/corrections/_utils.do:L26:program-body" "statement" 2 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L29:step-generate" "rows/G0/corrections/_utils.do:L26:program-body" "statement" 3 4 `=_rc' // WFLOG-INJECTED
    generate double `generate'=.
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L29:step-generate" "rows/G0/corrections/_utils.do:L26:program-body" "statement" 3 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L30:step-if" "rows/G0/corrections/_utils.do:L26:program-body" "statement" 4 4 `=_rc' // WFLOG-INJECTED
* Dengan opsi signed, izinkan pembilang positif, nol, atau negatif; pembagi tetap harus positif. // WFDOC-INJECTED
    if "`signed'"!="" replace `generate'=`numerator'/`denominator' if !missing(`numerator',`denominator') & `denominator'>0
* Tanpa signed, hitung rasio hanya bila pembilang tidak negatif; pembagi positif mencegah pembagian nol/negatif. // WFDOC-INJECTED
    else replace `generate'=`numerator'/`denominator' if !missing(`numerator',`denominator') & `denominator'>0 & `numerator'>=0
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L30:step-if" "rows/G0/corrections/_utils.do:L26:program-body" "statement" 4 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L26:program-body" "" "program" 1 1 `=_rc' // WFLOG-INJECTED
end
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L26:step-program" "rows/G0/corrections/_utils.do:L1:file" "statement" 13 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L33:step-program" "rows/G0/corrections/_utils.do:L1:file" "statement" 14 17 `=_rc' // WFLOG-INJECTED
capture program drop g0c_log
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L33:step-program" "rows/G0/corrections/_utils.do:L1:file" "statement" 14 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L34:step-program" "rows/G0/corrections/_utils.do:L1:file" "statement" 15 17 `=_rc' // WFLOG-INJECTED
* Definisikan log natural untuk angka positif yang terisi; nilai nol, negatif, dan missing tetap missing. // WFDOC-INJECTED
* Definisikan perintah bantu g0c_log; isi blok berjalan saat perintah ini dipanggil. // WFDOC-INJECTED
program define g0c_log
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L34:program-body" "" "program" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L35:step-syntax" "rows/G0/corrections/_utils.do:L34:program-body" "statement" 1 3 `=_rc' // WFLOG-INJECTED
    syntax varname(numeric), Generate(name)
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L35:step-syntax" "rows/G0/corrections/_utils.do:L34:program-body" "statement" 1 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L36:step-generate" "rows/G0/corrections/_utils.do:L34:program-body" "statement" 2 3 `=_rc' // WFLOG-INJECTED
    generate double `generate'=.
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L36:step-generate" "rows/G0/corrections/_utils.do:L34:program-body" "statement" 2 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L37:step-replace" "rows/G0/corrections/_utils.do:L34:program-body" "statement" 3 3 `=_rc' // WFLOG-INJECTED
    replace `generate'=ln(`varlist') if `varlist'>0 & !missing(`varlist')
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L37:step-replace" "rows/G0/corrections/_utils.do:L34:program-body" "statement" 3 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L34:program-body" "" "program" 1 1 `=_rc' // WFLOG-INJECTED
end
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L34:step-program" "rows/G0/corrections/_utils.do:L1:file" "statement" 15 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L39:step-program" "rows/G0/corrections/_utils.do:L1:file" "statement" 16 17 `=_rc' // WFLOG-INJECTED
capture program drop g0c_roundtrip
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L39:step-program" "rows/G0/corrections/_utils.do:L1:file" "statement" 16 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L40:step-program" "rows/G0/corrections/_utils.do:L1:file" "statement" 17 17 `=_rc' // WFLOG-INJECTED
* Definisikan perintah bantu g0c_roundtrip; isi blok berjalan saat perintah ini dipanggil. // WFDOC-INJECTED
* Definisikan uji ekspor-impor yang bekerja pada salinan data dan mengembalikan tabel awal saat selesai. // WFDOC-INJECTED
program define g0c_roundtrip, rclass
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L40:program-body" "" "program" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L41:step-syntax" "rows/G0/corrections/_utils.do:L40:program-body" "statement" 1 18 `=_rc' // WFLOG-INJECTED
    syntax, INPUT(string) OUTPUT(string)
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L41:step-syntax" "rows/G0/corrections/_utils.do:L40:program-body" "statement" 1 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L42:step-preserve" "rows/G0/corrections/_utils.do:L40:program-body" "statement" 2 18 `=_rc' // WFLOG-INJECTED
    preserve
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L42:step-preserve" "rows/G0/corrections/_utils.do:L40:program-body" "statement" 2 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L43:step-use" "rows/G0/corrections/_utils.do:L40:program-body" "statement" 3 18 `=_rc' // WFLOG-INJECTED
    use "`input'", clear
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L43:step-use" "rows/G0/corrections/_utils.do:L40:program-body" "statement" 3 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L44:step-unab" "rows/G0/corrections/_utils.do:L40:program-body" "statement" 4 18 `=_rc' // WFLOG-INJECTED
    unab oldorder : _all
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L44:step-unab" "rows/G0/corrections/_utils.do:L40:program-body" "statement" 4 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L45:step-ds" "rows/G0/corrections/_utils.do:L40:program-body" "statement" 5 18 `=_rc' // WFLOG-INJECTED
    quietly ds, has(type numeric)
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L45:step-ds" "rows/G0/corrections/_utils.do:L40:program-body" "statement" 5 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L46:step-local" "rows/G0/corrections/_utils.do:L40:program-body" "statement" 6 18 `=_rc' // WFLOG-INJECTED
    local numeric `r(varlist)'
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L46:step-local" "rows/G0/corrections/_utils.do:L40:program-body" "statement" 6 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L47:step-local" "rows/G0/corrections/_utils.do:L40:program-body" "statement" 7 18 `=_rc' // WFLOG-INJECTED
    local rows=_N
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L47:step-local" "rows/G0/corrections/_utils.do:L40:program-body" "statement" 7 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L48:step-local" "rows/G0/corrections/_utils.do:L40:program-body" "statement" 8 18 `=_rc' // WFLOG-INJECTED
    local columns=c(k)
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L48:step-local" "rows/G0/corrections/_utils.do:L40:program-body" "statement" 8 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L49:step-foreach" "rows/G0/corrections/_utils.do:L40:program-body" "loop" 9 18 `=_rc' "local-expanded" `"`numeric'"' // WFLOG-INJECTED
* Ulangi blok untuk tiap v dalam daftar local numeric. // WFDOC-INJECTED
    foreach v of local numeric {
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L49:iteration-body" "rows/G0/corrections/_utils.do:L49:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L50:step-format" "rows/G0/corrections/_utils.do:L49:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
        format `v' %24.17g
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L50:step-format" "rows/G0/corrections/_utils.do:L49:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L49:iteration-body" "rows/G0/corrections/_utils.do:L49:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
    }
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L49:step-foreach" "rows/G0/corrections/_utils.do:L40:program-body" "loop" 9 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L52:step-export" "rows/G0/corrections/_utils.do:L40:program-body" "statement" 10 18 `=_rc' // WFLOG-INJECTED
* Tulis salinan CSV dengan format angka yang diminta agar nilai dapat dibandingkan setelah impor. // WFDOC-INJECTED
    export delimited using "`output'", datafmt nolabel quote replace
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L52:step-export" "rows/G0/corrections/_utils.do:L40:program-body" "statement" 10 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L53:step-import" "rows/G0/corrections/_utils.do:L40:program-body" "statement" 11 18 `=_rc' // WFLOG-INJECTED
* Baca kembali CSV sebagai teks dahulu; angka akan dipulihkan lalu dibandingkan dengan input. // WFDOC-INJECTED
    import delimited using "`output'", varnames(1) case(preserve) stringcols(_all) bindquote(strict) clear encoding("UTF-8")
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L53:step-import" "rows/G0/corrections/_utils.do:L40:program-body" "statement" 11 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L54:step-foreach" "rows/G0/corrections/_utils.do:L40:program-body" "loop" 12 18 `=_rc' "local-expanded" `"`numeric'"' // WFLOG-INJECTED
* Ulangi blok untuk tiap v dalam daftar local numeric. // WFDOC-INJECTED
    foreach v of local numeric {
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L54:iteration-body" "rows/G0/corrections/_utils.do:L54:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L55:step-rename" "rows/G0/corrections/_utils.do:L54:iteration-body" "statement" 1 3 `=_rc' // WFLOG-INJECTED
        rename `v' __text_value
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L55:step-rename" "rows/G0/corrections/_utils.do:L54:iteration-body" "statement" 1 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L56:step-generate" "rows/G0/corrections/_utils.do:L54:iteration-body" "statement" 2 3 `=_rc' // WFLOG-INJECTED
        generate double `v'=real(strtrim(__text_value))
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L56:step-generate" "rows/G0/corrections/_utils.do:L54:iteration-body" "statement" 2 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L57:step-drop" "rows/G0/corrections/_utils.do:L54:iteration-body" "statement" 3 3 `=_rc' // WFLOG-INJECTED
        drop __text_value
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L57:step-drop" "rows/G0/corrections/_utils.do:L54:iteration-body" "statement" 3 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L54:iteration-body" "rows/G0/corrections/_utils.do:L54:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
    }
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L54:step-foreach" "rows/G0/corrections/_utils.do:L40:program-body" "loop" 12 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L59:step-order" "rows/G0/corrections/_utils.do:L40:program-body" "statement" 13 18 `=_rc' // WFLOG-INJECTED
    order `oldorder'
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L59:step-order" "rows/G0/corrections/_utils.do:L40:program-body" "statement" 13 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L60:step-assert" "rows/G0/corrections/_utils.do:L40:program-body" "statement" 14 18 `=_rc' // WFLOG-INJECTED
    assert _N==`rows' & c(k)==`columns'
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L60:step-assert" "rows/G0/corrections/_utils.do:L40:program-body" "statement" 14 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L61:step-cf" "rows/G0/corrections/_utils.do:L40:program-body" "statement" 15 18 `=_rc' // WFLOG-INJECTED
* Bandingkan setiap kolom hasil round-trip dengan input awal; perbedaan membuat uji gagal. // WFDOC-INJECTED
    cf _all using "`input'"
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L61:step-cf" "rows/G0/corrections/_utils.do:L40:program-body" "statement" 15 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L62:step-restore" "rows/G0/corrections/_utils.do:L40:program-body" "statement" 16 18 `=_rc' // WFLOG-INJECTED
    restore
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L62:step-restore" "rows/G0/corrections/_utils.do:L40:program-body" "statement" 16 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L63:step-return" "rows/G0/corrections/_utils.do:L40:program-body" "statement" 17 18 `=_rc' // WFLOG-INJECTED
    return scalar rows=`rows'
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L63:step-return" "rows/G0/corrections/_utils.do:L40:program-body" "statement" 17 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/_utils.do:L64:step-return" "rows/G0/corrections/_utils.do:L40:program-body" "statement" 18 18 `=_rc' // WFLOG-INJECTED
    return scalar columns=`columns'
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L64:step-return" "rows/G0/corrections/_utils.do:L40:program-body" "statement" 18 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L40:program-body" "" "program" 1 1 `=_rc' // WFLOG-INJECTED
end
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L40:step-program" "rows/G0/corrections/_utils.do:L1:file" "statement" 17 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/_utils.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
