version 17
clear all
set more off
set varabbrev off
args actual masked development
if `"`actual'"'=="" | `"`masked'"'=="" | `"`development'"'=="" error 198
* Read-only aggregate checks. Paths supplied by the caller; no datasets saved.
foreach mode in actual masked development {
    local input `"``mode''"'
    use obs_id year firm_id g1_results_attached panel_empirical_ready ///
        all_downstream_ready dev_nominal_tfp_op dev_nominal_tfp_lp ///
        dev_nominal_tfp_acf dev_nominal_tfp_wrdg using `"`input'"', clear
    assert _N==33049
    isid obs_id year
    assert panel_empirical_ready==0 & all_downstream_ready==0
    if "`mode'"=="actual" {
        assert missing(firm_id)
        assert g1_results_attached==0
        local expectedfirms=0
    }
    else {
        isid firm_id year
        assert !missing(firm_id)
        if "`mode'"=="masked" {
            assert g1_results_attached==0
            local expectedfirms=10472
        }
        else {
            assert g1_results_attached==1
            local expectedfirms=10395
        }
    }
    quietly egen byte firmtag=tag(firm_id) if !missing(firm_id)
    quietly count if firmtag==1
    local firms=r(N)
    assert `firms'==`expectedfirms'
    display as result "AUDIT_DATASET | `mode' | rows=" _N " | firms=`firms'"
    foreach method in op lp acf wrdg {
        quietly count if !missing(dev_nominal_tfp_`method')
        local observed=r(N)
        local expected=0
        if "`mode'"=="development" local expected=cond("`method'"=="op",683,10315)
        assert `observed'==`expected'
        display as result "AUDIT_TFP | `mode' | `method' | nonmissing=`observed'"
    }
}
display as result "LINEAGE_AUDIT_NATIVE_CHECKS_PASS"
exit, clear
