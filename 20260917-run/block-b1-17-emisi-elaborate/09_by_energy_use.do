/*==========================================================================
  Line 9: "Energy use 1, 2, total"
  Data  : SI 2010-2022 (data/b17_si.dta), clean == 1
  Energy use 1 = GJ of the scope 1 fuels (diesel, petrol, coal, LPG),
  energy use 2 = GJ of purchased electricity, total = both.
  Output sheets:
    t09_energy_stats   per-firm stats of energy use (level & ln) and CO2 per GJ,
                       pool + by year
    t09_by_gj_s1_q, t09_by_gj_s2_q, t09_by_gj_total_q
                       CO2 scope 1 / 2 / total (level & ln), intensities, by
                       quintile of energy use (within year, among firms using
                       some; "Zero" = none), pool + by year

  NOTE: CO2 per GJ moves only with the fuel mix and the grid factor, so it is
  an emission factor check, not a performance measure.
==========================================================================*/
if "$B17" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
local EMIS "co2_s1 co2_s2 co2_total ln_co2_s1 ln_co2_s2 ln_co2_total co2_per_va co2_pw"

* ---- energy use itself ----
use "$B17_DATA/b17_si.dta", clear
keep if clean == 1
do "$B17/_sumstats.do" "gj_s1 gj_s2 gj_total ln_gj_s1 ln_gj_s2 ln_gj_total co2_per_gj gj_per_va gj_pw" "" "t09_energy_stats"

* ---- emissions by energy-use quintile ----
foreach v in gj_s1 gj_s2 gj_total {
    use "$B17_DATA/b17_si.dta", clear
    keep if clean == 1
    generate q_`v' = 0 if `v' == 0
    levelsof year if `v' > 0 & !missing(`v'), local(years)
    foreach y of local years {
        xtile tmp = `v' if year == `y' & `v' > 0, nquantiles(5)
        replace q_`v' = tmp if year == `y' & `v' > 0 & !missing(`v')
        drop tmp
    }
    label define quint 0 "Zero" 1 "Q1 (lowest)" 2 "Q2" 3 "Q3" 4 "Q4" 5 "Q5 (highest)", replace
    label values q_`v' quint
    do "$B17/_sumstats.do" "`EMIS'" "q_`v'" "t09_by_`v'_q"
}
