/*==========================================================================
  Line 10: "RnD"
  Data  : SI 2010-2022 (data/b14_si.dta), clean == 1
  Output sheets:
    t10_rnd_rate  share doing R&D by KBLI 2-digit sector (mean x 100 = %), 2017-2022

  NOTE: R&D is used for 2017-2022 only (as b1-17); many records leave the
  question blank.
==========================================================================*/
if "$B14" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B14_DATA/b14_si.dta", clear
keep if clean == 1
do "$B14/_sumstats.do" "rnd" "kbli2" "t10_rnd_rate"
