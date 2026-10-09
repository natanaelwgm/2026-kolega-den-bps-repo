/*==========================================================================
  Line 7: "Male/female"
  Data  : NOT IN BLOCK 0. This file is written against the expected column
          names workers_male and workers_female (persons). If they are
          missing it prints what is missing and writes no table.
  Output sheets (only when the columns exist):
    t07_change   change in male and female workers and in the female share
                 of workers between the firm's first and last year, by group
    t07_levels   male, female workers and female share, by group,
                 pool + by year (level & ln)
  NOTE: 01a carries these columns and 02 builds their change only if they
        exist in analysis_ready_data.dta.
==========================================================================*/
if "$B209" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B209_DATA/b209_panel.dta", clear
local missing ""
foreach v in workers_male workers_female {
    capture confirm variable `v'
    if _rc local missing "`missing' `v'"
}
if "`missing'" != "" {
    display as error "Line 7 (male/female) not answered: not in the data:`missing'"
    display as error "No table written. Needs a male/female worker count from BPS."
    exit
}

* ---- levels, pool + by year ----
generate female_share = 100 * workers_female / (workers_male + workers_female) ///
    if workers_male + workers_female > 0
generate ln_workers_male   = ln(workers_male)   if workers_male > 0
generate ln_workers_female = ln(workers_female) if workers_female > 0
do "$B209/_sumstats.do" "workers_male ln_workers_male workers_female ln_workers_female female_share" "ci_group" "t07_levels"

* ---- change between the firm's first and last year ----
use "$B209_DATA/b209_firm.dta", clear
generate d_female_share = 100 * workers_female_l / (workers_male_l + workers_female_l) ///
                        - 100 * workers_female_f / (workers_male_f + workers_female_f)
do "$B209/_changestats.do" "d_workers_male dln_workers_male d_workers_female dln_workers_female d_female_share" "t07_change"
