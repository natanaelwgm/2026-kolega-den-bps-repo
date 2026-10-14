/*==========================================================================
  Line 7: "Export or not, import or not"
  Data  : SI 2010-2022 (data/b15_si.dta), clean == 1
  Output sheets:
    t07_trade_rate_java           share exporting and share importing by Java vs outside Java (mean x 100 = %)
    t07_trade_profile_share_java  % of firm-years per trade profile by Java vs outside Java
    t07_import_value_java         imports (level & ln), imports / materials (%) by Java vs outside Java
    t07_export_share_java         export share of output (%) by Java vs outside Java
    t07_trade_rate_prov           share exporting and share importing by province (mean x 100 = %)
    t07_trade_profile_share_prov  % of firm-years per trade profile by province
    t07_import_value_prov         imports (level & ln), imports / materials (%) by province
    t07_export_share_prov         export share of output (%) by province

  NOTE: 2022 exporter is set missing (the form asks only about direct
  exports); importer reporting jumps between 2015 and 2017.
==========================================================================*/
if "$B15" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B15_DATA/b15_si.dta", clear
keep if clean == 1
do "$B15/_sumstats.do" "exporter importer" "java" "t07_trade_rate_java"
do "$B15/_shares.do" "trade_profile" "java" "t07_trade_profile_share_java"
do "$B15/_sumstats.do" "import_val ln_import_val import_share_mat" "java" "t07_import_value_java"
do "$B15/_sumstats.do" "export_share" "java" "t07_export_share_java"
do "$B15/_sumstats.do" "exporter importer" "prov" "t07_trade_rate_prov"
do "$B15/_shares.do" "trade_profile" "prov" "t07_trade_profile_share_prov"
do "$B15/_sumstats.do" "import_val ln_import_val import_share_mat" "prov" "t07_import_value_prov"
do "$B15/_sumstats.do" "export_share" "prov" "t07_export_share_prov"
