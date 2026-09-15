log using "dag/logs/G0_adversarial_cases.log", text replace
clear
set obs 1002
generate int source_year=2010+(_n>501)
generate int source_row=mod(_n-1,501)+1
foreach v in gross_output_nominal value_added_nominal capital_stock_nominal capital_additions_nominal {
 generate double `v'=100
}
generate double workers=10
replace gross_output_nominal=1e9 if source_year==2010 & source_row==1
replace gross_output_nominal=-10 if source_row==2
replace workers=0 if source_row==3
replace workers=. if source_row==4
replace capital_stock_nominal=-2 if source_row==5
replace value_added_nominal=. if source_row==6
replace value_added_nominal=0 if source_row==7
do "dag/edges/G0_economic_clean_program.do"
g0_economic_clean
assert out_checked_output==1 & missing(clean_output_nominal,clean_output_per_worker) if source_year==2010 & source_row==1
assert out_checked_output==0 & clean_output_nominal==100 if source_year==2011 & source_row==1
assert out_checked_output==1 & missing(clean_output_nominal) if source_row==2
assert missing(clean_output_per_worker,clean_va_per_worker,clean_stock_per_worker) if inlist(source_row,3,4)
assert missing(clean_stock_nominal) & capital_stock_nominal==-2 if source_row==5
assert missing(clean_va_nominal) if source_row==6
assert clean_va_nominal==0 if source_row==7
assert _N==1002
* Ratio/domain and own-generation identity cases use physical components, not empirical firms.
clear
input double(fuel purchased own nominal idx)
10 5 20 200 250
. 5 20 200 0
0 0 30 0 .
end
generate double total=fuel+purchased
assert total==15 in 1
assert missing(total) in 2
assert total==0 in 3
generate double real_value=nominal/(idx/100) if idx>0 & !missing(idx,nominal)
assert real_value==80 in 1
assert missing(real_value) in 2/3
generate double logged=ln(real_value) if real_value>0 & !missing(real_value)
assert missing(logged) in 2/3
* Unique lookup gate must actively reject duplicates.
clear
input int(isic4 source_year) double(index)
1511 2010 200
1511 2010 210
end
capture isid isic4 source_year
assert _rc==459
display "G0_ADVERSARIAL_CASES_PASS tail_triggered_negative_zero_missing_year_isolation_duplicate_key"
log close
