/*==========================================================================
  Line 11: "Elaborate bs dengan output stats/stylish facts dalam bentuk
           table atau dengan graph, atau table yg ready untuk dibuat graph"
  Every other file writes its tables to output/b1_15_tables.xlsx. This
  file draws the charts FROM those tables (helper _charts.do), so a chart
  always matches its table. The exact points of every chart, and the label
  printed next to each point, are written to a sheet figNN_data.
  Runs LAST in 00_run.do.

  Charts (output/):
    fig01a_group_share_java.png  % of firm-years per group, by year
    fig01b_profile_java.png      who the groups are (pooled)
    fig03_tfp_java.png           TFP (Levinsohn-Petrin) by group and year
    fig04_va_pw_java.png         Value added per worker by group and year
    fig08_energy_java.png        Energy use per firm-year (median) by group and year
    fig09_emissions_java.png     CO2 per firm-year (median) by group and year
    fig01_group_share_prov.png   % of firm-years per province (pooled)
    fig03_tfp_prov.png           TFP (Levinsohn-Petrin) per province (pooled)
    fig04_va_pw_prov.png         Value added per worker per province (pooled)
    fig08_energy_prov.png        Energy use (median) per province (pooled)
    fig09_emissions_prov.png     CO2 emissions (median) per province (pooled)

  Chart rules (repo consensus): see _charts.do.
==========================================================================*/
if "$B15" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

global FIG_XLSX "$B15_XLSX"
global FIG_OUT  "$B15_OUT"
do "$B15/_charts.do"


* ---- fig01a: % of firm-years per group, by year ----
ch_wide, sheet(t01_group_share_java) key(category) stat(pct_firms)
ch_lines `wide', labels(`glabels') fmt(%4.1f) ///
    ytitle("% of firm-years") title("Firm-years by group: Java vs outside Java") ///
    note("Notes: % of firm-years with a known group in each year." "$FIG_SRC") ///
    sheet(fig01a_data_java) file(fig01a_group_share_java)


* ---- fig01b: who the groups are (pooled) ----
ch_profile, sheet(t01_profile_java) title("Group profile: Java vs outside Java (pooled)") ///
    note("Notes: % of firm-years in each group." "Exporter excludes 2022, FDI excludes 2020, R&D is 2017-2022." "$FIG_SRC") ///
    outsheet(fig01b_data_java) file(fig01b_profile_java)


* ---- fig03: TFP (Levinsohn-Petrin) by group and year ----
ch_wide, sheet(t03_tfp_java) key(group) stat(mean) var(tfp_lp)
ch_lines `wide', labels(`glabels') fmt(%4.2f) ///
    ytitle("Mean TFP (LP, log)") title("TFP (Levinsohn-Petrin): Java vs outside Java") ///
    note("Notes: block 0 nominal development residual (LP, own sample) on fictional firm links; not real TFP." "$FIG_SRC") ///
    sheet(fig03_data_java) file(fig03_tfp_java)


* ---- fig04: Value added per worker by group and year ----
ch_wide, sheet(t04_va_output_capital_java) key(group) stat(mean) var(ln_va_pw)
ch_lines `wide', labels(`glabels') fmt(%4.2f) ///
    ytitle("Mean ln(VA per worker)") title("Value added per worker: Java vs outside Java") ///
    note("Notes: mean of ln(nominal value added per worker); values are masked and not deflated." "$FIG_SRC") ///
    sheet(fig04_data_java) file(fig04_va_pw_java)


* ---- fig08: Energy use per firm-year (median) by group and year ----
ch_wide, sheet(t08_energy_java) key(group) stat(p50) var(gj_total)
ch_lines `wide', labels(`glabels') fmt(%9.0fc) ///
    ytitle("Median GJ") title("Energy use per firm-year (median): Java vs outside Java") ///
    note("Notes: scope 1 fuels (diesel, petrol, coal, LPG) + purchased electricity; energy reporting changes between 2015 and 2017." "$FIG_SRC") ///
    sheet(fig08_data_java) file(fig08_energy_java)


* ---- fig09: CO2 per firm-year (median) by group and year ----
ch_wide, sheet(t09_emissions_java) key(group) stat(p50) var(co2_total)
ch_lines `wide', labels(`glabels') fmt(%9.1f) ///
    ytitle("Median tonnes CO2") title("CO2 per firm-year (median): Java vs outside Java") ///
    note("Notes: scope 1 (4 fuels) + scope 2 (purchased electricity, 2014 grid factor carried forward after 2014)." "$FIG_SRC") ///
    sheet(fig09_data_java) file(fig09_emissions_java)


* ---- fig01: % of firm-years per province (pooled) ----
ch_shares, sheet(t01_group_share_prov) prefix("") title("Firm-years by province (pooled)") ///
    note("Notes: province as reported; district is blank in block 0." "$FIG_SRC") ///
    outsheet(fig01_data_prov) file(fig01_group_share_prov)


* ---- fig03: TFP (Levinsohn-Petrin) per province (pooled) ----
ch_dots, sheet(t03_tfp_prov) var(tfp_lp) stat(mean) fmt(%4.2f) minn(100) prefix("") ///
    xtitle("Mean TFP (LP, log); axis does not start at zero") legend("Pooled mean") title("TFP (Levinsohn-Petrin) by province (pooled)") ///
    note("Notes: groups with 100+ firm-years." "block 0 nominal development residual (LP, own sample) on fictional firm links; not real TFP." "$FIG_SRC") ///
    outsheet(fig03_data_prov) file(fig03_tfp_prov)


* ---- fig04: Value added per worker per province (pooled) ----
ch_dots, sheet(t04_va_output_capital_prov) var(ln_va_pw) stat(mean) fmt(%4.2f) minn(100) prefix("") ///
    xtitle("Mean ln(VA per worker); axis does not start at zero") legend("Pooled mean") title("Value added per worker by province (pooled)") ///
    note("Notes: groups with 100+ firm-years." "mean of ln(nominal value added per worker); values are masked and not deflated." "$FIG_SRC") ///
    outsheet(fig04_data_prov) file(fig04_va_pw_prov)


* ---- fig08: Energy use (median) per province (pooled) ----
ch_dots, sheet(t08_energy_prov) var(gj_total) stat(p50) fmt(%9.0fc) minn(100) prefix("") ///
    xtitle("Median GJ per firm-year") legend("Pooled median") title("Energy use (median) by province (pooled)") ///
    note("Notes: groups with 100+ firm-years." "scope 1 fuels (diesel, petrol, coal, LPG) + purchased electricity; energy reporting changes between 2015 and 2017." "$FIG_SRC") ///
    outsheet(fig08_data_prov) file(fig08_energy_prov)


* ---- fig09: CO2 emissions (median) per province (pooled) ----
ch_dots, sheet(t09_emissions_prov) var(co2_total) stat(p50) fmt(%9.1f) minn(100) prefix("") ///
    xtitle("Median tonnes CO2 per firm-year") legend("Pooled median") title("CO2 emissions (median) by province (pooled)") ///
    note("Notes: groups with 100+ firm-years." "scope 1 (4 fuels) + scope 2 (purchased electricity, 2014 grid factor carried forward after 2014)." "$FIG_SRC") ///
    outsheet(fig09_data_prov) file(fig09_emissions_prov)


graph drop _all
display as result "Figures written to $FIG_OUT"
