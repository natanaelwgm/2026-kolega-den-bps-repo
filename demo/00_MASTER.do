/*****************************************************************************
 DEASY–IMED | Buka file ini. Ubah pilihan di BAGIAN A, lalu Run seluruh file.

 Dari Stata, pertama kali:
     do "/path/to/2026-kolega-den-bps-repo/demo/00_MASTER.do"

 BAGIAN A memilih pekerjaan. 01_INPUTS.do memetakan file/kolom setiap tahun.
 Semua hasil baru masuk folder run baru. File sumber tidak ditimpa.
*****************************************************************************/
version 17
set more off
set varabbrev off
set linesize 100
capture window manage forward results

* A1. PILIH INPUT: excel_demo | g05_full | custom
* excel_demo = Excel G0.5 yang sudah tersedia (view ringkas, bukan 4.396 kolom).
* g05_full   = seluruh 33.049 x 4.396 data G0.5 yang ada di GitHub.
* custom     = Excel / DTA milik kita; petakan di 01_INPUTS.do.
global RUN_INPUT "g05_full"

* A2. development = demo; actual = nilai sumber asli dan ID asli yang dinyatakan.
* actual + g05_full memakai G0 asli lokal yang hash-nya telah disahkan.
global RUN_DATA_MODE "development"

* A3. auto = pakai ID lengkap bila ada; jika tidak ada, buat ID hanya untuk demo.
* supplied = wajib ID yang disediakan. synthetic = buat ulang, demo saja.
global RUN_ID_POLICY "auto"
global RUN_REAL_ID_CONFIRMED 0
global RUN_SEED 20260913

* A4. Pilih tahap: 1 jalan, 0 lewati. Tiap tahap punya log dan hasil sendiri.
global RUN_WAVES       0
global RUN_COVERAGE    1
global RUN_PANEL       1
global RUN_SUMMARIES   1
global RUN_G0_TABLES   1
global RUN_WORKBOOK    1
global RUN_FIGURES     1

* Untuk mengulang hasil dari input yang sama, cache input diverifikasi dan dipakai.
* Run baru selalu punya folder sendiri. Untuk melanjutkan run yang berhenti,
* isi RUN_RESUME dengan folder run itu; tahap selesai yang masih valid dilewati.
global RUN_RESUME ""
global RUN_VERBOSE 1

* B. LOKASI MESIN. local_paths.do dibuat oleh setup lokal dan tidak masuk Git.
* Bisa juga: do "00_RUN_ME.do" "/lokasi/repository/run-g0-g05"
* DEMO: g0 | g05 | g1. G0 = preparation of supplied data; G05 = development panel; G1 = nominal estimators.
global RUN_TO "g1"
* Compact output keeps every row and all G1 analytical inputs. Full preserves all 4,396 fields; needs extra disk.
global RUN_FULL_MASTER 0
* Optional research repetitions; default primary point estimates (no bootstrap standard errors).
global RUN_G1_SENSITIVITY 0
global RUN_G1_BOOTSTRAP 0
args owner_folder
if `"`owner_folder'"'=="" local owner_folder `"`c(pwd)'"'
global RUN_HOME `"`owner_folder'"'
confirm file "$RUN_HOME/01_INPUTS.do"
global RUN_REPO "$RUN_HOME/.."
global RUN_PYTHON "python3"
global RUN_OUTPUT "$RUN_HOME/../../owner-runs"
global RUN_ACTUAL_PATH ""
capture confirm file "$RUN_HOME/local_paths.do"
if !_rc do "$RUN_HOME/local_paths.do"

* Isolasi nama konfigurasi agar nama kolom sumber cukup diedit satu tempat.
do "$RUN_HOME/01_INPUTS.do"

* Pilihan tambahan dari command line/setup boleh ditaruh di file lokal ini.
* File ini tidak diperlukan untuk run biasa; jangan mengubah kode di bawah.
capture confirm file "$RUN_HOME/run_overrides.local.do"
if !_rc do "$RUN_HOME/run_overrides.local.do"

if c(maxvar)<10000 {
    clear
    set maxvar 10000
}

foreach flag in RUN_FULL_MASTER RUN_G1_SENSITIVITY RUN_G1_BOOTSTRAP {
    if !inlist("${`flag'}","0","1") {
        display as error "`flag' must be 0 or 1"
        exit 198
    }
}
if "$RUN_TO"=="g1" & "$RUN_RESUME"!="" {
    display as error "G1 demo needs a new run. Leave RUN_RESUME empty."
    exit 198
}
if !inlist("$RUN_TO","g0","g05","g1") {
    display as error "RUN_TO must be g0, g05, or g1"
    exit 198
}
if "$RUN_TO"=="g0" {
    global RUN_DATA_MODE "actual"
    if "$RUN_ID_POLICY"=="synthetic" global RUN_ID_POLICY "auto"
}
if inlist("$RUN_TO","g05","g1") & "$RUN_DATA_MODE"!="development" {
    display as error "G05/G1 demo requires development data. Choose RUN_TO g0 for actual source checks."
    exit 198
}
quietly do "$RUN_HOME/code/live_progress.do"
demo_progress "0" "Mulai demo: periksa input dan pilihan run"
* Semua validasi input diselesaikan sebelum sebuah tahap analisis dijalankan.
do "$RUN_HOME/code/driver.do"

if "$RUN_TO"=="g1" {
    capture noisily do "$RUN_HOME/code/g1_demo.do"
    local g1_rc=_rc
    if `g1_rc' {
        demo_shell "$RUN_PYTHON" "$RUN_HOME/scripts/demo.py" failed "$DR_RUN" "G1 rc=`g1_rc'; see g1/logs/G1_execution.log"
        exit `g1_rc'
    }
}
else {
    demo_shell "$RUN_PYTHON" "$RUN_HOME/scripts/demo.py" finish "$DR_RUN" "$RUN_TO"
    confirm file "$DR_RUN/DEMO_COMPLETE.json"
}
demo_progress "SELESAI" "Semua tahap yang dipilih sudah lulus; hasil siap dibuka"
display as result "DEMO_DONE | $DR_RUN/DEMO.html"
