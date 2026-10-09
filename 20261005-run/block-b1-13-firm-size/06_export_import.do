/*==========================================================================
  Line 6: "Export or not, import or not"
  Data  : SI 2010-2022 (data/b13_si.dta), clean == 1
  Output sheets:
    t06_trade_rate           share exporting and share importing by medium (<=100 workers) vs large (>100 workers) (mean x 100 = %)
    t06_trade_profile_share  % of firm-years per trade profile by medium (<=100 workers) vs large (>100 workers)
    t06_import_value         imports (level & ln), imports / materials (%) by medium (<=100 workers) vs large (>100 workers)
    t06_export_share         export share of output (%) by medium (<=100 workers) vs large (>100 workers)

  NOTE: 2022 exporter is set missing (the form asks only about direct
  exports); importer reporting jumps between 2015 and 2017.
==========================================================================*/
if "$B13" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B13_DATA/b13_si.dta", clear
keep if clean == 1
do "$B13/_sumstats.do" "exporter importer" "large" "t06_trade_rate"
do "$B13/_shares.do" "trade_profile" "large" "t06_trade_profile_share"
do "$B13/_sumstats.do" "import_val ln_import_val import_share_mat" "large" "t06_import_value"
do "$B13/_sumstats.do" "export_share" "large" "t06_export_share"
