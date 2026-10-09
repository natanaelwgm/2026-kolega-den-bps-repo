/*==========================================================================
  Line 2: "Sumber energi utama"
  Data  : SI 2010-2022 (data/b17_si.dta), clean == 1
  Main energy source = the source with the largest energy use (GJ) of the
  firm. Ties go to the source listed first. Firms with no energy use are
  group "No energy reported", so the counts add up to all firms.
  Output sheets:
    t02_energy_mix      total GJ per source and its share of all GJ, pool + by year
    t02_main_src_share  % of firms per main source, pool + by year
    t02_by_main_src     CO2 scope 1 / 2 / total (level & ln), intensities,
                        by main source, pool + by year

  NOTE: diesel oil, fuel oil, natural gas (MMBTU) and biodiesel exist only on
  the 2020-2022 form; city gas and other gas only before 2020. Kerosene, city
  gas, other gas and coal briquettes are not asked every year. Biomass is
  left out (its unit, kg or tonne, is not settled). Electricity = purchased
  only. These sources count for the main-source choice, but scope 1 CO2 is
  still the 4 fuels of line 1.
==========================================================================*/
if "$B17" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
local src "gj_diesel gj_petrol gj_kerosene gj_coal2 gj_lpg gj_citygas gj_othergas gj_coalbriq gj_dieseloil gj_fueloil gj_natgas gj_biodiesel gj_elec"

* ---- A. energy mix: how much of all energy comes from each source ----
use "$B17_DATA/b17_si.dta", clear
keep if clean == 1
keep year `src'
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) `src', by(year)
reshape long gj_, i(year) j(source) string
rename gj_ gj
* readable names (same as the main-source labels below)
replace source = "Diesel"                  if source == "diesel"
replace source = "Petrol"                  if source == "petrol"
replace source = "Kerosene"                if source == "kerosene"
replace source = "Coal"                    if source == "coal2"
replace source = "LPG"                     if source == "lpg"
replace source = "City gas"                if source == "citygas"
replace source = "Other gas"               if source == "othergas"
replace source = "Coal briquettes"         if source == "coalbriq"
replace source = "Diesel oil (2020+)"      if source == "dieseloil"
replace source = "Fuel oil (2020+)"        if source == "fueloil"
replace source = "Natural gas (2020+)"     if source == "natgas"
replace source = "Biodiesel (2020+)"       if source == "biodiesel"
replace source = "Electricity (purchased)" if source == "elec"
bysort year: egen gj_all = total(gj)
generate share_pct = 100 * gj / gj_all
generate period = cond(year == 0, "pool", string(year))
gsort year -gj
order period source gj share_pct
drop year gj_all
list if period == "pool", clean noobs
export excel using "$B17_XLSX", sheet("t02_energy_mix", replace) firstrow(variables)

* ---- the main source of each firm ----
use "$B17_DATA/b17_si.dta", clear
keep if clean == 1
generate main_src = 0
generate best_gj  = 0
local k 0
foreach v of local src {
    local ++k
    replace main_src = `k' if `v' > best_gj & !missing(`v')
    replace best_gj  = `v' if `v' > best_gj & !missing(`v')
}
label define main_src 0 "No energy reported" 1 "Diesel" 2 "Petrol" 3 "Kerosene" 4 "Coal" ///
    5 "LPG" 6 "City gas" 7 "Other gas" 8 "Coal briquettes" 9 "Diesel oil (2020+)" ///
    10 "Fuel oil (2020+)" 11 "Natural gas (2020+)" 12 "Biodiesel (2020+)" ///
    13 "Electricity (purchased)"
label values main_src main_src
tabulate main_src
tempfile firms
save `firms'

* ---- B. share of firms per main source ----
generate n_firms = 1
expand 2, generate(copy)
replace year = 0 if copy == 1
collapse (sum) n_firms, by(main_src year)
bysort year: egen total = total(n_firms)
generate pct_firms = 100 * n_firms / total
generate period = cond(year == 0, "pool", string(year))
sort year main_src
order main_src period n_firms pct_firms
drop year total
export excel using "$B17_XLSX", sheet("t02_main_src_share", replace) firstrow(variables)

* ---- C. emissions by main source ----
use `firms', clear
local EMIS "co2_s1 co2_s2 co2_total ln_co2_s1 ln_co2_s2 ln_co2_total co2_per_va co2_pw"
do "$B17/_sumstats.do" "`EMIS'" "main_src" "t02_by_main_src"
