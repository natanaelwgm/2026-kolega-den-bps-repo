/*==========================================================================
  Line 2: "Elaborate perubahan 2010-2022 untuk:"
  Data  : SI 2010-2022 (data/b201_si.dta), clean == 1
  Output sheets:
    t02_overview   every indicator of lines 3-9 for all manufacturing:
                   value in 2010, 2015, 2017 and 2022, % change 2010-2022,
                   change in ln 2010-2022, and % change within each
                   questionnaire period (2010-2015 and 2017-2022)
    t02_by_kbli2   the same indicators per KBLI 2-digit sector: 2010, 2022,
                   % change and ln change 2010-2022

  Every value is an AGGREGATE: totals are sums over firms, and ratios are
  ratios of sums (e.g. GJ/VA = total GJ / total VA), not means of firm ratios.
  NOTE: sums over firms rise with coverage. The number of firms and the
  energy reporting jump between 2015 and 2017 (questionnaire change), so the
  2010-2022 change mixes real change with that break; the two within-period
  changes do not. VA and output are nominal (and masked): read the direction,
  not the level. There is no 2016 survey.
==========================================================================*/
if "$B201" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* the indicators, in the order of the to-do list
local ind "n_firms output va gj_s1 gj_s2 gj_total co2_s1 co2_s2 co2_total gj_per_va gj_per_out co2_per_va co2_per_out va_per_gj va_per_co2"

* ---- A. all manufacturing ----
use "$B201_DATA/b201_si.dta", clear
keep if clean == 1
generate n_firms = 1
collapse (sum) n_firms output va gj_s1 gj_s2 gj_total co2_s1 co2_s2 co2_total, by(year)
generate gj_per_va   = gj_total / va
generate gj_per_out  = gj_total / output
generate co2_per_va  = co2_total / va
generate co2_per_out = co2_total / output
generate va_per_gj   = va / gj_total
generate va_per_co2  = va / co2_total

keep if inlist(year, 2010, 2015, 2017, 2022)
* one row per indicator, one column per year
local i 0
foreach v of local ind {
    local ++i
    rename `v' v`i'
}
reshape long v, i(year) j(order)
reshape wide v, i(order) j(year)
generate str24 indicator = ""
local i 0
foreach v of local ind {
    local ++i
    replace indicator = "`v'" if order == `i'
}
rename (v2010 v2015 v2017 v2022) (y2010 y2015 y2017 y2022)
generate pct_2010_2022 = 100 * (y2022 / y2010 - 1)
generate ln_change_2010_2022 = ln(y2022) - ln(y2010)
generate pct_2010_2015 = 100 * (y2015 / y2010 - 1)
generate pct_2017_2022 = 100 * (y2022 / y2017 - 1)
sort order
order indicator y2010 y2015 y2017 y2022 pct_2010_2022 ln_change_2010_2022 pct_2010_2015 pct_2017_2022
drop order
list indicator y2010 y2022 pct_2010_2022 pct_2017_2022, clean noobs
export excel using "$B201_XLSX", sheet("t02_overview", replace) firstrow(variables)

* ---- B. per sector (KBLI 2-digit) ----
use "$B201_DATA/b201_si.dta", clear
keep if clean == 1 & inlist(year, 2010, 2022)
generate n_firms = 1
collapse (sum) n_firms output va gj_s1 gj_s2 gj_total co2_s1 co2_s2 co2_total, by(kbli2 year)
generate gj_per_va   = gj_total / va
generate gj_per_out  = gj_total / output
generate co2_per_va  = co2_total / va
generate co2_per_out = co2_total / output
generate va_per_gj   = va / gj_total
generate va_per_co2  = va / co2_total
local i 0
foreach v of local ind {
    local ++i
    rename `v' v`i'
}
reshape long v, i(kbli2 year) j(order)
reshape wide v, i(kbli2 order) j(year)
generate str24 indicator = ""
local i 0
foreach v of local ind {
    local ++i
    replace indicator = "`v'" if order == `i'
}
rename (v2010 v2022) (y2010 y2022)
generate pct_2010_2022 = 100 * (y2022 / y2010 - 1)
generate ln_change_2010_2022 = ln(y2022) - ln(y2010)
sort kbli2 order
order kbli2 indicator y2010 y2022 pct_2010_2022 ln_change_2010_2022
drop order
export excel using "$B201_XLSX", sheet("t02_by_kbli2", replace) firstrow(variables)
