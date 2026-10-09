/*==========================================================================
  Line 8: "Export or not, import or not"
  Data  : SI 2010-2022 (data/b17_si.dta), clean == 1
  Output sheets:
    t08_by_exporter   CO2 scope 1 / 2 / total (level & ln), intensities,
                      exporter vs non-exporter, pool + by year
    t08_by_importer   the same, importer vs non-importer
    t08_by_trade      the same, 4 groups: neither / export only /
                      import only / both

  NOTE: 2022 export flag is set missing (the form only asks about direct
  exports). The importer rate jumps between 2015 and 2017 (questionnaire
  change, not a trend).
==========================================================================*/
if "$B17" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B17_DATA/b17_si.dta", clear
keep if clean == 1
generate trade = 1 if exporter == 0 & importer == 0
replace  trade = 2 if exporter == 1 & importer == 0
replace  trade = 3 if exporter == 0 & importer == 1
replace  trade = 4 if exporter == 1 & importer == 1
label define trade 1 "Neither" 2 "Export only" 3 "Import only" 4 "Export and import"
label values trade trade

local EMIS "co2_s1 co2_s2 co2_total ln_co2_s1 ln_co2_s2 ln_co2_total co2_per_va co2_pw"
do "$B17/_sumstats.do" "`EMIS'" "exporter" "t08_by_exporter"
do "$B17/_sumstats.do" "`EMIS'" "importer" "t08_by_importer"
do "$B17/_sumstats.do" "`EMIS'" "trade" "t08_by_trade"
