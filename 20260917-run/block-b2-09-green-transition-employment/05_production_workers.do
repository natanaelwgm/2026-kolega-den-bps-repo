/*==========================================================================
  Line 5: "Production workers"
  Data  : data/b209_firm.dta and data/b209_panel.dta, clean == 1
          block 0 column production_workers (prod_workers in 01a)
  Output sheets:
    t05_change   change in production workers between the firm's first and
                 last year, by group: level (d_) and ln (dln_)
    t05_levels   production workers by group, pool + by year (level & ln)
  NOTE: production workers are missing for 1,240 firms in 2020 and 1,441 in
        2021 (about 40-47% of those years). A firm whose first or last year is
        2020/2021 and lacks the split drops out of t05_change.
        1 record with more production than total workers is set missing (01a).
        Firm links are fictional in the development data (see 02).
==========================================================================*/
if "$B209" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B209_DATA/b209_firm.dta", clear
do "$B209/_changestats.do" "d_prod_workers dln_prod_workers" "t05_change"

use "$B209_DATA/b209_panel.dta", clear
do "$B209/_sumstats.do" "prod_workers ln_prod_workers" "ci_group" "t05_levels"
