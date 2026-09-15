* Driver: parameter -> preflight -> normalisasi -> identitas -> modul -> hasil.
* Setiap helper menulis reply baru hanya setelah sukses; shell exit bukan bukti.
tempfile request reply
file open cfg using "`request'", write text replace
file write cfg "repo" _tab "$RUN_REPO" _n "home" _tab "$RUN_HOME" _n
file write cfg "output" _tab "$RUN_OUTPUT" _n "actual_path" _tab "$RUN_ACTUAL_PATH" _n
file write cfg "profile" _tab "$RUN_INPUT" _n "mode" _tab "$RUN_DATA_MODE" _n
file write cfg "id_policy" _tab "$RUN_ID_POLICY" _n "real_id_confirmed" _tab "$RUN_REAL_ID_CONFIRMED" _n
file write cfg "seed" _tab "$RUN_SEED" _n "resume" _tab "$RUN_RESUME" _n
file write cfg "years" _tab "$INPUT_YEARS" _n "number_style" _tab "$INPUT_NUMBER_STYLE" _n
file write cfg "extra_fields" _tab "$INPUT_EXTRA_FIELDS" _n
file write cfg "missing_tokens" _tab "$INPUT_MISSING_TOKENS" _n
foreach step in WAVES COVERAGE PANEL SUMMARIES G0_TABLES WORKBOOK FIGURES {
    file write cfg "run_`step'" _tab "${RUN_`step'}" _n
}
foreach y of global INPUT_YEARS {
    local extra_number=0
    foreach field of global INPUT_EXTRA_FIELDS {
        local ++extra_number
        file write cfg "MAP_EXTRA_`field'_`y'" _tab "${EXTRA`extra_number'_`y'}" _n
    }
    foreach setting in FILE FORMAT SHEET HEADER FIRST LAST FILTER_YEAR {
        file write cfg "`setting'_`y'" _tab "${`setting'_`y'}" _n
    }
    foreach role in FIRM_ID OBS_ID YEAR PROVINCE SECTOR WORKERS OUTPUT VALUE_ADDED INPUTS MATERIALS FUEL_COST ELECTRICITY PAYROLL_PROD PAYROLL_OTHER {
        file write cfg "MAP_`role'_`y'" _tab "${MAP_`role'_`y'}" _n
    }
}
file close cfg

demo_progress "1" "Memeriksa file input, header, mapping dan hash data"
display as text "PREFLIGHT | Memeriksa file, header, konfigurasi dan versi input..."
demo_shell "$RUN_PYTHON" "$RUN_HOME/scripts/workflow.py" prepare --request "`request'" --reply "`reply'"
capture confirm file "`reply'"
if _rc {
    display as error "Preflight gagal. Lihat pesan Python tepat di atas; belum ada analisis dijalankan."
    exit 601
}
do "`reply'"

capture log close OWNER_RUN
log using "$DR_RUN/logs/00_master.log", name(OWNER_RUN) text append
if "$DR_NEEDS_NORMALIZATION"=="1" {
    display as text "NORMALIZE | Excel/DTA -> nama standar; semua kolom sumber dipertahankan."
    capture noisily do "$DR_RUN/code/normalize.do"
    local normalize_rc=_rc
    if `normalize_rc' {
        display as error "NORMALIZE FAILED | rc=`normalize_rc' | $DR_RUN/logs/01_normalize.log"
        tempfile failure_reply
        demo_shell "$RUN_PYTHON" "$RUN_HOME/scripts/workflow.py" fail --run "$DR_RUN" --stage normalization --rc "`normalize_rc'" --reply "`failure_reply'"
        capture log close OWNER_RUN
        exit `normalize_rc'
    }
    tempfile identity_reply
    demo_shell "$RUN_PYTHON" "$RUN_HOME/scripts/workflow.py" identity --run "$DR_RUN" --reply "`identity_reply'"
    confirm file "`identity_reply'"
    do "`identity_reply'"
    use "$DR_RUN/intermediate/normalized.dta", clear
    merge 1:1 obs_id using "$DR_RUN/intermediate/identity.dta", assert(match) nogen
    isid obs_id
    label data "DEASY normalized input; see run receipt for data and identity basis"
    save "$DR_RUN/data/analysis_ready.dta", replace
}

