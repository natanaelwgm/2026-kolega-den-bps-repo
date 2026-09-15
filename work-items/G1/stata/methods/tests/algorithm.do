* WFDOC: Fixture ini membangkitkan 180 ID fiktif untuk tahun 2010-2022, lalu menyimpan 2.160 baris setelah tahun 2016 dihapus; tidak memakai atau menghasilkan estimasi G0.5.
* WFDOC: Skala variabel simulasi arbitrer. Persamaan output yang dibangkitkan adalah y=0.6*l+0.3*k+omega+noise; flag verifikasi di pemanggilan hanya mengaktifkan uji algoritme, bukan membuktikan definisi input aktual.
* WFDOC: Berkas keluaran berupa fixture DTA eksternal dan CSV agregat uji; log disimpan di tests/algorithm.log.
version 17
clear all
set more off
capture log close
log using "work-items/G1/stata/methods/tests/algorithm.log", text replace
run "work-items/G1/stata/methods/load.do"
args outputdir
if "`outputdir'"=="" local outputdir "`c(tmpdir)'g1-method-tests"
capture mkdir "`outputdir'"
* INDEPENDENT ALGORITHM FIXTURE, generated here; never a G0.5 input/result.
* Random-walk omega is deliberately compatible with the pinned WRDG shared theta.
* WFDOC: Seed tetap membuat noise, produktivitas laten, input, dan status keluar dapat direproduksi; omega dibangkitkan sebagai random walk untuk mencocokkan pembatasan theta bersama pada fixture WRDG.
set seed 9130913
set obs 180
gen long id=_n
gen double base=4+rnormal(0,.5)
expand 13
bys id: gen int year=2009+_n
sort id year
gen double innovation=rnormal(0,.12)
gen double transfer=rnormal(0,.28)
gen double wage=rnormal(0,.7)
gen double noise=rnormal(0,.03)
gen double u=runiform()
gen double omega=.
gen double k=.
gen double l=.
gen double inv=.
gen double p=.
gen double y=.
gen byte risk=0
gen byte exited=.
gen byte alive=1
* WFDOC: Panel buatan memakai urutan tahun kalender; risk_t menandai paparan pada interval sebelumnya-ke-t dan exited disimulasikan hanya pada risk set, sedangkan y hanya dibuat untuk perusahaan yang masih hidup.
forvalues t=2010/2022 {
    by id: replace omega=cond(year==2010,innovation,omega[_n-1]+innovation) if year==`t'
    by id: replace k=cond(year==2010,base,.7*k[_n-1]+.3*base+transfer) if year==`t'
    by id: replace l=1+.3*k+cond(year==2010,0,.2*omega[_n-1])+wage if year==`t'
    replace inv=.4*k+.8*omega if year==`t'
    replace p=.4*k+omega if year==`t'
    by id: replace risk=alive[_n-1] if year==`t' & year>2010
    by id: replace exited=u<invlogit(-3+.2*omega[_n-1]) if year==`t' & risk==1
    replace alive=0 if year==`t' & year>2010 & (risk==0 | exited==1)
    replace y=.6*l+.3*k+omega+noise if year==`t' & alive
}
* Keep authenticated risk skeleton after exit and remove one actual calendar wave.
* WFDOC: Hapus satu gelombang tetapi pertahankan baris tahun lain dan risk skeleton; uji memastikan 2017 tidak memperoleh lag satu tahun palsu dari 2015.
drop if year==2016
gen byte eligible=!missing(y)
gen str48 fixture="INDEPENDENT_ALGORITHM_TEST_NOT_G05"
xtset id year
tempfile fixture
save `fixture'
save "`outputdir'/fixture.dta", replace
gen double malformed_probability=.
* WFDOC: Uji guard point OP dengan probabilitas kosong harus gagal; pemeriksaan juga memastikan perintah tidak menghapus atau mengubah panel pemanggil.
capture noisily g1_prodest_point y if eligible, free(l) state(k) proxy(inv) id(id) t(year) valueadded method(op) attrition opprob(malformed_probability) reps(1) init(.6,.3) optimizer(nm)
assert _rc==9
assert _N==2160
drop malformed_probability
* WFDOC: Tabel agregat menyimpan beta, jumlah observasi, objective dan status konvergensi untuk membandingkan jalur metode pada fixture yang sama.
postfile results str8 method double labor double capital double N double N_selection double objective double converged using "`outputdir'/algorithm-results.dta", replace
* WFDOC: Empat cabang memakai investment untuk OP dan proxy input antara untuk LP/ACF/Wooldridge; 2016 yang hilang harus menghapus transisi 2017 dari e(sample).
foreach method in op lp acf wrdg {
    use `fixture', clear
    local proxy p
    local selection ""
    if "`method'"=="op" {
        local proxy inv
        local selection "risk(risk) exit(exited) selectionverified(1)"
    }
    g1_fit, method(`method') id(id) time(year) output(y) labor(l) capital(k) proxy(`proxy') eligible(eligible) panelverified(1) inputsverified(1) `selection' poly(3) start(ols)
    assert e(converged)==1
    assert e(N)>0
    * WFDOC: Kedekatan terhadap koefisien pembangkit adalah pemeriksaan mekanik berambang pada data simulasi, bukan estimasi atau bukti empiris tentang perusahaan G0.5.
    assert abs(_b[labor]-.6)<.08
    assert abs(_b[capital]-.3)<.08
    gen byte fitted=e(sample)
    assert fitted==0 if year==2017 | year==2010
    gen double structural_residual=y-_b[labor]*l-_b[capital]*k if fitted
    assert !missing(structural_residual) if fitted
    assert _N==2160
    assert fixture=="INDEPENDENT_ALGORITHM_TEST_NOT_G05"
    post results ("`method'") (_b[labor]) (_b[capital]) (e(N)) (e(N_selection)) (e(objective)) (e(converged))
    if "`method'"=="wrdg" {
        matrix list G1_POINT_FULL_B
        preserve
        clear
        svmat double G1_POINT_FULL_B
        export delimited using "`outputdir'/wrdg-b.csv", replace
        clear
        svmat double G1_POINT_W
        export delimited using "`outputdir'/wrdg-W.csv", replace
        restore
    }
}
postclose results
use "`outputdir'/algorithm-results.dta", clear
export delimited using "work-items/G1/stata/methods/tests/algorithm-results.csv", replace
list, noobs
* WFDOC: Pesan akhir membatasi klaim pada empat point fit algoritme dan keanggotaan sampel kalender dalam fixture buatan.
di "G1_INDEPENDENT_ALGORITHM_PASS: four distinct point fits and exact-calendar prediction samples; not empirical evidence"
log close
