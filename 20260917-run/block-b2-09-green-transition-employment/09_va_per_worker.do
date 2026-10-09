/*==========================================================================
  Line 9: "VA/workers"
  Data  : data/b209_firm.dta and data/b209_panel.dta, clean == 1
          va_pw = nominal value added / total workers
  Output sheets:
    t09_change   change in VA per worker between the firm's first and last
                 year, by group: level (d_) and ln (dln_, x100 ~ % change)
    t09_levels   VA per worker by group, pool + by year (level & ln)
  NOTE: nominal (no deflator) and masked in the development data: read the
        differences between groups, not the levels. Firm links are
        fictional in the development data (see 02).
        CO2/VA defines the groups and VA is also in VA/worker, so a VA
        rise by itself pushes a firm towards "Rapidly falling".
==========================================================================*/
if "$B209" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B209_DATA/b209_firm.dta", clear
do "$B209/_changestats.do" "d_va_pw dln_va_pw" "t09_change"

use "$B209_DATA/b209_panel.dta", clear
do "$B209/_sumstats.do" "va_pw ln_va_pw" "ci_group" "t09_levels"
