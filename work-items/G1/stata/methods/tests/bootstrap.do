* WFDOC: Script ini memakai fixture independen yang dibuat algorithm.do dan meminta dua draw per metode untuk menguji jalannya bootstrap serta hitung kovarians saja.
* WFDOC: Dua draw bukan inferensi penelitian 999 draw. DTA, CSV kovarians dan log ditulis ke outputdir eksternal; G0.5 tidak dibaca.
version 17
clear all
set more off
capture log close
log using "work-items/G1/stata/methods/tests/bootstrap.log", text replace
run "work-items/G1/stata/methods/load.do"
args outputdir
if "`outputdir'"=="" local outputdir "`c(tmpdir)'g1-method-tests"
* WFDOC: Setiap metode menerima panel sumber utuh yang sama; OP juga membawa risk/exit yang disimulasikan, sedangkan metode lain memakai proxy p.
foreach method in op lp acf wrdg {
    use "`outputdir'/fixture.dta", clear
    assert fixture=="INDEPENDENT_ALGORITHM_TEST_NOT_G05"
    local proxy p
    local selection ""
    if "`method'"=="op" {
        local proxy inv
        local selection "risk(risk) exit(exited) selectionverified(1)"
    }
    * WFDOC: Pemanggilan sengaja menetapkan draws(2) agar setiap draw baru mengulang estimasi penuh; seed tetap membuat uji dapat direproduksi.
    g1_bootstrap, id(id) saving("`outputdir'/bootstrap-`method'") draws(2) seed(9913) ///
        method(`method') time(year) output(y) labor(l) capital(k) proxy(`proxy') ///
        eligible(eligible) panelverified(1) inputsverified(1) `selection' poly(3) start(ols)
    assert r(requested)==2
    assert r(successful)==2
    assert r(covariance_denominator)==1
    * WFDOC: Pastikan uji dua draw tidak pernah ditandai sebagai pemenuhan kebutuhan 999 draw penelitian.
    assert r(full_999_draws)==0
    * WFDOC: Simpan matriks kovarians yang dihitung hanya dari dua keberhasilan, lalu bandingkan aritmetikanya dengan NumPy pada validator terpisah.
    matrix covariance=r(covariance)
    preserve
    clear
    svmat double covariance
    export delimited using "`outputdir'/bootstrap-`method'-cov.csv", replace
    restore
    assert _N==2160
}
* WFDOC: Hasil lulus berarti hanya mekanisme resampling dan kovarians dua draw fixture berjalan; bukan interval kepercayaan empiris.
di "G1_BOOTSTRAP_EXECUTION_PASS: two new-ID full-source draws per method; execution/covariance check only, NOT 999-draw empirical inference"
log close
