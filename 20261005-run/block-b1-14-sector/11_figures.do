/*==========================================================================
  Line 11: "Elaborate bs dengan output stats/stylish facts dalam bentuk
           table atau dengan graph, atau table yg ready untuk dibuat graph"
  Every other file writes its tables to output/b1_14_tables.xlsx. This
  file draws the charts FROM those tables (helper _charts.do), so a chart
  always matches its table. The exact points of every chart, and the label
  printed next to each point, are written to a sheet figNN_data.
  Runs LAST in 00_run.do.

  Charts (output/):
    fig01_group_share.png  % of firm-years per KBLI 2-digit sector (pooled)
    fig02_tfp.png          TFP (Levinsohn-Petrin) per KBLI 2-digit sector (pooled)
    fig03_va_pw.png        Value added per worker per KBLI 2-digit sector (pooled)
    fig07_energy.png       Energy use (median) per KBLI 2-digit sector (pooled)
    fig08_emissions.png    CO2 emissions (median) per KBLI 2-digit sector (pooled)

  Chart rules (repo consensus): see _charts.do.
==========================================================================*/
if "$B14" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

global FIG_XLSX "$B14_XLSX"
global FIG_OUT  "$B14_OUT"
do "$B14/_charts.do"


* ---- fig01: % of firm-years per KBLI 2-digit sector (pooled) ----
ch_shares, sheet(t01_group_share) prefix("KBLI ") title("Firm-years by KBLI 2-digit sector (pooled)") ///
    note("Notes: codes as reported; no bridge between classification versions." "$FIG_SRC") ///
    outsheet(fig01_data) file(fig01_group_share)


* ---- fig02: TFP (Levinsohn-Petrin) per KBLI 2-digit sector (pooled) ----
ch_dots, sheet(t02_tfp) var(tfp_lp) stat(mean) fmt(%4.2f) minn(100) prefix("KBLI ") ///
    xtitle("Mean TFP (LP, log); axis does not start at zero") legend("Pooled mean") title("TFP (Levinsohn-Petrin) by KBLI 2-digit sector (pooled)") ///
    note("Notes: groups with 100+ firm-years." "block 0 nominal development residual (LP, own sample) on fictional firm links; not real TFP." "$FIG_SRC") ///
    outsheet(fig02_data) file(fig02_tfp)


* ---- fig03: Value added per worker per KBLI 2-digit sector (pooled) ----
ch_dots, sheet(t03_va_output_capital) var(ln_va_pw) stat(mean) fmt(%4.2f) minn(100) prefix("KBLI ") ///
    xtitle("Mean ln(VA per worker); axis does not start at zero") legend("Pooled mean") title("Value added per worker by KBLI 2-digit sector (pooled)") ///
    note("Notes: groups with 100+ firm-years." "mean of ln(nominal value added per worker); values are masked and not deflated." "$FIG_SRC") ///
    outsheet(fig03_data) file(fig03_va_pw)


* ---- fig07: Energy use (median) per KBLI 2-digit sector (pooled) ----
ch_dots, sheet(t07_energy) var(gj_total) stat(p50) fmt(%9.0fc) minn(100) prefix("KBLI ") ///
    xtitle("Median GJ per firm-year") legend("Pooled median") title("Energy use (median) by KBLI 2-digit sector (pooled)") ///
    note("Notes: groups with 100+ firm-years." "scope 1 fuels (diesel, petrol, coal, LPG) + purchased electricity; energy reporting changes between 2015 and 2017." "$FIG_SRC") ///
    outsheet(fig07_data) file(fig07_energy)


* ---- fig08: CO2 emissions (median) per KBLI 2-digit sector (pooled) ----
ch_dots, sheet(t08_emissions) var(co2_total) stat(p50) fmt(%9.1f) minn(100) prefix("KBLI ") ///
    xtitle("Median tonnes CO2 per firm-year") legend("Pooled median") title("CO2 emissions (median) by KBLI 2-digit sector (pooled)") ///
    note("Notes: groups with 100+ firm-years." "scope 1 (4 fuels) + scope 2 (purchased electricity, 2014 grid factor carried forward after 2014)." "$FIG_SRC") ///
    outsheet(fig08_data) file(fig08_emissions)


graph drop _all
display as result "Figures written to $FIG_OUT"
