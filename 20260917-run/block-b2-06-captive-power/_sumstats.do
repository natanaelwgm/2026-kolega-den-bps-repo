/*==========================================================================
  _sumstats.do -- helper: descriptive statistics table, POOLED + BY YEAR

  Usage (data already loaded, must contain variable year):
      do "$B206/_sumstats.do" "own_kwh ln_own_kwh" "fdi" "t05_kwh_by_fdi"

      argument 1 = list of variables
      argument 2 = grouping variable ("" for no grouping)
      argument 3 = sheet name in output/b2_06_tables.xlsx (max 31 characters)

  Result: 1 row = variable x group x period (pool, 2010, 2011, ...)
          columns n mean sd p10 p25 p50 p75 p90 min max
  Rows with a missing group are not counted.
  The data in memory are unchanged after this file runs.
==========================================================================*/
args vars grp sheet

tempfile result original
save `original'
local first 1
if "`grp'" == "" {
    generate byte all = 1
    local grp all
}
foreach v of local vars {
    foreach period in pool year {
        preserve
        keep `v' `grp' year
        keep if !missing(`v') & !missing(`grp')
        if _N > 0 {
            if "`period'" == "pool" replace year = 0
            collapse (count) n = `v' (mean) mean = `v' (sd) sd = `v' ///
                     (p10) p10 = `v' (p25) p25 = `v' (p50) p50 = `v' ///
                     (p75) p75 = `v' (p90) p90 = `v' (min) min = `v' (max) max = `v', ///
                     by(`grp' year)
            generate str32 variable = "`v'"
            if `first' == 0 append using `result'
            save `result', replace
            local first 0
        }
        restore
    }
}

use `result', clear
generate str6 period = cond(year == 0, "pool", string(year))
* the group is written as text using its value label (if it has one)
capture decode `grp', generate(group)
if _rc generate group = string(`grp')
* keep the variables in the order they were listed
generate variable_order = .
local i 0
foreach v of local vars {
    local ++i
    replace variable_order = `i' if variable == "`v'"
}
sort variable_order `grp' year
keep variable group period n mean sd p10 p25 p50 p75 p90 min max
export excel using "$B206_XLSX", sheet("`sheet'", replace) firstrow(variables)
display as result "  -> sheet `sheet' (" _N " rows)"
use `original', clear
