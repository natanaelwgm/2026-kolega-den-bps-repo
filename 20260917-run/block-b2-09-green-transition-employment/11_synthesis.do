/*==========================================================================
  Line 11: "Question: apakah decarbonisasi berasosiasi dengan employment
            constraction ayau justru productivity/job expansion"
  No new computation: collects the ln changes from lines 4, 9 and 10 into
  one sheet, so the question can be read in one place.
  Output sheet:
    t11_synthesis   1 row = outcome (workers, VA/worker, capital/worker):
                    median and mean ln change (x100 ~ % change) and % of
                    firms where it rose, for Rapidly falling / Stable / Rapidly rising,
                    and the gap falling - rising
  How to read: a positive gap = the outcome grew more (or fell less) among
  firms whose carbon intensity fell fastest. Employment contraction would
  show as a negative gap for workers; productivity / job expansion as a
  positive gap for VA per worker / workers.
  The gap and the reading use the median. Workers are whole numbers, so the
  median change is often 0; check the mean and pct_rose columns too.
  NOTE: VA is in both CO2/VA (the grouping) and VA/worker, so a VA rise by
        itself moves a firm towards "Rapidly falling": the VA/worker gap is
        partly mechanical. Workers and capital/worker are not in CO2/VA.
        An association between groups, not a causal effect. Firm links are
        fictional in the development data, values nominal (see 02).
==========================================================================*/
if "$B209" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
tempfile stack
local first 1
foreach s in t04_change t09_change t10_change {
    import excel using "$B209_XLSX", sheet("`s'") firstrow clear
    keep if substr(variable, 1, 4) == "dln_"
    keep variable group n p50 mean pct_rose
    if `first' == 0 append using `stack'
    save `stack', replace
    local first 0
}

* one row per outcome, the 3 groups side by side
generate g = "falling" if group == "Rapidly falling"
replace  g = "stable"  if group == "Stable"
replace  g = "rising"  if group == "Rapidly rising"
drop group
rename p50 med_dln_
rename mean mean_dln_
rename pct_rose pct_rose_
rename n n_
reshape wide med_dln_ mean_dln_ pct_rose_ n_, i(variable) j(g) string

generate outcome = substr(variable, 5, .)
generate gap_falling_minus_rising = med_dln_falling - med_dln_rising
generate str60 reading = "grew more / fell less among rapidly falling" if gap_falling_minus_rising > 0
replace  reading = "grew less / fell more among rapidly falling" if gap_falling_minus_rising < 0
generate order = 1 if outcome == "workers"
replace  order = 2 if outcome == "va_pw"
replace  order = 3 if outcome == "cap_pw"
sort order
order outcome med_dln_falling med_dln_stable med_dln_rising gap_falling_minus_rising reading ///
      mean_dln_falling mean_dln_stable mean_dln_rising ///
      pct_rose_falling pct_rose_stable pct_rose_rising n_falling n_stable n_rising
drop variable order
list outcome med_dln_falling med_dln_stable med_dln_rising gap_falling_minus_rising, clean noobs
export excel using "$B209_XLSX", sheet("t11_synthesis", replace) firstrow(variables)
