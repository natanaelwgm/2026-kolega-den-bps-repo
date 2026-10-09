/*==========================================================================
  Line 10: "Apakah firms yg selef generate mempunyai scope 1 emissions yg
            lebih tinggi?"
  Data  : SI 2010-2022 (data/b206_si.dta), clean == 1, firms asked about own
          generation (2014-2015: ~1,060 not asked per year are left out)
  Scope 1 = CO2 from the 4 fuels asked every year (diesel, petrol, coal, LPG).
  Output sheets:
    t10_s1_by_owngen  scope 1 level, ln, per worker (level and ln), per VA,
                      own-generators vs not, pool + by year
    t10_regression    ln scope 1 (and ln scope 1 per worker) on has_owngen:
                      ln scope 1: (1) year FE; (2) + ln workers + KBLI2 FE.
                      ln scope 1 per worker: (3) year FE; (4) + KBLI2 FE.
                      pct_diff = 100*(exp(b)-1) = % higher scope 1
  NOTE: the generator's own fuel cannot be separated (line 7), so the gap is
  the WHOLE difference in on-site fuel use, not just the generator. The ln
  versions drop firms with zero scope 1. Descriptive, not causal.
==========================================================================*/
if "$B206" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B206_DATA/b206_si.dta", clear
keep if clean == 1 & !missing(has_owngen)

* ---- descriptive comparison ----
do "$B206/_sumstats.do" "co2_s1 ln_co2_s1 co2_s1_pw ln_co2_s1_pw co2_s1_va" "has_owngen" "t10_s1_by_owngen"

* ---- simple regressions (robust SE) ----
* each row of matrix R: coefficient on has_owngen, SE, N, R2
regress ln_co2_s1 has_owngen i.year, vce(robust)
matrix R = (_b[has_owngen], _se[has_owngen], e(N), e(r2))
regress ln_co2_s1 has_owngen ln_workers i.kbli2 i.year, vce(robust)
matrix R = R \ (_b[has_owngen], _se[has_owngen], e(N), e(r2))
regress ln_co2_s1_pw has_owngen i.year, vce(robust)
matrix R = R \ (_b[has_owngen], _se[has_owngen], e(N), e(r2))
* (adding ln workers here would give exactly row 2 again, so KBLI2 FE only)
regress ln_co2_s1_pw has_owngen i.kbli2 i.year, vce(robust)
matrix R = R \ (_b[has_owngen], _se[has_owngen], e(N), e(r2))

clear
svmat R
rename (R1 R2 R3 R4) (b_owngen se_owngen n_obs r2)
generate str14 outcome  = cond(_n <= 2, "ln_co2_s1", "ln_co2_s1_pw")
generate str40 controls = "year FE" in 1
replace controls = "year FE + ln workers + KBLI2 FE" in 2
replace controls = "year FE" in 3
replace controls = "year FE + KBLI2 FE" in 4
generate t_stat   = b_owngen / se_owngen
generate pct_diff = 100 * (exp(b_owngen) - 1)
order outcome controls b_owngen se_owngen t_stat pct_diff n_obs r2
list, clean noobs
export excel using "$B206_XLSX", sheet("t10_regression", replace) firstrow(variables)
