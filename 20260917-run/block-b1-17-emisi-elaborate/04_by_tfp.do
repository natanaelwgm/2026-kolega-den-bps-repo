/*==========================================================================
  Line 4: "TFP (semua)"
  Data  : SI 2010-2022 (data/b17_si.dta), clean == 1
  Each TFP measure is cut into quintiles WITHIN each year (Q1 = lowest 20%
  of firms in that year), so the groups do not shift as the sample grows.
  Output sheets (one per TFP method):
    t04_by_tfp_op_q, t04_by_tfp_lp_q, t04_by_tfp_acf_q, t04_by_tfp_wrdg_q
        CO2 scope 1 / 2 / total (level & ln), intensities, by quintile,
        pool + by year

  NOTE: TFP = block 0's nominal development residuals. tfp_op exists for only
  672 firm-years (2011-2014, 2018-2022), so its quintiles are thin. The four
  methods are on different scales: compare quintiles, not levels.
==========================================================================*/
if "$B17" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
local EMIS "co2_s1 co2_s2 co2_total ln_co2_s1 ln_co2_s2 ln_co2_total co2_per_va co2_pw"

foreach t in tfp_op tfp_lp tfp_acf tfp_wrdg {
    use "$B17_DATA/b17_si.dta", clear
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
    do "$B17/_sumstats.do" "`EMIS'" "q_`t'" "t04_by_`t'_q"
}
