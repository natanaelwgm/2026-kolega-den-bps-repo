/*==========================================================================
  Line 2: "Construct firm energy mix per year: coal, diesel/fuel oil, gas/lpg,
           electicity pln, non pln, self generation, biomass."
  Data  : SI 2010-2022 (data/b205_si.dta), clean == 1
  Output: data/b205_mix.dta  -- 1 row = 1 firm x year, GJ and % share per source
  Output sheets:
    t02_mix_mean        mean of firm shares (%) per source, pool + by year
    t02_mix_aggregate   all firms' GJ per source / all firms' GJ (%), pool + by year
    t02_share_stats     n mean sd p10-p90 min max of every share, pool + by year
    t02_self_generation % firms generating their own electricity, and own
                        generation as % of the electricity they use
    t02_biomass         biomass reporters (2020+), shown apart, see NOTE

  Sources (GJ):
    coal         coal (2017 corrected) + coal briquettes + coke
    oil          diesel + petrol + kerosene + diesel oil + fuel oil
    gas          LPG + city gas + other gas + natural gas
    pln          electricity bought from PLN
    nonpln       electricity bought from others
    biofuel      biodiesel
  The denominator gj_mix = the sum of these six (= 100%).

  SELF GENERATION is NOT one of the six. The generator burns diesel, coal or
  gas that the firm already reports among its fuels, so adding the kWh it
  makes would count the same energy twice (the shares would sum to > 100).
  It is reported apart: own kWh / (PLN + non-PLN + own kWh).
  BIOMASS is NOT in the six either. Block 0 calls the column kg, the 2020 form
  says tonne; nothing settles which, and the GJ differ by 1000x. t02_biomass
  shows how many firms report it and what the share would be under each unit.
  NOTE: diesel oil, fuel oil, natural gas, biodiesel and biomass are asked
  from 2020 only; city gas, other gas, kerosene and briquettes are not asked
  every year. A step in 2020 is partly the new form, not a transition.
  Lubricant is not energy (not burned) and is left out.
==========================================================================*/
if "$B205" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B205_DATA/b205_si.dta", clear
keep if clean == 1

* ---- GJ per source -----------------------------------------------------
egen gj_c_coal   = rowtotal(gj_coal2 gj_coalbriq gj_coke)
egen gj_c_oil    = rowtotal(gj_diesel gj_petrol gj_kerosene gj_dieseloil gj_fueloil)
egen gj_c_gas    = rowtotal(gj_lpg gj_citygas gj_othergas gj_natgas)
egen gj_c_pln    = rowtotal(gj_elec_pln)
egen gj_c_nonpln = rowtotal(gj_elec_nonpln)
egen gj_c_bio    = rowtotal(gj_biodiesel)
egen gj_mix      = rowtotal(gj_c_coal gj_c_oil gj_c_gas gj_c_pln gj_c_nonpln gj_c_bio)

* ---- share of each source in the firm's GJ (%) -------------------------
foreach c in coal oil gas pln nonpln bio {
    generate sh_`c' = 100 * gj_c_`c' / gj_mix if gj_mix > 0
}
generate sh_elec = sh_pln + sh_nonpln
label variable sh_coal   "Coal, briquettes, coke (% of GJ)"
label variable sh_oil    "Diesel, petrol, kerosene, diesel oil, fuel oil (% of GJ)"
label variable sh_gas    "LPG, city gas, other gas, natural gas (% of GJ)"
label variable sh_pln    "Electricity bought from PLN (% of GJ)"
label variable sh_nonpln "Electricity bought from non-PLN (% of GJ)"
label variable sh_bio    "Biodiesel (% of GJ)"
label variable sh_elec   "Electricity bought, PLN + non-PLN (% of GJ)"

* ---- self generation (apart from the mix) ------------------------------
generate owngen = (gj_elec_owngen > 0) if !missing(gj_elec_owngen)
egen gj_elec_all = rowtotal(gj_elec_pln gj_elec_nonpln gj_elec_owngen)
generate sh_owngen_elec = 100 * gj_elec_owngen / gj_elec_all if gj_elec_all > 0 & !missing(gj_elec_owngen)
label variable owngen         "1 = generates some of its own electricity"
label variable sh_owngen_elec "Own generation as % of all electricity used"

generate has_energy = (gj_mix > 0)
generate ln_gj_mix  = ln(gj_mix) if gj_mix > 0
label variable gj_mix "Energy used (GJ): the six sources, excl. own generation and biomass"
count if has_energy == 0
display as result "Firm-years with no energy reported (no mix): " r(N)
save "$B205_DATA/b205_mix.dta", replace

