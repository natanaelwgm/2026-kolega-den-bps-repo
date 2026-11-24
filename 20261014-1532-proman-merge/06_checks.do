/*==========================================================================
  06  Checks: match rates, units, and everything that was changed
  Input : output/analysis_ready_with_roster.dta, output/roster_firm_year.dta,
          output/proman_rows.dta, output/bahanbaku_rows.dta, output/_notes_*.dta
  Output:
    output/merge_report.csv   1 row = roster x year
        key_type             key of the year (kipb / cell_kab / cell)
        main_firm_years      firm-years of the ready-to-use file
        main_matched, pct_main_matched     ... that received this roster's values
        pct_main_one_firm    ... matched AND alone in their key (100 with Kipb)
        roster_keys, roster_keys_found, pct_keys_found   roster firm-years / cells found
        roster_rows, pct_rows_found        roster rows whose key is found
    output/units_check.csv    1 row = year: median ratio of roster values to the
        ready-to-use file, over matched firm-years alone in their key
        ratio_prod_output    Proman production value / $PM_MAIN_OUTPUT
        ratio_mat_materials  Bahan Baku material value / $PM_MAIN_MAT
        flag                 CHECK UNITS when a median is below 0.1 or above 10
        (a factor ~1000 means Rp vs Rp 000; values in block 0 are masked
        +/-20-30%, so expect medians near 1, not exactly 1)
    output/cleaning_report.csv  every count noted by 01-05 (roster, year, item, n)
==========================================================================*/
if "$PM" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
pm_notes_start

* ---- keys present in the ready-to-use file --------------------------------------------
use roster_key roster_match roster_n_main roster_key_type in_proman in_bahanbaku $PM_MAIN_YEAR ///
    using "$PM_OUT/analysis_ready_with_roster.dta", clear
rename $PM_MAIN_YEAR year
keep if roster_match < .
tempfile mainside
save `mainside'

* the key of every main row, also the unmatched ones, is rebuilt in 05 only for
* matched rows; for "found" we use the roster side against the matched keys
preserve
keep if roster_key != ""
keep year roster_key
duplicates drop
generate byte in_main = 1
tempfile mainkeys
save `mainkeys'
restore

