/*==========================================================================
  Line 9: "pertanyaan: aapakah self generation terutama merupakan resilience
           strategy?"
  Data  : SI 2010-2022 (data/b206_si.dta), clean == 1
  Two simple, DESCRIPTIVE tests (not causal; nothing in the data records why a
  firm generates, and there is no outage or tariff variable):
  (a) Grid reliability. The grid is weaker outside Java. If self generation is
      mainly insurance against a bad grid, the own-generation rate (and the
      own share of electricity) should be much higher outside Java.
        t09a_by_java      Java vs outside Java, pool + by year
        t09a_by_province  per province (with java flag), pool + by year
  (b) Shock performance. If own power protects production, own-generators
      should lose less output in the 2020 shock. Firms present in both years,
      own-generation status in the BASE year, change = ln(output t+1) -
      ln(output t). 2018->2019 is shown as a normal-year benchmark.
        t09b_output_change  by own-generation status and period
  Read together with t06_share_bands: most own-generators make <10% of their
  power (standby-like) -> consistent with back-up / resilience use.
  NOTE (b): firm links are FICTIONAL in the development data, so (b) only
  means something on the real BPS data. Output is nominal and masked.
==========================================================================*/
if "$B206" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- (a) Java vs outside Java, and by province ----
foreach loc in java prov {
    use "$B206_DATA/b206_si.dta", clear
    keep if clean == 1 & !missing(`loc') & !missing(has_owngen)
    generate n_firms   = 1
    generate share_gen = owngen_share if has_owngen == 1
    generate java_flag = java             // copy, so the province table keeps the Java flag
    expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
    replace year = 0 if copy == 1
    collapse (sum) n_firms n_owngen = has_owngen (mean) pct_owngen = has_owngen ///
             pct_nonpln = has_nonpln java_flag (p50) med_share = share_gen, by(`loc' year)
    replace pct_owngen = 100 * pct_owngen
    replace pct_nonpln = 100 * pct_nonpln
    generate period = cond(year == 0, "pool", string(year))
    sort `loc' year
    order `loc' period n_firms n_owngen pct_owngen med_share pct_nonpln
    drop year
    if "`loc'" == "java" {
        drop java_flag
        list, clean noobs
        export excel using "$B206_XLSX", sheet("t09a_by_java", replace) firstrow(variables)
    }
    else {
        rename java_flag java
        label values java java
        order prov java
        export excel using "$B206_XLSX", sheet("t09a_by_province", replace) firstrow(variables)
    }
}

* ---- (b) output change around the 2020 shock ----
* loop: base year 2018 (normal year) and 2019 (shock year follows)
tempfile next result
local first 1
foreach b in 2018 2019 {
    * output in the following year
    use "$B206_DATA/b206_si.dta", clear
    keep if year == `b' + 1 & clean == 1 & output > 0 & !missing(output)
    keep firm_id output
    rename output output_next
    save `next', replace

    * base year: own-generation status and output
    use "$B206_DATA/b206_si.dta", clear
    keep if year == `b' & clean == 1 & !missing(has_owngen) & output > 0 & !missing(output)
    keep firm_id has_owngen output
    merge 1:1 firm_id using `next', keep(master match)
    generate linked   = (_merge == 3)
    generate dln_out  = ln(output_next) - ln(output) if linked == 1
    generate out_fell = (output_next < output) if linked == 1
    generate n_firms  = 1
    collapse (sum) n_firms n_linked = linked ///
             (p50) med_dln_output = dln_out (mean) mean_dln_output = dln_out pct_output_fell = out_fell, ///
             by(has_owngen)
    replace pct_output_fell = 100 * pct_output_fell
    generate change = "`b'-" + string(`b' + 1)
    if `first' == 0 append using `result'
    save `result', replace
    local first 0
}
use `result', clear
sort change has_owngen
order change has_owngen n_firms n_linked med_dln_output mean_dln_output pct_output_fell
list, clean noobs
export excel using "$B206_XLSX", sheet("t09b_output_change", replace) firstrow(variables)
