/*==========================================================================
  Line 10: "Capital/workers"
  Data  : data/b209_firm.dta and data/b209_panel.dta, clean == 1
          cap_pw = nominal capital stock / total workers
  Output sheets:
    t10_change   change in capital per worker between the firm's first and
                 last year, by group: level (d_) and ln (dln_)
    t10_levels   capital per worker by group, pool + by year (level & ln)
  NOTE: many records report zero capital (the yearly median is 0 in 2017
        and 2021), so the ln change only covers firms with capital > 0 in
        both years. Nominal and masked. Firm links are fictional (see 02).
==========================================================================*/
if "$B209" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B209_DATA/b209_firm.dta", clear
do "$B209/_changestats.do" "d_cap_pw dln_cap_pw" "t10_change"

use "$B209_DATA/b209_panel.dta", clear
do "$B209/_sumstats.do" "cap_pw ln_cap_pw" "ci_group" "t10_levels"
