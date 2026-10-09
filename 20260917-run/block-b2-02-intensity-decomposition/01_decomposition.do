/*==========================================================================
  Line 1: "Decompose carbon intensity (CO2/VA = GJ/VA x CO2/GJ)"
  Data  : SI 2010-2022 (data/b202_si.dta), clean == 1
  Output sheets:
    t01_total        all manufacturing, pool + by year: total CO2, GJ, VA,
                     workers; the three ratios in level and ln; check column
                     (ln CO2/VA - ln GJ/VA - ln CO2/GJ, must be 0)
    t01_by_kbli2     the same per KBLI 2-digit sector, pool + by year
    t01_firm_stats   firm-level distribution of the three ratios, level and
                     ln, pool + by year (n mean sd p10..p90 min max)

  The identity: CO2/VA = (GJ/VA) x (CO2/GJ), so ln CO2/VA = ln GJ/VA + ln CO2/GJ.
  Aggregate ratios = total CO2 of all firms / total VA of all firms (etc.):
  this is the "manufacturing as a whole" number and the identity holds exactly.
  Firm-level stats use only firms with CO2 > 0, GJ > 0 and VA > 0, so the
  identity also holds firm by firm.

  NOTE: VA is NOMINAL (no deflator) and masked in the development data, so a
  fall in GJ/VA can be price inflation, not energy saved. The per-worker
  columns (co2_pw, gj_pw) are physical and carry no price; read them beside
  the VA columns. Scope 1 = the 4 fuels asked in every year, scope 2 =
  purchased electricity (block 0 grid factor). There is no 2016.
==========================================================================*/
if "$B202" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- A. all manufacturing ----
use "$B202_DATA/b202_si.dta", clear
keep if clean == 1
generate n_firms = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms tot_co2 = co2_total tot_gj = gj_total tot_va = va ///
         tot_workers = workers, by(year)
generate co2_per_va = tot_co2 / tot_va
generate gj_per_va  = tot_gj / tot_va
generate co2_per_gj = tot_co2 / tot_gj
generate ln_co2_per_va = ln(co2_per_va)
generate ln_gj_per_va  = ln(gj_per_va)
generate ln_co2_per_gj = ln(co2_per_gj)
generate check_identity = ln_co2_per_va - ln_gj_per_va - ln_co2_per_gj
generate co2_pw = tot_co2 / tot_workers
generate gj_pw  = tot_gj / tot_workers
generate period = cond(year == 0, "pool", string(year))
order period n_firms tot_co2 tot_gj tot_va tot_workers co2_per_va gj_per_va co2_per_gj ///
      ln_co2_per_va ln_gj_per_va ln_co2_per_gj check_identity co2_pw gj_pw
drop year
summarize check_identity
list period co2_per_va gj_per_va co2_per_gj, clean noobs
export excel using "$B202_XLSX", sheet("t01_total", replace) firstrow(variables)

* ---- B. per KBLI 2-digit sector ----
use "$B202_DATA/b202_si.dta", clear
keep if clean == 1 & !missing(kbli2)
generate n_firms = 1
expand 2, generate(copy)
replace year = 0 if copy == 1
collapse (sum) n_firms tot_co2 = co2_total tot_gj = gj_total tot_va = va ///
         tot_workers = workers, by(kbli2 year)
generate co2_per_va = tot_co2 / tot_va if tot_va > 0
generate gj_per_va  = tot_gj / tot_va  if tot_va > 0
generate co2_per_gj = tot_co2 / tot_gj if tot_gj > 0
generate ln_co2_per_va = ln(co2_per_va)
generate ln_gj_per_va  = ln(gj_per_va)
generate ln_co2_per_gj = ln(co2_per_gj)
generate check_identity = ln_co2_per_va - ln_gj_per_va - ln_co2_per_gj
generate co2_pw = tot_co2 / tot_workers if tot_workers > 0
generate gj_pw  = tot_gj / tot_workers  if tot_workers > 0
generate period = cond(year == 0, "pool", string(year))
sort kbli2 year
order kbli2 period n_firms tot_co2 tot_gj tot_va tot_workers co2_per_va gj_per_va co2_per_gj ///
      ln_co2_per_va ln_gj_per_va ln_co2_per_gj check_identity co2_pw gj_pw
drop year
export excel using "$B202_XLSX", sheet("t01_by_kbli2", replace) firstrow(variables)

* ---- C. firm-level distribution of the three terms ----
use "$B202_DATA/b202_si.dta", clear
keep if clean == 1 & !missing(ln_co2_per_va, ln_gj_per_va, ln_co2_per_gj)
count
do "$B202/_sumstats.do" "co2_per_va gj_per_va co2_per_gj ln_co2_per_va ln_gj_per_va ln_co2_per_gj" "" "t01_firm_stats"
