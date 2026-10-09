/*==========================================================================
  Line 7: "Exporter concentration"
  Data  : SI 2010-2022 (data/b210_si.dta), clean == 1
  Output sheets:
    t07_exp_java        Java / outside Java, pool + by year
    t07_exp_prov        by province, pool + by year
    t07_exp_kabkot      by district (only when district codes exist)
      columns: n_firms, n_asked (firms with an export answer), n_exporters,
               pct_exporters      = exporters / firms asked in the region
               exp_output_share   = output of exporters / output of firms
                                    asked in the region, %
               share_of_exporters = region's exporters / all exporters in
                                    the country that period, %
  Two readings of "concentration": how export-oriented a region is (first
  two columns) and where the country's exporters sit (last column).

  NOTE: firms with no export answer are left out of the denominator, not
        counted as non-exporters. 2022 is empty: the form only asks about
        direct exports, so no "no" is recorded (set missing in 01a).
==========================================================================*/
if "$B210" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

use "$B210_DATA/b210_si.dta", clear
local levels "java prov"
count if kabkot != ""
if r(N) > 0 local levels "java prov kabkot"
else display as error "No district (kabkot) codes in this data: kabkot table skipped."

foreach lev of local levels {
    use "$B210_DATA/b210_si.dta", clear
    keep if clean == 1 & !missing(`lev')
    generate n_firms   = 1
    generate n_asked   = !missing(exporter)
    generate out_asked = output if !missing(exporter)
    generate out_exp   = output if exporter == 1
    expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
    replace year = 0 if copy == 1
    collapse (sum) n_firms n_asked n_exporters = exporter out_asked out_exp, by(`lev' year)
    generate pct_exporters    = 100 * n_exporters / n_asked if n_asked > 0
    generate exp_output_share = 100 * out_exp / out_asked   if out_asked > 0
    bysort year: egen double all = total(n_exporters)
    generate share_of_exporters = 100 * n_exporters / all if all > 0
    generate period = cond(year == 0, "pool", string(year))
    sort `lev' year
    order `lev' period n_firms n_asked n_exporters pct_exporters exp_output_share share_of_exporters
    drop year all out_asked out_exp
    if "`lev'" == "java" list if period == "pool", clean noobs
    export excel using "$B210_XLSX", sheet("t07_exp_`lev'", replace) firstrow(variables)
}
