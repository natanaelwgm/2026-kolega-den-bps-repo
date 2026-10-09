/*==========================================================================
  Line 6: "AMDAL/environmental management"
  Data  : SI 2020-2022 (data/b208_si.dta), clean == 1
  Output sheets:
    t06_env_by_year   % firms holding AMDAL, UKL/UPL, SPPL, and any of the
                      three (env_doc), among firms that answered;
                      pool (2020-2022) + by year
    t06_env_combo     which combination of the three documents firms hold,
                      firms that answered all three, pool + by year

  NOTE: the environmental documents are in the 2020-2022 forms only, and
  about 45% of firms leave them blank. AMDAL alone understates environmental
  management: UKL/UPL and SPPL are the documents for smaller-impact plants.
  The waste-treatment installation question (also 2020-2022) is in file 07.
==========================================================================*/
if "$B208" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B208_DATA/b208_si.dta", clear
keep if clean == 1
do "$B208/_incidence.do" "amdal ukl_upl sppl env_doc" "t06_env_by_year"

* ---- combinations of documents ----
use "$B208_DATA/b208_si.dta", clear
keep if clean == 1 & !missing(amdal) & !missing(ukl_upl) & !missing(sppl)
generate str40 combo = ""
replace combo = combo + "AMDAL "   if amdal == 1
replace combo = combo + "UKL/UPL " if ukl_upl == 1
replace combo = combo + "SPPL"     if sppl == 1
replace combo = strtrim(combo)
replace combo = "No document" if combo == ""
generate n_firms = 1
expand 2, generate(copy)
replace year = 0 if copy == 1
collapse (sum) n_firms, by(year combo)
bysort year: egen total = total(n_firms)
generate pct_firms = 100 * n_firms / total
generate period = cond(year == 0, "pool", string(year))
gsort year -n_firms
order period combo n_firms pct_firms
drop year total
list if period == "pool", clean noobs
export excel using "$B208_XLSX", sheet("t06_env_combo", replace) firstrow(variables)