* ---- main-file side ---------------------------------------------------------
tempfile report
local first 1
foreach r in proman bahanbaku {
    use `mainside', clear
    generate byte m   = (in_`r' == 1)
    generate byte one = (in_`r' == 1 & roster_n_main == 1)
    collapse (count) main_firm_years = roster_match (sum) main_matched = m one ///
             (firstnm) key_type = roster_key_type, by(year)
    generate double pct_main_matched  = 100 * main_matched / main_firm_years
    generate double pct_main_one_firm = 100 * one / main_firm_years
    drop one
    generate str9 roster = "`r'"
    if `first' == 0 append using `report'
    save `report', replace
    local first 0
}

* ---- roster side ------------------------------------------------------------------
foreach r in proman bahanbaku {
    capture confirm file "$PM_OUT/`r'_rows.dta"
    if _rc continue
    use "$PM_OUT/roster_firm_year.dta", clear
    keep if in_`r' == 1
    merge 1:1 roster_key year using `mainkeys', keep(master match)
    generate byte found = (_merge == 3)
    collapse (count) roster_keys = found (sum) roster_keys_found = found, by(year)
    generate double pct_keys_found = 100 * roster_keys_found / roster_keys
    generate str9 roster = "`r'"
    tempfile k_`r'
    save `k_`r''
    * rows: the key of each row, as in 04
    use "$PM_OUT/key_by_year.dta", clear
    keep year key_type
    tempfile keys
    save `keys'
    use "$PM_OUT/`r'_rows.dta", clear
    merge m:1 year using `keys', keep(master match) nogenerate
    generate str100 roster_key = ""
    replace roster_key = "K:" + kipb                           if key_type == "kipb"     & kipb != ""
    replace roster_key = "D:" + prov + "_" + kab + "_" + kbli5 if key_type == "cell_kab" & prov != "" & kab != "" & kbli5 != ""
    replace roster_key = "C:" + prov + "_" + kbli5             if key_type == "cell"     & prov != "" & kbli5 != ""
    merge m:1 roster_key year using `mainkeys', keep(master match)
    generate byte found = (_merge == 3)
    collapse (count) roster_rows = found (sum) rows_found = found, by(year)
    generate double pct_rows_found = 100 * rows_found / roster_rows
    drop rows_found
    generate str9 roster = "`r'"
    merge 1:1 roster year using `k_`r'', nogenerate
    tempfile r_`r'
    save `r_`r''
}
use `report', clear
foreach r in proman bahanbaku {
    capture confirm file `r_`r''
    if !_rc merge 1:1 roster year using `r_`r'', nogenerate update
}
order roster year key_type main_firm_years main_matched pct_main_matched pct_main_one_firm ///
      roster_keys roster_keys_found pct_keys_found roster_rows pct_rows_found
sort roster year
format pct_* %5.1f
list, clean noobs abbreviate(18)
export delimited using "$PM_OUT/merge_report.csv", replace datafmt

* ---- units check -------------------------------------------------------------------
quietly describe using "$PM_MAIN", varlist
local mvars `r(varlist)'
local vout $PM_MAIN_OUTPUT
local vmat $PM_MAIN_MAT
local hasout : list vout in mvars
local hasmat : list vmat in mvars
local uv ""
if `hasout' local uv `uv' `vout'
if `hasmat' local uv `uv' `vmat'
quietly describe using "$PM_OUT/analysis_ready_with_roster.dta", varlist
local merged `r(varlist)'
local rv ""
foreach v in pm_val_prod bb_val_total {
    local has : list v in merged
    if `has' local rv `rv' `v'
}
use $PM_MAIN_YEAR roster_match roster_n_main `rv' `uv' using "$PM_OUT/analysis_ready_with_roster.dta", clear
rename $PM_MAIN_YEAR year
keep if roster_match == 1 & roster_n_main == 1
foreach v in pm_val_prod bb_val_total {
    capture confirm variable `v'
    if _rc generate double `v' = .
}
generate double ratio_prod_output   = .
generate double ratio_mat_materials = .
if `hasout' replace ratio_prod_output   = pm_val_prod  / `vout' if `vout' > 0 & pm_val_prod > 0
if `hasmat' replace ratio_mat_materials = bb_val_total / `vmat' if `vmat' > 0 & bb_val_total > 0
if _N > 0 {
    collapse (median) ratio_prod_output ratio_mat_materials ///
             (count) n_prod = ratio_prod_output n_mat = ratio_mat_materials, by(year)
    generate str12 flag = ""
    replace flag = "CHECK UNITS" if (ratio_prod_output < 0.1 | (ratio_prod_output > 10 & !missing(ratio_prod_output))) ///
                                  | (ratio_mat_materials < 0.1 | (ratio_mat_materials > 10 & !missing(ratio_mat_materials)))
    format ratio_* %9.3f
    list, clean noobs
    export delimited using "$PM_OUT/units_check.csv", replace datafmt
    quietly count if flag != ""
    if r(N) > 0 display as error "UNITS: `r(N)' year(s) where roster values are far from the ready-to-use file: see units_check.csv"
}
else display as error "Units check: no matched firm-year alone in its key (cell keys too coarse)."

* ---- everything that was changed -----------------------------------------------------
pm_notes_save 06
clear
local nf : dir "$PM_OUT" files "_notes_*.dta"
local first 1
foreach f of local nf {
    if `first' use "$PM_OUT/`f'", clear
    else append using "$PM_OUT/`f'"
    local first 0
}
if _N > 0 {
    order step roster year item n
    sort roster year step item
    export delimited using "$PM_OUT/cleaning_report.csv", replace
    display as result "Cleaning report: " _N " counts -> $PM_OUT/cleaning_report.csv"
}
foreach f of local nf {
    capture erase "$PM_OUT/`f'"
}
