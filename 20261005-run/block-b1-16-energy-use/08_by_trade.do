/*==========================================================================
  Line 8: "Export or not, import or not"
  Data  : SI 2010-2022 (data/b16_si.dta), clean == 1
  Output sheets:
    t08_by_exporter  GJ scope 1 / 2 / total (level & ln), GJ per VA and per worker, exporter vs non-exporter
    t08_by_importer  the same, importer vs non-importer
    t08_by_trade     the same, by trade profile (none / export only / import only / both)

  NOTE: 2022 exporter is set missing (the form asks only about direct
  exports); importer reporting jumps between 2015 and 2017.
==========================================================================*/
if "$B16" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B16_DATA/b16_si.dta", clear
keep if clean == 1
local ENERGY "gj_s1 gj_s2 gj_total ln_gj_s1 ln_gj_s2 ln_gj_total gj_per_va gj_pw"
do "$B16/_sumstats.do" "`ENERGY'" "exporter" "t08_by_exporter"
do "$B16/_sumstats.do" "`ENERGY'" "importer" "t08_by_importer"
do "$B16/_sumstats.do" "`ENERGY'" "trade_profile" "t08_by_trade"
