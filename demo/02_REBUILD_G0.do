/*****************************************************************************
 PILIHAN TERPISAH: membangun ulang G0 dari staged DTA dan pemetaan yang diterima.
 Default hanya menyiapkan salinan + memeriksa seluruh input, bukan run berat.
 Ini tidak dipanggil otomatis oleh demo dan tidak mengubah workspace G0 asli.
*****************************************************************************/
version 17
set more off
args owner_folder
if `"`owner_folder'"'=="" local owner_folder `"`c(pwd)'"'
global RUN_HOME `"`owner_folder'"'
global RUN_PYTHON "python3"
global RUN_STATA "stata-se"
global RUN_OUTPUT "$RUN_HOME/../../owner-runs"
global G0_ORIGINAL_ROOT ""
capture confirm file "$RUN_HOME/local_paths.do"
if !_rc do "$RUN_HOME/local_paths.do"

* Ubah 0 -> 1 untuk menjalankan. Satu proses Stata anak setiap saat.
global G0_EXECUTE 0
* H090 = seluruh 17 tahap; F010 = fixture dan pemeriksaan 12 input awal saja.
global G0_THROUGH "H090"

if "$G0_ORIGINAL_ROOT"=="" {
    display as error "Isi G0_ORIGINAL_ROOT di local_paths.do dengan workspace G0 yang diterima."
    exit 198
}
tempfile reply
shell env OPENBLAS_NUM_THREADS=1 OMP_NUM_THREADS=1 "$RUN_PYTHON" "$RUN_HOME/scripts/raw_replay.py" --original "$G0_ORIGINAL_ROOT" --output "$RUN_OUTPUT/g0-replay" --stata "$RUN_STATA" --execute "$G0_EXECUTE" --through "$G0_THROUGH" --reply "`reply'"
confirm file "`reply'"
do "`reply'"
display as result "$G0_REPLAY_STATUS | $G0_REPLAY_FOLDER"
