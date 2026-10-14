/*==========================================================================
  Line 6: "Do import or not"
  Data  : SI 2010-2022 (data/b07_si.dta), clean == 1
  Output sheets:
    t06_importer_rate  share importing, all firms (mean x 100 = %)
    t06_import_value   imports (level & ln), imports / materials (%), all firms

  NOTE: Importer reporting jumps between 2015 and 2017 (questionnaire change,
  not a trend).
==========================================================================*/
if "$B07" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B07_DATA/b07_si.dta", clear
keep if clean == 1
do "$B07/_sumstats.do" "importer" "" "t06_importer_rate"
do "$B07/_sumstats.do" "import_val ln_import_val import_share_mat" "" "t06_import_value"
