/*==========================================================================
  _incidence.do -- helper: yes / no / blank table, BY YEAR + POOLED

  Usage (data already loaded, must contain variable year):
      do "$B208/_incidence.do" "rnd rnd_ext" "t03_rnd_by_year"

      argument 1 = list of variables (0/1 flags, or amounts: "yes" = > 0)
      argument 2 = sheet name in output/b2_08_tables.xlsx (max 31 characters)

  Result: 1 row = variable x period (pool, 2010, 2011, ...)
    n_records     firm-years in that period
    n_answered    firm-years with an answer (yes or no)
    n_blank       not asked or left blank  -- NOT counted as "no"
    pct_answered  n_answered / n_records
    n_yes         answered yes (amounts: > 0)
    pct_yes       n_yes / n_answered       <- the incidence to read
    pct_yes_all   n_yes / n_records        (lower bound: treats blanks as no)
  The pooled row only adds up the years in which the question was asked.
  The data in memory are unchanged after this file runs.
==========================================================================*/
args vars sheet

tempfile result original
save `original'
local first 1
foreach v of local vars {
    local lab : variable label `v'
    preserve
    keep year `v'
    generate n_records  = 1
    generate n_answered = !missing(`v')
    generate n_yes      = (`v' > 0 & !missing(`v'))
    collapse (sum) n_records n_answered n_yes, by(year)
    * pooled row (year = 0): only the years in which the question was asked
    expand 2 if n_answered > 0, generate(copy)
    replace year = 0 if copy == 1
    collapse (sum) n_records n_answered n_yes, by(year)
    generate str20 variable = "`v'"
    generate str80 question = "`lab'"
    if `first' == 0 append using `result'
    save `result', replace
    local first 0
    restore
}

use `result', clear
generate n_blank      = n_records - n_answered
generate pct_answered = 100 * n_answered / n_records
generate pct_yes      = 100 * n_yes / n_answered      if n_answered > 0
generate pct_yes_all  = 100 * n_yes / n_records       if n_answered > 0
generate str6 period  = cond(year == 0, "pool", string(year))
* keep the variables in the order they were listed
generate variable_order = .
local i 0
foreach v of local vars {
    local ++i
    replace variable_order = `i' if variable == "`v'"
}
sort variable_order year
keep  variable question period n_records n_answered n_blank pct_answered n_yes pct_yes pct_yes_all
order variable question period n_records n_answered n_blank pct_answered n_yes pct_yes pct_yes_all
export excel using "$B208_XLSX", sheet("`sheet'", replace) firstrow(variables)
display as result "  -> sheet `sheet' (" _N " rows)"
use `original', clear
