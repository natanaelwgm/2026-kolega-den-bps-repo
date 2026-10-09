/*==========================================================================
  Lines 2-5 (one calculation, its components are lines 3-5):
    2 "Accounting decomposition perubahan carbon intensity dan energy
       intensity menjadi:"
    3 "Within firm improvement"
    4 "Reallocation toward cleaner firms"
    5 "Entry/exit"
  Methods named in line 1: FHK (2001) and Melitz-Polanec (2015), both done by
  the helper _decompose.do (formulas in its header).

  Data  : SI 2010-2022 (data/b204_si.dta), clean == 1, VA > 0
  Indicators: carbon intensity = total CO2 / total VA
              energy intensity = total GJ / total VA
              (firms weighted by their share of VA, so the aggregate is the
              ratio of totals)
  Periods: 2010-2015 and 2017-2022 (each side of the 2016 questionnaire
           change) and 2010-2022 (whole window)

  Output sheets:
    t02_05_fhk        FHK: within, between, cross, entry, exit, their sum, the
                      total change and the difference (must be ~0)
    t02_05_mp         Melitz-Polanec: survivors' mean, survivors' covariance,
                      entry, exit, sum, total change, difference
    t02_05_summary    both methods mapped to the to-do's three parts, in
                      levels, as % of the total change and as % of the
                      start-year intensity
    t02_05_firm_int   firm-level CO2/VA and GJ/VA, descriptive stats, pool + yearly
  Dataset: data/b204_decomp_total.dta

  NOTE: FIRM LINKS (firm_id across years) ARE FICTIONAL in the development
        data. Who is a continuer, entrant or exiter, and therefore every
        component, only means something on the real BPS data. Only the total
        change does not depend on the links.
  NOTE: VA is nominal (and masked in the dev data), so the intensities mix
        price change with real change. Read signs and shares, not levels.
==========================================================================*/
if "$B204" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- run the decomposition: 2 indicators x 3 periods -------------------
capture erase "$B204_DATA/b204_decomp_rows.dta"
foreach ind in co2_va gj_va {
    do "$B204/_decompose.do" `ind' 2010 2015
    do "$B204/_decompose.do" `ind' 2017 2022
    do "$B204/_decompose.do" `ind' 2010 2022
}
use "$B204_DATA/b204_decomp_rows.dta", clear
save "$B204_DATA/b204_decomp_total.dta", replace

* ---- FHK table ------------------------------------------------------------
keep indicator period n_continuers n_entrants n_exiters I_t0 I_t1 change fhk_*
order indicator period n_continuers n_entrants n_exiters I_t0 I_t1 change ///
      fhk_within fhk_between fhk_cross fhk_entry fhk_exit fhk_sum fhk_diff
list indicator period change fhk_sum fhk_diff, clean noobs
export excel using "$B204_XLSX", sheet("t02_05_fhk", replace) firstrow(variables)

* ---- Melitz-Polanec table ---------------------------------------------------
use "$B204_DATA/b204_decomp_total.dta", clear
keep indicator period n_continuers n_entrants n_exiters I_t0 I_t1 change mp_* share_va_*
order indicator period n_continuers n_entrants n_exiters I_t0 I_t1 change ///
      mp_mean mp_cov mp_entry mp_exit mp_sum mp_diff share_va_entrants_t1 share_va_exiters_t0
list indicator period change mp_sum mp_diff, clean noobs
export excel using "$B204_XLSX", sheet("t02_05_mp", replace) firstrow(variables)

* ---- summary: the to-do's three parts, both methods -------------------
*   Within firm improvement     FHK within          MP survivors' mean
*   Reallocation (cleaner firms) FHK between + cross MP survivors' covariance
*   Entry/exit                  FHK entry + exit    MP entry + exit
use "$B204_DATA/b204_decomp_total.dta", clear
generate double fhk_1 = fhk_within
generate double fhk_2 = fhk_between + fhk_cross
generate double fhk_3 = fhk_entry + fhk_exit
generate double mp_1  = mp_mean
generate double mp_2  = mp_cov
generate double mp_3  = mp_entry + mp_exit
keep indicator period I_t0 change fhk_1 fhk_2 fhk_3 mp_1 mp_2 mp_3
reshape long fhk_ mp_, i(indicator period) j(part)
rename (fhk_ mp_) (value_fhk value_mp)
reshape long value_, i(indicator period part) j(method) string
rename value_ value
replace method = cond(method == "fhk", "FHK (2001)", "Melitz-Polanec (2015)")
label define part 1 "Within firm improvement" 2 "Reallocation toward cleaner firms" 3 "Entry/exit"
label values part part
generate double pct_of_change = 100 * value / change
generate double pct_of_start  = 100 * value / I_t0
sort indicator period method part
order indicator period method part value pct_of_change pct_of_start change I_t0
list indicator method part pct_of_start if period == "2010-2022", clean noobs
export excel using "$B204_XLSX", sheet("t02_05_summary", replace) firstrow(variables)

* ---- the firm-level intensities behind the aggregate ------------------
use "$B204_DATA/b204_si.dta", clear
keep if clean == 1 & va > 0
do "$B204/_sumstats.do" "co2_per_va gj_per_va ln_co2_per_va ln_gj_per_va" "" "t02_05_firm_int"
