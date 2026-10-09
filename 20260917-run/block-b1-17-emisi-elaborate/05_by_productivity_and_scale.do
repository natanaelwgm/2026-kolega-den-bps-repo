/*==========================================================================
  Line 5: "Value added per worker, value added, output, output per worker,
           capital, capital per worker,"
  Data  : SI 2010-2022 (data/b17_si.dta), clean == 1
  Each variable is cut into quintiles WITHIN each year, among firms with a
  positive value (Q1 = lowest 20% in that year). Firms with zero or negative
  values (negative VA, zero capital) are their own group "Zero or negative".
  Output sheets (one per variable):
    t05_by_va_pw_q, t05_by_va_q, t05_by_output_q, t05_by_out_pw_q,
    t05_by_capital_q, t05_by_cap_pw_q
        CO2 scope 1 / 2 / total (level & ln), intensities, by quintile,
        pool + by year

  NOTE: all money values are nominal and masked. CO2 per VA is mechanically
  lower in the high-VA quintiles (VA is in the denominator).
==========================================================================*/
if "$B17" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
local EMIS "co2_s1 co2_s2 co2_total ln_co2_s1 ln_co2_s2 ln_co2_total co2_per_va co2_pw"

foreach v in va_pw va output out_pw capital cap_pw {
    use "$B17_DATA/b17_si.dta", clear
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
    do "$B17/_sumstats.do" "`EMIS'" "q_`v'" "t05_by_`v'_q"
}
