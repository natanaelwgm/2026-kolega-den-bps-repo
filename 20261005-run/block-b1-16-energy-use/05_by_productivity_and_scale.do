/*==========================================================================
  Line 5: "Value added per worker, value added, output, output per worker, capital, capital per worker,"
  Data  : SI 2010-2022 (data/b16_si.dta), clean == 1
  Output sheets:
    t05_by_{va_pw,va,output,out_pw,capital,cap_pw}_q  GJ scope 1 / 2 / total (level & ln), GJ per VA and per worker, by quintile (within year)

  NOTE: Quintiles are among firms with a positive value; zero or negative
  values are a separate group. Nominal, masked values.
==========================================================================*/
if "$B16" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
local ENERGY "gj_s1 gj_s2 gj_total ln_gj_s1 ln_gj_s2 ln_gj_total gj_per_va gj_pw"

foreach v in va_pw va output out_pw capital cap_pw {
    use "$B16_DATA/b16_si.dta", clear
    keep if clean == 1
    * quintiles within each year, among positive values
    generate q_`v' = 0 if `v' <= 0
    levelsof year if `v' > 0 & !missing(`v'), local(years)
    foreach y of local years {
        xtile tmp = `v' if year == `y' & `v' > 0, nquantiles(5)
        replace q_`v' = tmp if year == `y' & `v' > 0 & !missing(`v')
        drop tmp
    }
    label define quint 0 "Zero or negative" 1 "Q1 (lowest)" 2 "Q2" 3 "Q3" 4 "Q4" 5 "Q5 (highest)", replace
    label values q_`v' quint
    do "$B16/_sumstats.do" "`ENERGY'" "q_`v'" "t05_by_`v'_q"
}
