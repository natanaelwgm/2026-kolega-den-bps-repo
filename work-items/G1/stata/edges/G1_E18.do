* WFDOC: Membuat derivative eligibility/status, bukan lampiran TFP numerik; sidecar bergrain obs_id-tahun dan flag prediksi tetap false.
* WFDOC: Main derivative mempertahankan panel input; audit tahunan merangkum jumlah sumber, common support, eligibility, dan prediksi.
* Save a one-to-one eligibility/status sidecar; all four numerical TFP fields remain missing.
isid obs_id
save "$G1_RUN/analysis/G1_input_eligibility.dta", replace
keep obs_id source_year g1_* tfp_*
isid obs_id
save "$G1_RUN/analysis/G1_tfp_status_sidecar.dta", replace
tempfile sidecar
save `sidecar'
use "$G1_RUN/S01_input.dta", clear
local n_source=_N
* WFDOC: Join obs_id-tahun satu-ke-satu menolak kunci ganda/using-only; cek N dan isid menjaga row count.
merge 1:1 obs_id source_year using `sidecar', assert(match) nogen
assert _N==`n_source'
isid obs_id
save "$G1_RUN/analysis/G1_main_with_tfp.dta", replace
* This is a selected-column derivative with status fields, not a completed numerical TFP attachment.
preserve
* WFDOC: Rekap tahunan memakai semua baris sumber sebagai denominator dan jumlah prediksi nonmissing per metode.
gen byte g1_obs=1
collapse (sum) N_source=g1_obs N_development_panel_usable=g1_panel_usable N_common=g1_common N_op=g1_predicted_op N_lp=g1_predicted_lp N_acf=g1_predicted_acf N_wrdg=g1_predicted_wrdg, by(source_year)
gen str70 attachment_status = "STATUS_SIDECAR_ONLY_NO_NUMERICAL_TFP"
gen str100 data_label = "G0.5 DEVELOPMENT - perturbed data; not final empirical findings"
export delimited using "$G1_RUN/outputs/tfp_attachment_audit.csv", replace
restore
