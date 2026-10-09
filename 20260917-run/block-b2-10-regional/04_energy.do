/*==========================================================================
  Line 4: "Energy use"
  Data  : SI 2010-2022 (data/b210_si.dta), clean == 1
  Output sheets:
    t04_energy_java        energy use by Java / outside Java, pool + by year
    t04_energy_prov        by province, pool + by year
    t04_energy_kabkot      by district (only when district codes exist)
      columns: n_firms, gj_s1 (4 fuels: diesel, petrol, coal, LPG),
               gj_s2 (purchased electricity), gj_total, gj_share_pct
               (% of the period's national GJ), gj_per_va (aggregate),
               gj_pw (GJ per worker, aggregate), median GJ per firm,
               mean ln GJ per firm
    t04_energy_dist_java   firm-level GJ and GJ per VA (level and ln),
                           Java vs outside Java

  NOTE: energy = the 4 fuels asked every year + purchased electricity (same
        definition as gj_total in every B1/B2 block). The full energy mix,
        incl. gas and the fuels added in 2020, is line 9.
        Reporting jumps between 2015 and 2017 (questionnaire change).
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
    collapse (sum) n_firms gj_s1 gj_s2 gj_total va workers ///
             (p50) med_gj = gj_total (mean) mean_ln_gj = ln_gj_total, by(`lev' year)
    bysort year: egen double all = total(gj_total)
    generate gj_share_pct = 100 * gj_total / all
    generate gj_per_va    = gj_total / va      if va > 0
    generate gj_pw        = gj_total / workers if workers > 0
    generate period = cond(year == 0, "pool", string(year))
    sort `lev' year
    order `lev' period n_firms gj_s1 gj_s2 gj_total gj_share_pct gj_per_va gj_pw med_gj mean_ln_gj
    drop year all va workers
    if "`lev'" == "java" list if period == "pool", clean noobs
    export excel using "$B210_XLSX", sheet("t04_energy_`lev'", replace) firstrow(variables)
}

* ---- firm-level distribution, Java vs outside Java ----
use "$B210_DATA/b210_si.dta", clear
keep if clean == 1
do "$B210/_sumstats.do" "gj_total ln_gj_total gj_per_va ln_gj_per_va" "java" "t04_energy_dist_java"
