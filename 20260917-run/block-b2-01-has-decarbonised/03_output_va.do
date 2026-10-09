/*==========================================================================
  Line 3: "Total output dan VA"
  Data  : SI 2010-2022 (data/b201_si.dta), clean == 1
  Output sheets:
    t03_total      all manufacturing, by year: number of firms, total output,
                   total VA, VA / output, index 2010 = 100, ln of each total
    t03_by_kbli2   the same per KBLI 2-digit sector, plus the sector's % of
                   all manufacturing output and VA in that year

  NOTE: totals are sums over the firms in the survey, so they move with the
  number of firms (coverage jumps between 2015 and 2017). Values are nominal
  and masked: read the direction, not the level. There is no 2016 survey.
==========================================================================*/
if "$B201" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B201_DATA/b201_si.dta", clear
keep if clean == 1
generate n_firms = 1
expand 2, generate(copy)              // copy of every row as sector 0 = all manufacturing
replace kbli2 = 0 if copy == 1
collapse (sum) n_firms output va, by(kbli2 year)

generate va_share_output = va / output
foreach v in output va {
    egen base = total(cond(year == 2010, `v', .)), by(kbli2)
    generate idx_`v' = 100 * `v' / base if base > 0
    generate ln_`v'  = ln(`v') if `v' > 0
    * share of all manufacturing in the same year
    egen all = total(cond(kbli2 == 0, `v', .)), by(year)
    generate pct_of_all_`v' = 100 * `v' / all
    drop base all
}
sort kbli2 year
order kbli2 year n_firms output va va_share_output idx_output idx_va ln_output ln_va

preserve
keep if kbli2 == 0
drop kbli2 pct_of_all_*
list year n_firms output va idx_output idx_va, clean noobs
export excel using "$B201_XLSX", sheet("t03_total", replace) firstrow(variables)
restore
keep if kbli2 > 0
export excel using "$B201_XLSX", sheet("t03_by_kbli2", replace) firstrow(variables)
