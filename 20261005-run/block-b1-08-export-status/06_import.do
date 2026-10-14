/*==========================================================================
  Line 6: "Do import or not"
  Data  : SI 2010-2022 (data/b08_si.dta), clean == 1
  Output sheets:
    t06_importer_rate  share importing by exporter vs non-exporter (mean x 100 = %)
    t06_import_value   imports (level & ln), imports / materials (%) by exporter vs non-exporter

  NOTE: Importer reporting jumps between 2015 and 2017 (questionnaire change,
  not a trend).
==========================================================================*/
if "$B08" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B08_DATA/b08_si.dta", clear
keep if clean == 1
do "$B08/_sumstats.do" "importer" "exporter" "t06_importer_rate"
do "$B08/_sumstats.do" "import_val ln_import_val import_share_mat" "exporter" "t06_import_value"
