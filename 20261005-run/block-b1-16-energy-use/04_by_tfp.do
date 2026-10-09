/*==========================================================================
  Line 4: "TFP (semua)"
  Data  : SI 2010-2022 (data/b16_si.dta), clean == 1
  Output sheets:
    t04_by_tfp_{op,lp,acf,wrdg}_q  GJ scope 1 / 2 / total (level & ln), GJ per VA and per worker, by TFP quintile (within year)

  NOTE: TFP = block 0 nominal development residuals on fictional firm links
  (not real TFP); OP has only 672 firm-years.
==========================================================================*/
if "$B16" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
local ENERGY "gj_s1 gj_s2 gj_total ln_gj_s1 ln_gj_s2 ln_gj_total gj_per_va gj_pw"

foreach t in tfp_op tfp_lp tfp_acf tfp_wrdg {
    use "$B16_DATA/b16_si.dta", clear
    keep if clean == 1
    * quintiles within each year
    generate q_`t' = .
    levelsof year if !missing(`t'), local(years)
    foreach y of local years {
        xtile tmp = `t' if year == `y', nquantiles(5)
        replace q_`t' = tmp if year == `y'
        drop tmp
    }
    label define quint 1 "Q1 (lowest)" 2 "Q2" 3 "Q3" 4 "Q4" 5 "Q5 (highest)", replace
    label values q_`t' quint
    do "$B16/_sumstats.do" "`ENERGY'" "q_`t'" "t04_by_`t'_q"
}
