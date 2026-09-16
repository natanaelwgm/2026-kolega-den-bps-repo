version 17
args mode
if !inlist("`mode'","actual","development") error 198
if "$DS_ROOT"=="" | "$DS_RUN"=="" {
 display as error "Run downstream/00_MASTER.do or the Downloads launcher for setup."
 exit 198
}
do "$DS_ROOT/downstream/code/fields_`mode'.do"
local input "$DS_ACTUAL"
if "`mode'"=="development" local input "$DS_G1"
confirm file "`input'"
noisily display as result "INPUT | `mode' | `input'"
use $DS_FIELDS using "`input'", clear
generate long _source_order=_n
assert _N==33049
assert inlist(source_year,2010,2011,2012,2013,2014,2015,2017,2018,2019,2020,2021,2022)
if "`mode'"=="actual" isid source_year source_row
else isid obs_id source_year
noisily display as result "PROJECTED | `mode' | rows=" _N " | variables=" c(k)
