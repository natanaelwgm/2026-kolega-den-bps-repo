* WFDOC: Uji ini memakai fixture algorithm.do berlabel INDEPENDENT_ALGORITHM_TEST_NOT_G05; angka dan ID fiktif dengan skala arbitrer, bukan data atau hasil G0.5.
* WFDOC: Log dan DTA perbandingan ada di outputdir; satu CSV agregat akhir ditulis di direktori tes.
version 17
clear all
set more off
capture log close
log using "work-items/G1/stata/methods/tests/measurement_mode.log", text replace
run "work-items/G1/stata/methods/load.do"
args outputdir
if "`outputdir'"=="" local outputdir "`c(tmpdir)'g1-method-tests"
use "`outputdir'/fixture.dta", clear
assert fixture=="INDEPENDENT_ALGORITHM_TEST_NOT_G05"
gen str24 panel_status="synthetic_development"
local common "id(id) time(year) output(y) labor(l) capital(k) proxy(p) eligible(eligible) panelverified(1) inputsverified(1)"
* WFDOC: Delapan percobaan pertama membuktikan nama mode nominal saja tidak cukup: jalur juga perlu syntheticpanel(1), status tiap baris, dan kontrak input yang diterima.
foreach method in op lp acf wrdg {
    capture noisily g1_fit, method(`method') `common' measurementmode(nominal_development)
    assert _rc==459
    capture noisily g1_fit, method(`method') `common' measurementmode(nominal_development) syntheticpanel(1)
    assert _rc==459
}
* WFDOC: Baris dengan status verified yang bukan synthetic_development harus ditolak meskipun pemanggil mengaktifkan flag panel sintetik.
replace panel_status="verified"
capture noisily g1_fit, method(lp) `common' measurementmode(nominal_development) syntheticpanel(1) panelstatus(panel_status)
assert _rc==459
replace panel_status="synthetic_development"
* WFDOC: Disappearance sintetis dilarang pada mode default real; exit buatan tidak boleh dipakai sebagai bukti penutupan aktual.
capture noisily g1_fit, method(op) `common' selectionmode(synthetic_disappearance) risk(risk) exit(exited) selectionverified(1)
assert _rc==459
* WFDOC: Memberi mode real tetap tidak mengizinkan selectionmode(synthetic_disappearance), walaupun risk dan exit fixture disediakan.
capture noisily g1_fit, method(op) `common' measurementmode(real) syntheticpanel(1) panelstatus(panel_status) selectionmode(synthetic_disappearance) risk(risk) exit(exited) selectionverified(1)
assert _rc==459
* WFDOC: Label dataset DEASY G0 ACTUAL harus memblokir kombinasi mode nominal dan panel sintetik.
label data "DEASY G0 ACTUAL"
capture noisily g1_fit, method(lp) `common' measurementmode(nominal_development) syntheticpanel(1) panelstatus(panel_status)
assert _rc==459
label data "INDEPENDENT_ALGORITHM_TEST_NOT_G05"
* WFDOC: Metadata deasy_data_mode=actual juga harus memblokir jalur fiktif, walaupun label dataset sudah dikembalikan ke nama fixture.
char _dta[deasy_data_mode] "actual"
capture noisily g1_fit, method(lp) `common' measurementmode(nominal_development) syntheticpanel(1) panelstatus(panel_status)
assert _rc==459
char _dta[deasy_data_mode] "development"
* WFDOC: Tabel perbandingan menyimpan beta, objective dan N dari mode real-default serta nominal-development untuk diperiksa per metode.
postfile results str8 method double real_l double nominal_l double real_k double nominal_k double real_Q double nominal_Q long N using "`outputdir'/measurement-mode-results.dta", replace
* WFDOC: Empat fit membandingkan label mode pada fixture sama; OP memakai investment dan mode disappearance sintetis hanya pada panggilan nominal.
foreach method in op lp acf wrdg {
    local selected_proxy p
    local riskopts ""
    local modeopts ""
    if "`method'"=="op" {
        local selected_proxy inv
        local riskopts "risk(risk) exit(exited) selectionverified(1)"
        local modeopts "selectionmode(synthetic_disappearance)"
    }
    local inputs "id(id) time(year) output(y) labor(l) capital(k) proxy(`selected_proxy') eligible(eligible) panelverified(1) inputsverified(1) `riskopts'"
* WFDOC: Fit dasar menetapkan point estimate dengan mode default real dan selection mode authenticated; angka ini tetap berasal dari fixture fiktif.
    g1_fit, method(`method') `inputs'
    assert "`e(measurement_mode)'"=="real"
    assert "`e(selection_mode)'"=="authenticated"
    assert e(real_input_verified)==1
    assert e(development_only)==1
    scalar before_l=_b[labor]
    scalar before_k=_b[capital]
    scalar before_Q=e(objective)
    gen byte before_sample=e(sample)
* WFDOC: Setelah e(sample) dan hasil dasar disimpan, fit nominal memakai baris dan nilai yang sama; hanya kontrak penerimaan serta label ukuran yang berbeda.
    g1_fit, method(`method') `inputs' measurementmode(nominal_development) syntheticpanel(1) panelstatus(panel_status) `modeopts'
    assert "`e(measurement_mode)'"=="nominal_development"
    assert "`e(input_acceptance_scope)'"=="accepted_declared_nominal_candidate_contract"
    assert "`e(panel_identity_contract)'"=="official_synthetic_development"
    assert "`e(measure_type)'"=="structural_log_nominal_VA_residual"
    assert e(real_input_verified)==0
    assert e(development_only)==1
    assert e(synthetic_panel_authorized)==1
    if "`method'"=="op" assert "`e(selection_mode)'"=="synthetic_disappearance"
* WFDOC: Equality beta/objective/sample pada toleransi ketat membuktikan jalur ini tidak melakukan konversi atau deflasi diam-diam; ini hanya cek plumbing.
    assert reldif(_b[labor],scalar(before_l))<1e-12
    assert reldif(_b[capital],scalar(before_k))<1e-12
    assert reldif(e(objective),scalar(before_Q))<1e-12
    assert before_sample==e(sample)
    assert _N==2160
    post results ("`method'") (scalar(before_l)) (_b[labor]) (scalar(before_k)) (_b[capital]) (scalar(before_Q)) (e(objective)) (e(N))
    drop before_sample
}
postclose results
* WFDOC: Ekspor DTA sementara dibuka ulang untuk cek equality, lalu CSV ringkasan dibuat; tak satu pun berisi hasil perusahaan G0.5.
preserve
use "`outputdir'/measurement-mode-results.dta", clear
assert real_l==nominal_l & real_k==nominal_k & real_Q==nominal_Q
export delimited using "work-items/G1/stata/methods/tests/measurement-mode-results.csv", replace
restore
* WFDOC: Pesan akhir hanya melaporkan 13 guard otorisasi dan kontinuitas mekanis empat fit fixture; ia tidak menyatakan hasil G0.5 maupun hasil aktual.
di "G1_MEASUREMENT_MODE_PASS: 13 authorization/mode guards; exact coefficient/objective/sample continuity across four fixture methods; no G0.5 or actual result"
log close
