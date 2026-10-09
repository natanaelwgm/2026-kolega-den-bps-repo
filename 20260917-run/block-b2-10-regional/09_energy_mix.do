/*==========================================================================
  Line 9: "Energy mix"
  Data  : SI 2010-2022 (data/b210_si.dta), clean == 1
  Output sheets:
    t09_mix_java        Java / outside Java, pool + by year
    t09_mix_prov        by province, pool + by year
    t09_mix_kabkot      by district (only when district codes exist)
      columns: n_firms, mix_total (GJ), and the share of mix_total (%) from
               sh_coal    coal + coal briquettes + coke
               sh_oil     diesel + petrol + kerosene + diesel oil + fuel oil
               sh_gas     LPG + city gas + other gas + natural gas
               sh_pln     electricity bought from PLN
               sh_nonpln  electricity bought from others
               (the 5 shares add up to 100)
               owngen_pct_elec  own-generated electricity as % of all the
                                electricity the firms use (memo)
               biodiesel_pct    biodiesel GJ as % of mix_total (memo)
               pct_biomass_user % of firms reporting biomass (memo)
  Source groups as in B2-05. Own generation is NOT a sixth share: the fuel
  the generator burns is already in coal/oil/gas, so adding it would count
  the same energy twice. Biomass is left out of the mix: its unit (kg or
  tonne) is not settled in block 0.

  NOTE: diesel oil, fuel oil and natural gas are only asked from 2020, and
        city gas / other gas only up to 2019. A shift in the oil/gas shares
        around 2020 is partly a questionnaire change. Compare shares within
        a year.
==========================================================================*/
if "$B210" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

use "$B210_DATA/b210_si.dta", clear
local levels "java prov"
count if kabkot != ""
if r(N) > 0 local levels "java prov kabkot"
else display as error "No district (kabkot) codes in this data: kabkot table skipped."

foreach lev of local levels {
    use "$B210_DATA/b210_si.dta", clear
    keep if clean == 1 & !missing(`lev')
    generate n_firms = 1
    expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
    replace year = 0 if copy == 1
    collapse (sum) n_firms mix_coal mix_oil mix_gas mix_pln mix_nonpln mix_total ///
             gj_owngen gj_biodiesel (mean) pct_biomass_user = biomass_user, by(`lev' year)
    foreach s in coal oil gas pln nonpln {
        generate sh_`s' = 100 * mix_`s' / mix_total if mix_total > 0
    }
    generate owngen_pct_elec = 100 * gj_owngen / (mix_pln + mix_nonpln + gj_owngen) ///
        if (mix_pln + mix_nonpln + gj_owngen) > 0
    generate biodiesel_pct = 100 * gj_biodiesel / mix_total if mix_total > 0
    replace  pct_biomass_user = 100 * pct_biomass_user
    generate period = cond(year == 0, "pool", string(year))
    sort `lev' year
    order `lev' period n_firms mix_total sh_coal sh_oil sh_gas sh_pln sh_nonpln ///
          owngen_pct_elec biodiesel_pct pct_biomass_user
    drop year mix_coal mix_oil mix_gas mix_pln mix_nonpln gj_owngen gj_biodiesel
    if "`lev'" == "java" list if period == "pool", clean noobs
    export excel using "$B210_XLSX", sheet("t09_mix_`lev'", replace) firstrow(variables)
}
