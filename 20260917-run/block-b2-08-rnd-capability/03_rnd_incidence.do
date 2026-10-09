/*==========================================================================
  Line 3: "Incidence R&D"
  Data  : SI 2011, 2017-2022 (data/b208_si.dta), clean == 1
  Output sheets:
    t03_rnd_by_year    % firms doing R&D and % with external R&D funding,
                       among firms that answered; with the number left blank.
                       Pool + by year (pool = 2011 + 2017-2022)
    t03_rnd_workers    R&D workers, R&D firms vs others, 2017-2022,
                       pool + by year

  NOTE: the R&D question is in the 2011 and 2017-2022 forms only. About 45%
  of firms leave it blank in 2017-2022; those are not counted as "no".
  pct_yes_all (yes / all firms) is the lower bound if every blank were a no.
  2011 is a different questionnaire; compare it with 2017+ with care.
==========================================================================*/
if "$B208" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B208_DATA/b208_si.dta", clear
keep if clean == 1
do "$B208/_incidence.do" "rnd rnd_ext" "t03_rnd_by_year"

* ---- R&D workers, by R&D answer ----
use "$B208_DATA/b208_si.dta", clear
keep if clean == 1 & year >= 2017 & !missing(rnd)
do "$B208/_sumstats.do" "rnd_workers" "rnd" "t03_rnd_workers"
