/*==========================================================================
  Line 2: "Compare firms dengan rapidly falling vs rising carbon intensity"
  Data  : SI 2010-2022 (data/b209_si.dta), clean == 1
  Method: carbon intensity = CO2 (scope 1 + 2, t) / nominal value added.
          For every firm, take the first and the last year in which its
          carbon intensity can be computed (CO2 > 0 and VA > 0), and the
          change ln(CO2/VA)_last - ln(CO2/VA)_first.
          A firm needs at least 2 such years. Firms are then split into
          terciles of that change:
            1 Rapidly falling   bottom third (largest fall)
            2 Stable            middle third
            3 Rapidly rising    top third
  Output data:
    data/b209_firm.dta   1 row = 1 firm: group, first/last year, and every
                         outcome in the first (_f) and last (_l) year, with
                         its change d_* (level) and dln_* (ln)
    data/b209_panel.dta  1 row = 1 firm x year (all clean years of the
                         classified firms), with the firm's group
  Output sheets:
    t02_coverage     how many firms can be classified
    t02_groups       per group: n firms, change in ln CO2/VA, years covered
    t02_ci_by_year   CO2/VA by group, pool + by year (level & ln)

  NOTE: firm_id links across years are FICTIONAL in the development data,
  so a "firm's change" here is a change between two unrelated records.
  The code is right for the real BPS data; the numbers only mean something
  there. Values are nominal, and energy reporting changes between 2015 and
  2017, so changes that span 2016 partly reflect the questionnaire.
==========================================================================*/
if "$B209" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B209_DATA/b209_si.dta", clear
keep if clean == 1

* ---- coverage ----------------------------------------------------------
generate has_ci = !missing(ln_co2_per_va)
bysort firm_id: egen n_years_ci = total(has_ci)
by firm_id: generate first_row = (_n == 1)
preserve
keep if first_row == 1
generate firms_all     = 1
generate firms_ci_1plus = (n_years_ci >= 1)
generate firms_ci_2plus = (n_years_ci >= 2)
collapse (sum) firms_all firms_ci_1plus firms_ci_2plus
generate pct_classified = 100 * firms_ci_2plus / firms_all
list, clean noobs
export excel using "$B209_XLSX", sheet("t02_coverage", replace) firstrow(variables)
restore

* ---- first and last year with a carbon intensity, per firm -------------
keep if has_ci == 1 & n_years_ci >= 2
sort firm_id year
by firm_id: keep if _n == 1 | _n == _N
by firm_id: generate pos = cond(_n == 1, "_f", "_l")

* outcomes (gender / wage columns join only if the data have them)
local outcomes "workers prod_workers nonprod_workers nonprod_share va_pw cap_pw"
foreach v in workers_male workers_female wage_total wage_prod wage_nonprod {
    capture confirm variable `v'
    if !_rc local outcomes "`outcomes' `v'"
}
keep firm_id pos year kbli2 co2_per_va ln_co2_per_va `outcomes'
reshape wide year kbli2 co2_per_va ln_co2_per_va `outcomes', i(firm_id) j(pos) string

* ---- change in carbon intensity and the 3 groups -----------------------
generate ci_change = ln_co2_per_va_l - ln_co2_per_va_f
generate years_apart = year_l - year_f
xtile ci_group = ci_change, nq(3)
label define ci_group 1 "Rapidly falling" 2 "Stable" 3 "Rapidly rising"
label values ci_group ci_group
label variable ci_change "Change in ln(CO2/VA), last minus first year"
label variable ci_group "Carbon-intensity trend (tercile of ci_change)"

* ---- change in every outcome between the same two years ----------------
foreach v of local outcomes {
    generate d_`v' = `v'_l - `v'_f
    generate dln_`v' = ln(`v'_l) - ln(`v'_f) if `v'_l > 0 & `v'_f > 0
}
drop dln_nonprod_share                 // a share: use the change in % points

compress
save "$B209_DATA/b209_firm.dta", replace
display as result "Firms classified: " _N

* ---- t02_groups --------------------------------------------------------
preserve
generate n_firms = 1
collapse (sum) n_firms (min) min_change = ci_change (max) max_change = ci_change ///
         (mean) mean_change = ci_change (p50) med_change = ci_change ///
         med_years_apart = years_apart med_first_year = year_f med_last_year = year_l ///
         med_ci_first = co2_per_va_f med_ci_last = co2_per_va_l, by(ci_group)
list, clean noobs
export excel using "$B209_XLSX", sheet("t02_groups", replace) firstrow(variables)
restore

* ---- panel: all clean years of the classified firms, with their group ---
keep firm_id ci_group ci_change
tempfile groups
save `groups'
use "$B209_DATA/b209_si.dta", clear
keep if clean == 1
merge m:1 firm_id using `groups', keep(match) nogenerate
compress
save "$B209_DATA/b209_panel.dta", replace
display as result "Panel of classified firms: " _N " firm-years"

* ---- carbon intensity by group, pool + by year --------------------------
do "$B209/_sumstats.do" "co2_per_va ln_co2_per_va" "ci_group" "t02_ci_by_year"
