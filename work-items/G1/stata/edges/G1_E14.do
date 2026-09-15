* WFDOC: Empat baris diagnostik method-specific dibuat sebelum fit real: status BLOCKED_BEFORE_ESTIMATION, attempted=0 dan N_estimation=0.
* WFDOC: Beta, RTS, convergence, rank, objective, iterasi dan CI missing berarti belum diestimasi, bukan parameter atau N nol hasil fit.
preserve
clear
set obs 4
gen str8 method = ""
local j=0
foreach m in op lp acf wrdg {
    local ++j
    replace method="`m'" in `j'
}
gen str32 specification_id = "VA_CD_d3_pinned2018"
gen str20 sample_id = "method_specific"
gen str40 status = "BLOCKED_BEFORE_ESTIMATION"
gen str100 reason = "Development panel accepted; real measurement, concept-specific prices and technology bridge pending"
gen byte attempted = 0
gen double convergence = .
gen double instrument_count = .
gen double instrument_rank = .
gen double jacobian_rank = .
gen double moment_criterion = .
gen double iterations = .
gen double N_estimation = 0
gen str100 data_label = "G0.5 DEVELOPMENT - perturbed data; not final empirical findings"
* WFDOC: CSV optimizer dan coefficients memisahkan diagnostics dari parameter; CI belum tersedia sebelum fit sah.
export delimited using "$G1_RUN/outputs/tfp_optimizer_diagnostics.csv", replace
keep method specification_id sample_id status reason N_estimation data_label
gen double beta_L = .
gen double beta_K = .
gen double returns_to_scale = .
gen double ci_lower = .
gen double ci_upper = .
export delimited using "$G1_RUN/outputs/tfp_coefficients.csv", replace
restore
