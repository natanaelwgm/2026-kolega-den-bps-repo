/*==========================================================================
  Line 8: "Fdi concentration"
  Data  : SI 2010-2022 (data/b210_si.dta), clean == 1
  Output sheets:
    t08_fdi_java        Java / outside Java, pool + by year
    t08_fdi_prov        by province, pool + by year
    t08_fdi_kabkot      by district (only when district codes exist)
      columns: n_firms, n_asked (firms with an ownership answer), n_fdi,
               pct_fdi          = FDI firms (foreign ownership >= 10%) /
                                  firms asked in the region
               fdi_output_share = output of FDI firms / output of firms
                                  asked in the region, %
               share_of_fdi     = region's FDI firms / all FDI firms in the
                                  country that period, %

  NOTE: 2020 is empty: the 2020 ownership answers are not credible (47% FDI
        against 8-11% in other years) and are set missing in 01a.
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
    generate n_asked   = !missing(fdi)
    generate out_asked = output if !missing(fdi)
    generate out_fdi   = output if fdi == 1
    expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
    replace year = 0 if copy == 1
    collapse (sum) n_firms n_asked n_fdi = fdi out_asked out_fdi, by(`lev' year)
    generate pct_fdi          = 100 * n_fdi / n_asked     if n_asked > 0
    generate fdi_output_share = 100 * out_fdi / out_asked if out_asked > 0
    bysort year: egen double all = total(n_fdi)
    generate share_of_fdi = 100 * n_fdi / all if all > 0
    generate period = cond(year == 0, "pool", string(year))
    sort `lev' year
    order `lev' period n_firms n_asked n_fdi pct_fdi fdi_output_share share_of_fdi
    drop year all out_asked out_fdi
    if "`lev'" == "java" list if period == "pool", clean noobs
    export excel using "$B210_XLSX", sheet("t08_fdi_`lev'", replace) firstrow(variables)
}
