/*==========================================================================
  Line 6: "Non production workers"
  Data  : data/b209_firm.dta and data/b209_panel.dta, clean == 1
          non-production workers = total workers - production workers
          (block 0 has no column of its own; built in 01a)
  Output sheets:
    t06_change   change between the firm's first and last year, by group:
                 non-production workers (level d_, ln dln_) and
                 non-production share of workers (change in % points)
    t06_levels   non-production workers and share, by group,
                 pool + by year (level & ln)
  NOTE: same 2020/2021 gap as line 5 (production workers missing for
        ~40-47% of firms). Firm links are fictional in the development data.
==========================================================================*/
if "$B209" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B209_DATA/b209_firm.dta", clear
do "$B209/_changestats.do" "d_nonprod_workers dln_nonprod_workers d_nonprod_share" "t06_change"

use "$B209_DATA/b209_panel.dta", clear
do "$B209/_sumstats.do" "nonprod_workers ln_nonprod_workers nonprod_share" "ci_group" "t06_levels"
