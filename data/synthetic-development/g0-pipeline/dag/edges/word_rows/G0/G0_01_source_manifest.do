* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* Validate each pinned source; hashes and full schema are inspected by prepare_g0.py.
use "$G0INPUT/sample_mfg2010_raw.dta", clear
isid source_year source_row
assert source_year==2010
assert _N==100
use "$G0INPUT/sample_mfg2011_raw.dta", clear
isid source_year source_row
assert source_year==2011
assert _N==100
use "$G0INPUT/sample_mfg2012_raw.dta", clear
isid source_year source_row
assert source_year==2012
assert _N==100
use "$G0INPUT/sample_mfg2013_raw.dta", clear
isid source_year source_row
assert source_year==2013
assert _N==100
use "$G0INPUT/sample_mfg2014_raw.dta", clear
isid source_year source_row
assert source_year==2014
assert _N==100
use "$G0INPUT/sample_mfg2015_raw.dta", clear
isid source_year source_row
assert source_year==2015
assert _N==100
use "$G0INPUT/sample_mfg2017_raw.dta", clear
isid source_year source_row
assert source_year==2017
assert _N==100
use "$G0INPUT/sample_mfg2018_raw.dta", clear
isid source_year source_row
assert source_year==2018
assert _N==100
use "$G0INPUT/sample_mfg2019_raw.dta", clear
isid source_year source_row
assert source_year==2019
assert _N==100
use "$G0INPUT/sample_mfg2020_raw.dta", clear
isid source_year source_row
assert source_year==2020
assert _N==100
use "$G0INPUT/sample_mfg2021_raw.dta", clear
isid source_year source_row
assert source_year==2021
assert _N==100
use "$G0INPUT/sample_mfg2022_raw.dta", clear
isid source_year source_row
assert source_year==2022
assert _N==100
