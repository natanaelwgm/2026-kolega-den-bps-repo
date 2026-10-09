/*==========================================================================
  Line 4: "R&D expenditure/VA"
  Data  : SI 2017-2022 (data/b208_si.dta), clean == 1, VA > 0
  Output sheets:
    t04_coverage        by year: firms, % with a positive R&D expense,
                        % R&D (flag, among answered), aggregate ratio
                        = total R&D expense / total VA
    t04_ratio_spenders  R&D expense / VA (level and ln) among firms with a
                        positive R&D expense: n mean sd p10-p90, pool + by year
    t04_cost_vs_flag    R&D answer (yes / no / blank) x positive expense,
                        by year: do the two questions agree?

  NOTE:
  - Denominator: only firms with VA > 0. The ratio is shown for spenders only;
    with every firm included the median is 0.
  - Block 0 writes 0 when no expense is reported, so 0 = "none or blank".
  - 2018 and 2019 report a positive expense for ~47% of firms against 3-5%
    in the other years, and many of them answer "no R&D". This looks like a
    change in what the field records, not in behaviour: compare those two
    years with care (see t04_cost_vs_flag).
  - Both amounts are nominal and masked, and block 0 calls the expense unit
    a "Rp000 candidate": read the comparison across groups/years, not the level.
==========================================================================*/
if "$B208" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- coverage and aggregate ratio by year ----
use "$B208_DATA/b208_si.dta", clear
keep if clean == 1 & !missing(rnd_cost) & va > 0
generate n_firms = 1
generate cost_for_sum = rnd_cost
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms n_cost_pos = rnd_cost_pos sum_cost = cost_for_sum sum_va = va ///
         (mean) pct_cost_pos = rnd_cost_pos pct_rnd_flag = rnd (count) n_rnd_answered = rnd, by(year)
replace pct_cost_pos = 100 * pct_cost_pos
replace pct_rnd_flag = 100 * pct_rnd_flag
generate agg_ratio = sum_cost / sum_va
generate period = cond(year == 0, "pool", string(year))
order period n_firms n_cost_pos pct_cost_pos n_rnd_answered pct_rnd_flag agg_ratio sum_cost sum_va
drop year
list period n_firms pct_cost_pos pct_rnd_flag agg_ratio, clean noobs
export excel using "$B208_XLSX", sheet("t04_coverage", replace) firstrow(variables)

* ---- distribution of the ratio among spenders ----
use "$B208_DATA/b208_si.dta", clear
keep if clean == 1 & rnd_cost_pos == 1 & va > 0
do "$B208/_sumstats.do" "rnd_va ln_rnd_va" "" "t04_ratio_spenders"

* ---- does the expense agree with the R&D answer? ----
use "$B208_DATA/b208_si.dta", clear
keep if clean == 1 & !missing(rnd_cost)
generate rnd_answer = rnd
replace  rnd_answer = 2 if missing(rnd)
label define rnd_answer 0 "No R&D" 1 "R&D" 2 "Blank"
label values rnd_answer rnd_answer
generate n_firms = 1
expand 2, generate(copy)
replace year = 0 if copy == 1
collapse (sum) n_firms n_cost_pos = rnd_cost_pos, by(rnd_answer year)
generate pct_cost_pos = 100 * n_cost_pos / n_firms
generate period = cond(year == 0, "pool", string(year))
sort year rnd_answer
order period rnd_answer n_firms n_cost_pos pct_cost_pos
drop year
export excel using "$B208_XLSX", sheet("t04_cost_vs_flag", replace) firstrow(variables)
