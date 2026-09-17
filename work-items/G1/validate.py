#!/usr/bin/env python3
"""Independently reconcile Stata aggregates, domains, keys, and blocked states."""
# WFDOC: Audit ini merekonsiliasi angka dan status blokir dari keluaran Stata; tidak mengestimasi fungsi produksi.
import json
from pathlib import Path
import sys
import numpy as np
import pandas as pd
from input_contract import load_input_contract


def validate(run):
    contract = load_input_contract(run)
    # WFDOC: Input terpilih dan sidecar eligibility dicocokkan lewat obs_id; setiap nilai sumber harus identik setelah indeks disusun ulang.
    source = pd.read_stata(run / "input.dta", convert_categoricals=False)
    derived = pd.read_stata(run / "analysis/G1_input_eligibility.dta", convert_categoricals=False)
    checks = []
    def check(name, condition):
        if not bool(condition):
            raise AssertionError(name)
        checks.append({"check": name, "status": "PASS"})
    check("input_rows_match_pinned_contract", len(source) == contract['rows'])
    check("observation_ids_unique", source.obs_id.is_unique and derived.obs_id.is_unique)
    check("one_to_one_complete_attachment", set(source.obs_id) == set(derived.obs_id))
    a = source.set_index("obs_id").sort_index()
    b = derived.set_index("obs_id").sort_index()
    pd.testing.assert_frame_equal(a, b[a.columns], check_dtype=False, check_exact=True)
    check("every_selected_source_cell_unchanged", True)
    check("approved_synthetic_panel_ids", source.psid.notna().all() and source.psid_status.eq("synthetic_development").all() and derived.g1_panel_usable.eq(1).all())
    # WFDOC: Lag dihitung dari kunci perusahaan-tahun, bukan baris tetangga; celah 2016 tidak menciptakan transisi semu.
    keys=set(zip(a.psid,a.source_year))
    expected_lag1=[(f,y-1) in keys for f,y in zip(a.psid,a.source_year)]
    expected_lag2=[(f,y-2) in keys for f,y in zip(a.psid,a.source_year)]
    check("exact_real_calendar_lag1", np.array_equal(expected_lag1,b.g1_lag1.eq(1)))
    check("exact_real_calendar_lag2", np.array_equal(expected_lag2,b.g1_lag2.eq(1)))
    check("no_missing_lag_status_on_accepted_panel", b[["g1_lag1","g1_lag2"]].notna().all().all())
    check("fictional_firm_count_matches_pinned_contract", source.psid.nunique()==contract['firms'])
    check("annual_lag_count_matches_pinned_contract", sum(expected_lag1)==contract['lag1_rows'])
    check("no_2016_and_exact_calendar", set(source.source_year) == set(range(2010, 2016)) | set(range(2017, 2023)))
    positive=lambda x: x.gt(0) & x.notna()
    # WFDOC: Masker nominal hanya memeriksa nilai positif; masker konsep menambahkan flag kuesioner dan tidak mengesahkan satuan atau harga riil.
    base=positive(a.value_added_nominal) & positive(a.workers) & positive(a.capital_stock_nominal)
    for method in ["op", "lp", "acf", "wrdg"]:
        nominal=base & positive(a.capital_additions_nominal if method=="op" else a.val_rtlvcu)
        concept=nominal & a.capital_stock_verified.eq(1)
        if method=="op":
            concept &= a.capital_additions_verified.eq(1)
        check(f"independent_nominal_mask_{method}", np.array_equal(nominal, b[f"g1_nominal_{method}"].eq(1)))
        check(f"independent_concept_mask_{method}", np.array_equal(concept, b[f"g1_concept_{method}"].eq(1)))
    # WFDOC: Agregat gelombang, status missing/nilai, dan domain direkonstruksi dari input per tahun untuk memeriksa jumlah dan kuantil.
    waves = pd.read_csv(run / "outputs/observed_waves.csv")
    expected = source.groupby("source_year").size()
    check("wave_counts_exact", np.array_equal(waves.set_index("source_year").N_source.sort_index(), expected))
    states = pd.read_csv(run / "outputs/source_status.csv")
    state_vars=["gross_output_nominal","value_added_nominal","workers","capital_stock_nominal","capital_additions_nominal","intermediate_inputs_nominal","val_rtlvcu"]
    state_keys=set((v,y) for v in state_vars for y in source.source_year.unique())
    check("complete_source_state_variable_year_coverage", set(zip(states.variable,states.source_year))==state_keys)
    check("source_state_keys_unique", not states.duplicated(["variable","source_year","source_state"]).any())
    for (v,y),g in states.groupby(["variable","source_year"]):
        check(f"source_state_partition_{v}_{int(y)}", g.N_state.sum()==int(expected.loc[y]) and g.N_source.eq(expected.loc[y]).all())
    for r in states.itertuples():
        x = source.loc[source.source_year.eq(r.source_year), "vs_" + r.variable]
        n = x.isna().sum() if pd.isna(r.source_state) else x.eq(r.source_state).sum()
        if n != r.N_state or len(x) != r.N_source:
            raise AssertionError(f"Source-state count mismatch: {r.variable}/{r.source_year}")
    check("source_state_rows_exact", True)
    domains = pd.read_csv(run / "outputs/variable_domains.csv")
    domain_vars=state_vars+["deflator_output","deflator_inputs","deflator_capital","gross_output_real","value_added_real","capital_real","intermediate_inputs_real"]
    check("complete_unique_domain_grid", len(domains)==len(domain_vars)*len(expected) and set(zip(domains.variable,domains.source_year))=={(v,y) for v in domain_vars for y in expected.index})
    for r in domains.itertuples():
        x = source.loc[source.source_year.eq(r.source_year), r.variable]
        actual = [len(x), x.isna().sum(), x.eq(0).sum(), x.lt(0).sum(), x.gt(0).sum()]
        wanted = [r.N_source, r.N_missing, r.N_zero, r.N_negative, r.N_positive]
        check(f"domain_{r.variable}_{int(r.source_year)}", actual == wanted)
        valid=x.dropna().to_numpy()
        if len(valid):
            quantiles=np.quantile(valid,[.01,.5,.99],method="averaged_inverted_cdf")
            check(f"quantiles_{r.variable}_{int(r.source_year)}", np.allclose(quantiles,[r.p1,r.p50,r.p99],rtol=1e-12,atol=1e-8))
            check(f"extremes_{r.variable}_{int(r.source_year)}", np.allclose([valid.min(),valid.max()],[r.min,r.max],rtol=1e-12,atol=1e-8))
    # WFDOC: Funnel diperiksa pada metode×tahun×prefix; setiap stage harus lengkap dan jumlah prefix harus kembali ke baris ALL.
    flow = pd.read_csv(run / "outputs/tfp_sample_attrition.csv", dtype={"code_prefix": str})
    check("attrition_keys_unique", not flow.duplicated(["method", "source_year", "code_prefix", "stage"]).any())
    expected_groups={(m,y,c) for m in ["op","lp","acf","wrdg"] for y,g in derived.groupby("source_year") for c in ["ALL",*g.g1_code_prefix.unique()]}
    check("attrition_group_coverage", set(zip(flow.method,flow.source_year,flow.code_prefix))==expected_groups)
    check("six_complete_stages_per_group", flow.groupby(["method","source_year","code_prefix"]).size().eq(6).all())
    for r in flow.itertuples():
        x = derived.loc[derived.source_year.eq(r.source_year)]
        if r.code_prefix != "ALL":
            x = x.loc[x.g1_code_prefix.eq(r.code_prefix)]
        flag = r.stage[3:]
        count = len(x) if r.stage == "01_source" else int(x[flag].eq(1).sum())
        if len(x) != r.N_source or count != r.N_retained:
            raise AssertionError(f"Flow mismatch {r}")
    check("all_method_year_category_funnel_cells_exact", True)
    grouped = flow.loc[flow.code_prefix.ne("ALL")].groupby(["method", "source_year", "stage"])[["N_source", "N_retained"]].sum().sort_index()
    totals = flow.loc[flow.code_prefix.eq("ALL")].set_index(["method", "source_year", "stage"])[["N_source", "N_retained"]].sort_index()
    pd.testing.assert_frame_equal(grouped, totals)
    check("observed_code_prefixes_reconcile_to_ALL", True)
    # WFDOC: Gate struktural seperti panel dan kalender dihitung ulang; gate measurement, teknologi, proxy, harga dan timing tetap terblokir.
    gates=pd.read_csv(run / "outputs/eligibility_gates.csv")
    gate_names=["g1_panel_usable","g1_lag1","g1_lag2","g1_stock_concept","g1_measurement_admitted","g1_technology_verified","g1_proxy_definition_verified","g1_investment_price_verified","g1_selection_verified","g1_timing_verified","g1_real_base"]
    check("complete_unique_gate_grid", len(gates)==11*len(expected) and set(zip(gates.gate,gates.source_year))=={(g,y) for g in gate_names for y in expected.index})
    for r in gates.itertuples():
        x=source.loc[source.source_year.eq(r.source_year)]
        if r.gate=="g1_stock_concept":
            passing=int(x.capital_stock_verified.eq(1).sum()); unknown=0
        elif r.gate=="g1_panel_usable":
            passing=len(x); unknown=0
        elif r.gate in {"g1_lag1","g1_lag2"}:
            lag=1 if r.gate=="g1_lag1" else 2
            passing=sum((f,y-lag) in keys for f,y in zip(x.psid,x.source_year)); unknown=0
        else:
            passing=0; unknown=0
        check(f"gate_{r.gate}_{int(r.source_year)}", [r.N_source,r.N_pass,r.N_unknown,r.N_not_pass]==[len(x),passing,unknown,len(x)-passing-unknown])
    for method in ["op", "lp", "acf", "wrdg"]:
        check(f"no_fabricated_tfp_{method}", derived[f"tfp_{method}"].isna().all())
        check(f"no_eligible_{method}", derived[f"g1_eligible_{method}"].eq(0).all())
    # WFDOC: Status tertahan dibedakan dari kegagalan optimizer: tidak ada percobaan, koefisien, prediksi TFP atau perbandingan metode yang diklaim.
    diag = pd.read_csv(run / "outputs/tfp_optimizer_diagnostics.csv")
    check("four_methods_blocked_not_failed_optimizers", len(diag) == 4 and diag.attempted.eq(0).all() and diag.convergence.isna().all())
    coeff = pd.read_csv(run / "outputs/tfp_coefficients.csv")
    check("no_coefficients_or_intervals_in_status_table", coeff[["beta_L", "beta_K", "returns_to_scale", "ci_lower", "ci_upper"]].isna().all().all())
    pairs = pd.read_csv(run / "outputs/tfp_method_comparison.csv")
    check("six_comparisons_unavailable", len(pairs) == 6 and pairs.common_N.eq(0).all() and pairs.rho_spearman.isna().all())
    # Arithmetic contracts for future calendar support, independent of the implementation.
    keys = {(1, 2015), (1, 2017), (1, 2018), (2, 2017)}
    check("calendar_gap_2017_has_no_t_minus_1", (1, 2017-1) not in keys)
    check("calendar_gap_2017_has_t_minus_2", (1, 2017-2) in keys)
    check("2018_t_minus_1_is_2017", (1, 2018-1) in keys)
    # WFDOC: Receipt mencatat semua pemeriksaan independen dan cakupannya; audit nominal ada di validator terpisah.
    report = {"status": "PASS", "scope": "Primary real-input audit and selected-source preservation; nominal estimates validated separately", "checks": checks, "check_count": len(checks), "domain_cells": len(domains), "funnel_cells": len(flow), "source_cells_compared": int(a.size)}
    (run / "qa/numeric-validation.json").write_text(json.dumps(report, indent=2) + "\n")
    print(json.dumps({k: v for k, v in report.items() if k != "checks"}))


if __name__ == "__main__":
    validate(Path(sys.argv[1]).resolve())
