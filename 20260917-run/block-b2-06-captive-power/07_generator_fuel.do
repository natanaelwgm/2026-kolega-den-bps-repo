/*==========================================================================
  Line 7: "fuel yg digunakan untuk generator"
  Data  : SI 2010-2022 (data/b206_si.dta), clean == 1
  Output sheets (only when the variables exist):
    t07_genfuel_use   by year + pool, OWN-GENERATORS ONLY: % using each fuel
                      in their generator
  STATUS: NOT ANSWERABLE YET. Block 0 has no generator-fuel quantities.
  The raw SI records fuel used for electricity generation in every wave
  (raw_esolie* / raw_esdlie* diesel litres, raw_eclkge* coal kg,
  raw_elpkge* LPG kg, raw_engkge* natural gas 2022). Expected names in
  block 0:
     gen_diesel_ltr gen_petrol_ltr gen_coal_kg gen_lpg_kg gen_natgas_m3
  Today the generator's fuel is inside the firm's total fuel (scope 1) and
  cannot be split out.
==========================================================================*/
if "$B206" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B206_DATA/b206_si.dta", clear
keep if clean == 1

capture confirm variable gen_diesel_ltr gen_petrol_ltr gen_coal_kg gen_lpg_kg gen_natgas_m3
if _rc {
    display as error "Line 7 not answered: generator-fuel variables are not in block 0."
    display as error "  Needed: gen_diesel_ltr gen_petrol_ltr gen_coal_kg gen_lpg_kg gen_natgas_m3"
    display as error "  Source: raw SI fuel-for-electricity columns (raw_e*lie*, raw_e*kge*). No table written."
    exit
}

keep if has_owngen == 1
foreach f in diesel_ltr petrol_ltr coal_kg lpg_kg natgas_m3 {
    generate uses_`f' = (gen_`f' > 0 & !missing(gen_`f'))
}
generate n_owngen = 1
expand 2, generate(copy)
replace year = 0 if copy == 1
collapse (sum) n_owngen (mean) pct_diesel = uses_diesel_ltr pct_petrol = uses_petrol_ltr ///
         pct_coal = uses_coal_kg pct_lpg = uses_lpg_kg pct_natgas = uses_natgas_m3, by(year)
foreach v in pct_diesel pct_petrol pct_coal pct_lpg pct_natgas {
    replace `v' = 100 * `v'
}
generate period = cond(year == 0, "pool", string(year))
order period n_owngen
drop year
list, clean noobs
export excel using "$B206_XLSX", sheet("t07_genfuel_use", replace) firstrow(variables)
