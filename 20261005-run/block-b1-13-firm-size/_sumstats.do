/*==========================================================================
  _sumstats.do -- helper: descriptive statistics table, POOLED + BY YEAR
  (same helper as b1-17's _sumstats.do, writing to this block's workbook)

  Usage (data already loaded, must contain variable year):
      do "$B13/_sumstats.do" "$ECON $TFP" "exporter" "t08_econ"

      argument 1 = list of variables
      argument 2 = grouping variable ("" for no grouping)
      argument 3 = sheet name in output/b1_13_tables.xlsx (max 31 characters)
      argument 4 = optional: "poolonly" to skip the by-year rows
                   (for groups with many values, e.g. 5-digit sector)

  Result: 1 row = variable x group x period (pool, 2010, 2011, ...)
          columns n mean sd p10 p25 p50 p75 p90 min max
  Rows with a missing group are not counted. A variable equal to the
  grouping variable is skipped.
  The data in memory are unchanged after this file runs.
==========================================================================*/
args vars grp sheet mode

tempfile result original
save `original'
local first 1
if "`grp'" == "" {
    generate byte all = 1
    label define all 1 "All firms", replace
    label values all all
    local grp all
}
local periods "pool year"
if "`mode'" == "poolonly" local periods "pool"
foreach v of local vars {
    * a variable is not summarised by itself (e.g. exporter rate by exporter)
    if "`v'" == "`grp'" continue
    foreach period of local periods {
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

if `first' == 1 {
    display as error "  -> sheet `sheet' not written: no nonmissing values"
    use `original', clear
    exit
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
export excel using "$B13_XLSX", sheet("`sheet'", replace) firstrow(variables)
display as result "  -> sheet `sheet' (" _N " rows)"
use `original', clear
