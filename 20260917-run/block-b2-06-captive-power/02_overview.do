/*==========================================================================
  Line 2: "Elaborate berapa % firms punya:"
  Data  : SI 2010-2022 (data/b206_si.dta), clean == 1
  Output sheets:
    t02_overview   by year + pool: % of firms with each item of lines 3-7
      pct_owngen      line 3/5: reports own-generated electricity (kWh > 0)
      pct_genset      line 4:   reports generator capacity > 0     (empty: not in block 0)
      pct_mostly_own  line 6:   own generation is >= 50% of its electricity
      med_share_gen   line 6:   median own share, own-generators only
      pct_genfuel     line 7:   reports fuel used in a generator   (empty: not in block 0)
      pct_nonpln      context:  buys electricity from a non-PLN supplier
  Denominator: firms that were ASKED about own generation (n_asked). In 2014
  and 2015 about 1,060 firms per year were not asked; they are left out, not
  counted as "no". n_firms is every clean record.
==========================================================================*/
if "$B206" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B206_DATA/b206_si.dta", clear
keep if clean == 1

* line 4 and 7 items exist only when block 0 carries the generator variables
generate has_genset = .
capture confirm variable genset_kw
if !_rc replace has_genset = (genset_kw > 0) if !missing(genset_kw)
else display as text "  genset_kw not in block 0 -> pct_genset left empty"

generate has_genfuel = .
capture confirm variable gen_diesel_ltr
if !_rc {
    egen genfuel_any = rowtotal(gen_*), missing
    replace has_genfuel = (genfuel_any > 0) if !missing(genfuel_any)
}
else display as text "  generator fuel not in block 0 -> pct_genfuel left empty"

* firms with no own generation (share 0 or no electricity at all) count as 0
generate mostly_own = (owngen_share >= 0.5 & !missing(owngen_share)) if !missing(has_owngen)
generate share_gen  = owngen_share if has_owngen == 1
generate n_firms = 1
generate asked   = !missing(has_owngen)

expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms n_asked = asked n_owngen = has_owngen ///
         (mean) pct_owngen = has_owngen pct_genset = has_genset ///
                pct_mostly_own = mostly_own pct_genfuel = has_genfuel pct_nonpln = has_nonpln ///
         (p50) med_share_gen = share_gen, by(year)
foreach v in pct_owngen pct_genset pct_mostly_own pct_genfuel pct_nonpln {
    replace `v' = 100 * `v'
}
generate period = cond(year == 0, "pool", string(year))
order period n_firms n_asked n_owngen pct_owngen pct_genset pct_mostly_own med_share_gen pct_genfuel pct_nonpln
drop year
list, clean noobs
export excel using "$B206_XLSX", sheet("t02_overview", replace) firstrow(variables)
