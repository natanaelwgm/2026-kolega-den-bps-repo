/*==========================================================================
  Line 3: "Firms menggunakan energi lebih sedikit"
          (the first term of the decomposition: GJ per unit of VA)
  Data  : SI 2010-2022 (data/b202_si.dta), clean == 1
  Output sheets:
    t03_by_year      all manufacturing, pool + by year: % of firms reporting
                     any energy, total GJ (fuel / electricity), aggregate
                     GJ/VA (total, fuel, electricity), GJ per worker,
                     GJ per output, ln GJ/VA
    t03_by_kbli2     aggregate GJ/VA and median firm GJ/VA per KBLI 2-digit,
                     pool + by year
    t03_firm_stats   firm-level GJ/VA and GJ per worker, level and ln,
                     pool + by year (firms with GJ > 0 and VA > 0)
    t03_by_size      firm-level GJ/VA, level and ln, medium vs large firms

  NOTE: VA and output are NOMINAL; GJ per worker is physical. The share of
  firms reporting energy jumps between 2015 and 2017 (questionnaire change),
  which moves the totals; the firm-level medians are less affected.
==========================================================================*/
if "$B202" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- A. all manufacturing, by year ----
use "$B202_DATA/b202_si.dta", clear
keep if clean == 1
generate n_firms = 1
generate reports_energy = (gj_total > 0 & !missing(gj_total))
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms reports_energy tot_gj = gj_total gj_fuel = gj_s1 gj_elec = gj_s2 ///
         tot_va = va tot_output = output tot_workers = workers, by(year)
generate pct_reporting_energy = 100 * reports_energy / n_firms
generate gj_per_va      = tot_gj / tot_va
generate gj_fuel_per_va = gj_fuel / tot_va
generate gj_elec_per_va = gj_elec / tot_va
generate gj_pw          = tot_gj / tot_workers
generate gj_per_out     = tot_gj / tot_output
generate ln_gj_per_va   = ln(gj_per_va)
generate period = cond(year == 0, "pool", string(year))
order period n_firms pct_reporting_energy tot_gj gj_fuel gj_elec tot_va gj_per_va ///
      gj_fuel_per_va gj_elec_per_va gj_pw gj_per_out ln_gj_per_va
keep  period n_firms pct_reporting_energy tot_gj gj_fuel gj_elec tot_va gj_per_va ///
      gj_fuel_per_va gj_elec_per_va gj_pw gj_per_out ln_gj_per_va
list period pct_reporting_energy gj_per_va gj_pw, clean noobs
export excel using "$B202_XLSX", sheet("t03_by_year", replace) firstrow(variables)

* ---- B. per KBLI 2-digit sector ----
use "$B202_DATA/b202_si.dta", clear
keep if clean == 1 & !missing(kbli2)
generate n_firms = 1
expand 2, generate(copy)
replace year = 0 if copy == 1
collapse (sum) n_firms tot_gj = gj_total tot_va = va (p50) med_firm_gj_per_va = gj_per_va, by(kbli2 year)
generate agg_gj_per_va = tot_gj / tot_va if tot_va > 0
generate period = cond(year == 0, "pool", string(year))
sort kbli2 year
order kbli2 period n_firms tot_gj tot_va agg_gj_per_va med_firm_gj_per_va
drop year
export excel using "$B202_XLSX", sheet("t03_by_kbli2", replace) firstrow(variables)

* ---- C. firm-level distribution ----
use "$B202_DATA/b202_si.dta", clear
keep if clean == 1 & !missing(ln_gj_per_va)
do "$B202/_sumstats.do" "gj_per_va ln_gj_per_va gj_pw ln_gj_pw" "" "t03_firm_stats"
do "$B202/_sumstats.do" "gj_per_va ln_gj_per_va" "large" "t03_by_size"
