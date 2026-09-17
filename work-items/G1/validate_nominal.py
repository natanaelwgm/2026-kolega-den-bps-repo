#!/usr/bin/env python3
"""Independent arithmetic and lineage reconciliation of Stata nominal DEVELOPMENT outputs.

No estimator is fitted in Python. Missing required evidence is an error unless
--allow-incomplete is explicitly supplied; an incomplete receipt never says PASS.
"""
# WFDOC: Validator ini menghitung ulang lineage dan aritmetika dari input serta ekspor Stata; bukan estimator dan hanya mencakup DEVELOPMENT nominal.
from __future__ import annotations
import argparse
import hashlib
import itertools
import json
from pathlib import Path
import numpy as np
import pandas as pd
from input_contract import load_input_contract

METHODS = ("op", "lp", "acf", "wrdg")
SAMPLES = ("own", "common")
VARIANTS = {"primary": (3, "ols"), "low_l": (3, "low_l"), "high_l": (3, "high_l"), "poly2": (2, "ols")}
HERE = Path(__file__).resolve().parent


def validate(run: Path, source_run: Path, allow_incomplete: bool = False):
    spec = json.loads((HERE / "nominal-specification.json").read_text())
    contract = load_input_contract(source_run)
    checks, unavailable, files = [], [], []

    def check(name, ok):
        if not bool(ok):
            raise AssertionError(name)
        checks.append(name)

    def near(name, actual, expected, atol=1e-9, rtol=1e-10):
        check(name, np.allclose(np.asarray(actual, dtype=float), np.asarray(expected, dtype=float), atol=atol, rtol=rtol, equal_nan=True))

    def load(relative, source=False):
        path = (source_run if source else run) / relative
        if not path.exists():
            unavailable.append(str(path))
            if not allow_incomplete:
                raise FileNotFoundError(path)
            return None
        files.append(path)
        return pd.read_stata(path, convert_categoricals=False) if path.suffix == ".dta" else pd.read_csv(path, dtype={"sector": str})

    source = load("S01_input.dta", True)
    n01 = load("nominal/N01_source.dta", True)
    frozen = load("nominal/N03_frozen.dta")
    fits = load("nominal/fit_results.dta")
    pred = load("nominal/N04_predictions.dta")
    if any(x is None for x in [source, n01, frozen, fits, pred]):
        raise FileNotFoundError("Source, frozen samples, fits and predictions are necessary even for partial arithmetic validation")
    check("full_selected_source_matches_pinned_contract", len(source) == contract['rows'] and source.psid.nunique() == contract['firms'])
    check("official_synthetic_panel_and_unique_keys", source.psid_status.eq("synthetic_development").all() and not source.duplicated(["psid", "source_year"]).any() and source.obs_id.is_unique)
    source_years = set(spec["history_years"])
    production_years = {y for y in source_years if y - 1 in source_years}
    dynamic_years = {y for y in production_years if y - 1 in production_years}
    check("complete_declared_source_calendar", set(source.source_year) == source_years)
    check("production_calendar_requires_exact_preceding_source_year", set(spec["production_years"]) == production_years)
    check("dynamic_calendar_requires_two_exact_preceding_source_years", set(spec["dynamic_years"]) == dynamic_years)
    check("observed_calendar_gap_retained", 2016 not in source_years)
    # WFDOC: production_years diturunkan dari ketersediaan t−1 source, sedangkan dynamic_years diturunkan lagi dari t−1 production; dua derivasi ini mempertahankan gap 2016.
    # WFDOC: Eligibility dibentuk sebelum lag; stok modal awal memakai tahun kalender t−1 pada kunci psid-tahun, tanpa menjembatani 2015 ke 2017.
    base = source[source.source_year.isin(spec["history_years"])].copy().set_index(["psid", "source_year"]).sort_index()
    index = base.index
    lag_index = pd.MultiIndex.from_tuples([(f, y - 1) for f, y in index], names=index.names)

    def positive_log(x):
        x = np.asarray(x, dtype=float)
        out = np.full(len(x), np.nan)
        np.log(x, out=out, where=np.isfinite(x) & (x > 0))
        return out

    wanted = pd.DataFrame(index=index)
    wanted["nom_k_begin"] = base.capital_stock_nominal.reindex(lag_index).to_numpy()
    wanted["nom_k_concept"] = lag_index.isin(index)
    wanted["nom_k_documented"] = base.capital_stock_verified.reindex(lag_index).eq(1).to_numpy()
    wanted["nom_i_documented"] = base.capital_additions_verified.eq(1).to_numpy()
    wanted["nom_i_concept"] = True
    wanted["nom_k_assumed"] = wanted.nom_k_concept
    wanted["nom_i_assumed"] = True
    # WFDOC: *_documented menyalin flag sumber; *_concept dan *_assumed merekam konvensi hitung yang disahkan owner, tanpa mengubah nilai input atau membuat pengamatan baru.
    for output, column in [("nom_y", "value_added_nominal"), ("nom_l", "workers"), ("nom_i", "capital_additions_nominal"), ("nom_m", "val_rtlvcu")]:
        wanted[output] = positive_log(base[column])

    wanted["nom_k"] = positive_log(wanted.nom_k_begin)
    wanted.loc[~wanted.nom_k_concept, "nom_k"] = np.nan
    wanted["nom_sector"] = base.industry_code.str[:2]
    # WFDOC: Predicate ini harus sama dengan N01: tahun produksi, kode industri tepat lima digit numerik dan sektor 10–33; validasi membandingkan domain per baris setelahnya.
    wanted["nom_production"] = index.get_level_values(1).isin(spec["production_years"]) & base.industry_code.str.fullmatch(r"[0-9]{5}").fillna(False) & pd.to_numeric(wanted.nom_sector, errors="coerce").between(10, 33)
    for m in METHODS:
        wanted["nom_domain_" + m] = wanted.nom_production & wanted[["nom_y", "nom_l", "nom_k", "nom_i" if m == "op" else "nom_m"]].notna().all(axis=1)
    wanted["nom_domain_common"] = wanted.nom_domain_op & wanted.nom_domain_lp
    x01 = n01.set_index(["psid", "source_year"]).sort_index()
    check("N01_exact_source_keys", x01.index.equals(index))
    for column in wanted.columns:
        if column == "nom_sector":
            check("N01_sector_from_observed_code", wanted[column].equals(x01[column]))
        else:
            near("N01_" + column, x01[column], wanted[column], atol=1e-12)
    pd.testing.assert_frame_equal(base, x01[base.columns], check_dtype=False, check_exact=True)
    check("N01_all_selected_source_values_unchanged", True)

    # Risk intervals are reconstructed by set membership, not row shifts or an exit inference.
    # WFDOC: Semesta risiko OP menambahkan interval untuk seluruh pasangan tahun sumber yang berurutan; disappearance sintetis bukan status penutupan aktual.
    risk_keys = {(f, y + 1) for f, y in index if y + 1 in source_years}
    # WFDOC: risk_keys adalah union observasi sumber dengan endpoint interval t+1 yang benar-benar tersedia; interval-only tetap turunan sintetis dan tidak boleh menjadi source row.
    original_keys = set(index)
    expected_keys = original_keys | risk_keys
    z = frozen.set_index(["psid", "source_year"]).sort_index()
    check("N03_full_risk_union_exact_keys", not z.index.duplicated().any() and set(z.index) == expected_keys)
    original = np.array([key in original_keys for key in z.index])
    risk = np.array([key in risk_keys for key in z.index])
    near("interval_only_is_not_an_original_observation", z.nom_interval_only, ~original)
    near("exact_generator_risk_intervals", z.nom_risk, risk)
    near("synthetic_disappearance_only_missing_generator_assignment", z.nom_disappearance, np.where(risk, ~original, np.nan))
    check("intervals_carry_no_obs_id", z.loc[~original, "obs_id"].fillna("").eq("").all())
    pd.testing.assert_frame_equal(base, z.loc[index, base.columns], check_dtype=False, check_exact=True)
    check("N03_original_source_values_preserved", True)
    risk_lag = pd.MultiIndex.from_tuples([(f, y - 1) for f, y in z.index], names=z.index.names)
    for prior, current in [("nom_sector", "nom_risk_sector"), ("dev_panel_stratum", "nom_risk_stratum"), ("psid_status", "nom_risk_panel_status")]:
        expected_prior = x01[prior].reindex(risk_lag).to_numpy()
        check("risk_interval_prior_metadata_" + current, np.array_equal(z.loc[risk, current].to_numpy(), expected_prior[risk]))
    check("event_only_sector_retains_preceding_source_assignment", z.loc[~original, "nom_sector"].eq(z.loc[~original, "nom_risk_sector"]).all())
    augmented = wanted.reindex(z.index)
    for m in (*METHODS, "common"):
        column = "nom_domain_" + m
        augmented[column] = augmented[column].fillna(False).astype(bool)
        lag = pd.MultiIndex.from_tuples([(f, y - 1) for f, y in z.index], names=z.index.names)
        same_sector = augmented.nom_sector.eq(augmented.nom_sector.reindex(lag).to_numpy())
        dynamic = augmented[column] & augmented[column].reindex(lag).fillna(False).to_numpy() & same_sector
        augmented["nom_dynamic_" + m] = dynamic
        near("N03_domain_" + m, z[column], augmented[column])
        near("N03_dynamic_" + m, z["nom_dynamic_" + m], dynamic)
    lagged = augmented.reindex(lag)
    selection = risk & lagged[["nom_k", "nom_i"]].notna().all(axis=1).to_numpy() & z.nom_sector.eq(z.nom_sector.reindex(lag).to_numpy()).to_numpy()
    near("N03_selection_uses_exact_lagged_state_and_investment", z.nom_selection, selection)
    check("constructed_intervals_retained_outside_production", augmented.loc[~original, ["nom_domain_" + m for m in METHODS]].eq(False).all().all())

    sectors = sorted(s for s in z.nom_sector.unique() if s)
    # WFDOC: Grid kewajiban mempertahankan setiap sektor, metode, own/common dan empat spesifikasi tetap, termasuk percobaan yang dilewati.
    expected_fit_keys = set(itertools.product(sectors, METHODS, SAMPLES, VARIANTS))
    fit_keys = ["sector", "method", "sample_id", "variant"]
    check("complete_fixed_fit_obligations", not fits.duplicated(fit_keys).any() and set(fits[fit_keys].itertuples(index=False, name=None)) == expected_fit_keys)
    check("nominal_metadata_never_claims_real_inputs", fits.real_input_verified.eq(0).all() and fits.development_only.eq(1).all() and fits.measurement_mode.eq("nominal_development").all())
    check("fit_metadata_matches_declared_input_and_specification", fits.specification_id.eq(spec["specification_id"]).all() and fits.input_manifest_sha256.eq(contract['manifest_sha256']).all())
    check("all_fit_rows_declare_pooled_reference", fits.reference_scope.eq("pooled_dynamic").all() and fits.reference_year.isna().all())
    check("fit_statuses_are_explicit", fits.status.isin(["skipped_support", "fit_failed", "fit_success"]).all())
    pred_groups = {k: g for k, g in pred.groupby(fit_keys)}
    successful = set()
    for row in fits.itertuples():
        key = (row.sector, row.method, row.sample_id, row.variant)
        cell = augmented.loc[z.nom_sector.eq(row.sector)].copy()
        cell_z = z.loc[cell.index]
        domain = cell["nom_domain_" + (row.method if row.sample_id == "own" else "common")]
        lag_cell = pd.MultiIndex.from_tuples([(f, y - 1) for f, y in cell.index], names=cell.index.names)
        dynamic = domain & domain.reindex(lag_cell).fillna(False).to_numpy()
        # WFDOC: local_selection memakai state modal dan investasi pada lag kalender untuk risk rows; cell sudah dibatasi sektor sehingga support OP tidak mengambil lag sektor lain.
        local_selection = cell_z.nom_risk.eq(1).to_numpy() & cell[["nom_k", "nom_i"]].reindex(lag_cell).notna().all(axis=1).to_numpy()
        ns = int(local_selection.sum())
        nd = int((local_selection & cell_z.nom_disappearance.eq(1).to_numpy()).sum())
        nf = int(cell.index.get_level_values(0)[dynamic].nunique())
        counts = [int(cell_z.nom_interval_only.eq(0).sum()), len(cell), int(domain.sum()), int(dynamic.sum()), nf, ns, nd, ns - nd]
        near("fit_support_" + "_".join(key), [row.N_source, row.N_full_source, row.N_domain, row.N_dynamic, row.N_firms, row.N_selection, row.N_disappearance, row.N_continuer], counts)
        years = cell.index.get_level_values("source_year")[dynamic]
        expected_calendar = [years.min(), years.max(), years.nunique()] if len(years) else [np.nan, np.nan, 0]
        near("fit_calendar_metadata_" + "_".join(key), [row.fit_year_min, row.fit_year_max, row.N_fit_years], expected_calendar)
        # WFDOC: N_dynamic menambahkan transisi kalender nyata ke domain PRE-LAG; kelayakan OP juga mensyaratkan N risiko, exits dan continuers sesuai cutoff.
        support = counts[2] >= spec["minimum_first_stage_N"] and counts[3] >= spec["minimum_dynamic_N"] and nf >= spec["minimum_dynamic_firms"]
        if row.method == "op":
            support &= ns >= spec["minimum_OP_selection_N"] and nd >= spec["minimum_OP_selection_exits"] and ns - nd >= spec["minimum_OP_selection_continuers"]
        check("fixed_admission_" + "_".join(key), bool(row.attempted) == support and (row.status == "skipped_support") == (not support))
        check("fixed_variant_" + "_".join(key), (row.poly, row.start) == VARIANTS[row.variant])
        median = cell.loc[domain, ["nom_y", "nom_l", "nom_k", "nom_i" if row.method == "op" else "nom_m"]].median().to_numpy()
        near("frozen_medians_" + "_".join(key), [row.center_y, row.center_l, row.center_k, row.center_proxy], median)
        if row.status != "fit_success":
            check("failed_cell_no_prediction_" + "_".join(key), key not in pred_groups and row.rc != 0 and np.isnan(row.beta_L) and np.isnan(row.beta_K))
            continue
        successful.add(key)
        check("success_contract_" + "_".join(key), row.rc == 0 and row.converged == 1 and row.N == dynamic.sum())
        g = pred_groups[key].set_index(["psid", "source_year"]).sort_index()
        expected = cell.loc[domain]
        check("exact_prediction_keys_" + "_".join(key), g.index.equals(expected.index) and g.obs_id.eq(cell_z.loc[expected.index, "obs_id"]).all())
        near("exact_estimation_mask_" + "_".join(key), g.in_fit, dynamic.loc[expected.index])
        # WFDOC: Residu mentah ialah ln(VA nominal)−βL ln(L)−βK ln(K awal); pemusatan memakai rerata seluruh baris dynamic gabungan tahun, lalu indeks = exp(residu terpusat).
        raw = expected.nom_y - row.beta_L * expected.nom_l - row.beta_K * expected.nom_k
        mean = raw.loc[dynamic.loc[expected.index]].mean()
        near("native_log_residual_" + "_".join(key), g.raw_log_residual, raw)
        near("normalization_mean_" + "_".join(key), [row.residual_reference_mean], [mean])
        check("prediction_reference_metadata_" + "_".join(key), g.reference_scope.eq("pooled_dynamic").all() and g.reference_year.isna().all())
        check("prediction_measurement_metadata_" + "_".join(key), g.specification_id.eq(spec["specification_id"]).all() and g.measurement_mode.eq("nominal_development").all())
        for field in ["fit_year_min", "fit_year_max", "N_fit_years", "labor", "capital"]:
            near("prediction_" + field + "_" + "_".join(key), g[field], np.full(len(g), getattr(row, field)))
        near("centered_residual_" + "_".join(key), g.normalized_log_residual, raw - mean)
        near("row_normalization_constants_" + "_".join(key), g.residual_reference_mean, np.full(len(g), mean))
        with np.errstate(over="ignore"):
            exponent = np.exp(raw - mean)
        exponent = np.where(np.isfinite(exponent), exponent, np.nan)
        near("normalized_level_index_" + "_".join(key), g.normalized_residual_index, exponent)
    check("no_orphan_prediction_cells", set(pred_groups) == successful)
    check("long_predictions_unique_original_keys", not pred.duplicated(fit_keys + ["obs_id"]).any() and pred.obs_id.isin(source.obs_id).all())
    primary = pred[pred.variant.eq("primary") & pred.in_fit.eq(1)]
    # WFDOC: primary hanya baris dynamic yang benar-benar masuk fit, sedangkan all_primary adalah seluruh prediction production-domain yang dipakai untuk attachment.
    check("primary_dynamic_years_follow_exact_calendar", primary.source_year.isin(spec["dynamic_years"]).all())
    all_primary = pred[pred.variant.eq("primary")]
    check("all_primary_predictions_follow_production_calendar", all_primary.source_year.isin(production_years).all())

    # WFDOC: Attachment harus mempertahankan semua 33.049 kunci dan nilai input asli; residu development ditempel hanya ke observasi yang cocok.
    attached = load("nominal/N06_selected_attached.dta")
    if attached is not None:
        aa = source.set_index(["obs_id", "source_year"]).sort_index()
        bb = attached.set_index(["obs_id", "source_year"]).sort_index()
        check("attachment_all33049_keys", aa.index.equals(bb.index) and len(bb) == 33049)
        pd.testing.assert_frame_equal(aa, bb[aa.columns], check_dtype=False, check_exact=True)
        check("attachment_every_original_value_unchanged", True)
        for m in METHODS:
            for sample in SAMPLES:
                pp = all_primary[all_primary.method.eq(m) & all_primary.sample_id.eq(sample)].set_index(["obs_id", "source_year"])
                prefix = "dev_nominal_" if sample == "own" else "dev_nominal_common_"
                near("attachment_raw_" + m + sample, bb[prefix + "tfp_" + m], pp.raw_log_residual.reindex(bb.index))
                near("attachment_centered_" + m + sample, bb[prefix + "c_" + m], pp.normalized_log_residual.reindex(bb.index))
                near("attachment_prediction_flag_" + m + sample, bb[prefix + "pred_" + m], bb[prefix + "tfp_" + m].notna())
                near("attachment_dynamic_fit_flag_" + m + sample, bb[prefix + "in_fit_" + m], pp.in_fit.reindex(bb.index).fillna(0))
        for m in (*METHODS, "common"):
            mapping = pd.Series(augmented.loc[original, "nom_dynamic_" + m].to_numpy(), index=pd.MultiIndex.from_arrays([z.loc[original, "obs_id"], z.loc[original].index.get_level_values(1)], names=bb.index.names))
            near("attachment_eligibility_" + m, bb["dev_nominal_eligible_" + m], mapping.reindex(bb.index).fillna(False))
            mapping = pd.Series(augmented.loc[original, "nom_domain_" + m].to_numpy(), index=mapping.index)
            near("attachment_pre_lag_domain_" + m, bb["dev_nominal_domain_" + m], mapping.reindex(bb.index).fillna(False))
        for field in ["k_assumed", "k_documented", "i_assumed", "i_documented"]:
            mapping = pd.Series(z.loc[original, "nom_" + field].to_numpy(), index=mapping.index)
            near("attachment_assumption_documentation_" + field, bb["dev_nominal_" + field], mapping.reindex(bb.index))
        check("attachment_development_metadata", bb.dev_nominal_real_verified.eq(0).all() and bb.dev_nominal_development_only.eq(1).all() and bb.dev_nominal_spec.eq(spec["specification_id"]).all())
        check("attachment_pooled_reference_metadata", bb.dev_nominal_reference_scope.eq("pooled_dynamic").all() and bb.dev_nominal_reference_year.isna().all())

    annual = load("outputs/nominal_master_attachment.csv")
    if annual is not None and attached is not None:
        check("annual_master_attachment_complete_source_calendar", not annual.source_year.duplicated().any() and set(annual.source_year) == source_years)
        annual = annual.set_index("source_year").sort_index()
        by_year = attached.groupby("source_year")
        near("annual_master_attachment_source_totals", annual.N_source, by_year.size().reindex(annual.index))
        for m in METHODS:
            near("annual_master_attachment_predictions_" + m, annual["N_" + m], by_year["dev_nominal_pred_" + m].sum().reindex(annual.index))
            near("annual_master_attachment_dynamic_fits_" + m, annual["N_fit_" + m], by_year["dev_nominal_in_fit_" + m].sum().reindex(annual.index))

    # WFDOC: Grid statistik mempertahankan kombinasi kosong; histogram memeriksa bin lebar 0,5 tanpa trimming dan denominator seluruh prediksi tersedia.
    dist = load("outputs/nominal_distribution_quantiles.csv")
    hist = load("outputs/nominal_histogram_bins.csv")
    grid = set(itertools.product(["ALL", *sectors], METHODS, SAMPLES, ["raw", "centered"]))
    if dist is not None:
        check("distribution_includes_empty_cells", set(dist[["sector", "method", "sample_id", "measure"]].itertuples(index=False, name=None)) == grid and len(dist) == len(grid))
        for row in dist.itertuples():
            g = primary[primary.method.eq(row.method) & primary.sample_id.eq(row.sample_id)]
            if row.sector != "ALL":
                g = g[g.sector.eq(row.sector)]
            values = g["raw_log_residual" if row.measure == "raw" else "normalized_log_residual"].to_numpy()
            key = "_".join((row.sector, row.method, row.sample_id, row.measure))
            check("distribution_N_" + key, row.N == len(values))
            wanted_stats = [np.nan] * 11
            if len(values):
                wanted_stats = [values.mean(), values.std(ddof=1) if len(values) > 1 else 0, values.min(), *np.quantile(values, [.01, .05, .25, .5, .75, .95, .99], method="averaged_inverted_cdf"), values.max()]
            near("distribution_statistics_" + key, [row.mean, row.sd, row.min, row.p1, row.p5, row.p25, row.p50, row.p75, row.p95, row.p99, row.max], wanted_stats)
            if hist is not None:
                h = hist[hist.sector.eq(row.sector) & hist.method.eq(row.method) & hist.sample_id.eq(row.sample_id) & hist.measure.eq(row.measure)].sort_values("bin_lower")
                counts = pd.Series(np.floor(values / .5) * .5).value_counts().sort_index()
                near("untrimmed_histogram_counts_" + key, h.N_bin, counts)
                near("histogram_boundaries_" + key, h.bin_lower, counts.index)
                near("histogram_upper_bounds_" + key, h.bin_upper, counts.index + .5)
                near("histogram_denominators_" + key, h.N_total, np.full(len(h), len(values)))
                near("histogram_shares_" + key, h.share, counts.to_numpy() / len(values) if len(values) else [])

    # WFDOC: Pairwise memakai irisan prediksi dua metode, sedangkan four_method memakai irisan keempat metode; korelasi dihitung ulang pada irisan itu.
    comparisons = load("outputs/nominal_pairwise_comparisons.csv")
    scatter = load("outputs/nominal_rank_scatter_bins.csv")
    pairs_expected = set(itertools.product(["ALL", *sectors], SAMPLES, list(itertools.combinations(METHODS, 2)), ["pairwise", "four_method"]))
    if comparisons is not None:
        got = {(r.sector, r.sample_id, (r.method_a, r.method_b), r.comparison_scope) for r in comparisons.itertuples()}
        check("all_six_pair_obligations_and_distinct_intersections", got == pairs_expected and len(got) == len(comparisons))
        for row in comparisons.itertuples():
            g = primary[primary.sample_id.eq(row.sample_id)]
            if row.sector != "ALL":
                g = g[g.sector.eq(row.sector)]
            c = g.pivot(index="obs_id", columns="method", values="normalized_log_residual").reindex(columns=METHODS)
            raw = g.pivot(index="obs_id", columns="method", values="raw_log_residual").reindex(columns=METHODS)
            pair_mask = c[[row.method_a, row.method_b]].notna().all(axis=1)
            four_mask = c.notna().all(axis=1)
            mask = pair_mask if row.comparison_scope == "pairwise" else four_mask
            selected = c.loc[mask, [row.method_a, row.method_b]]
            native = raw.loc[mask, [row.method_a, row.method_b]]
            key = "_".join((row.sector, row.sample_id, row.method_a, row.method_b, row.comparison_scope))
            near("pair_counts_" + key, [row.N_pairwise, row.N_four_method, row.N_compared], [pair_mask.sum(), four_mask.sum(), len(selected)])
            def corr(frame):
                return frame.corr().iloc[0, 1] if len(frame) > 1 and frame.nunique().gt(1).all() else np.nan
            near("pair_correlations_" + key, [row.pearson_raw, row.pearson_centered, row.rho_spearman], [corr(native), corr(selected), corr(selected.rank(method="average"))])
            if scatter is not None:
                h = scatter[scatter.sector.eq(row.sector) & scatter.sample_id.eq(row.sample_id) & scatter.method_a.eq(row.method_a) & scatter.method_b.eq(row.method_b) & scatter.comparison_scope.eq(row.comparison_scope)].sort_values("rank_bin")
                means = pd.DataFrame(columns=["N_bin", "mean_x", "mean_y", "mean_rank_x", "mean_rank_y"])
                if len(selected) > 1:
                    ranks = selected.rank(method="average") / (len(selected) + 1)
                    t = pd.DataFrame({"mean_x": selected.iloc[:, 0], "mean_y": selected.iloc[:, 1], "mean_rank_x": ranks.iloc[:, 0], "mean_rank_y": ranks.iloc[:, 1]})
                    t["rank_bin"] = np.ceil(20 * ranks.iloc[:, 0]).astype(int)
                    means = t.groupby("rank_bin").mean()
                    means["N_bin"] = t.groupby("rank_bin").size()
                    means = means[means.N_bin.ge(5)].sort_index()
                near("scatter_bin_keys_" + key, h.rank_bin, means.index)
                for column in ["N_bin", "mean_x", "mean_y", "mean_rank_x", "mean_rank_y"]:
                    near("scatter_" + column + "_" + key, h[column], means[column])
                near("scatter_released_count_" + key, [row.scatter_N_released], [means.N_bin.sum()])

    # WFDOC: Audit bootstrap mempertahankan ID draw gagal dan memeriksa ambang sukses; kovarians memakai n−1 dan batas percentile mengikuti Stata centile.
    # WFDOC: Pemeriksaan bootstrap mengikat jumlah draw dan seed, kesinambungan point estimate serta covariance n−1; ambang sukses dipisahkan dari status panggilan.
    boot = load("nominal/bootstrap_summary.dta")
    bootstrap_cells = 0
    if boot is not None:
        primary_success = {k[:3] for k in successful if k[3] == "primary"}
        check("bootstrap_all_successful_primary_obligations", set(boot[["sector", "method", "sample_id"]].itertuples(index=False, name=None)) == primary_success and len(boot) == len(primary_success))
        for row in boot.itertuples():
            key = "_".join((row.sector, row.method, row.sample_id))
            if row.rc != 0:
                check("bootstrap_failed_call_not_admitted_" + key, row.interval_admitted == 0)
                continue
            draws = load("nominal/bootstrap_" + key + ".dta")
            if draws is None:
                continue
            bootstrap_cells += 1
            good = draws[draws.success.eq(1)]
            check("bootstrap_fixed_draw_ids_" + key, len(draws) == spec["bootstrap_draws"] and set(draws.draw) == set(range(1, spec["bootstrap_draws"] + 1)))
            check("bootstrap_failed_draws_retained_" + key, draws.success.eq(draws.rc.eq(0).astype(int)).all())
            check("bootstrap_draw_contract_metadata_" + key, draws.requested_draws.eq(spec["bootstrap_draws"]).all() and draws.bootstrap_seed.eq(spec["bootstrap_seed"]).all())
            near("bootstrap_denominator_" + key, [row.requested, row.successful, row.covariance_denominator], [len(draws), len(good), len(good) - 1])
            admitted = len(good) >= spec["bootstrap_success_minimum"]
            check("bootstrap_success_threshold_" + key, row.interval_admitted == admitted)
            fit = fits[fits.sector.eq(row.sector) & fits.method.eq(row.method) & fits.sample_id.eq(row.sample_id) & fits.variant.eq("primary")].iloc[0]
            near("bootstrap_point_continuity_" + key, [row.beta_L, row.beta_K], [fit.beta_L, fit.beta_K], atol=1e-7)
            near("bootstrap_draw_point_labor_" + key, draws.point_labor, np.full(len(draws), fit.beta_L), atol=1e-7)
            near("bootstrap_draw_point_capital_" + key, draws.point_capital, np.full(len(draws), fit.beta_K), atol=1e-7)
            covariance = good[["labor", "capital"]].cov().to_numpy() if len(good) > 1 else np.full((2, 2), np.nan)
            near("bootstrap_sample_covariance_" + key, [row.var_L, row.var_K, row.cov_LK], [covariance[0, 0], covariance[1, 1], covariance[0, 1]], atol=1e-10)
            near("bootstrap_standard_errors_" + key, [row.se_L, row.se_K, row.se_RTS], np.sqrt([covariance[0, 0], covariance[1, 1], covariance.sum()]), atol=1e-10)
            # Stata centile.ado interpolates h=(N+1)*p, distinct from summarize's quantiles.
            ci = np.quantile(good[["labor", "capital"]], [.025, .975], axis=0, method="weibull").T.flatten() if admitted else [np.nan] * 4
            near("bootstrap_centile_intervals_" + key, [row.ci_L_lo, row.ci_L_hi, row.ci_K_lo, row.ci_K_hi], ci, atol=1e-9)

    # WFDOC: Receipt membedakan PASS lengkap dari cek yang lolos saat bukti hilang, lalu menyimpan hash sumber dan spesifikasi yang dibaca.
    report = {"status": "PASS" if not unavailable else "INCOMPLETE_AVAILABLE_CHECKS_PASSED", "scope": "Independent source/timing/domain/residual/aggregate/bootstrap arithmetic; nominal development only; no estimator fitted in Python", "complete_required_evidence": not unavailable, "source_rows": len(source), "source_cells_compared": int(source.size), "fit_rows": len(fits), "successful_primary_cells": sum(k[3] == "primary" for k in successful), "successful_all_variant_cells": len(successful), "prediction_rows_all_variants": len(pred), "bootstrap_cells_validated": bootstrap_cells, "checks": checks, "check_count": len(checks), "missing_evidence": unavailable, "script_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(), "specification_sha256": hashlib.sha256((HERE / "nominal-specification.json").read_bytes()).hexdigest(), "evidence": [{"path": str(p), "sha256": hashlib.sha256(p.read_bytes()).hexdigest()} for p in dict.fromkeys(files)]}
    report["source_years"] = sorted(source_years)
    report["production_years"] = sorted(production_years)
    report["potential_dynamic_years"] = sorted(dynamic_years)
    report["actual_primary_dynamic_years"] = sorted(int(y) for y in primary.source_year.unique())
    report["actual_primary_prediction_years"] = sorted(int(y) for y in all_primary.source_year.unique())
    (run / "qa").mkdir(exist_ok=True)
    (run / "qa/nominal-validation.json").write_text(json.dumps(report, indent=2) + "\n")
    print(json.dumps({k: v for k, v in report.items() if k not in {"checks", "evidence"}}, indent=2))
    return report


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--run", type=Path, required=True)
    parser.add_argument("--source-run", type=Path, help="Separate prepared source run for S01/N01; does not change fit evidence paths")
    parser.add_argument("--allow-incomplete", action="store_true", help="Allow absent downstream evidence and label the receipt INCOMPLETE")
    args = parser.parse_args()
    validate(args.run.resolve(), (args.source_run or args.run).resolve(), args.allow_incomplete)
