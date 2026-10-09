/*==========================================================================
  Line 4: "besarnya generation capacity"
  Data  : SI 2010-2022 (data/b206_si.dta), clean == 1
  Output sheets (only when the variables exist):
    t04_capacity_stats  genset_kw, ln_genset_kw, genset_n among firms with a
                        generator (genset_kw > 0), pool + by year
    t04_capacity_owngen same, by own-generation status
  STATUS: NOT ANSWERABLE YET. Block 0 does not carry generator capacity.
  The raw SI asks it in every year (generator kW and number of generators,
  raw variable mgekwu).
  Add genset_kw / genset_n to block 0 and this file runs as written.
  NOTE: capacity is blank for ~half the firms in
  2018-2021; rates must use firms with a non-missing value as denominator.
==========================================================================*/
if "$B206" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B206_DATA/b206_si.dta", clear
keep if clean == 1

capture confirm variable genset_kw genset_n
if _rc {
    display as error "Line 4 not answered: genset_kw and/or genset_n are not in block 0."
    display as error "  Needed: generator capacity (kW) and number of generators per firm-year."
    display as error "  Source: raw SI generator block (mgekwu), asked 2010-2022. No table written."
    exit
}

keep if genset_kw > 0 & !missing(genset_kw)
generate ln_genset_kw = ln(genset_kw)
do "$B206/_sumstats.do" "genset_kw ln_genset_kw genset_n" "" "t04_capacity_stats"
do "$B206/_sumstats.do" "genset_kw ln_genset_kw genset_n" "has_owngen" "t04_capacity_owngen"