* Loop ini tidak menelan error. Modul berikutnya hanya jalan setelah pendahulunya.
local stage_number=1
foreach stage in input waves coverage panel summaries g0_tables workbook figures {
    local ++stage_number
    local task_`stage' "`stage'"
    if "`stage'"=="input" local task_`stage' "G0: baca data dan periksa kunci observasi"
    if "`stage'"=="waves" local task_`stage' "G0: simpan file per tahun"
    if "`stage'"=="coverage" local task_`stage' "G0: cek isi dan missing setiap kolom per tahun"
    if "`stage'"=="panel" local task_`stage' "G0.5: cek panel dan hubungan antar tahun"
    if "`stage'"=="summaries" local task_`stage' "G0: statistik deskriptif per variabel dan tahun"
    if "`stage'"=="g0_tables" local task_`stage' "G0: tabel analisis dari modul asli"
    if "`stage'"=="workbook" local task_`stage' "G0: membuat Excel dan memeriksa setiap sheet"
    if "`stage'"=="figures" local task_`stage' "G0: menggambar grafik per variabel"
    demo_progress "`stage_number'/16" "`task_`stage''"
    tempfile stage_reply
    demo_shell "$RUN_PYTHON" "$RUN_HOME/scripts/workflow.py" stage-start --run "$DR_RUN" --stage "`stage'" --reply "`stage_reply'"
    confirm file "`stage_reply'"
    do "`stage_reply'"
    if "$DR_SKIP_STAGE"=="1" {
        noisily display as text "DILEWATI | tahap tidak dipilih atau sudah selesai"
        continue
    }
    display as result "START | `stage' | $DR_RUN"
    timer clear 91
    timer on 91
    if inlist("`stage'","workbook","figures") {
        tempfile presentation_reply
        demo_shell "$RUN_PYTHON" "$RUN_HOME/scripts/workflow.py" present --run "$DR_RUN" --stage "`stage'" --reply "`presentation_reply'"
        capture confirm file "`presentation_reply'"
        local stage_rc=_rc
    }
    else {
        if $RUN_VERBOSE capture noisily do "$RUN_HOME/code/`stage'.do"
        else capture quietly do "$RUN_HOME/code/`stage'.do"
        local stage_rc=_rc
    }
    timer off 91
    quietly timer list 91
    local elapsed=r(t91)
    tempfile receipt_reply
    demo_shell "$RUN_PYTHON" "$RUN_HOME/scripts/workflow.py" stage-end --run "$DR_RUN" --stage "`stage'" --rc "`stage_rc'" --elapsed "`elapsed'" --reply "`receipt_reply'"
    capture confirm file "`receipt_reply'"
    if _rc & !`stage_rc' local stage_rc=459
    if `stage_rc' {
        display as error "FAILED | `stage' | rc=`stage_rc' | $DR_RUN/logs/`stage'.log"
        display as error "Hasil tahap sebelumnya tetap ada. Baca STATUS.md di folder run."
        capture log close OWNER_RUN
        exit `stage_rc'
    }
    do "`receipt_reply'"
    display as result "$DR_STAGE_STATUS | `stage' | `elapsed' seconds"
}
tempfile final_reply
demo_shell "$RUN_PYTHON" "$RUN_HOME/scripts/workflow.py" finish --run "$DR_RUN" --reply "`final_reply'"
confirm file "`final_reply'"
do "`final_reply'"
display as result "SELESAI | $DR_RUN/START_HERE.md"
display as text "Data: $DR_INPUT"
capture log close OWNER_RUN
