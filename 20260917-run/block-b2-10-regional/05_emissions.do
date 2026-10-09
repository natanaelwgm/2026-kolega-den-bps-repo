/*==========================================================================
  Line 5: "Emissions"
  Data  : SI 2010-2022 (data/b210_si.dta), clean == 1
  Output sheets:
    t05_co2_java        CO2 by Java / outside Java, pool + by year
    t05_co2_prov        by province, pool + by year
    t05_co2_kabkot      by district (only when district codes exist)
      columns: n_firms, co2_s1 (4 fuels), co2_s2 (purchased electricity,
               block 0 grid factor), co2_total (tonnes), co2_share_pct
               (% of the period's national CO2), co2_pw (aggregate),
               median CO2 per firm, mean ln CO2 per firm
    t05_co2_dist_java   firm-level CO2 (level and ln), Java vs outside Java

  NOTE: scope 2 uses one national grid factor, so a regional difference in
        scope 2 is a difference in how much electricity is bought, not in how
        it is generated.
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
    collapse (sum) n_firms co2_s1 co2_s2 co2_total workers ///
             (p50) med_co2 = co2_total (mean) mean_ln_co2 = ln_co2_total, by(`lev' year)
    bysort year: egen double all = total(co2_total)
    generate co2_share_pct = 100 * co2_total / all
    generate co2_pw        = co2_total / workers if workers > 0
    generate period = cond(year == 0, "pool", string(year))
    sort `lev' year
    order `lev' period n_firms co2_s1 co2_s2 co2_total co2_share_pct co2_pw med_co2 mean_ln_co2
    drop year all workers
    if "`lev'" == "java" list if period == "pool", clean noobs
    export excel using "$B210_XLSX", sheet("t05_co2_`lev'", replace) firstrow(variables)
}

* ---- firm-level distribution, Java vs outside Java ----
use "$B210_DATA/b210_si.dta", clear
keep if clean == 1
do "$B210/_sumstats.do" "co2_total ln_co2_total" "java" "t05_co2_dist_java"
