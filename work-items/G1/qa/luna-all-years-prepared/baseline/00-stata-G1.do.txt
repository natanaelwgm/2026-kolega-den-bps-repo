version 17
* WFDOC: Argumen root, run, mode memilih repo, folder keluaran, dan mode loader; satu master dimuat lewat harness/g05/use_data.do.
* WFDOC: E01–E19 mengaudit kunci, kalender, domain, dan gate metode real; N01–N07 adalah cabang nominal-development ber-psid fiktif.
* WFDOC: Artefak/log berada di G1_RUN. START/END menandai progres, bukan keberhasilan fit; residual nominal bukan TFP riil/final.
* WFDOC: Assert atau perintah tanpa capture menghentikan alur saat gagal; log mempertahankan tahap terakhir yang tercapai.
clear all
set more off
set type double
set maxvar 12000
args root run mode base
* WFDOC: Dalam mode diagnostics, base adalah run nominal-development yang dibaca saja dan run adalah folder baru untuk enam pemeriksaan N08–N13.
* WFDOC: Rute diagnostics memanggil child G1_deep.do lalu keluar sebelum memuat master atau menjalankan E01–E19 dan N01–N07.
if "`mode'"=="diagnostics" {
    do "`root'/work-items/G1/stata/deep/G1_deep.do" "`root'" "`base'" "`run'"
    exit, clear
}
* WFDOC: Di mode biasa, blok setelah rute ini tetap memakai alur audit utama dan cabang nominal-development seperti semula.
global G1_ROOT "`root'"
global G1_RUN "`run'"
global G1_MODE "`mode'"
global G1_CODE "$G1_ROOT/work-items/G1/stata"
cd "$G1_ROOT"
capture log close _all
log using "$G1_RUN/G1_execution.log", text replace
display "G1 START | $G1_MODE | input and calendar gates precede every estimator"
do "$G1_ROOT/harness/g05/use_data.do" "$G1_MODE" "$G1_RUN/input.dta"
forvalues e=1/19 {
    local edge : display %02.0f `e'
    display "G1_E`edge' START | rows=" _N
    do "$G1_CODE/edges/G1_E`edge'.do"
    display "G1_E`edge' END | rows=" _N
}
* WFDOC: Penanda ini menutup audit gate real pada panel development; bukan penerimaan ukuran real atau fit primer.
display "G1_REAL_PRIMARY_AUDIT_COMPLETE | fictional development panel accepted"
foreach child in N01_inputs N02_risk N03_samples N04_fits N05_bootstrap N06_outputs N07_master {
    display "G1_`child' START | explicitly declared nominal development branch"
    do "$G1_CODE/nominal/`child'.do"
    display "G1_`child' END"
}
* WFDOC: Status akhir memisahkan cabang nominal-development dari primary real yang belum diadmit.
display "G1_DEVELOPMENT_COMPLETE_PRIMARY_REAL_NOT_ADMITTED"
log close
exit, clear
