/*==========================================================================
  Line 10: "Compare productivity tfp, energy productivity dan carbon productivity"
  Data  : data/b207_groups.dta, clean == 1, classified firms only (groups 1-7)
  Measures:
    TFP                  tfp_op tfp_lp tfp_acf tfp_wrdg (already log residuals)
    energy productivity  va_per_gj   = VA / GJ          (+ ln)
    carbon productivity  va_per_co2  = VA / tonne CO2   (+ ln)
  Output sheets (n mean sd p10-p90 min max, by group, pool + by year):
    t10_tfp           the four TFP measures
    t10_energy_prod   va_per_gj, ln_va_per_gj
    t10_carbon_prod   va_per_co2, ln_va_per_co2
    t10_medians       compact table: n firms and the median of each measure,
                      by group, pool + by year

  NOTE: TFP = nominal development residuals; tfp_op has far fewer observations
        than the other three, and none in 2010. Compare groups within one TFP
        method, not levels across methods. VA is nominal (and masked in the
        development data), so compare groups within a year or the pool, not
        levels across years. Energy/carbon productivity only for firms with
        GJ > 0 / CO2 > 0. 2020 and 2022 cannot be classified (see 02-08).
==========================================================================*/
if "$B207" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B207_DATA/b207_groups.dta", clear
keep if clean == 1 & group7 != 99

do "$B207/_sumstats.do" "tfp_op tfp_lp tfp_acf tfp_wrdg" "group7" "t10_tfp"
do "$B207/_sumstats.do" "va_per_gj ln_va_per_gj" "group7" "t10_energy_prod"
do "$B207/_sumstats.do" "va_per_co2 ln_va_per_co2" "group7" "t10_carbon_prod"

* ---- t10_medians: one compact comparison table ------------------------
generate n_firms = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms (p50) med_tfp_op = tfp_op med_tfp_lp = tfp_lp ///
         med_tfp_acf = tfp_acf med_tfp_wrdg = tfp_wrdg ///
         med_va_per_gj = va_per_gj med_va_per_co2 = va_per_co2, by(group7 year)
generate period = cond(year == 0, "pool", string(year))
sort year group7
order group7 period n_firms
drop year
list if period == "pool", clean noobs
export excel using "$B207_XLSX", sheet("t10_medians", replace) firstrow(variables)
