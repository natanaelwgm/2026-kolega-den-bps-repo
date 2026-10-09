/*==========================================================================
  Line 4: "Employment"
  Data  : data/b209_firm.dta (change per firm) and data/b209_panel.dta
          (firm-years of the classified firms), clean == 1
  Output sheets:
    t04_change   change in total workers between the firm's first and last
                 year, by group: level (d_) and ln (dln_, x100 ~ % change)
    t04_levels   total workers by group, pool + by year (level & ln)
  NOTE: firm links are fictional in the development data (see 02).
==========================================================================*/
if "$B209" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B209_DATA/b209_firm.dta", clear
do "$B209/_changestats.do" "d_workers dln_workers" "t04_change"

use "$B209_DATA/b209_panel.dta", clear
do "$B209/_sumstats.do" "workers ln_workers" "ci_group" "t04_levels"
