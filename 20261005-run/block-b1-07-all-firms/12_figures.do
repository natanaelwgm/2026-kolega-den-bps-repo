/*==========================================================================
  Line 12: "Elaborate bs dengan output stats/stylish facts dalam bentuk
           table atau dengan graph, atau table yg ready untuk dibuat graph"
  Every other file writes its tables to output/b1_07_tables.xlsx. This
  file draws the charts FROM those tables (helper _charts.do), so a chart
  always matches its table. The exact points of every chart, and the label
  printed next to each point, are written to a sheet figNN_data.
  Runs LAST in 00_run.do.

  Charts (output/):
    fig01a_records_per_year.png  firm-years per survey year
    fig01b_participation.png     % exporting, importing, FDI by year
    fig02_tfp.png                mean TFP by year, 4 methods
    fig03_va_pw.png              mean ln(VA per worker) by year
    fig07_kbli2_share.png        % of firm-years per KBLI 2-digit (pooled)
    fig08_energy.png             median energy use by year
    fig09_emissions.png          median CO2 by year
    fig10_prov_share.png         % of firm-years per province (pooled)

  Chart rules (repo consensus): see _charts.do.
==========================================================================*/
if "$B07" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

global FIG_XLSX "$B07_XLSX"
global FIG_OUT  "$B07_OUT"
do "$B07/_charts.do"


* ---- fig01a: firm-years per survey year ----
ch_counts, sheet(t04_workers) var(workers) title("Firm-years per survey year") ///
    note("Notes: excludes the 30 energy-outlier records (clean = 0). There is no 2016 survey file." "$FIG_SRC") ///
    outsheet(fig01a_data) file(fig01a_records_per_year)


* ---- fig01b: % exporting, importing, FDI by year ----
ch_wide, sheet(t01_profile) key(variable) stat(mean) scale(100) ///
    filter(inlist(variable, "exporter", "importer", "fdi"))
ch_lines `wide', labels("Exporting" "Importing" "FDI (foreign share >=10%)") fmt(%4.1f) ///
    ytitle("% of firm-years") title("Exporting, importing and foreign-owned firms") ///
    note("Notes: % of firm-years with a known answer. Exporter 2022 and FDI 2020 are set missing (see 01a)." ///
         "Importer reporting jumps between 2015 and 2017 (questionnaire change)." "$FIG_SRC") ///
    sheet(fig01b_data) file(fig01b_participation)


* ---- fig02: mean TFP by year, 4 methods ----
ch_wide, sheet(t02_tfp) key(variable) stat(mean)
ch_lines `wide', labels("OP" "LP" "ACF" "WRDG") fmt(%4.2f) ///
    ytitle("Mean TFP (log)") title("TFP by method, all firms") ///
    note("Notes: block 0 nominal development residuals on fictional firm links; not real TFP." ///
         "The four methods are on different scales; OP has only 672 firm-years." "$FIG_SRC") ///
    sheet(fig02_data) file(fig02_tfp)


* ---- fig03: mean ln(VA per worker) by year ----
ch_wide, sheet(t03_va_output_capital) key(group) stat(mean) var(ln_va_pw)
ch_lines `wide', labels("All firms") fmt(%4.2f) ///
    ytitle("Mean ln(VA per worker)") title("Value added per worker, all firms") ///
    note("Notes: mean of ln(nominal value added per worker); values are masked and not deflated." "$FIG_SRC") sheet(fig03_data) file(fig03_va_pw)


* ---- fig07: % of firm-years per KBLI 2-digit (pooled) ----
ch_shares, sheet(t07_kbli2_share) prefix("KBLI ") title("Firm-years by KBLI 2-digit sector (pooled)") ///
    note("Notes: codes as reported; no bridge between classification versions." "$FIG_SRC") ///
    outsheet(fig07_data) file(fig07_kbli2_share)


* ---- fig08: median energy use by year ----
ch_wide, sheet(t08_energy) key(group) stat(p50) var(gj_total)
ch_lines `wide', labels("Median GJ per firm-year") fmt(%9.0fc) ///
    ytitle("GJ") title("Energy use per firm-year (median)") ///
    note("Notes: scope 1 fuels (diesel, petrol, coal, LPG) + purchased electricity; energy reporting changes between 2015 and 2017." "$FIG_SRC") sheet(fig08_data) file(fig08_energy)


* ---- fig09: median CO2 by year ----
ch_wide, sheet(t09_emissions) key(group) stat(p50) var(co2_total)
ch_lines `wide', labels("Median tonnes CO2 per firm-year") fmt(%9.1f) ///
    ytitle("Tonnes CO2") title("CO2 emissions per firm-year (median)") ///
    note("Notes: scope 1 (4 fuels) + scope 2 (purchased electricity, 2014 grid factor carried forward after 2014)." "$FIG_SRC") sheet(fig09_data) file(fig09_emissions)


* ---- fig10: % of firm-years per province (pooled) ----
ch_shares, sheet(t10_prov_share) title("Firm-years by province (pooled)") ///
    note("Notes: province as reported; district is blank in block 0." "$FIG_SRC") ///
    outsheet(fig10_data) file(fig10_prov_share)


graph drop _all
display as result "Figures written to $FIG_OUT"
