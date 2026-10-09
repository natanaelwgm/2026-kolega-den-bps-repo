/*==========================================================================
  Line 2: "Cek data before after covid… compared stats."
  Data  : SI 2017-2022 (data/b20_si.dta), clean == 1
  Periods: Pre 2017-19 | Covid 2020 | Recovery 2021-22
  Output sheets:
    t02_by_period   per period and per year: n firms, % FDI, % importer,
                    % exporter, % large, % Java, % own generation, and the
                    median of workers, VA, output, capital, VA per worker,
                    energy and CO2 per VA
    t02_stats       n mean sd p10-p90 min max by period (+ each year),
                    level and ln
                    (group = COVID period; column period "pool" = the whole COVID period)
  NOTE: these are all firms in each year (cross-sections), no firm links.
        All money values are nominal (and masked in the development data):
        read direction, not levels. FDI is missing in 2020 and the export
        flag in 2022 (see 01a).
==========================================================================*/
if "$B20" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- A. shares and medians, by period and by year ----
use "$B20_DATA/b20_si.dta", clear
keep if clean == 1 & !missing(period)
generate n_firms = 1
* one copy per period ("pool" of the period) and one per single year
expand 2, generate(copy)
generate str16 when = string(year)
replace when = "period" if copy == 1
collapse (sum) n_firms (mean) pct_fdi = fdi pct_importer = importer pct_exporter = exporter ///
         pct_large = large pct_java = java pct_owngen = has_owngen ///
         (p50) med_workers = workers med_va = va med_output = output med_capital = capital ///
         med_va_pw = va_pw med_gj_per_va = gj_per_va med_co2_per_va = co2_per_va, by(period when)
foreach v in pct_fdi pct_importer pct_exporter pct_large pct_java pct_owngen {
    replace `v' = 100 * `v'
}
* period rows first, then its years
generate sortkey = cond(when == "period", 0, real(when))
sort period sortkey
drop sortkey
rename when year
list period year n_firms pct_fdi pct_exporter med_workers med_va, clean noobs
export excel using "$B20_XLSX", sheet("t02_by_period", replace) firstrow(variables)

* ---- B. full distribution, level and ln ----
use "$B20_DATA/b20_si.dta", clear
keep if clean == 1 & !missing(period)
rename period covid_period          // _sumstats writes its own "period" column
do "$B20/_sumstats.do" "workers va output capital va_pw cap_pw gj_per_va co2_per_va ln_workers ln_va ln_output ln_capital ln_va_pw" "covid_period" "t02_stats"
