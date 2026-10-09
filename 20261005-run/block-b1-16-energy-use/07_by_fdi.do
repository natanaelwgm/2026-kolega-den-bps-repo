/*==========================================================================
  Line 7: "FDI or not"
  Data  : SI 2010-2022 (data/b16_si.dta), clean == 1
  Output sheets:
    t07_by_fdi  GJ scope 1 / 2 / total (level & ln), GJ per VA and per worker, FDI (>=10%) vs domestic

  NOTE: 2020 FDI is set missing (see 01a), so 2020 is not in this table.
==========================================================================*/
if "$B16" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B16_DATA/b16_si.dta", clear
keep if clean == 1
local ENERGY "gj_s1 gj_s2 gj_total ln_gj_s1 ln_gj_s2 ln_gj_total gj_per_va gj_pw"
do "$B16/_sumstats.do" "`ENERGY'" "fdi" "t07_by_fdi"
