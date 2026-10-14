/*==========================================================================
  Line 2: "Sumber energi utama"
  Data  : SI 2010-2022 (data/b16_si.dta), clean == 1
  Output sheets:
    t02_energy_mix      total GJ per source and its share of all GJ, pool + by year
    t02_main_src_share  % of firm-years per main source, pool + by year
    t02_by_main_src     GJ scope 1 / 2 / total (level & ln), GJ per VA and per worker, by main source

  NOTE: Main energy source = the source with the largest GJ of the firm (built
  in 01a, same rule as b1-17 line 2). Diesel oil, fuel oil, natural gas and
  biodiesel exist only on the 2020-2022 form; city gas and other gas only
  before 2020. Biomass is left out (its unit, kg or tonne, is not settled).
  Electricity = purchased only.
==========================================================================*/
if "$B16" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
local src "gj_diesel gj_petrol gj_kerosene gj_coal2 gj_lpg gj_citygas gj_othergas gj_coalbriq gj_dieseloil gj_fueloil gj_natgas gj_biodiesel gj_elec"

* ---- A. energy mix: how much of all energy comes from each source ----
use "$B16_DATA/b16_si.dta", clear
keep if clean == 1
keep year `src'
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) `src', by(year)
reshape long gj_, i(year) j(source) string
rename gj_ gj
* readable names (same as the main-source labels)
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
export excel using "$B16_XLSX", sheet("t02_energy_mix", replace) firstrow(variables)

* ---- B. share of firms per main source ----
use "$B16_DATA/b16_si.dta", clear
keep if clean == 1
do "$B16/_shares.do" "main_src" "" "t02_main_src_share"

* ---- C. energy use by main source ----
local ENERGY "gj_s1 gj_s2 gj_total ln_gj_s1 ln_gj_s2 ln_gj_total gj_per_va gj_pw"
do "$B16/_sumstats.do" "`ENERGY'" "main_src" "t02_by_main_src"
