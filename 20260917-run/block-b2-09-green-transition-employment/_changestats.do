/*==========================================================================
  _changestats.do -- helper: statistics of a firm-level CHANGE, by group

  Usage (data/b209_firm.dta loaded: 1 row = 1 firm):
      do "$B209/_changestats.do" "d_workers dln_workers" "t04_change"

      argument 1 = list of change variables (d_* level, dln_* ln)
      argument 2 = sheet name in output/b2_09_tables.xlsx (max 31 characters)

  Result: 1 row = variable x group (Rapidly falling / Stable / Rapidly rising)
          columns n mean sd p10 p25 p50 p75 p90 pct_rose
          pct_rose = % of firms whose value went up (change > 0)
  There is no "by year" here: the change runs from each firm's first to its
  last year (see 02). The yearly view is in the *_levels sheets.
  The data in memory are unchanged after this file runs.
==========================================================================*/
args vars sheet

tempfile result original
save `original'
local first 1
foreach v of local vars {
    preserve
    keep `v' ci_group
    keep if !missing(`v') & !missing(ci_group)
    generate rose = 100 * (`v' > 0)
    collapse (count) n = `v' (mean) mean = `v' (sd) sd = `v' ///
             (p10) p10 = `v' (p25) p25 = `v' (p50) p50 = `v' ///
             (p75) p75 = `v' (p90) p90 = `v' (mean) pct_rose = rose, by(ci_group)
    generate str32 variable = "`v'"
    if `first' == 0 append using `result'
    save `result', replace
    local first 0
    restore
}

use `result', clear
decode ci_group, generate(group)
generate variable_order = .
local i 0
foreach v of local vars {
    local ++i
    replace variable_order = `i' if variable == "`v'"
}
sort variable_order ci_group
drop ci_group
keep variable group n mean sd p10 p25 p50 p75 p90 pct_rose
order variable group n mean sd p10 p25 p50 p75 p90 pct_rose
export excel using "$B209_XLSX", sheet("`sheet'", replace) firstrow(variables)
display as result "  -> sheet `sheet' (" _N " rows)"
use `original', clear
