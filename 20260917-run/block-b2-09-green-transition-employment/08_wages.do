/*==========================================================================
  Line 8: "Wages"
  Data  : NOT IN BLOCK 0. This file is written against the expected column
          names wage_total, wage_prod, wage_nonprod (nominal wage bill). If
          wage_total is missing it prints what is missing and writes no table.
          (deflator_wages in block 0 is a price index, not a wage.)
  Output sheets (only when the columns exist):
    t08_change   change in the wage bill and the wage per worker between the
                 firm's first and last year, by group (level & ln)
    t08_levels   wage bill and wage per worker by group, pool + by year
  NOTE: 01a carries these columns and 02 builds their change only if they
        exist in analysis_ready_data.dta. wage_prod / wage_nonprod are used
        when present.
==========================================================================*/
if "$B209" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B209_DATA/b209_panel.dta", clear
local missing ""
foreach v in wage_total wage_prod wage_nonprod {
    capture confirm variable `v'
    if _rc local missing "`missing' `v'"
}
capture confirm variable wage_total
if _rc {
    display as error "Line 8 (wages) not answered: not in the data:`missing'"
    display as error "No table written. Needs a wage bill (total, and ideally production / non-production) from BPS."
    exit
}

* ---- levels, pool + by year ----
local V "wage_total"
foreach v in wage_prod wage_nonprod {
    capture confirm variable `v'
    if !_rc local V "`V' `v'"
}
generate wage_pw = wage_total / workers if workers > 0
local L ""
foreach v in `V' wage_pw {
    generate ln_`v' = ln(`v') if `v' > 0
    local L "`L' `v' ln_`v'"
}
do "$B209/_sumstats.do" "`L'" "ci_group" "t08_levels"

* ---- change between the firm's first and last year ----
use "$B209_DATA/b209_firm.dta", clear
generate wage_pw_f = wage_total_f / workers_f if workers_f > 0
generate wage_pw_l = wage_total_l / workers_l if workers_l > 0
generate d_wage_pw   = wage_pw_l - wage_pw_f
generate dln_wage_pw = ln(wage_pw_l) - ln(wage_pw_f) if wage_pw_l > 0 & wage_pw_f > 0
local C ""
foreach v in `V' wage_pw {
    local C "`C' d_`v' dln_`v'"
}
do "$B209/_changestats.do" "`C'" "t08_change"
