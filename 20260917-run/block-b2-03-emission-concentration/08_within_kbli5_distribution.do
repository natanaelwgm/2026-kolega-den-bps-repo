/*==========================================================================
  Line 8: "Within KBLI 5 digit, hitung distribusi dari carbon intensity dan
           energy intensity (P10, P25, median, P75, P90, P95)"
  Data  : SI 2010-2022 (data/b203_si.dta), clean == 1
  Measures:
    co2_per_va   carbon intensity = CO2 (t) / value added      (main)
    gj_per_va    energy intensity = GJ / value added           (main)
    co2_per_out  CO2 (t) / gross output   (output never < 0, so no plant
    gj_per_out   GJ / gross output         drops out for negative VA)
  Output sheets:
    t08_kbli5_pool     1 row = KBLI5 x measure, pooled 2010-2022:
                       n, P10 P25 P50 P75 P90 P95, P90/P10
    t08_kbli5_year     the same by year
    t08_spread_summary across KBLI5 sectors with n >= 20 (pooled): median
                       and quartiles of the within-sector P90/P10
    t08_all_firms      all plants together (no KBLI5 split), pool + by year

  NOTE: plants that report zero energy have intensity 0 and are included;
  P90/P10 is missing when P10 = 0. A KBLI5 cell with few plants (column
  few_obs = 1 when n < 20) gives unreliable percentiles. Value added and
  output are nominal and masked: compare plants within a sector and year,
  not levels across years.
==========================================================================*/
if "$B203" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- A. percentiles per KBLI5, pool + by year ----
tempfile stack
local i 0
foreach m in co2_per_va gj_per_va co2_per_out gj_per_out {
    local ++i
    use "$B203_DATA/b203_si.dta", clear
    keep if clean == 1 & !missing(`m') & kbli5 != ""
    expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
    replace year = 0 if copy == 1
    collapse (count) n = `m' (p10) p10 = `m' (p25) p25 = `m' (p50) p50 = `m' ///
             (p75) p75 = `m' (p90) p90 = `m' (p95) p95 = `m', by(kbli5 year)
    generate m_order = `i'
    generate measure = "`m'"
    if `i' > 1 append using `stack'
    save `stack', replace
}
generate p90_p10 = p90 / p10 if p10 > 0
generate few_obs = (n < 20)
generate period  = cond(year == 0, "pool", string(year))
sort m_order kbli5 year
order kbli5 measure period n p10 p25 p50 p75 p90 p95 p90_p10 few_obs
save "$B203_DATA/b203_kbli5_pct.dta", replace

preserve
keep if period == "pool"
keep kbli5 measure period n p10 p25 p50 p75 p90 p95 p90_p10 few_obs
export excel using "$B203_XLSX", sheet("t08_kbli5_pool", replace) firstrow(variables)
restore
keep if period != "pool"
keep kbli5 measure period n p10 p25 p50 p75 p90 p95 p90_p10 few_obs
export excel using "$B203_XLSX", sheet("t08_kbli5_year", replace) firstrow(variables)

* ---- B. how wide is the within-sector spread? (pooled, n >= 20) ----
use "$B203_DATA/b203_kbli5_pct.dta", clear
keep if period == "pool" & few_obs == 0
generate n_sectors = 1
collapse (sum) n_sectors (count) n_with_ratio = p90_p10 ///
         (p25) ratio_p25 = p90_p10 (p50) ratio_median = p90_p10 (p75) ratio_p75 = p90_p10, ///
         by(m_order measure)
sort m_order
drop m_order
label variable ratio_median "Median across KBLI5 sectors of the within-sector P90/P10"
list, clean noobs
export excel using "$B203_XLSX", sheet("t08_spread_summary", replace) firstrow(variables)

* ---- C. the national distribution, for reference ----
use "$B203_DATA/b203_si.dta", clear
keep if clean == 1
do "$B203/_sumstats.do" "co2_per_va gj_per_va co2_per_out gj_per_out" "" "t08_all_firms"
