version 17
* Use the same module body after this input boundary in both environments.
* First export through harness/data_source.py so the input has a checked label.
* do harness/g05/use_data.do development /local/path/G0_input.dta
* do harness/g05/use_data.do actual /local/path/G0_input_actual.dta
args mode input_path
if "`mode'" == "" local mode "development"
if !inlist("`mode'", "development", "actual") {
    display as error "Mode must be development or actual"
    exit 198
}
if "`input_path'" == "" {
    display as error "Explicit adapter-exported DTA path required; no original-data fallback"
    exit 198
}
use "`input_path'", clear
local input_label : data label
if "`mode'" == "development" & "`input_label'" != "DEASY G0.5 DEVELOPMENT" {
    display as error "Development mode requires the labelled G0.5 export"
    exit 459
}
if "`mode'" == "actual" & "`input_label'" != "DEASY G0 ACTUAL" {
    display as error "Actual mode requires the labelled local actual export"
    exit 459
}
char _dta[deasy_data_mode] "`mode'"
display as text "DEASY INPUT MODE: `mode' -- retain this label in all logs and outputs"
