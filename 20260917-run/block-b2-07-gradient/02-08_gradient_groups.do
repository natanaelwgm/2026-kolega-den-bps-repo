/*==========================================================================
  Lines 2-8: the 7 groups of the internationalisation gradient
     2 "Domestic only"
     3 "Exporter only"
     4 "Importer only"
     5 "Exporter + importer"
     6 "Fdi, dan domestic market oriented"
     7 "Fdi, dan exporter"
     8 "Fdi, dan exporter + importer"
  The 7 bullets are the categories of ONE variable, so they share one file.

  Data  : SI 2010-2022 (data/b207_si.dta), clean == 1
  Output: data/b207_groups.dta  (b207_si + group7), used by 09 and 10
  Output sheets:
    t02_definition     the rule behind each group (exporter / importer / FDI)
    t02_counts         n firms per group, pool + by year, incl. "Not classified"
    t02_not_classified per year: how many firms cannot be classified and which
                       flag is missing

  Group definition (decided 9 Oct, follows the docx):
    1 Domestic only          non-FDI, no export, no import
    2 Exporter only          non-FDI, export, no import
    3 Importer only          non-FDI, no export, import
    4 Exporter + importer    non-FDI, export, import
    5 FDI, domestic market   FDI, no export (with OR without imports)
                             FDI firms that import but do not export are
                             in group 5, as the docx defines it.
    6 FDI, exporter          FDI, export, no import
    7 FDI, exporter+importer FDI, export, import
   99 Not classified         a flag the group needs is missing

  NOTE: 2020 (FDI set missing) and 2022 (export flag set missing) cannot be
        classified at all. In the other years, firms whose export or import
        question was not answered are also "Not classified". Group 5 does
        not need the import flag, so an FDI non-exporter is classified even
        when its import flag is missing.
==========================================================================*/
if "$B207" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B207_DATA/b207_si.dta", clear

* ---- build the 7 groups ----------------------------------------------
generate group7 = 99
replace group7 = 1 if fdi == 0 & exporter == 0 & importer == 0
replace group7 = 2 if fdi == 0 & exporter == 1 & importer == 0
replace group7 = 3 if fdi == 0 & exporter == 0 & importer == 1
replace group7 = 4 if fdi == 0 & exporter == 1 & importer == 1
replace group7 = 5 if fdi == 1 & exporter == 0             // imports or not
replace group7 = 6 if fdi == 1 & exporter == 1 & importer == 0
replace group7 = 7 if fdi == 1 & exporter == 1 & importer == 1
label define group7 1 "1 Domestic only" 2 "2 Exporter only" 3 "3 Importer only" ///
    4 "4 Exporter + importer" 5 "5 FDI, domestic market" 6 "6 FDI, exporter" ///
    7 "7 FDI, exporter + importer" 99 "Not classified"
label values group7 group7
label variable group7 "Internationalisation gradient (7 groups, 99 = not classified)"
generate classified = (group7 != 99)
tabulate year group7 if clean == 1
compress
save "$B207_DATA/b207_groups.dta", replace

* ---- t02_definition: the rule behind each group -----------------------
clear
input byte group7 str12 fdi_rule str12 export_rule str16 import_rule
 1 "Non-FDI" "No export" "No import"
 2 "Non-FDI" "Export"    "No import"
 3 "Non-FDI" "No export" "Import"
 4 "Non-FDI" "Export"    "Import"
 5 "FDI"     "No export" "Import or not"
 6 "FDI"     "Export"    "No import"
 7 "FDI"     "Export"    "Import"
99 "missing"  "missing"  "missing"
end
label values group7 group7
replace fdi_rule = "any flag the group needs is missing" if group7 == 99
replace export_rule = "" if group7 == 99
replace import_rule = "" if group7 == 99
export excel using "$B207_XLSX", sheet("t02_definition", replace) firstrow(variables)

* ---- t02_counts: n firms per group, pool + by year --------------------
use "$B207_DATA/b207_groups.dta", clear
keep if clean == 1
generate n_firms = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms, by(group7 year)
* % of all clean firms in that period, and % of the classified ones
bysort year: egen n_all = total(n_firms)
bysort year: egen n_classified = total(n_firms * (group7 != 99))
generate pct_of_all        = 100 * n_firms / n_all
generate pct_of_classified = 100 * n_firms / n_classified if group7 != 99
generate period = cond(year == 0, "pool", string(year))
sort year group7
order group7 period n_firms pct_of_classified pct_of_all
drop year n_all n_classified
list if period == "pool", clean noobs
export excel using "$B207_XLSX", sheet("t02_counts", replace) firstrow(variables)

* ---- t02_not_classified: which flag is missing, by year ---------------
use "$B207_DATA/b207_groups.dta", clear
keep if clean == 1
generate n_firms          = 1
generate n_classified     = classified
generate n_not_classified = 1 - classified
generate n_missing_export = missing(exporter)
generate n_missing_import = missing(importer)
generate n_missing_fdi    = missing(fdi)
expand 2, generate(copy)
replace year = 0 if copy == 1
collapse (sum) n_firms n_classified n_not_classified n_missing_export n_missing_import n_missing_fdi, by(year)
generate pct_classified = 100 * n_classified / n_firms
generate period = cond(year == 0, "pool", string(year))
generate str60 reason = ""
replace reason = "FDI set missing (47% FDI not credible)" if year == 2020
replace reason = "Export flag set missing (direct exports only)" if year == 2022
sort year
order period n_firms n_classified n_not_classified pct_classified
drop year
list, clean noobs
export excel using "$B207_XLSX", sheet("t02_not_classified", replace) firstrow(variables)
