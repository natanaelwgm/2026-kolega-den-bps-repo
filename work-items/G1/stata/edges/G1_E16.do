* WFDOC: Direncanakan 999 bootstrap draw per metode, tetapi attempted=0 dan successful missing karena point fit asli belum diterima.
* WFDOC: Status bukan kegagalan draw yang dicoba; covariance/CI belum tersedia sebelum cabang real diadmit.
preserve
clear
set obs 4
gen str8 method = ""
local j=0
foreach m in op lp acf wrdg {
    local ++j
    replace method="`m'" in `j'
}
gen double planned_draws = 999
gen double attempted_draws = 0
gen double successful_draws = .
gen str70 status = "BLOCKED_NO_IDENTIFIED_ORIGINAL_FIT"
gen str100 data_label = "G0.5 DEVELOPMENT - perturbed data; not final empirical findings"
export delimited using "$G1_RUN/outputs/bootstrap_status.csv", replace
restore
