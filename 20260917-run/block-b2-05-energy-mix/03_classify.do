/*==========================================================================
  Line 3: "Classify firm menjadi coal-intensive, oil intensive, gas intensive,
           electricity intensive, mixed."
  Data  : data/b205_mix.dta (from 02), firms with energy > 0
  Output: data/b205_class.dta  -- 1 row = 1 firm x year, with its class
  Output sheets:
    t03_class_by_year   number and % of firms per class, pool + by year
    t03_class_profile   per class (pooled): mean share of each source, and
                        % large, FDI, exporter, importer, Java, own generation

  RULE (decided 9 Oct): a firm is X-intensive if source X supplies >= 50% of
  its GJ (the six sources of line 2), otherwise "mixed".
    electricity = PLN + non-PLN electricity bought
    biofuel     = biodiesel. Not in the to-do list, so it gets its own class
                  ("Biofuel-intensive") instead of hiding in "mixed".
  Self generation and biomass are not in the GJ (see 02), so they cannot
  decide a class. A firm that makes its own power from diesel shows up as
  oil-intensive, which is what it is.
  Change the 50 in "local cut 50" below to try another threshold.
  NOTE: the 2020 form adds diesel oil, fuel oil and natural gas, so part of
  the change in classes in 2020 is the form, not the firms.
==========================================================================*/
if "$B205" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
local cut 50

use "$B205_DATA/b205_mix.dta", clear
keep if has_energy == 1

generate class = 6
replace  class = 1 if sh_coal >= `cut'
replace  class = 2 if sh_oil  >= `cut'
replace  class = 3 if sh_gas  >= `cut'
replace  class = 4 if sh_elec >= `cut'
replace  class = 5 if sh_bio  >= `cut'
label define class 1 "Coal-intensive" 2 "Oil-intensive" 3 "Gas-intensive" ///
                   4 "Electricity-intensive" 5 "Biofuel-intensive" 6 "Mixed"
label values class class
label variable class "Main energy source (>= `cut'% of GJ), else mixed"
* high-carbon = coal- or oil-intensive (used by the transition matrix, line 4)
generate high_carbon = inlist(class, 1, 2)
label define high_carbon 0 "Not high-carbon" 1 "High-carbon (coal/oil)"
label values high_carbon high_carbon

* two sources at exactly 50/50 would both qualify; the later line wins
count if (sh_coal >= `cut') + (sh_oil >= `cut') + (sh_gas >= `cut') + (sh_elec >= `cut') + (sh_bio >= `cut') > 1
display as result "Firm-years with two sources at exactly 50%: " r(N)
tabulate year class, row nofreq
save "$B205_DATA/b205_class.dta", replace

* ---- A. firms per class, pool + by year ----------------------------------
generate n_firms = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms, by(class year)
bysort year: egen total = total(n_firms)
generate pct_firms = 100 * n_firms / total
generate period = cond(year == 0, "pool", string(year))
sort year class
order period class n_firms pct_firms
drop year total
list if period == "pool", clean noobs
export excel using "$B205_XLSX", sheet("t03_class_by_year", replace) firstrow(variables)

* ---- B. what each class looks like (pooled) ------------------------------
use "$B205_DATA/b205_class.dta", clear
generate n_firms = 1
collapse (sum) n_firms (mean) sh_coal sh_oil sh_gas sh_pln sh_nonpln sh_bio ///
         pct_large = large pct_fdi = fdi pct_exporter = exporter pct_importer = importer ///
         pct_java = java pct_owngen = owngen (p50) med_workers = workers, by(class)
foreach v in pct_large pct_fdi pct_exporter pct_importer pct_java pct_owngen {
    replace `v' = 100 * `v'
}
list class n_firms sh_coal sh_oil sh_gas sh_pln, clean noobs
export excel using "$B205_XLSX", sheet("t03_class_profile", replace) firstrow(variables)
