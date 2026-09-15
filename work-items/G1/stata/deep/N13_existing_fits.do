* WFDOC: N13 hanya membaca variasi fit dan bootstrap draws yang sudah disimpan; tidak menjalankan fit, resampling, atau mengganti spesifikasi utama.
* WFDOC: Kunci sensitivitas sektor×metode×sampel×variant; setiap slope/objective dibandingkan dengan primary milik sel yang sama.
* WFDOC: Input ialah nominal_coefficients.csv dan file draw nominal_* yang tersedia; keluaran deep_fit_sensitivities.csv, deep_bootstrap_profiles.csv, dan deep_bootstrap_histograms.csv.
* WFDOC: Wooldridge tetap memakai pembatasan shared theta pada kontrak pinned; beda objective antar-metode tidak dapat dibandingkan.
* WFDOC: Ringkasan draw memakai draw sukses yang sudah ada; group N<5 menyembunyikan statistik persis, dan nilai draw individual tetap privat.
import delimited using "$G1_BASE/outputs/nominal_coefficients.csv", clear varnames(1) stringcols(1)
keep if variant=="primary"
keep sector method sample_id beta_l beta_k objective
rename beta_l primary_beta_L
rename beta_k primary_beta_K
rename objective primary_objective
tempfile primary
save `primary'
import delimited using "$G1_BASE/outputs/nominal_coefficients.csv", clear varnames(1) stringcols(1)
* WFDOC: Merge m:1 menempelkan satu fit primary per sel ke seluruh variant; assert(3) menolak sel tanpa pasangan pembanding.
merge m:1 sector method sample_id using `primary', assert(3) nogen
rename beta_l beta_L
rename beta_k beta_K
rename n N
gen double delta_L=beta_L-primary_beta_L
gen double delta_K=beta_K-primary_beta_K
gen double delta_objective=objective-primary_objective
gen byte objective_below_primary=objective<primary_objective if !missing(objective,primary_objective)
keep sector method sample_id variant status beta_L beta_K objective primary_beta_L primary_beta_K primary_objective delta_L delta_K delta_objective objective_below_primary N
order sector method sample_id variant status beta_L beta_K objective primary_beta_L primary_beta_K primary_objective delta_L delta_K delta_objective objective_below_primary N
ds, has(type numeric)
format `r(varlist)' %24.17g
export delimited using "$G1_DEEP/outputs/deep_fit_sensitivities.csv", replace
tempname p h
postfile `p' str4 sector str8 method str8 sample_id str20 measure double N double mean double sd double min double p1 double p5 double p25 double p50 double p75 double p95 double p99 double max double iqr double fence_lo15 double fence_hi15 double fence_lo3 double fence_hi3 double N_below15 double N_above15 double N_below3 double N_above3 double numeric_released double N_requested double N_successful using "$G1_DEEP/intermediate/deep_bootstrap_profiles.dta", replace
postfile `h' str4 sector str8 method str8 sample_id str20 measure double bin_lower double bin_upper double N_bin double N_total double share using "$G1_DEEP/intermediate/deep_bootstrap_histograms.dta", replace
* WFDOC: Bootstrap dibaca per sektor observasi; ALL dilewati agar distribusi draw tidak mencampur strata/fit cells.
foreach sector in $D_SECTORS {
    if "`sector'"!="ALL" {
        foreach method in op lp acf wrdg {
            foreach sample in own common {
                capture confirm file "$G1_BASE/outputs/bootstrap_draws/nominal_`sector'_`method'_`sample'.csv"
                if !_rc {
                    import delimited using "$G1_BASE/outputs/bootstrap_draws/nominal_`sector'_`method'_`sample'.csv", clear varnames(1)
                    count
                    local nr=r(N)
                    count if success==1
                    local ns=r(N)
                    * WFDOC: N_requested menghitung seluruh file dan N_successful draw success==1; failure tetap memengaruhi penyebut receipt.
                    foreach measure in labor capital objective {
                        deep_stats `measure' if success==1
                        post `p' ("`sector'") ("`method'") ("`sample'") ("`measure'") $D_POST (`nr') (`ns')
                        * WFDOC: Bin tetap selebar 0.1 hanya untuk slope labor/capital; objective tiap metode tidak dikumpulkan bersama.
                        if $D_N>0 & "`measure'"!="objective" {
                            preserve
                            keep if success==1 & !missing(`measure')
                            local nt=_N
                            gen double bin_lower=floor(`measure'/.1)*.1
                            collapse (count) N_bin=`measure', by(bin_lower)
                            forvalues j=1/`=_N' {
                                post `h' ("`sector'") ("`method'") ("`sample'") ("`measure'") (bin_lower[`j']) (bin_lower[`j']+.1) (N_bin[`j']) (`nt') (N_bin[`j']/`nt')
                            }
                            restore
                        }
                    }
                }
            }
        }
    }
}
* WFDOC: Tiga CSV mempertahankan semua variant, distribusi draw sukses, dan bin slope tanpa membuka baris draw individual.
postclose `p'
use "$G1_DEEP/intermediate/deep_bootstrap_profiles.dta", clear
ds, has(type numeric)
format `r(varlist)' %24.17g
export delimited using "$G1_DEEP/outputs/deep_bootstrap_profiles.csv", replace
postclose `h'
use "$G1_DEEP/intermediate/deep_bootstrap_histograms.dta", clear
ds, has(type numeric)
format `r(varlist)' %24.17g
export delimited using "$G1_DEEP/outputs/deep_bootstrap_histograms.csv", replace
