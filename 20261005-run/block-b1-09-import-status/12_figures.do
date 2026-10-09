/*==========================================================================
  Line 12: "Elaborate bs dengan output stats/stylish facts dalam bentuk
           table atau dengan graph, atau table yg ready untuk dibuat graph"
  Every other file writes its tables to output/b1_09_tables.xlsx. This
  file draws the charts FROM those tables (helper _charts.do), so a chart
  always matches its table. The exact points of every chart, and the label
  printed next to each point, are written to a sheet figNN_data.
  Runs LAST in 00_run.do.

  Charts (output/):
    fig01a_group_share.png  % of firm-years per group, by year
    fig01b_profile.png      who the groups are (pooled)
    fig02_tfp.png           TFP (Levinsohn-Petrin) by group and year
    fig03_va_pw.png         Value added per worker by group and year
    fig08_energy.png        Energy use per firm-year (median) by group and year
    fig09_emissions.png     CO2 per firm-year (median) by group and year

  Chart rules (repo consensus): see _charts.do.
==========================================================================*/
if "$B09" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

global FIG_XLSX "$B09_XLSX"
global FIG_OUT  "$B09_OUT"
do "$B09/_charts.do"


* ---- fig01a: % of firm-years per group, by year ----
ch_wide, sheet(t01_group_share) key(category) stat(pct_firms)
ch_lines `wide', labels(`glabels') fmt(%4.1f) ///
    ytitle("% of firm-years") title("Firm-years by group: importer vs non-importer") ///
    note("Notes: % of firm-years with a known group in each year." "$FIG_SRC") ///
    sheet(fig01a_data) file(fig01a_group_share)


* ---- fig01b: who the groups are (pooled) ----
ch_profile, sheet(t01_profile) title("Group profile: importer vs non-importer (pooled)") ///
    note("Notes: % of firm-years in each group." "Exporter excludes 2022, FDI excludes 2020, R&D is 2017-2022." "$FIG_SRC") ///
    outsheet(fig01b_data) file(fig01b_profile)


* ---- fig02: TFP (Levinsohn-Petrin) by group and year ----
ch_wide, sheet(t02_tfp) key(group) stat(mean) var(tfp_lp)
ch_lines `wide', labels(`glabels') fmt(%4.2f) ///
    ytitle("Mean TFP (LP, log)") title("TFP (Levinsohn-Petrin): importer vs non-importer") ///
    note("Notes: block 0 nominal development residual (LP, own sample) on fictional firm links; not real TFP." "$FIG_SRC") ///
    sheet(fig02_data) file(fig02_tfp)


* ---- fig03: Value added per worker by group and year ----
ch_wide, sheet(t03_va_output_capital) key(group) stat(mean) var(ln_va_pw)
ch_lines `wide', labels(`glabels') fmt(%4.2f) ///
    ytitle("Mean ln(VA per worker)") title("Value added per worker: importer vs non-importer") ///
    note("Notes: mean of ln(nominal value added per worker); values are masked and not deflated." "$FIG_SRC") ///
    sheet(fig03_data) file(fig03_va_pw)


* ---- fig08: Energy use per firm-year (median) by group and year ----
ch_wide, sheet(t08_energy) key(group) stat(p50) var(gj_total)
ch_lines `wide', labels(`glabels') fmt(%9.0fc) ///
    ytitle("Median GJ") title("Energy use per firm-year (median): importer vs non-importer") ///
    note("Notes: scope 1 fuels (diesel, petrol, coal, LPG) + purchased electricity; energy reporting changes between 2015 and 2017." "$FIG_SRC") ///
    sheet(fig08_data) file(fig08_energy)


* ---- fig09: CO2 per firm-year (median) by group and year ----
ch_wide, sheet(t09_emissions) key(group) stat(p50) var(co2_total)
ch_lines `wide', labels(`glabels') fmt(%9.1f) ///
    ytitle("Median tonnes CO2") title("CO2 per firm-year (median): importer vs non-importer") ///
    note("Notes: scope 1 (4 fuels) + scope 2 (purchased electricity, 2014 grid factor carried forward after 2014)." "$FIG_SRC") ///
    sheet(fig09_data) file(fig09_emissions)


graph drop _all
display as result "Figures written to $FIG_OUT"
