demo_progress "10/16" "G1: menyiapkan input estimasi, modal, material dan panel"
tempfile g1reply
demo_shell "$RUN_PYTHON" "$RUN_HOME/scripts/demo.py" prepare "$DR_RUN" "$RUN_REPO" "$RUN_FULL_MASTER" "`g1reply'"
confirm file "`g1reply'"
do "`g1reply'"
cd "$RUN_REPO"
capture log close G1_DEMO
log using "$G1_RUN/logs/G1_execution.log", name(G1_DEMO) text replace
global G1_VARIANTS "primary"
if "$RUN_G1_SENSITIVITY"=="1" global G1_VARIANTS "primary low_l high_l poly2"
foreach stage in N01_inputs N02_risk N03_samples N04_fits {
    local meaning "`stage'"
    if "`stage'"=="N01_inputs" local meaning "11/16 G1: lag modal kalender dan log input positif"
    if "`stage'"=="N02_risk" local meaning "12/16 G1: bangun interval panel development"
    if "`stage'"=="N03_samples" local meaning "13/16 G1: tentukan sampel OP, LP, ACF, Wooldridge"
    if "`stage'"=="N04_fits" local meaning "14/16 G1: estimasi per sektor, metode dan sampel"
    if "`stage'"=="N06_outputs" local meaning "15/16 G1: distribusi residual dan perbandingan metode"
    if "`stage'"=="N07_master" local meaning "16/16 G1: tempel hasil estimasi ke seluruh baris"
    demo_progress "G1" "`meaning'"
    display as result "G1_START | `stage'"
    demo_shell "$RUN_PYTHON" "$RUN_HOME/scripts/demo.py" progress "$DR_RUN" "`stage' running"
    do "$RUN_HOME/code/nominal/`stage'.do"
    display as result "G1_PASSED | `stage'"
}
if "$RUN_G1_BOOTSTRAP"=="1" do "$RUN_HOME/code/nominal/N05_bootstrap.do"
foreach stage in N06_outputs N07_master {
    local meaning "`stage'"
    if "`stage'"=="N01_inputs" local meaning "11/16 G1: lag modal kalender dan log input positif"
    if "`stage'"=="N02_risk" local meaning "12/16 G1: bangun interval panel development"
    if "`stage'"=="N03_samples" local meaning "13/16 G1: tentukan sampel OP, LP, ACF, Wooldridge"
    if "`stage'"=="N04_fits" local meaning "14/16 G1: estimasi per sektor, metode dan sampel"
    if "`stage'"=="N06_outputs" local meaning "15/16 G1: distribusi residual dan perbandingan metode"
    if "`stage'"=="N07_master" local meaning "16/16 G1: tempel hasil estimasi ke seluruh baris"
    demo_progress "G1" "`meaning'"
    display as result "G1_START | `stage'"
    demo_shell "$RUN_PYTHON" "$RUN_HOME/scripts/demo.py" progress "$DR_RUN" "`stage' running"
    do "$RUN_HOME/code/nominal/`stage'.do"
    display as result "G1_PASSED | `stage'"
}
demo_progress "VALIDASI" "Cek ulang residual, data, grafik G1 dan Excel akhir"
demo_shell "$RUN_PYTHON" "$RUN_HOME/scripts/demo.py" finish "$DR_RUN" "g1"
confirm file "$DR_RUN/DEMO_COMPLETE.json"
log close G1_DEMO
