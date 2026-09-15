* WFDOC: N12 verifies observed group means using saved primary slopes and the pooled dynamic mean; no new fit is made.
* WFDOC: Every supported sector-method-sample has pooled source_year0 plus all annual obligations; N<5 suppresses observed means and derived examples.
* WFDOC: A separate source_year0 illustrative row uses designed logs y=10,l=3,k=8 and has no observation count. It is never a company record.
* WFDOC: mean(exp(centered)) and exp(mean(centered)) are separate quantities. Documentary source flags remain unchanged upstream.
tempname w
postfile `w' str4 sector str8 method str8 sample_id double source_year str40 example_type double N double mean_y double mean_l double mean_k double beta_L double beta_K double labor_product double capital_product double normalizer_value double raw_residual double centered_residual double exp_centered double mean_index double numeric_released double normalizer_year str24 normalizer_scope using "$G1_DEEP/intermediate/deep_worked_calculations.dta", replace
use "$G1_DEEP/intermediate/primary_predictions.dta", clear
levelsof sector, local(sectors) clean
foreach sector of local sectors {
    foreach method in op lp acf wrdg {
        foreach sample in own common {
            preserve
            keep if sector=="`sector'" & method=="`method'" & sample_id=="`sample'"
            count
            local ncell=r(N)
            if `ncell'>0 {
                assert labor==labor[1] & capital==capital[1] & residual_reference_mean==residual_reference_mean[1]
                local bl=labor[1]
                local bk=capital[1]
                local norm=residual_reference_mean[1]
                foreach year in $D_YEARS {
                    local yr "source_year==`year'"
                    if `year'==0 local yr "1"
                    count if `yr'
                    local n=r(N)
                    foreach v in my ml mk raw mi lp kp cent ex {
                        local `v' .
                    }
                    * WFDOC: Group means memakai log y/l/k pada kelompok prediction; identitas raw=mean_y−beta_L×mean_l−beta_K×mean_k diuji sebelum centering dengan normalizer pooled yang sama.
                    if `n'>=5 {
                        foreach x in y l k {
                            summarize nom_`x' if `yr', meanonly
                            local m`x'=r(mean)
                        }
                        summarize raw if `yr', meanonly
                        local raw=r(mean)
                        summarize index if `yr', meanonly
                        local mi=r(mean)
                        local lp=`bl'*`ml'
                        local kp=`bk'*`mk'
                        assert abs(`raw'-(`my'-`lp'-`kp'))<1e-10
                        local cent=`raw'-`norm'
                        local ex=exp(`cent')
                    }
                    post `w' ("`sector'") ("`method'") ("`sample'") (`year') ("observed_group_means") (`n') (`my') (`ml') (`mk') (`bl') (`bk') (`lp') (`kp') (`norm') (`raw') (`cent') (`ex') (`mi') (`n'>=5) (.) ("pooled_dynamic")
                }
                * WFDOC: Baris illustrative_fixed_log_inputs memakai log yang dirancang dan slope cell tanpa N atau firm denominator; source_year=0 di sini adalah label contoh, bukan observed pooled group.
                local raw=10-`bl'*3-`bk'*8
                local cent=`raw'-`norm'
                post `w' ("`sector'") ("`method'") ("`sample'") (0) ("illustrative_fixed_log_inputs") (.) (10) (3) (8) (`bl') (`bk') (`bl'*3) (`bk'*8) (`norm') (`raw') (`cent') (exp(`cent')) (.) (1) (.) ("pooled_dynamic")
            }
            restore
        }
    }
}
postclose `w'
use "$G1_DEEP/intermediate/deep_worked_calculations.dta", clear
ds, has(type numeric)
format `r(varlist)' %24.17g
export delimited using "$G1_DEEP/outputs/deep_worked_calculations.csv", replace
