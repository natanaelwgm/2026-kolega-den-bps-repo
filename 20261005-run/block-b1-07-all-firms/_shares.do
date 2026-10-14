/*==========================================================================
  _shares.do -- helper: composition table (% of firms per category),
                POOLED + BY YEAR, optionally within a group

  Usage (data already loaded, must contain variable year):
      do "$B07/_shares.do" "kbli2" "exporter" "t08_kbli2_share"

      argument 1 = categorical variable (the categories counted)
      argument 2 = grouping variable ("" for no grouping)
      argument 3 = sheet name in output/b1_07_tables.xlsx (max 31 characters)

  Result: 1 row = group x category x period (pool, 2010, 2011, ...)
          columns n_firms (firm-years) and pct_firms (% of the group in that
          period). Firms with a missing category or group are not counted.
  The data in memory are unchanged after this file runs.
==========================================================================*/
args cat grp sheet

preserve
if "`grp'" == "" {
    generate byte all = 1
    label define all 1 "All firms", replace
    label values all all
    local grp all
}
keep `cat' `grp' year
keep if !missing(`cat') & !missing(`grp')
if "`cat'" == "kbli5" | "`grp'" == "kbli5" {
    * kbli5 is text; empty text counts as missing
    capture confirm string variable kbli5
    if !_rc drop if kbli5 == ""
}
generate n_firms = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms, by(`grp' `cat' year)
bysort `grp' year: egen total = total(n_firms)
generate pct_firms = 100 * n_firms / total
generate str6 period = cond(year == 0, "pool", string(year))
* groups and categories are written as text using their value labels
capture decode `grp', generate(group)
if _rc {
    capture confirm string variable `grp'
    if _rc generate group = string(`grp')
    else   generate group = `grp'
}
capture decode `cat', generate(category)
if _rc {
    capture confirm string variable `cat'
    if _rc generate category = string(`cat')
    else   generate category = `cat'
}
sort `grp' year `cat'
keep group category period n_firms pct_firms
order group category period n_firms pct_firms
export excel using "$B07_XLSX", sheet("`sheet'", replace) firstrow(variables)
display as result "  -> sheet `sheet' (" _N " rows)"
restore
