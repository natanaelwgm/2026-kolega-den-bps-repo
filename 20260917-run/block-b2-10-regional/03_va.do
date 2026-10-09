/*==========================================================================
  Line 3: "Industrial VA"
  Data  : SI 2010-2022 (data/b210_si.dta), clean == 1
  Output sheets:
    t03_va_java        VA by Java / outside Java, pool + by year
    t03_va_prov        VA by province, pool + by year
    t03_va_kabkot      VA by district (only when district codes exist)
      columns: n_firms, va_total, va_share_pct (% of the period's national VA),
               workers, va_pw_agg (= total VA / total workers),
               median VA per firm, mean ln VA per firm
    t03_va_dist_java   firm-level VA and VA per worker (level and ln),
                       Java vs outside Java: n mean sd p10-p90 min max

  NOTE: VA is nominal and masked. Shares within a year are comparable over
        time; levels are not.
==========================================================================*/
if "$B210" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

use "$B210_DATA/b210_si.dta", clear
local levels "java prov"
count if kabkot != ""
if r(N) > 0 local levels "java prov kabkot"
else display as error "No district (kabkot) codes in this data: kabkot table skipped."

foreach lev of local levels {
    use "$B210_DATA/b210_si.dta", clear
    keep if clean == 1 & !missing(`lev')
    generate n_firms = 1
    expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
    replace year = 0 if copy == 1
    collapse (sum) n_firms va_total = va workers ///
             (p50) med_va = va (mean) mean_ln_va = ln_va, by(`lev' year)
    bysort year: egen double all = total(va_total)
    generate va_share_pct = 100 * va_total / all
    generate va_pw_agg    = va_total / workers if workers > 0
    generate period = cond(year == 0, "pool", string(year))
    sort `lev' year
    order `lev' period n_firms va_total va_share_pct workers va_pw_agg med_va mean_ln_va
    drop year all
    if "`lev'" == "java" list if period == "pool", clean noobs
    export excel using "$B210_XLSX", sheet("t03_va_`lev'", replace) firstrow(variables)
}

* ---- firm-level distribution, Java vs outside Java ----
use "$B210_DATA/b210_si.dta", clear
keep if clean == 1
do "$B210/_sumstats.do" "va ln_va va_pw ln_va_pw" "java" "t03_va_dist_java"
