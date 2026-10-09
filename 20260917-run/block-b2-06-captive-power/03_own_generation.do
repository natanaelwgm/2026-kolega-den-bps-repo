/*==========================================================================
  Line 3: "own generation"
  Data  : SI 2010-2022 (data/b206_si.dta), clean == 1
  Output sheets:
    t03_by_year   by year + pool: firms asked, own-generators, % own-generators,
                  % buying non-PLN power (the other way around PLN)
  Own generation = own-generated electricity > 0 (elec_owngen_kwh).
  Block 0 has no "owns a generator" variable.
  Denominator: firms ASKED (n_asked). 2014-2015: ~1,060 firms per year were
  not asked and are left out; pct_owngen_allfirms shows what happens if they
  are wrongly counted as "no".
  NOTE: the rate jumps between 2015 and 2017 (questionnaire change, like the
  importer and energy reporting rates) and falls after 2019.
==========================================================================*/
if "$B206" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B206_DATA/b206_si.dta", clear
keep if clean == 1
generate n_firms   = 1
generate asked     = !missing(has_owngen)
generate none      = (has_owngen == 0)
generate owngen_all = (has_owngen == 1)      // not asked counted as 0, for comparison only

expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms n_asked = asked n_owngen = has_owngen n_none = none ///
         (mean) pct_owngen = has_owngen pct_owngen_allfirms = owngen_all pct_nonpln = has_nonpln, by(year)
foreach v in pct_owngen pct_owngen_allfirms pct_nonpln {
    replace `v' = 100 * `v'
}
generate period = cond(year == 0, "pool", string(year))
order period n_firms n_asked n_owngen n_none pct_owngen pct_owngen_allfirms pct_nonpln
drop year
list, clean noobs
export excel using "$B206_XLSX", sheet("t03_by_year", replace) firstrow(variables)
