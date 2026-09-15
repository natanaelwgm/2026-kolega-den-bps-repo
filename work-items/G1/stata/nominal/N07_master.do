* WFDOC: Menempel sidecar N06 ke full_input.dta, mempertahankan kolom master dan urutan baris asal.
* WFDOC: Join obs_id-tahun harus match; psid-tahun unik hanya memeriksa ID development fiktif, bukan linkage aktual.
* WFDOC: Output DTA/CSV berlabel nominal-development; residual lampiran bukan TFP riil atau final.
* Attach the computed sidecar to all original columns; preserve original row order.
use "$G1_RUN/nominal/N06_selected_attached.dta", clear
keep obs_id source_year dev_nominal_*
isid obs_id source_year
tempfile sidecar
save `sidecar'
use "$G1_RUN/full_input.dta", clear
local n_source=_N
gen long g1_original_row_order=_n
* WFDOC: Merge harus match satu-ke-satu; row count dan psid-tahun unik dicek sebelum urutan master dipulihkan.
* WFDOC: Merge exact obs_id×source_year hanya dapat menambahkan sidecar yang sudah diaudit; assert(match) dan row count memastikan tidak ada observasi master yang hilang atau baru.
merge 1:1 obs_id source_year using `sidecar', assert(match) nogen
assert _N==`n_source'
isid psid source_year
sort g1_original_row_order
drop g1_original_row_order
label data "G0.5 DEVELOPMENT plus G1 nominal residuals; not final real TFP"
save "$G1_RUN/analysis/G1_main_with_tfp.dta", replace
preserve
* WFDOC: Rekap akhir memakai N_source per tahun sebagai denominator attachment residual nonmissing.
* WFDOC: Rekap tahunan memakai seluruh row master sebagai N_source lalu menghitung prediction dan dynamic fit per metode; ini bukan jumlah perusahaan atau inferensi populasi.
gen byte source_record=1
foreach m in op lp acf wrdg {
    gen byte attached_`m'=!missing(dev_nominal_tfp_`m')
    gen byte fitted_`m'=dev_nominal_in_fit_`m'
}
collapse (sum) N_source=source_record N_op=attached_op N_lp=attached_lp N_acf=attached_acf N_wrdg=attached_wrdg N_fit_op=fitted_op N_fit_lp=fitted_lp N_fit_acf=fitted_acf N_fit_wrdg=fitted_wrdg, by(source_year)
gen str100 data_label="G0.5 DEVELOPMENT - full original master plus nominal residuals; original fields preserved"
export delimited using "$G1_RUN/outputs/nominal_master_attachment.csv", replace
restore
