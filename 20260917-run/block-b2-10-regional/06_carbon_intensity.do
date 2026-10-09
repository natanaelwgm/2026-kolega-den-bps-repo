/*==========================================================================
  Line 6: "Carbon intensity"
  Data  : SI 2010-2022 (data/b210_si.dta), clean == 1
  Output sheets:
    t06_intensity_java        Java / outside Java, pool + by year
    t06_intensity_prov        by province, pool + by year
    t06_intensity_kabkot      by district (only when district codes exist)
      columns: n_firms,
               co2_per_va   = total CO2 / total VA of the region (aggregate)
               co2_per_out  = total CO2 / total output
               co2_per_gj   = total CO2 / total GJ  (how dirty each GJ is)
               gj_per_va    = total GJ / total VA   (how much energy per VA)
               (co2_per_va = gj_per_va x co2_per_gj)
               median firm CO2/VA, mean firm ln CO2/VA
    t06_intensity_dist_java   firm-level CO2/VA (level and ln), Java vs outside

  NOTE: VA and output are nominal: compare regions within a year. CO2 per GJ
        is physical and can be compared across years.
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
    collapse (sum) n_firms co2_total gj_total va output ///
             (p50) med_co2_per_va = co2_per_va (mean) mean_ln_co2_per_va = ln_co2_per_va, ///
             by(`lev' year)
    generate co2_per_va  = co2_total / va       if va > 0
    generate co2_per_out = co2_total / output   if output > 0
    generate co2_per_gj  = co2_total / gj_total if gj_total > 0
    generate gj_per_va   = gj_total / va        if va > 0
    generate period = cond(year == 0, "pool", string(year))
    sort `lev' year
    order `lev' period n_firms co2_per_va co2_per_out co2_per_gj gj_per_va ///
          med_co2_per_va mean_ln_co2_per_va
    drop year co2_total gj_total va output
    if "`lev'" == "java" list if period == "pool", clean noobs
    export excel using "$B210_XLSX", sheet("t06_intensity_`lev'", replace) firstrow(variables)
}

* ---- firm-level distribution, Java vs outside Java ----
use "$B210_DATA/b210_si.dta", clear
keep if clean == 1
do "$B210/_sumstats.do" "co2_per_va ln_co2_per_va co2_per_gj" "java" "t06_intensity_dist_java"
