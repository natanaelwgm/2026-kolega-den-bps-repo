/*==========================================================================
  Line 6: "Do export or not"
  Data  : SI 2010-2022 (data/b09_si.dta), clean == 1
  Output sheets:
    t06_exporter_rate  share exporting by importer vs non-importer (mean x 100 = %)
    t06_export_share   export share of output (%) by importer vs non-importer

  NOTE: 2022 exporter is set missing (the form asks only about direct
  exports).
==========================================================================*/
if "$B09" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B09_DATA/b09_si.dta", clear
keep if clean == 1
do "$B09/_sumstats.do" "exporter" "importer" "t06_exporter_rate"
do "$B09/_sumstats.do" "export_share" "importer" "t06_export_share"
