/*==========================================================================
  05  Merge the roster firm-years into the ready-to-use SI file
  Input : $PM_MAIN (read only), output/roster_firm_year.dta, output/key_by_year.dta
  Output: output/analysis_ready_with_roster.dta
          = every row and column of the ready-to-use file, in the same order,
            plus the pm_* and bb_* roster columns and:
            roster_key       the key used (K: Kipb, D: prov_kab_kbli5, C: prov_kbli5)
            roster_key_type  kipb / cell_kab / cell (the key of that year)
            roster_match     1 = firm-year has roster data; 0 = a roster year
                             without a roster row; missing = year with no roster
            roster_n_main    firm-years of the ready-to-use file sharing the key
                             in that year (1 = one firm; >1 = shared cell value)

  The key parts of the ready-to-use file are cleaned with the same rules as
  the rosters (pm_mainkeys / pm_code). In a Kipb year Kipb must identify one
  firm: if not, the run stops and lists the duplicates in
  output/main_kipb_duplicates.csv.
==========================================================================*/
if "$PM" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
capture erase "$PM_OUT/analysis_ready_with_roster.dta"
capture erase "$PM_OUT/main_kipb_duplicates.csv"
foreach f in roster_firm_year key_by_year {
    capture confirm file "$PM_OUT/`f'.dta"
    if _rc {
        display as error "output/`f'.dta not found: run 04 first."
        exit 601
    }
}

* ---- the key of each roster year ------------------------------------------------
use year key_type proman_rows bahanbaku_rows using "$PM_OUT/key_by_year.dta", clear
keep if proman_rows > 0 | bahanbaku_rows > 0
quietly levelsof year, local(ryears)
local ryears : subinstr local ryears " " ",", all
rename (year key_type) (__year __keytype)
keep __year __keytype
tempfile keys
save `keys'

* ---- the ready-to-use file and its key -------------------------------------------
use "$PM_MAIN", clear
local n_main = _N
generate long __order = _n          // keep the row order of the ready-to-use file
pm_mainkeys
generate int __year = $PM_MAIN_YEAR
merge m:1 __year using `keys', keep(master match) nogenerate
generate str100 roster_key = ""
replace roster_key = "K:" + __kipb                                if __keytype == "kipb"     & __kipb != ""
replace roster_key = "D:" + __prov + "_" + __kab + "_" + __kbli   if __keytype == "cell_kab" & __prov != "" & __kab != "" & __kbli != ""
replace roster_key = "C:" + __prov + "_" + __kbli                 if __keytype == "cell"     & __prov != "" & __kbli != ""

* Kipb must identify one firm in a Kipb year
bysort __year roster_key: generate long __dup = _N if __keytype == "kipb" & roster_key != ""
quietly count if __dup > 1 & !missing(__dup)
if r(N) > 0 {
    display as error "Kipb is not unique within a year in the ready-to-use file (`r(N)' rows)."
    display as error "Listed in output/main_kipb_duplicates.csv. Fix the file (or set PM_KEY = cell_kab / cell)."
    preserve
    keep if __dup > 1 & !missing(__dup)
    keep __year __kipb __dup
    rename (__year __kipb __dup) (year kipb copies)
    duplicates drop
    export delimited using "$PM_OUT/main_kipb_duplicates.csv", replace
    restore
    exit 459
}
drop __dup
bysort __year roster_key: generate int roster_n_main = _N if roster_key != ""

* ---- merge ------------------------------------------------------------------
preserve
use "$PM_OUT/roster_firm_year.dta", clear
drop kipb prov kab kbli5 key_type
rename year __year
tempfile roster
save `roster'
restore
merge m:1 roster_key __year using `roster', keep(master match)
generate byte roster_match = (_merge == 3) if inlist(__year, `ryears')
drop _merge
rename __keytype roster_key_type
replace roster_n_main = . if roster_match != 1
replace roster_key = "" if roster_match != 1
sort __order
drop __order __year __kipb __prov __kab __kbli
assert _N == `n_main'

tabulate $PM_MAIN_YEAR roster_match, missing

* ---- labels -------------------------------------------------------------------
label variable roster_key      "Roster merge key (K: Kipb / D: prov_kab_kbli5 / C: prov_kbli5)"
label variable roster_key_type "Key of the year: kipb = firm values; cell_kab / cell = shared by the cell"
label variable roster_match    "1 = firm-year has roster data; missing = year not covered by the rosters"
label variable roster_n_main   "Firm-years sharing the roster key in that year (1 = one firm)"
foreach v of varlist pm_* bb_* in_proman in_bahanbaku {
    notes `v': Production roster (Proman / Bahan Baku); values as reported (not masked). Merged by 20261014-1532-proman-merge/05_merge.do; key per year in roster_key_type.
}
notes _dta: 20261014-1532-proman-merge/05_merge.do: ready-to-use file ($PM_MAIN) + production rosters; key per year in output/key_by_year.csv.
compress
save "$PM_OUT/analysis_ready_with_roster.dta", replace
display as result "Merged: " _N " rows (unchanged) -> $PM_OUT/analysis_ready_with_roster.dta"
