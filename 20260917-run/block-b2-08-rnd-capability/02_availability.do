/*==========================================================================
  Line 2: "Untuk tahun Ketika tersedia:"
  Data  : SI 2010-2022 (data/b208_si.dta), clean == 1
  Which capability question is asked in which year, and how many firms answer.
  Output sheets:
    t02_availability  every capability variable x year: records, answered,
                      blank, % answered, % yes among answered (pool = asked years)
    t02_matrix        % answered, 1 row per variable, 1 column per year
                      (0 = question not in that year's form)

  NOTE: a blank is "not asked or not answered", never "no". Even in the years
  a question is asked, 25-55% of firms leave it blank (R&D: about 45%).
  rnd_cost and rnd_workers are amounts: block 0 writes 0 when nothing is
  reported, so for them "answered" = present and "yes" = a positive amount.
==========================================================================*/
if "$B208" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B208_DATA/b208_si.dta", clear
keep if clean == 1

local ALL "rnd rnd_ext rnd_cost rnd_workers innov innov_product innov_process innov_marketing innov_org amdal ukl_upl sppl env_doc waste_treat waste_solid waste_liquid waste_haz waste_any"
do "$B208/_incidence.do" "`ALL'" "t02_availability"

* ---- matrix: % answered by year ----
import excel using "$B208_XLSX", sheet("t02_availability") firstrow clear
drop if period == "pool"
keep variable period pct_answered
generate variable_order = _n          // keeps the order of the list above
bysort variable (variable_order): replace variable_order = variable_order[1]
replace pct_answered = round(pct_answered, 0.1)
reshape wide pct_answered, i(variable variable_order) j(period) string
rename pct_answered* y*
sort variable_order
drop variable_order
list, clean noobs
export excel using "$B208_XLSX", sheet("t02_matrix", replace) firstrow(variables)