* ---- A. mean of firm shares, pool + by year ----------------------------
generate n_firms = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms n_with_energy = has_energy ///
         (mean) sh_coal sh_oil sh_gas sh_pln sh_nonpln sh_bio sh_elec, by(year)
generate period = cond(year == 0, "pool", string(year))
order period n_firms n_with_energy
drop year
list period n_with_energy sh_coal sh_oil sh_gas sh_elec sh_bio, clean noobs
export excel using "$B205_XLSX", sheet("t02_mix_mean", replace) firstrow(variables)

* ---- B. aggregate shares: all firms' GJ per source / all firms' GJ ------
use "$B205_DATA/b205_mix.dta", clear
keep if has_energy == 1
expand 2, generate(copy)
replace year = 0 if copy == 1
collapse (sum) gj_c_coal gj_c_oil gj_c_gas gj_c_pln gj_c_nonpln gj_c_bio gj_mix, by(year)
foreach c in coal oil gas pln nonpln bio {
    generate agg_sh_`c' = 100 * gj_c_`c' / gj_mix
}
generate period = cond(year == 0, "pool", string(year))
order period gj_mix agg_sh_*
keep  period gj_mix agg_sh_* gj_c_*
list period agg_sh_*, clean noobs
export excel using "$B205_XLSX", sheet("t02_mix_aggregate", replace) firstrow(variables)

* ---- C. distribution of each share (firms with energy) ------------------
use "$B205_DATA/b205_mix.dta", clear
keep if has_energy == 1
do "$B205/_sumstats.do" "sh_coal sh_oil sh_gas sh_pln sh_nonpln sh_elec sh_bio gj_mix ln_gj_mix" "" "t02_share_stats"

* ---- D. self generation -----------------------------------------------
use "$B205_DATA/b205_mix.dta", clear
keep if !missing(owngen)
generate n_firms = 1
generate sh_owngen_if_any = sh_owngen_elec if owngen == 1
expand 2, generate(copy)
replace year = 0 if copy == 1
collapse (sum) n_firms n_owngen = owngen gj_elec_owngen gj_elec_all ///
         (mean) mean_sh_owngen = sh_owngen_if_any (p50) med_sh_owngen = sh_owngen_if_any, by(year)
generate pct_owngen = 100 * n_owngen / n_firms
generate agg_sh_owngen = 100 * gj_elec_owngen / gj_elec_all
generate period = cond(year == 0, "pool", string(year))
order period n_firms n_owngen pct_owngen mean_sh_owngen med_sh_owngen agg_sh_owngen
keep  period n_firms n_owngen pct_owngen mean_sh_owngen med_sh_owngen agg_sh_owngen
label variable mean_sh_owngen "Mean own generation as % of electricity, own generators only"
list, clean noobs
export excel using "$B205_XLSX", sheet("t02_self_generation", replace) firstrow(variables)

* ---- E. biomass, shown apart (unit not settled) -----------------------
* What would biomass's share of the firm's energy be, if the column is kg
* (0.0116 GJ per kg) or if it is tonnes (11.6 GJ per tonne)? 11.6 GJ/t is the
* IPCC 2006 default for other primary solid biomass. The answer decides
* whether a firm is biomass-dominant.
use "$B205_DATA/b205_mix.dta", clear
keep if year >= 2020
generate bio_reporter = (biomass_qty > 0) if !missing(biomass_qty)
generate gj_bio_if_kg = biomass_qty * 0.0116 if bio_reporter == 1
generate gj_bio_if_t  = biomass_qty * 11.6   if bio_reporter == 1
generate dom_if_kg = (gj_bio_if_kg / (gj_mix + gj_bio_if_kg) >= 0.5) if bio_reporter == 1
generate dom_if_t  = (gj_bio_if_t  / (gj_mix + gj_bio_if_t)  >= 0.5) if bio_reporter == 1
generate qty_if_reporter = biomass_qty if bio_reporter == 1
generate n_firms = 1
expand 2, generate(copy)
replace year = 0 if copy == 1
collapse (sum) n_firms n_reporters = bio_reporter n_dom_if_kg = dom_if_kg n_dom_if_t = dom_if_t ///
         (p50) med_qty = qty_if_reporter, by(year)
generate pct_reporters    = 100 * n_reporters / n_firms
generate pct_dom_if_kg    = 100 * n_dom_if_kg / n_reporters
generate pct_dom_if_tonne = 100 * n_dom_if_t / n_reporters
generate period = cond(year == 0, "pool 2020-22", string(year))
order period n_firms n_reporters pct_reporters med_qty pct_dom_if_kg pct_dom_if_tonne
keep  period n_firms n_reporters pct_reporters med_qty pct_dom_if_kg pct_dom_if_tonne
list, clean noobs
export excel using "$B205_XLSX", sheet("t02_biomass", replace) firstrow(variables)
