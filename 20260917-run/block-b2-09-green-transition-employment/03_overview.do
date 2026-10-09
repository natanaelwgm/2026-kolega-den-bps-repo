/*==========================================================================
  Line 3: "Lihat perubahan:"
  This line is the heading for lines 4-10, which each have their own file.
  This file gives the one-table overview: how every outcome changed between
  a firm's first and last year, in each carbon-intensity group.

  Data  : data/b209_firm.dta (1 row = 1 firm classified in 02)
  Output sheet:
    t03_overview   1 row = outcome x group:
                   n firms, median in the first and the last year,
                   median level change, median and mean ln change
                   (x100 = roughly % change), % of firms where it rose
  NOTE: nonprod_share is a % of workers, so its change is in % points
        and has no ln change. Production / non-production workers are
        missing for ~40-47% of firms in 2020 and 2021 (block 0), so their
        n is smaller. Male/female and wages appear only if the data have them.
        Firm links are fictional in the development data (see 02).
==========================================================================*/
if "$B209" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B209_DATA/b209_firm.dta", clear

local outcomes "workers prod_workers nonprod_workers nonprod_share va_pw cap_pw"
foreach v in workers_male workers_female wage_total wage_prod wage_nonprod {
    capture confirm variable d_`v'
    if !_rc local outcomes "`outcomes' `v'"
}

tempfile result
local first 1
foreach v of local outcomes {
    use "$B209_DATA/b209_firm.dta", clear
    keep if !missing(d_`v')
    capture confirm variable dln_`v'
    if _rc generate dln_`v' = .
    generate rose = 100 * (d_`v' > 0)
    generate n_firms = 1
    collapse (sum) n_firms (p50) med_first = `v'_f med_last = `v'_l med_change = d_`v' ///
             med_dln = dln_`v' (mean) mean_dln = dln_`v' pct_rose = rose, by(ci_group)
    generate str20 outcome = "`v'"
    if `first' == 0 append using `result'
    save `result', replace
    local first 0
}

use `result', clear
generate order = .
local i 0
foreach v of local outcomes {
    local ++i
    replace order = `i' if outcome == "`v'"
}
sort order ci_group
decode ci_group, generate(group)
order outcome group n_firms med_first med_last med_change med_dln mean_dln pct_rose
drop order ci_group
list, clean noobs
export excel using "$B209_XLSX", sheet("t03_overview", replace) firstrow(variables)
