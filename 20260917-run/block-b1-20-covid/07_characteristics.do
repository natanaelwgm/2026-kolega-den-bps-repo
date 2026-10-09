/*==========================================================================
  Line 7: "Cek karakteristiknya: fdi, import, export, medium vs large,
           Lokasi, all firms characteristics"
  Data  : data/b20_si.dta (clean == 1) + data/b20_flows.dta (from 04-06)
  Groups (definitions in 04-06), measured in the firm's own year Y:
    New        not in the previous survey year (incl. returning)
    Survivor   also in the previous survey year
    Exit       never seen again after Y (measured in its last year)
    All firms  everyone in Y (for comparison)
  A firm in Y is New or Survivor, and can also be an Exit, so the groups
  overlap: compare each group with "All firms", do not add them up.
  Output sheets:
    t07_profile    by group (firm_group) x period (pool + by year): n firms, % FDI,
                   % importer, % exporter, % large, % Java, % own generation,
                   median workers, VA per worker, TFP (LP), energy per VA
    t07_province   share of each group's firms by province, pool + by year
    t07_stats      n mean sd p10-p90 min max of the firm characteristics
                   (level and ln) by group, pool + by year
  Years: New/Survivor 2011-2022, Exit 2010-2021 (window edges, see 04-06).
  FIRM LINKS ARE FICTIONAL IN THE DEVELOPMENT DATA: the group labels only
  mean something on the real BPS data. FDI is missing in 2020 and the
  export flag in 2022 (see 01a). Values are nominal.
==========================================================================*/
if "$B20" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- build the stacked group data (1 row = firm x year x group) ----
use "$B20_DATA/b20_si.dta", clear
keep if clean == 1
merge 1:1 firm_id year using "$B20_DATA/b20_flows.dta", nogenerate keep(match)
tempfile base stack
save `base'

generate firm_group = 1 if inlist(status, 1, 2)
replace  firm_group = 2 if status == 3
keep if !missing(firm_group)
save `stack'

use `base', clear
keep if exit_status == 1
generate firm_group = 3
append using `stack'
save `stack', replace

use `base', clear
generate firm_group = 4
append using `stack'
label define firm_group 1 "New" 2 "Survivor" 3 "Exit" 4 "All firms"
label values firm_group firm_group
save `stack', replace

* ---- A. profile ----
generate n_firms = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms (mean) pct_fdi = fdi pct_importer = importer pct_exporter = exporter ///
         pct_large = large pct_java = java pct_owngen = has_owngen ///
         (p50) med_workers = workers med_va_pw = va_pw med_tfp_lp = tfp_lp ///
         med_gj_per_va = gj_per_va, by(firm_group year)
foreach v in pct_fdi pct_importer pct_exporter pct_large pct_java pct_owngen {
    replace `v' = 100 * `v'
}
generate period = cond(year == 0, "pool", string(year))
sort firm_group year
order firm_group period n_firms
drop year
list if period == "pool", clean noobs
export excel using "$B20_XLSX", sheet("t07_profile", replace) firstrow(variables)

* ---- B. location: province mix of each group ----
use `stack', clear
keep if !missing(prov)
generate n_firms = 1
expand 2, generate(copy)
replace year = 0 if copy == 1
collapse (sum) n_firms, by(firm_group year prov)
bysort firm_group year: egen group_total = total(n_firms)
generate pct_of_group = 100 * n_firms / group_total
drop group_total
generate period = cond(year == 0, "pool", string(year))
sort firm_group year prov
order firm_group period prov n_firms pct_of_group
drop year
export excel using "$B20_XLSX", sheet("t07_province", replace) firstrow(variables)

* ---- C. all firm characteristics: full distribution ----
use `stack', clear
do "$B20/_sumstats.do" "workers va output capital va_pw cap_pw tfp_op tfp_lp tfp_acf tfp_wrdg gj_per_va co2_per_va owngen_share ln_workers ln_va ln_output ln_capital ln_va_pw" "firm_group" "t07_stats"
