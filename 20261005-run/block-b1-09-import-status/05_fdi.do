/*==========================================================================
  Line 5: "FDI or not"
  Data  : SI 2010-2022 (data/b09_si.dta), clean == 1
  Output sheets:
    t05_fdi_rate       share FDI (>=10%) and any foreign share (>0%) by importer vs non-importer (mean x 100 = %)
    t05_foreign_share  foreign ownership (%) by importer vs non-importer

  NOTE: 2020 FDI is set missing (47% FDI in that year is not credible), so
  2020 is not in these tables.
==========================================================================*/
if "$B09" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B09_DATA/b09_si.dta", clear
keep if clean == 1
do "$B09/_sumstats.do" "fdi fdi_any" "importer" "t05_fdi_rate"
do "$B09/_sumstats.do" "foreign_share" "importer" "t05_foreign_share"
