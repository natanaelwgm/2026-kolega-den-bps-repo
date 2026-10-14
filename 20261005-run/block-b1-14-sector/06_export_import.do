/*==========================================================================
  Line 6: "Export or not, import or not"
  Data  : SI 2010-2022 (data/b14_si.dta), clean == 1
  Output sheets:
    t06_trade_rate           share exporting and share importing by KBLI 2-digit sector (mean x 100 = %)
    t06_trade_profile_share  % of firm-years per trade profile by KBLI 2-digit sector
    t06_import_value         imports (level & ln), imports / materials (%) by KBLI 2-digit sector
    t06_export_share         export share of output (%) by KBLI 2-digit sector

  NOTE: 2022 exporter is set missing (the form asks only about direct
  exports); importer reporting jumps between 2015 and 2017.
==========================================================================*/
if "$B14" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B14_DATA/b14_si.dta", clear
keep if clean == 1
do "$B14/_sumstats.do" "exporter importer" "kbli2" "t06_trade_rate"
do "$B14/_shares.do" "trade_profile" "kbli2" "t06_trade_profile_share"
do "$B14/_sumstats.do" "import_val ln_import_val import_share_mat" "kbli2" "t06_import_value"
do "$B14/_sumstats.do" "export_share" "kbli2" "t06_export_share"
