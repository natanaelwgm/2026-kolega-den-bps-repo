/*==========================================================================
  Line 5: "Innovation"
  Data  : SI (data/b208_si.dta), clean == 1
  Output sheets:
    t05_innov_by_year   % firms with any innovation, and with product /
                        process / marketing / organisational innovation,
                        among firms that answered; pool + by year
    t05_innov_types     among innovating firms (2017-2018): % with each type

  NOTE: "any innovation" is asked in 2011, 2017, 2018 and 2020-2022 (not 2019);
  the four types only in 2017-2018. About 45% of firms leave it blank.
  2017-2018 show ~50% innovating against ~20% in 2020-2022: the question
  changed with the form (2017-18 lists the four types), so read the
  levels within each form, not as a trend.
==========================================================================*/
if "$B208" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B208_DATA/b208_si.dta", clear
keep if clean == 1
do "$B208/_incidence.do" "innov innov_product innov_process innov_marketing innov_org" "t05_innov_by_year"

* ---- which types do innovators report? ----
use "$B208_DATA/b208_si.dta", clear
keep if clean == 1 & innov == 1 & inlist(year, 2017, 2018)
generate n_innovators = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_innovators (mean) pct_product = innov_product pct_process = innov_process ///
         pct_marketing = innov_marketing pct_org = innov_org, by(year)
foreach v in pct_product pct_process pct_marketing pct_org {
    replace `v' = 100 * `v'
}
generate period = cond(year == 0, "pool", string(year))
order period
drop year
list, clean noobs
export excel using "$B208_XLSX", sheet("t05_innov_types", replace) firstrow(variables)
