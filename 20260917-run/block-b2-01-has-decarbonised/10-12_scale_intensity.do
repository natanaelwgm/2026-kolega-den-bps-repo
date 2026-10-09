/*==========================================================================
  Line 10: "Pisahkan perubahan emisi menjadi:"
  Line 11: "Scale effect: manufacturing menjadi lebih besar"
  Line 12: "Intensity effect: produksi menjadi lebih clean"
  (one file: lines 11 and 12 are the two halves of one decomposition)
  Data  : SI 2010-2022 (data/b201_si.dta), clean == 1
  Output sheets:
    t10_12_total     all manufacturing: change in emissions split into the
                     scale and the intensity effect, for every step between
                     two survey years and for the windows 2010-2022,
                     2010-2015 and 2017-2022
    t10_12_by_kbli2  the same per KBLI 2-digit sector, for the three windows

  Method: CO2 = VA x (CO2/VA), so in logs
      change in ln CO2 = change in ln VA      (scale effect)
                       + change in ln CO2/VA  (intensity effect)
  and the two parts add up exactly. A negative intensity effect = production
  became cleaner per unit of VA. pct_change_co2 = the same change in %.
  CO2 = scope 1 (4 fuels) + scope 2, aggregated over firms (see line 5).
  NOTE: VA is NOMINAL, so the scale effect includes price inflation and the
  intensity effect is pushed down by it: a negative intensity effect is not
  by itself proof of cleaner production. Sums over firms move with coverage,
  which jumps between 2015 and 2017; 2015-2017 is a two-year step (no 2016
  survey). The windows 2010-2015 and 2017-2022 stay inside one
  questionnaire period.
==========================================================================*/
if "$B201" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B201_DATA/b201_si.dta", clear
keep if clean == 1
expand 2, generate(copy)              // copy of every row as sector 0 = all manufacturing
replace kbli2 = 0 if copy == 1
collapse (sum) co2_total va, by(kbli2 year)
generate ln_co2 = ln(co2_total) if co2_total > 0
generate ln_va  = ln(va)        if va > 0

* pair every year with every later year (within the same sector)
tempfile from
preserve
rename (year co2_total va ln_co2 ln_va) (year_from co2_from va_from ln_co2_from ln_va_from)
save `from'
restore
rename (year co2_total va ln_co2 ln_va) (year_to co2_to va_to ln_co2_to ln_va_to)
joinby kbli2 using `from'

* keep consecutive survey years and the three windows
generate str12 step = ""
replace step = "wave to wave" if year_to - year_from == 1
replace step = "2015 to 2017" if year_from == 2015 & year_to == 2017
replace step = "window"       if (year_from == 2010 & year_to == 2022) | ///
                                 (year_from == 2010 & year_to == 2015) | ///
                                 (year_from == 2017 & year_to == 2022)
keep if step != ""

generate d_ln_co2         = ln_co2_to - ln_co2_from
generate scale_effect     = ln_va_to - ln_va_from
generate intensity_effect = d_ln_co2 - scale_effect     // = change in ln(CO2/VA)
generate pct_change_co2   = 100 * (co2_to / co2_from - 1)
generate pct_change_va    = 100 * (va_to / va_from - 1)
generate pct_change_co2_per_va = 100 * ((co2_to / va_to) / (co2_from / va_from) - 1)
generate period = string(year_from) + "-" + string(year_to)

* windows first, then the steps in time order
generate sort1 = (step != "window")
sort kbli2 sort1 year_from year_to
order kbli2 step period year_from year_to co2_from co2_to va_from va_to ///
      d_ln_co2 scale_effect intensity_effect pct_change_co2 pct_change_va pct_change_co2_per_va
keep  kbli2 step period year_from year_to co2_from co2_to va_from va_to ///
      d_ln_co2 scale_effect intensity_effect pct_change_co2 pct_change_va pct_change_co2_per_va

preserve
keep if kbli2 == 0
drop kbli2
list period d_ln_co2 scale_effect intensity_effect, clean noobs
export excel using "$B201_XLSX", sheet("t10_12_total", replace) firstrow(variables)
restore
keep if kbli2 > 0 & step == "window"
export excel using "$B201_XLSX", sheet("t10_12_by_kbli2", replace) firstrow(variables)
