#!/usr/bin/env python3
"""Build G1's preserved analytical contracts and truthful exhibit reconciliation.

This is documentation/orchestration only. It neither computes statistical values
nor turns a diagnostic receipt into an accepted estimator state.
"""
from __future__ import annotations

import argparse
import csv
import fnmatch
import hashlib
import json
import re
from pathlib import Path
import shutil
import subprocess

ROOT = Path(__file__).resolve().parents[2]
MODULE = Path(__file__).resolve().parent
PLAN = ROOT / "releases/2026-09-13-data-foundation/stata-preparation/row-plans/G1.json"
INPUT = ROOT / "data/g0-5-development/manifest.json"
LABEL = "G0.5 DEVELOPMENT — perturbed data; not final empirical findings"
YEARS = "2010–2015, 2017–2022; 2016 absent"
EVIDENCE_ROOT = MODULE / "release"
NOMINAL_SPEC = MODULE / "nominal-specification.json"
DEEP_CONTRACT = MODULE / "deep-diagnostics-contract.json"
DEEP_EVIDENCE_ROOT = MODULE / "deep-release"
DEEP_FINAL_EXECUTION = MODULE / "qa/deep-final-execution.json"
CURRENT_INPUT_HASH = "060b0ee0a2158a9c94b0e7e68fcfba719eda37561422855471a99da6810ba260"
BLOCKERS = {
    "identity": "ACTUAL FINALISATION ONLY: authenticated real longitudinal linkage remains unresolved. G0.5 v3 official psid_status=synthetic_development and unique(psid,source_year) are accepted for explicitly labelled development; REAL linkage is not its blocker.",
    "prices": "Accepted concept-specific output/input/capital deflators and lineage-preserving real-value operands; current real/deflator fields are unavailable.",
    "capital": "Accepted capital-stock concept AND measurement unit, plus separately verified positive real investment. capital_stock_verified certifies questionnaire concept only, not measurement admission; additions and mixed aliases cannot replace stock.",
    "technology": "Verified two-digit technology bridge across questionnaire/classification vintages; demo_industry2 is not a certified bridge.",
    "quality": "G2 eligibility masks bound to this exact G0.5 input version, with semantic/unit/domain reasons; G1 local screens are not all of G2.",
    "selection": "PRIMARY REAL SPECIFICATION: authenticated economic risk/exit universe remains unresolved. Nominal development separately defines official-generator disappearance intervals; these are not actual closures.",
    "implementation": "Pinned adapter implementation and guard/numerical tests are documented in stata/methods/METHOD-AUDIT.md. Current nominal result receipts are separate from real-primary source acceptance; code existence alone never certifies either.",
}
AUDIT_OUTPUTS = {
    1: ["S01_input.dta", "outputs/observed_waves.csv"],
    2: ["S02_concepts.dta"], 3: ["S03_calendar.dta"],
    4: ["S04_domains.dta", "outputs/variable_domains.csv", "outputs/source_status.csv"],
    5: ["S05_OP_support.dta"], 6: ["S06_LP_support.dta"],
    7: ["S07_ACF_support.dta"], 8: ["S08_WRDG_support.dta"],
    9: ["S09_samples.dta", "outputs/tfp_sample_attrition.csv"],
    10: ["S10_op_blocked.dta"], 11: ["S11_lp_blocked.dta"],
    12: ["S12_acf_blocked.dta"], 13: ["S13_wrdg_blocked.dta"],
    14: ["outputs/tfp_coefficients.csv", "outputs/tfp_optimizer_diagnostics.csv"],
    15: ["S15_prediction_status.dta"], 16: ["outputs/bootstrap_status.csv"],
    17: ["outputs/tfp_method_comparison.csv"],
    18: ["analysis/G1_input_eligibility.dta", "analysis/G1_tfp_status_sidecar.dta", "analysis/G1_main_with_tfp.dta", "outputs/tfp_attachment_audit.csv"],
    19: ["outputs/eligibility_gates.csv"],
}
AUDIT_ROLES = {
    1: "Freeze selected-column development observations and count observed waves.",
    2: "Retain observed code prefixes and explicit unaccepted semantic/technology/measurement flags; do not admit a technology pool.",
    3: "Accept official synthetic_development psid for development, enforce exact calendar lags, count available synthetic links, and preserve the separate false actual-linkage acceptance flag.",
    4: "Compute marginal source-year missing/zero/negative/positive domains, quantiles and source-status counts; distinguish stock concept from measurement admission.",
    5: "Record OP nominal/concept/real/dynamic gate intersections; no inferred exit model.",
    6: "Record LP nominal/concept/real/dynamic gate intersections; no nominal-to-real proxy substitution.",
    7: "Record ACF support and timing gates without estimating coefficients.",
    8: "Record Wooldridge support and timing gates without estimating coefficients.",
    9: "Count fixed-source-denominator staged losses by method/year/observed code prefix; code prefix is not accepted technology.",
    10: "Assert unsupported OP state and preserve missing-valued status fields; estimator not attempted.",
    11: "Assert unsupported LP state and preserve missing-valued status fields; estimator not attempted.",
    12: "Assert unsupported ACF state and preserve missing-valued status fields; estimator not attempted.",
    13: "Assert unsupported Wooldridge state and preserve missing-valued status fields; estimator not attempted.",
    14: "Write method-level pre-estimation source-block receipts, not coefficient/convergence estimates or a full technology-cell census.",
    15: "Record unsupported prediction coverage and metadata; no productivity or centering constant is estimated.",
    16: "Record zero attempted bootstrap draws and unknown successful-draw outcomes; no bootstrap distribution.",
    17: "Preserve all six method-pair obligations with no predictions/correlations; undefined correlation is missing, not zero.",
    18: "Validate a one-to-one selected-input/status-sidecar derivative preserving obs_id and source_year; not a completed numerical TFP attachment.",
    19: "Reconcile source-gate pass/not-pass/unknown counts and assert unsupported predictions remain missing.",
}


def sha(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def write(path: Path, text: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(text, encoding="utf-8")


def dump(path: Path, value) -> None:
    write(path, json.dumps(value, ensure_ascii=False, indent=2) + "\n")


def table(path: Path, rows: list[dict]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    keys = list(dict.fromkeys(k for row in rows for k in row))
    with path.open("w", encoding="utf-8", newline="") as stream:
        writer = csv.DictWriter(stream, fieldnames=keys)
        writer.writeheader()
        for row in rows:
            writer.writerow({k: json.dumps(v, ensure_ascii=False) if isinstance(v, (list, dict)) else v for k, v in row.items()})


def relative(path: Path) -> str:
    return path.relative_to(ROOT).as_posix()


def effective_keys(node: dict) -> list[str]:
    keys = node["keys"][:]
    if "source_row" in keys:
        keys = ["obs_id"] + [k for k in keys if k not in ("source_row", "source_year")]
    return keys


def effective_units(node: dict) -> dict:
    code = node["id"]
    if code in ("G1_S10", "G1_S11", "G1_S12", "G1_S13", "G1_S14", "G1_S16"):
        return {"beta_L_beta_K_returns_to_scale": "elasticities, dimensionless",
                "N": "observations / distinct verified plants / calendar waves, explicitly distinguished",
                "rank_instruments_iterations_draws": "integer counts",
                "objective": "method-specific squared log-output residual or quadratic moment criterion; numerical convention must be saved",
                "status": "categorical outcome; not an estimate"}
    if code in ("G1_S15", "G1_S17", "G1_S18"):
        return {"TFP_residual_and_centering_constant": "natural-log points; not computed while input gates fail",
                "correlations": "dimensionless; undefined without supported predictions",
                "coverage": "observation count and percent of explicitly named denominator",
                "original_input_columns": "unchanged source units; see variable registry"}
    if code in ("G1_S00", "G1_S01", "G1_S19", "G1_INPUT_ESTIMATOR", "G1_INPUT_SEMANTICS", "G1_INPUT_QUALITY"):
        return {"contracts": "definitions / source hashes / acceptance statuses",
                "counts": "named registry entries or checks; not plant counts",
                "eligibility": "Boolean and explicit unknown states"}
    return {"source_monetary_candidates": "reported source units; measurement/unit admission remains unresolved, with no unverified conversion",
            "required_real_monetary_inputs": "constant-price Rp000 only after accepted source unit, deflator base and concept mapping",
            "labor": "canonical worker-count candidate; source definition/unit admission required",
            "time": "actual calendar year", "counts": "frozen source observations; no population weights",
            "eligibility": "Boolean plus distinct unknown states"}


def denominator(node: dict) -> str:
    code = node["id"]
    if code in ("G1_INPUT_CANONICAL", "G1_S02", "G1_S03", "G1_S18"):
        return "All 33,049 frozen G0.5 observations; year cells use their complete observed source-year count. No survey weights or population expansion."
    if code in ("G1_S04", "G1_S05", "G1_S06", "G1_S07", "G1_S08", "G1_S09"):
        return "Unfiltered source candidates per method and verified technology/year. Report marginal exclusions against the fixed source denominator, sequential losses against the previous gate, and the four-method intersection once per obs_id."
    if code in ("G1_S10", "G1_S11", "G1_S12", "G1_S13", "G1_S14"):
        return "Each predeclared technology × method × own/common sample × specification; record dynamic observations, distinct verified plants, calendar waves and every failed cell."
    if code == "G1_S16":
        return "999 external complete-process verified-plant cluster draws plus a distinct original estimate; ≥950 successful draws required for 95% percentile intervals. Covariance divisor is B_success−1."
    if code in ("G1_S15", "G1_S17"):
        return "Supported prediction records; six pairwise comparisons use the same four-method intersection. Preserve source-denominator coverage separately from prediction-denominator distribution summaries."
    return "Every named registry item, source object, or required check, including unavailable and failed entries; metadata counts are not plant counts."


def node_blockers(code: str) -> list[str]:
    if code == "G1_INPUT_ESTIMATOR":
        return ["implementation"]
    if code == "G1_INPUT_QUALITY":
        return ["quality"]
    if code == "G1_INPUT_SEMANTICS":
        return ["prices", "capital", "technology"]
    if code in ("G1_INPUT_CANONICAL", "G1_S00"):
        return []
    if code == "G1_S03":
        return ["selection"]
    if code in ("G1_S05", "G1_S10"):
        return list(BLOCKERS)
    return ["identity", "prices", "capital", "technology", "quality", "implementation"]


def node_status(code: str) -> str:
    return "development_input_and_synthetic_panel_accepted" if code in ("G1_INPUT_CANONICAL", "G1_S00") else "primary_real_state_unadmitted_development_branch_separate"


def current_decision(decision: dict, plan: dict) -> str:
    code = decision["id"]
    if code == "G1_D01":
        return "Select development through harness.data_source.load_data; pin the published G0.5 manifest, schema and selected columns. Preserve predecessor specifications as compatibility evidence only. Actual finalisation requires explicit validated local actual input and a complete rerun."
    if code == "G1_D02":
        return plan["method_protocol"]["required_production_concept"] + " " + plan["method_protocol"]["technology_cells"]
    if code == "G1_D08":
        return "Preserve the pinned two-equation Wooldridge GMM estimator and its shared nuisance coefficients; explicitly request method(wrdg) gmm. Single-step refers to joint estimation rather than sequential OP/LP stages; pinned weighting uses Stata's two-step GMM."
    if code == "G1_D16":
        return "Use 999 external full-process verified-plant cluster draws plus the original estimate, seed 20260913. Require ≥950 successes (ceil(0.95×999)); no PRIMARY REAL bootstrap results before real-input gates pass. The separate nominal DEVELOPMENT contract permits99 draws, at least95 successes, conditional on official fictional linkage. The detailed pinned_method_contract supersedes the stale 499-draw shorthand in the preserved original D16."
    if code == "G1_D18":
        return "Long prediction key: obs_id × method × sample_id × specification_id × normalization_id; validate uniqueness before alias-controlled reshape. Merge the unique wide derivative 1:1 on obs_id, preserve all 33,049 input observations and all originals, keep unsupported values missing. psid is a model prerequisite, never an attachment key substitute. Publish aggregate receipts; keep record-level derivatives private/local."
    if code == "G1_D19":
        return "Validate the executed diagnostic package and independent numeric checks separately from empirical TFP acceptance. Keep G1/#9 open until all four required empirical branches pass. The separate nominal branch may have supported numerical estimates while this primary obligation remains open. No PDF is required."
    return decision["selected_rule"]


def variables(plan: dict, manifest: dict) -> list[dict]:
    rows = [
        ("obs_id", "observation_join_key", "obs_id", "Frozen observation surrogate", "identifier", "Nonempty, unique within the exact manifest", "May join observation derivatives; never establishes a company or a lag."),
        ("psid", "panel_key", "psid; psid_status; identity_real_link_verified", "Official fictional longitudinal development identifier; real linkage separate", "identifier", "Development: synthetic_development and unique psid/year. Actual: authenticated real linkage required", BLOCKERS["identity"]),
        ("year", "calendar", "source_year", "Actual survey calendar year", "calendar year", "Exact t−1/t−2 only; 2016 remains absent", "No row-order or consecutive-wave lag."),
        ("technology", "technology_pool", "industry_code; vs_industry_code; classification_status; external verified classification bridge", "Harmonized two-digit industry", "classification code", "Verified bridge before pooling", BLOCKERS["technology"]),
        ("Y", "dependent_level", "value_added_real; value_added_nominal; deflator_output; deflator_inputs", "Preferred real value added", "constant-price Rp000 only after base and method verified", "Y>0 and valid deflation/source semantics", "No mixed-unit subtraction or nominal substitute. Single-output-deflator approximation would need a separate, explicit specification."),
        ("L", "labor_level", "workers; vs_workers; st_workers", "Canonical worker count", "canonical candidate worker count; source measurement/unit admission still required", "L>0 plus accepted labor-definition and G2 mask", "Use canonical workers, not a precomputed log or unregistered tail-trimmed sensitivity."),
        ("K", "capital_state", "capital_real; capital_stock_nominal; capital_stock_verified; capital_definition_status; money_unit_status; unit_status; deflator_capital", "Verified real capital stock", "constant-price Rp000 stock", "K>0; stock questionnaire concept AND measurement/unit admission AND price valid", "capital_stock_verified is a concept flag only. All current economic unit-admission rules are unresolved. capital_nominal and capital_prior_mixed_nominal are uncertified mixed aliases; additions cannot replace stock."),
        ("I", "OP_proxy_level", "capital_additions_nominal; capital_additions_verified; deflator_capital; accepted investment-definition evidence", "Verified positive real investment", "constant-price Rp000 flow per calendar year", "I>0 with verified economic investment definition", "No real-investment source field is assumed to exist; nominal additions alone do not certify the OP investment proxy."),
        ("M", "LP_ACF_W_proxy_level", "intermediate_inputs_real; intermediate_inputs_nominal; inputs_definition_status; deflator_inputs", "Verified flexible intermediate-input proxy", "constant-price Rp000 flow per calendar year", "M>0; timing, contents and price mapping accepted", "Total expenditure is not automatically materials quantity. Do not substitute val_iinput or nominal input expense silently."),
        ("y", "dependent_log", "ln(Y)", "Log real value added", "natural logarithm", "Only after Y gate passes", "Uncomputed while Y is unavailable."),
        ("l", "labor_log", "ln(L)", "Log workers", "natural logarithm", "Only after L gate passes", "Canonical level is transformed after source/domain checks."),
        ("k", "capital_log", "ln(K)", "Log real capital stock", "natural logarithm", "Only after K gate passes", "Do not use ln_capital_nominal or a mixed stock/flow log."),
        ("p_OP", "investment_log", "ln(I)", "OP investment proxy", "natural logarithm", "Only after I gate passes", "Zero investment is a domain exclusion, not log zero or a fabricated positive amount."),
        ("p_other", "flexible_input_log", "ln(M)", "LP/ACF/Wooldridge input proxy", "natural logarithm", "Only after M gate passes", "Monotonicity and input timing remain assumptions."),
        ("risk_exit", "OP_selection", "external authenticated risk/exit evidence; verified psid/calendar bridge", "Independent risk membership and observed exit", "Boolean outcomes plus reason codes", "Validated risk set; unknown outcome remains unknown", BLOCKERS["selection"]),
        ("tfp_method", "attachment_measure", "y − beta_L*l − beta_K*k", "Structural log value-added residual", "log points", "Supported model/sample prediction only", "Contains productivity plus transitory output/measurement error; not directly observed technical efficiency."),
        ("tfp_method_centered", "normalization", "tfp_method − pooled within-method/technology mean", "Pooled technology mean-centered residual", "log points", "Save mean, N and normalization_id", "Never center by year; doing so erases the temporal pattern."),
    ]
    names = set(manifest["column_names"])
    result = []
    for name, role, sources, definition, units, domain, limitation in rows:
        operands = [s.strip() for s in sources.split(";")]
        present = [v for v in operands if v in names]
        result.append(dict(variable_id=name, role=role, exact_operand_sources=sources,
                           operands_present_in_manifest=present, definition=definition,
                           units=units, eligibility=domain, limitation=limitation,
                           numerical_parent="harness.data_source.load_data(mode='development') only",
                           source_metadata="data/g0-5-development/dictionary.csv; variable-year-coverage.csv",
                           execution_claim="Registry definition only; consult run receipts for observed support."))
    return result


def build_methods(plan: dict) -> None:
    pinned = plan["pinned_method_contract"]
    dump(MODULE / "registries/pinned_method_contract.json", {
        "scope": "Preserved REAL PRIMARY specification; separate nominal-specification.json and nominal branch evidence do not relax these gates",
        "source_plan": relative(PLAN), "source_plan_sha256": sha(PLAN),
        "contract": pinned,
    })
    methods = []
    blocks = [f"# Kontrak empat metode G1\n\n{LABEL}\n\nDokumen ini menetapkan empat estimator yang berbeda. Kontrak bukan bukti bahwa estimator sudah berjalan atau bahwa input empirisnya valid. Simbol: y=ln(nilai tambah riil), l=ln(pekerja), k=ln(stok modal riil), p=ln(proksi yang sesuai). Fungsi produksi utama: y=βL l+βK k+ω+ε.\n"]
    for code in ("OP", "LP", "ACF", "Wooldridge"):
        method = pinned[code]
        methods.append(dict(method=code, source_version=pinned["version"], specification_id="VA_CD_d3_pinned2018", model="valueadded",
                            proxy="p_OP" if code == "OP" else "p_other", equations=method,
                            parameter_units="elasticities", inference="999 external complete-process plant-cluster draws; ≥950 successes",
                            scientific_status="primary_real_unadmitted_nominal_development_separate", code_readiness="Not certified by this registry",
                            source_plan_sha256=sha(PLAN)))
        blocks.append(f"## {code}\n")
        for key, value in method.items():
            blocks.append(f"**{key.replace('_', ' ')}.** {value}\n")
        explanation = {
            "OP": "Investasi menjadi proksi informasi produktivitas yang diketahui pabrik. Tenaga kerja ditaksir pada tahap pertama, modal pada tahap kedua. Koreksi seleksi wajib memakai risiko/keluar yang dibuktikan dari sumber tersendiri. Baris terakhir survei bukan bukti tutup. Sampel seleksi dipertahankan lebih luas daripada sampel investasi positif.",
            "LP": "Input antara menggantikan investasi sebagai proksi. Tahap pertama memisahkan koefisien tenaga kerja dari fungsi proksi; tahap kedua mencari koefisien modal dengan proses produktivitas Markov. Versi sumber yang dipatok memakai kuadrat residu pada tahap kedua. Angka pengeluaran positif belum membuktikan kuantitas, harga riil, atau asumsi monotonisitas.",
            "ACF": "Tahap pertama memasukkan polinomial lengkap tenaga kerja, modal, dan proksi tanpa mengidentifikasi koefisien tenaga kerja secara terpisah. Tahap kedua memilih kedua koefisien dari momen inovasi produktivitas. Instrumen adalah tenaga kerja t−1 dan modal t; itu menuntut asumsi waktu keputusan, bukan sekadar data tidak hilang.",
            "Wooldridge": "Dua persamaan diestimasi bersama dengan GMM. Persamaan kini dan lag memiliki instrumen berbeda, dan versi sumber ini membatasi koefisien proksi agar sama di kedua persamaan. Istilah sistem bersama tidak berarti satu langkah pembobotan: spesifikasi memakai pembobotan GMM dua tahap. Cabang IV linear bawaan bukan pengganti sistem yang diminta.",
        }[code]
        blocks.append(explanation + "\n")
    blocks.extend(["## Aturan bersama\n", plan["method_protocol"]["minimum_support"] + "\n",
                   plan["method_protocol"]["calendar"] + "\n", pinned["common_basis"] + "\n",
                   pinned["calendar_controls"] + "\n", pinned["prediction_contract"]["common_four_method_output"] + "\n",
                   pinned["prediction_contract"]["proxy_latent_companion"] + "\n",
                   "Polinomial tahap pertama derajat 3 adalah utama; derajat 2 adalah sensitivitas. Proses Markov OP/LP/ACF tetap kubik dalam implementasi yang dipatok. Tahan semua sel gagal dan laporkan peringkat matriks, momen, tujuan optimisasi, titik awal dan konvergensi. Konvergensi bukan pembuktian identifikasi.\n",
                   "Inferensi yang terdaftar: 999 pengambilan ulang klaster perusahaan atas seluruh proses, di luar estimasi asli, seed 20260913. Minimal 950 berhasil. Kovarians menggunakan pembagi B_berhasil−1. Aturan999 ini berlaku pada primary real. Cabang nominal DEVELOPMENT memakai99 draw dengan minimal95 sukses, bersyarat pada ID fiktif resmi; hasilnya bukan inferensi populasi.\n",
                   "Sumber kontrak: [rencana G1](../../../releases/2026-09-13-data-foundation/stata-preparation/row-plans/G1.json) dan [kontrak sumber yang dipatok](pinned_method_contract.json). Definisi ini mempertahankan spesifikasi warisan; lihat bukti penerimaan implementasi terpisah sebelum pemakaian empiris.\n"])
    table(MODULE / "registries/methods.csv", methods)
    write(MODULE / "registries/method-contracts.md", "\n".join(blocks))
    specs = []
    for code in ("OP", "LP", "ACF", "Wooldridge"):
        for sample in ("method_specific", "common_four"):
            for degree in (3, 2):
                specs.append(dict(method=code, sample_id=sample, specification_id=f"VA_CD_d{degree}_pinned2018",
                                  production_model="valueadded Cobb–Douglas", technology="verified harmonized two-digit pool",
                                  nuisance_degree=degree, markov_degree="3" if code != "Wooldridge" else "same nuisance degree",
                                  controls="none", bootstrap_draws=999, seed=20260913,
                                  minimum_plants=50, minimum_dynamic_records=250, minimum_waves=6,
                                  status="blocked; technology universe is unverified so no cell-count claim"))
    table(MODULE / "registries/specifications.csv", specs)
    aliases = []
    for code, suffix in (("OP", "OP"), ("LP", "LP"), ("ACF", "ACF"), ("Wooldridge", "W")):
        for normalization in ("raw", "pooled_technology_centered"):
            aliases.append(dict(column=f"tfp_{suffix}" + ("_centered" if normalization != "raw" else ""),
                                method=code, sample_id="method_specific", specification_id="VA_CD_d3_pinned2018",
                                normalization_id=normalization, measure_type="structural_log_VA_residual",
                                units="log points", join_key="obs_id", supported_values="none until validated estimator results exist",
                                current_status_sidecar_column={"OP":"tfp_op", "LP":"tfp_lp", "ACF":"tfp_acf", "W":"tfp_wrdg"}[suffix] if normalization == "raw" else "not created",
                                sidecar_measure_type="structural_log_VA_residual_NOT_ESTIMATED",
                                sidecar_normalization_id="raw_structural_log_VA_residual" if normalization == "raw" else "not created"))
    table(MODULE / "registries/column_aliases.csv", aliases)


def build_diagrams(plan: dict) -> None:
    mermaid = ["flowchart TB"]
    dot = ['digraph G1 {', 'graph [rankdir=TB, bgcolor="white", pad=0.4, nodesep=0.28, ranksep=0.48, labelloc=t, label="G1: preserved24 primary states/19edges +7 nominal stages +6 deep diagnostics\\nG0.5 v3 DEVELOPMENT | real primary separate from nominal execution", fontname="Arial", fontsize=18];',
           'node [shape=box, style="rounded,filled", fontname="Arial", fontsize=11, margin="0.14,0.09", color="#b96b42", fillcolor="#fff1e7"];',
           'edge [color="#94a3b8", arrowsize=0.6, fontname="Arial", fontsize=9];']
    short = {
        "G1_INPUT_ESTIMATOR": "Pinned method source", "G1_INPUT_QUALITY": "Same-version G2 masks", "G1_INPUT_SEMANTICS": "Units / definitions / prices",
        "G1_INPUT_CANONICAL": "Frozen G0.5 input", "G1_S00": "Input manifest", "G1_S01": "Freeze method / input contracts", "G1_S02": "Real production / technology",
        "G1_S03": "Synthetic panel / calendar lags", "G1_S04": "Input eligibility", "G1_S05": "OP investment / selection", "G1_S06": "LP proxy support",
        "G1_S07": "ACF timing / moments", "G1_S08": "Wooldridge system", "G1_S09": "Own / common dynamic samples", "G1_S10": "Estimate OP", "G1_S11": "Estimate LP",
        "G1_S12": "Estimate ACF", "G1_S13": "Estimate Wooldridge", "G1_S14": "Rank / convergence / sensitivity", "G1_S15": "Predict / normalize",
        "G1_S16": "999 full-process draws", "G1_S17": "Compare shared predictions", "G1_S18": "1:1 attachment to obs_id", "G1_S19": "Replication / acceptance",
    }
    for node in plan["nodes"]:
        code = node["id"]
        label = f"{code}<br/>{short[code]}<br/>{'INPUT FROZEN' if code in ('G1_S00','G1_INPUT_CANONICAL') else 'REAL PRIMARY UNADMITTED'}"
        mermaid.append(f'  {code}["{label}"]')
        fill = "#e9f4f1" if code in ("G1_S00", "G1_INPUT_CANONICAL") else "#fff1e7"
        dotlabel = label.replace("<br/>", "\\n")
        dot.append(f'  {code} [label="{dotlabel}", fillcolor="{fill}"];')
    for stage in NOMINAL_STAGES:
        code = "G1_" + stage["id"]
        label = f"{code}<br/>{stage['title']}<br/>NOMINAL DEVELOPMENT: IMPLEMENTED; SEE RECEIPTS"
        mermaid.append(f'  {code}["{label}"]')
        dotlabel = label.replace("<br/>", "\\n")
        dot.append(f'  {code} [label="{dotlabel}", fillcolor="#e8f0fc"];')
    for stage in DEEP_STAGES:
        code = "G1_" + stage["id"]
        label = f"{code}<br/>{stage['title']}<br/>DEEP NOMINAL DIAGNOSTIC; REAL PRIMARY SEPARATE"
        mermaid.append(f'  {code}["{label}"]')
        dotlabel = label.replace("<br/>", "\\n")
        dot.append(f'  {code} [label="{dotlabel}", fillcolor="#eaf4e5"];')
    mermaid_nodes, dot_nodes = mermaid[:], dot[:]
    links = []
    for edge in plan["edges"]:
        for source in edge["input_nodes"]:
            for target in edge["output_nodes"]:
                links.append((source, target, edge["id"]))
                mermaid.append(f'  {source} -->|{edge["id"]}| {target}')
                dot.append(f'  {source} -> {target} [label="{edge["id"].replace("G1_", "")}"];')
    for index, stage in enumerate(NOMINAL_STAGES):
        target = "G1_" + stage["id"]
        inputs = ["G1_INPUT_CANONICAL"] if index == 0 else ["G1_" + NOMINAL_STAGES[index-1]["id"]]
        if stage["id"] == "N07":
            inputs.append("G1_INPUT_CANONICAL")
        for source in inputs:
            links.append((source, target, "G1_NE" + stage["id"][1:]))
            mermaid.append(f'  {source} -->|G1_NE{stage["id"][1:]}| {target}')
            dot.append(f'  {source} -> {target} [label="NE{stage["id"][1:]}"];')
    for stage in DEEP_STAGES:
        target = "G1_" + stage["id"]
        edge_id = "G1_NE" + stage["id"][1:]
        for source in stage["input_nodes"]:
            links.append((source, target, edge_id))
            mermaid.append(f'  {source} -->|{edge_id}| {target}')
            dot.append(f'  {source} -> {target} [label="NE{stage["id"][1:]}"];')
    ranks = []
    for group in ([n["id"] for n in plan["nodes"][:5]], [f"G1_S{x:02d}" for x in range(5,9)], [f"G1_S{x:02d}" for x in range(10,14)], ["G1_S15", "G1_S16"]):
        ranks.append("  { rank=same; " + "; ".join(group) + "; }")
    write(MODULE / "dag/G1-full.mmd", "\n".join(mermaid) + "\n")
    write(MODULE / "dag/G1-full.dot", "\n".join(dot + ranks + ["}"]) + "\n")
    # The reading view removes only transitive dependency arrows. All original
    # numerical input links remain in G1-full and the exact edge registry.
    adjacency = {n["id"]: set() for n in plan["nodes"]}
    adjacency.update({"G1_" + stage["id"]: set() for stage in NOMINAL_STAGES})
    adjacency.update({"G1_" + stage["id"]: set() for stage in DEEP_STAGES})
    for source, target, _ in links:
        adjacency[source].add(target)

    def indirect(source: str, target: str) -> bool:
        queue, seen = list(adjacency[source] - {target}), set()
        while queue:
            vertex = queue.pop()
            if vertex == target:
                return True
            if vertex not in seen:
                seen.add(vertex)
                queue.extend(adjacency[vertex])
        return False

    for source, target, edge in links:
        if not indirect(source, target):
            mermaid_nodes.append(f'  {source} -->|{edge}| {target}')
            dot_nodes.append(f'  {source} -> {target} [label="{edge.replace("G1_", "")}"];')
    dot_nodes[1] = dot_nodes[1].replace("G0.5 v3 DEVELOPMENT | real primary separate from nominal execution", "G0.5 DEVELOPMENT — perturbed data; not final empirical findings\\nReading view: transitive arrows omitted; exact inputs in G1-full and edges.csv")
    write(MODULE / "dag/G1.mmd", "\n".join(mermaid_nodes) + "\n")
    write(MODULE / "dag/G1.dot", "\n".join(dot_nodes + ranks + ["}"]) + "\n")
    method_dot = '''digraph methods {
graph [rankdir=LR, bgcolor="white", pad=0.35, nodesep=0.4, ranksep=0.65, labelloc=t, label="Four distinct TFP estimators | definitions, not execution results\\nG0.5 DEVELOPMENT — perturbed data; not final empirical findings", fontsize=19, fontname="Arial"];
node [shape=box, style="rounded,filled", fillcolor="#eff5fa", color="#64748b", fontname="Arial", fontsize=13, margin="0.2,0.15"];
edge [color="#94a3b8"];
Y [label="Value-added Cobb–Douglas\\ny = beta_L l + beta_K k + omega + error\\nReal primary: accepted prices + real links\\nNominal development: official fictional panel"];
OP [label="OP: investment proxy\\nLabor first stage; capital second stage\\nReal primary: authenticated economic exits\\nDevelopment: separately declared simulated risk"];
LP [label="LP: flexible-input proxy\\nLabor first stage; capital second stage\\nCubic productivity transition"];
ACF [label="ACF: labor enters proxy basis\\nBoth coefficients from innovation moments\\nInstruments: lag labor, current capital"];
W [label="Wooldridge: two-equation GMM\\nCurrent and lagged proxy functions\\nEquation-specific instruments"];
R [label="Common reported residual\\nr = y − beta_L l − beta_K k\\nRaw + pooled technology centered\\nNot directly observed technical efficiency", fillcolor="#fff1e7"];
Y -> OP; Y -> LP; Y -> ACF; Y -> W;
OP -> R; LP -> R; ACF -> R; W -> R;
{rank=same; OP; LP; ACF; W;}
}
'''
    write(MODULE / "registries/methods.dot", method_dot)
    if not shutil.which("dot"):
        raise RuntimeError("Graphviz dot is required to reproduce the SVG diagrams; install it or use an existing supported runtime.")
    for base in (MODULE / "dag/G1", MODULE / "dag/G1-full", MODULE / "registries/methods"):
        subprocess.run(["dot", "-Tsvg", str(base.with_suffix(".dot")), "-o", str(base.with_suffix(".svg"))], check=True)


def main() -> None:
    global EVIDENCE_ROOT
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--evidence-run", type=Path, help="Read current external aggregate receipts before publication; default is release/. Does not copy outputs or run Stata.")
    args = parser.parse_args()
    if args.evidence_run:
        EVIDENCE_ROOT = args.evidence_run.resolve()
    plan, manifest = json.loads(PLAN.read_text()), json.loads(INPUT.read_text())
    assert sha(INPUT) == CURRENT_INPUT_HASH and manifest["identity"]["status"] == "synthetic_development"
    assert len(plan["nodes"]) == 24 and len(plan["edges"]) == 19 and len(plan["exhibits"]) == 24
    dag = MODULE / "dag"
    base_evidence = dict(plan=relative(PLAN), plan_sha256=sha(PLAN), input_manifest=relative(INPUT), input_manifest_sha256=sha(INPUT))
    dump(MODULE / "registries/source-preservation.json", {**base_evidence, "source": plan["source"], "source_fields_modified": False,
         "boundary_migration": "The later execution_input_policy supersedes the historical actual wave input path for development; obs_id replaces private source_row in public observation contracts. Historical source request/number/PIC/completion are preserved verbatim."})
    dump(MODULE / "registries/blockers.json", {"scope": LABEL, "blockers": BLOCKERS, **base_evidence})
    build_methods(plan)
    table(MODULE / "registries/variables.csv", variables(plan, manifest))
    decisions = {d["id"]: d for d in plan["decisions"]}
    producing = {n: e for e in plan["edges"] for n in e["output_nodes"]}
    node_rows, triage_rows, evidence_rows = [], [], []
    for node in plan["nodes"]:
        code = node["id"]
        parent_edge = producing.get(code)
        decision = decisions[parent_edge["decision_ids"][0]] if parent_edge else None
        chosen = current_decision(decision, plan) if decision else "Freeze this source as a distinct declared input; metadata availability does not waive substantive method gates."
        reasons = node_blockers(code)
        contract = {
            "node_id": code, "branch": "primary_real_prerequisite_audit", "source_plan_node_preserved": node, "effective_state": node["state"].split(" — planned output")[0],
            "material_state_status": node_status(code), "diagnostic_status": "See hash-bound run evidence; not inferred from this contract",
            "grain": node["grain"].replace("source record × year", "frozen observation"), "keys": effective_keys(node),
            "input_nodes": parent_edge["input_nodes"] if parent_edge else [], "producing_edge": parent_edge["id"] if parent_edge else None,
            "audit_output_contract": {"paths_relative_to_private_run": AUDIT_OUTPUTS[int(parent_edge["id"].split("E")[1])] if parent_edge else [],
                                      "role": AUDIT_ROLES[int(parent_edge["id"].split("E")[1])] if parent_edge else "Source input contract",
                                      "publication": "Only screened aggregate outputs copied to release/outputs. Private run root is recorded in run-manifest.json; .dta intermediates are outside the repository.",
                                      "existence_and_execution": "Declared artifact names; actual existence/hash/status comes only from the run manifest."},
            "required_fields": ["obs_id" if x == "source_row" else "psid" if x == "firm_id" else x for x in node["required_fields"]],
            "units": effective_units(node), "calendar": YEARS, "denominator": denominator(node),
            "missingness": "Keep source absence, unknown definition/unit, parse failure, observed zero/negative and valid positive states distinct. Unsupported statistical values stay missing, never zero.",
            "row_reconciliation": "Observation diagnostics preserve 33,049 unique obs_id. Method expansion checks 33,049 × declared method/sample combinations separately. Any filtering records marginal and sequential losses. Aggregates reconcile to their explicit fixed denominators.",
            "input_output_contract": "A validated numerical state and a typed unsupported receipt are distinct output types. A receipt cannot be consumed as the numerical state required by another estimator edge.",
            "current_decision": chosen, "blocked_dependencies": {k: BLOCKERS[k] for k in reasons},
            "numerical_output_privacy": "Record-level intermediate/output datasets remain local/private; only appropriate aggregate diagnostic tables and receipts are published.",
            **base_evidence,
        }
        directory = dag / "nodes" / code
        dump(directory / "contract.json", contract)
        write(directory / "triage.md", f"# {code} — triage\n\n{LABEL}\n\nStatus: **{node_status(code)}**.\n\nPertanyaan: {contract['effective_state']}.\n\nKontrak telah dicatat; status ini tidak menyatakan komputasi atau estimator berhasil. Bukti diagnostik yang tersedia harus dilihat pada manifest run.\n\n" + "\n".join(f"- `{k}`: {BLOCKERS[k]}" for k in reasons) + "\n\nBuka kembali hanya saat ada input/definisi/implementasi baru, perubahan hash, pemeriksaan gagal, atau koreksi pemilik. Jangan mengulang keputusan yang tertutup tanpa pemicu tersebut.\n")
        write(directory / "decision.md", f"# {code} — decision\n\n{LABEL}\n\n**Keputusan saat ini.** {chosen}\n\n**Grain dan key.** {contract['grain']}; `{', '.join(contract['keys'])}`.\n\n**Penyebut.** {contract['denominator']}\n\n**Unit.** {json.dumps(contract['units'], ensure_ascii=False)}\n\n**Waktu.** {YEARS}.\n\n**Missing dan keluaran.** {contract['missingness']} {contract['input_output_contract']}\n\n**Bukti.** Rencana `{relative(PLAN)}` SHA256 `{sha(PLAN)}`; manifest G0.5 SHA256 `{sha(INPUT)}`. Rincian asli dan kontrak efektif: [contract.json](contract.json).\n\n**Aturan pembukaan kembali.** Perubahan hash input/kode/keputusan, bukti sumber baru, pemeriksaan gagal, atau instruksi pemilik.\n" + (f"\n**Teks keputusan rencana asli, dipertahankan.** {decision['selected_rule']}\n" if decision else ""))
        node_rows.append(dict(node_id=code, state=contract["effective_state"], material_state_status=node_status(code), grain=contract["grain"], keys=contract["keys"], units=contract["units"], calendar=YEARS, denominator=contract["denominator"], input_nodes=contract["input_nodes"], producing_edge=contract["producing_edge"], contract=relative(directory / "contract.json"), contract_sha256=sha(directory / "contract.json")))
        triage_rows.append(dict(triage_id=f"{code}-T01", node_id=code, status=node_status(code), question=contract["effective_state"], blockers=reasons, reopen_rule="New source/code/decision hash, new source evidence, failed check or explicit owner correction", triage_file=relative(directory / "triage.md")))
        evidence_rows.append(dict(node_id=code, decision_id=decision["id"] if decision else f"{code}-D01", selected_rule=chosen, material_state_status=node_status(code), evidence_file=relative(directory / "contract.json"), evidence_sha256=sha(directory / "contract.json"), **base_evidence))
    nominal_nodes, nominal_triage, nominal_decisions, nominal_edges = build_nominal_contracts(base_evidence)
    node_rows.extend(nominal_nodes)
    triage_rows.extend(nominal_triage)
    evidence_rows.extend(nominal_decisions)
    deep_info = deep_evidence_bundle()
    deep_nodes, deep_triage, deep_decisions, deep_edges = build_deep_contracts(base_evidence, deep_info)
    node_rows.extend(deep_nodes)
    triage_rows.extend(deep_triage)
    evidence_rows.extend(deep_decisions)
    assert len(node_rows) == 37, f"Expected 37 preserved + development DAG nodes, got {len(node_rows)}"
    table(dag / "registries/nodes.csv", node_rows)
    table(dag / "registries/triage_ledger.csv", triage_rows)
    table(dag / "registries/decision_evidence_ledger.csv", evidence_rows)
    edge_rows = []
    for e in plan["edges"]:
        code = e["id"]
        edge_path = MODULE / "stata/edges" / f"{code}.do"
        if not edge_path.exists():
            matches = sorted((MODULE / "stata/edges").glob(f"{code.replace('G1_', '')}*.do")) if (MODULE / "stata/edges").exists() else []
            if len(matches) == 1:
                edge_path = matches[0]
        edge_rows.append(dict(edge_id=code, title=e["title"], input_nodes=e["input_nodes"], output_nodes=e["output_nodes"], depends_on=e["depends_on"],
                             primary_do="work-items/G1/stata/G1.do", do_file=relative(edge_path), source_exists=edge_path.exists(),
                             code_sha256=sha(edge_path) if edge_path.exists() else "", original_plan_do_file=e["do_file"],
                             decision_ids=e["decision_ids"], required_action=e["action"], required_validation=e["validation"],
                             implemented_audit_role=AUDIT_ROLES[int(code.split("E")[1])], audit_outputs_relative_to_private_run=AUDIT_OUTPUTS[int(code.split("E")[1])],
                             numerical_state_status="primary_real_unadmitted_nominal_execution_separate", execution_status="Consult run receipt; never inferred from code existence",
                             failure_behavior=e["failure_behavior"]))
    edge_rows.extend(nominal_edges)
    edge_rows.extend(deep_edges)
    assert len(edge_rows) == 32, f"Expected 32 preserved + development DAG edges, got {len(edge_rows)}"
    table(dag / "registries/edges.csv", edge_rows)
    write(dag / "TRIAGE_LEDGER.md", f"# G1 triage ledger\n\n{LABEL}\n\nThe original 24 nodes, 19 computational edges and 19 numbered decisions remain traceable. The frozen development input is available; the real-primary states remain unadmitted. N01–N07 remain the separate nominal-development execution branch. N08–N13 are a separate deep-diagnostics branch that reads the frozen source, fit, prediction, and draw states; it introduces no coefficient fits and does not materialize accepted-real states. See [deep exhibit reconciliation](../registries/deep-exhibit-reconciliation.md).\n\n| Node | Required state | Material status |\n|---|---|---|\n" + "\n".join(f"| [{r['node_id']}](nodes/{r['node_id']}/triage.md) | {r['state']} | {r['material_state_status']} |" for r in node_rows) + "\n")
    write(dag / "README.md", f"# G1 analytical DAG\n\n{LABEL}\n\n[Readable DAG](G1.svg) · [Mermaid](G1.mmd) · [full input DAG](G1-full.svg) · [full Mermaid](G1-full.mmd) · [node contracts](registries/nodes.csv) · [edge mapping](registries/edges.csv) · [triage ledger](TRIAGE_LEDGER.md) · [decision/evidence mirror](registries/decision_evidence_ledger.csv) · [deep exhibit mapping](../registries/deep-exhibit-reconciliation.md).\n\nThe original source plan remains unchanged at 24 states, 19 edges, and 24 exhibit families. The generated DAG adds seven separate nominal-development stages N01–N07 and six deep diagnostic stages N08–N13, for 37 nodes and 32 producing edges. Every original state keeps its triage, decision and JSON contract. The readable diagram omits only transitive dependency arrows; G1-full and the edge registry retain every direct input edge.\n\nThe N08–N13 edges follow the actual source files: N08 uses S01 and N01; N09 uses N03 and N04; N10 uses N01, N03 and N04; N11 uses the N03 sector universe and the private paired predictions created from N10; N12 uses the private primary-prediction intermediate created by N10; N13 uses N03 for the sector universe plus N04 fits and N05 draw files. The single diagnostics entry point is `stata/G1.do`; its separately recorded diagnostics route calls child driver `stata/deep/G1_deep.do`, which dispatches the stage-specific `.do` files. Their screened aggregate evidence lives in `deep-release/`, separate from the primary `release/`. Record-level intermediates remain in the external run. The independent arithmetic receipt validates aggregates but does not admit real-primary TFP; method and common-sample support are reported from the current fit ledger.\n\nDevelopment input is the shared adapter's G0.5 projection. Observation joins use `obs_id`; development dynamics use the official v3 `synthetic_development` psid. Only actual finalisation requires authenticated real linkage. The older actual wave paths and private source-row keys remain historical provenance in `source_plan_node_preserved`, not current numerical operands.\n\nReproduce contracts from repository root with `python3 work-items/G1/build_contracts.py`; Graphviz `dot` renders the two SVG diagrams. The builder does not run Stata or compute chart values. It refreshes source and receipt hashes, all 37 node contracts, all 32 edge records, and separate 24-family and deep-diagnostics exhibit registries.\n\nEach contract declares grain, keys, units, calendar coverage, denominator, missing states, input/output type, decisions and source hashes. All restricted record-level derivatives remain local.\n")
    build_diagrams(plan)
    build_exhibits(plan)
    deep_exhibit_rows = build_deep_exhibits(deep_info)
    update_development_branches(deep_info)
    artifacts = [p for folder in (dag, MODULE / "registries") for p in folder.rglob("*") if p.is_file() and p.name != "contracts-manifest.json"]
    dump(MODULE / "registries/contracts-manifest.json", {**base_evidence, "builder_sha256": sha(Path(__file__)), "node_count": len(node_rows), "edge_count": len(edge_rows), "preserved_primary_nodes": 24, "preserved_primary_edges": 19, "nominal_stages": 7, "deep_diagnostic_stages": 6, "evidence_root": str(EVIDENCE_ROOT), "preserved_primary_exhibit_count": 24, "deep_supplementary_exhibit_count": len(deep_exhibit_rows), "total_registered_exhibit_families": 24 + len(deep_exhibit_rows), "deep_validation_status": deep_info.get("validation_status"), "deep_validation_cells": (deep_info.get("validation") or {}).get("aggregate_cells_compared"), "deep_final_execution_status": deep_info.get("final_execution_status"), "deep_final_execution_verified": deep_info.get("final_execution_verified"), "deep_final_execution_receipt": "work-items/G1/qa/deep-final-execution.json" if deep_info.get("final_execution") else None, "deep_final_execution_receipt_sha256": deep_info.get("final_execution_sha256"), "files": [{"path": relative(p), "sha256": sha(p), "bytes": p.stat().st_size} for p in sorted(artifacts)]})
    print(f"G1 contracts built: {len(node_rows)} nodes, {len(edge_rows)} edges; original 24 exhibit families preserved plus {len(deep_exhibit_rows)} separate deep-diagnostic families. Real-primary admission remains false; deep validation status={deep_info.get('validation_status')}.")


def build_exhibits(plan: dict) -> None:
    # Names are module-relative output contracts. Mere existence records evidence,
    # never statistical acceptance; missing artifacts retain blocked status.
    maps = nominal_exhibit_maps()
    rows = []
    for x in plan["exhibits"]:
        num = int(x["id"].split("X")[1])
        desired, paths, delivered, missing = maps.get(num, ("blocked", [], "No numerical exhibit delivered.", "Validated real production inputs, verified panel/technology and accepted four-method estimates are absent; dependent rank, sensitivity, bootstrap, distribution or comparison values cannot be manufactured."))
        available = [p for p in paths if evidence_path(p).is_file()]
        # A partial source exhibit only becomes partial once some mapped evidence
        # exists; its remaining obligation never disappears on file existence.
        status = desired if available else "blocked"
        if num == 23 and not any(p.endswith("attachment.csv") or p.endswith("tfp_attachment_audit.csv") for p in available):
            delivered = "Nominal attachment code and aliases are implemented; final full-master attachment receipt is not present in this selected evidence root yet."
        rows.append(dict(exhibit_id=x["id"], original_title=x["title"], original_kind=x["kind"], priority=x["priority"], status=status,
                         source_nodes=x["source_nodes"], original_formula=x["formula_or_specification"],
                         original_denominator=x["sample_and_denominator"], effective_scope=LABEL,
                         mapped_artifacts=paths, existing_artifacts=available, delivered_scope=delivered if available else "Mapped evidence has not been generated in this checkout.",
                         remaining_obligation=missing, evidence_sha256={p: sha(evidence_path(p)) for p in available},
                         status_rule="Delivered refers only to the named exhibit scope; partial/blocked core exhibits keep #9 open."))
    table(MODULE / "registries/exhibits.csv", rows)
    dump(MODULE / "registries/exhibits.json", {"label": LABEL, "source_plan_sha256": sha(PLAN), "exhibits": rows})
    write(MODULE / "registries/exhibit-reconciliation.md", f"# Reconciliation of all 24 G1 exhibit families\n\n{LABEL}\n\nNo planned exhibit has been silently dropped. Four definition exhibits can be delivered before empirical estimation. A partial diagnostic is explicitly narrower than its original exhibit; all unfulfilled numerical obligations remain open. Mere file presence records available evidence, not successful statistical validation. The full original formula and denominator are preserved in [exhibits.csv](exhibits.csv).\n\n| ID | Original exhibit | Status | Available coverage | Remaining requirement |\n|---|---|---|---|---|\n" + "\n".join(f"| {r['exhibit_id']} | {r['original_title']} | **{r['status']}** | {r['delivered_scope']} | {r['remaining_obligation']} |" for r in rows) + "\n\nNominal development maps partial numerical evidence into all four chart families; this does not discharge real-primary obligations. Current nominal OP and common-sample results are included wherever their declared support rules pass. The issue’s four chart families remain distinct: G1-C1 eligible sample flow/coverage by method, sector and year; G1-C2 input coefficients/returns to scale with supported uncertainty; G1-C3 TFP distributions on own and common samples; G1-C4 rank/scatter comparisons plus failure/convergence summaries. Nominal support, coefficients and exploratory uncertainty, residual distributions, and shared-record rank comparisons supply separate partial C1–C4 evidence. Failed/unsupported cells remain in their denominators; no accepted-real completion is inferred.\n")
    chart_families = [
        dict(chart_id="G1-C1", requested="Eligible sample flow/coverage by method, sector and year", planned_exhibits=["G1-X03","G1-X04","G1-X05","G1-X06","G1-X09","G1-X19"], evidence=["release/outputs/nominal_sample_support.csv","release/figures/nominal_sample_support.svg"], partial_scope="Declared nominal own/common source, production, dynamic and simulated-selection support; OP/common failures retained. Real-primary admission remains false."),
        dict(chart_id="G1-C2", requested="Input coefficients/returns to scale and supported uncertainty", planned_exhibits=["G1-X10","G1-X11","G1-X12","G1-X13","G1-X14","G1-X18"], evidence=["release/outputs/nominal_coefficients.csv","release/outputs/nominal_bootstrap_summary.csv","release/figures/nominal_coefficients.svg"], partial_scope="Nominal LP/ACF/WRDG primary and sensitivity coefficients; exploratory99-draw intervals conditional on fictional linkage. OP/common unsupported; not real-VA primary."),
        dict(chart_id="G1-C3", requested="TFP distributions on own and common samples", planned_exhibits=["G1-X20","G1-X22"], evidence=["release/outputs/nominal_distribution_quantiles.csv","release/outputs/nominal_histogram_bins.csv","release/figures/nominal_residual_distribution.svg"], partial_scope="Nominal structural residuals on pooled primary dynamic fit records, raw and sector-method centered; no tail trimming. Empty OP/common distributions retained; no physical/real TFP claim."),
        dict(chart_id="G1-C4", requested="Method rank/scatter and failure/convergence summaries", planned_exhibits=["G1-X15","G1-X16","G1-X17","G1-X21"], evidence=["release/outputs/nominal_optimizer_diagnostics.csv","release/outputs/nominal_pairwise_comparisons.csv","release/outputs/nominal_rank_scatter_bins.csv","release/figures/nominal_rank_comparison.svg"], partial_scope="Nominal rank/optimizer evidence and pairwise shared-record comparisons; separate empty four-method scope. Scatter releases aggregate bins of at least5 observations."),
    ]
    for family in chart_families:
        family["existing_evidence"] = [p for p in family["evidence"] if evidence_path(p).is_file()]
        family["status"] = "partial" if family["existing_evidence"] else "blocked"
        family["scope"] = LABEL
        family["evidence_root"] = str(EVIDENCE_ROOT)
        family["evidence_sha256"] = {p: sha(evidence_path(p)) for p in family["existing_evidence"]}
    table(MODULE / "registries/chart-families.csv", chart_families)

NOMINAL_STAGES = [
    dict(id="N01", title="Declared nominal production inputs", file="N01_inputs.do", inputs=["S01_input.dta", "nominal-specification.json"], outputs=["nominal/N01_source.dta"], public=[], keys=["obs_id", "psid", "source_year"], grain="One original source observation", denominator="33049 source rows in2010–2015 and2017–2022; beginning-capital production candidates2011–2015 and2018–2022", decision="Use positive reported VA/workers/materials, assumed reported investment additions, and beginning-K equal to assumed prior year-end stock with exact delta1. Unknown common monetary scale is a declared development assumption, not source certification."),
    dict(id="N02", title="Synthetic disappearance intervals", file="N02_risk.do", inputs=["nominal/N01_source.dta"], outputs=["nominal/N02_source_and_risk.dta"], public=[], keys=["psid", "source_year"], grain="Original production observation or explicitly typed derivative interval endpoint", denominator="One interval per source fictional firm at every adjacent supplied calendar-year pair, before production complete-case filtering; interval-only rows never count as source observations", decision="Use official psid/predecessor linkage. Matched next-calendar-year assignment means simulated disappearance0; unmatched means1. Endpoint-only rows have no obs_id or invented output. This is not authenticated economic closure."),
    dict(id="N03", title="Own and common support", file="N03_samples.do", inputs=["nominal/N02_source_and_risk.dta"], outputs=["nominal/N03_frozen.dta", "nominal/support.dta"], public=["nominal_sample_support.csv"], keys=["sector", "method", "sample_id"], grain="Original records plus typed risk intervals; support table by sector × method × own/common sample", denominator="Count source rows, pre-lag positive production domain, exact current×lag dynamic intersection, and lag-covariate selection intervals separately. Dynamic endpoints2012–2015 and2019–2022, subject to observed positive input support", decision="Freeze method-specific and four-method common pre-lag domains. Wrapper applies exact annual intersection once. Do not pool sectors or relax first-stage100/dynamic50/firms50/selection100/exits10/continuers10 thresholds."),
    dict(id="N04", title="Nominal points and sensitivities", file="N04_fits.do", inputs=["nominal/N03_frozen.dta", "nominal-specification.json", "stata/methods/METHOD-CONTRACT.md"], outputs=["nominal/fit_results.dta", "nominal/N04_predictions.dta"], public=["nominal_coefficients.csv", "nominal_optimizer_diagnostics.csv"], keys=["sector", "method", "sample_id", "variant", "start", "poly"], grain="Declared fit cell; prediction sidecar additionally keyed by original obs_id", denominator="All declared sector×method×own/common×variant cells, including every unsupported cell. Primary d3/OLS, d3 low/high starts and d2 sensitivity retained", decision="Fit the pinned distinct methods under explicit nominal_development/syntheticpanel1; freeze within-cell log medians before optimizer. Restore native-log residuals; normalize by the sector-method-sample pooled dynamic fit mean. Only successful supported cells produce predictions."),
    dict(id="N05", title="Exploratory full-process bootstrap", file="N05_bootstrap.do", inputs=["nominal/fit_results.dta", "nominal/N03_frozen.dta"], outputs=["nominal/bootstrap_summary.dta", "nominal/bootstrap_<sector>_<method>_<sample>.*"], public=["nominal_bootstrap_summary.csv"], keys=["sector", "method", "sample_id", "draw (draw table only)"], grain="One successful primary cell summary and every requested synthetic-firm cluster draw", denominator="99 requested complete-process draws per successful primary cell, separate original estimate; at least95 successes for exploratory percentile intervals; covariance divisor B_success−1", decision="Resample complete synthetic-firm histories and interval rows with new draw IDs; reconstruct lags and rerun stages. Preserve failed draws. Seed9132026; inference conditional on frozen generator linkage, not population or999-draw primary acceptance."),
    dict(id="N06", title="Distributions comparisons and sidecar", file="N06_outputs.do", inputs=["nominal/N04_predictions.dta", "nominal/N03_frozen.dta", "S01_input.dta"], outputs=["nominal/N06_selected_attached.dta"], public=["nominal_distribution_quantiles.csv", "nominal_histogram_bins.csv", "nominal_pairwise_comparisons.csv", "nominal_rank_scatter_bins.csv"], keys=["obs_id", "source_year (sidecar)", "sector/method/sample/measure (aggregates)", "sector/sample/method-pair/comparison_scope (comparisons)"], grain="Unique original-observation sidecar; separately keyed aggregate distribution/comparison cells", denominator="Primary own/common pooled dynamic fitted records for aggregates; all supported primary domain predictions for attachment; each pairwise intersection and four-method intersection distinguished. Full33049-row source denominator for selected-input attachment; interval rows excluded", decision="Retain all finite tails, width0.5 log histogram bins, raw and sector-method-centered residuals. Pairwise ranks use exactly shared records; preserve empty four-method obligations. Release rank-bin means only when N_bin≥5; no firm scatter points."),
    dict(id="N07", title="Attach full original master", file="N07_master.do", inputs=["full_input.dta", "nominal/N06_selected_attached.dta"], outputs=["analysis/G1_main_with_tfp.dta"], public=["nominal_master_attachment.csv"], keys=["obs_id", "source_year"], grain="Every original full-master observation with separate development nominal columns", denominator="All33049 original observations and4396 original columns preserved; added sidecar coverage counted by source_year and method", decision="Merge unique sidecar1:1 using obs_id/source_year, preserve original order and every original field, keep unsupported residuals missing. Full artifact remains external/private. Code implementation is distinct from completed full-master validation."),
]


DEEP_STAGES = [
    dict(
        id="N08", title="Source-year input domains and distributions", file="N08_inputs.do",
        input_nodes=["G1_S01", "G1_N01"], input_artifacts=["S01_input.dta", "nominal/N01_source.dta"],
        output_files=["deep_input_domains.csv", "deep_input_distributions.csv"],
        keys_by_output={"deep_input_domains.csv": ["source_year", "input"], "deep_input_distributions.csv": ["source_year", "input", "scale"]},
        grain="One source-year × reported/constructed input domain row; a second table adds native/positive/log-positive scale.",
        denominator="All source rows in each observed year (33,049 overall; year-specific full source counts). Beginning capital is constructed from N01 only in its calendar-lag construction window; its other source-year rows remain explicit.",
        calendar="All observed source years 2010–2015 and 2017–2022; production_year_supported labels2011–2015 and2018–2022, not evidence that a fit is admitted.",
        units={"nominal_inputs": "reported nominal source units; no deflation or unit certification", "workers": "reported worker count", "log_positive": "natural-log points of strictly positive input values", "counts": "source observations; no weights"},
        missingness="Missing, zero, negative, positive, and concept-fail counts are separate. k_begin is missing outside the N01 calendar-construction window. Positive values and log usability do not establish accepted measurement units or deflators.",
        suppression="Report domain counts; exact distribution statistics are suppressed when group N<5, while N and fixed bins remain available under the frozen contract.",
        decision="Expose annual nominal input availability and distribution shape without altering the production domain or treating positivity as semantic, unit, or real-price admission.",
        private_intermediates=["intermediate/deep_input_domains.dta", "intermediate/deep_input_distributions.dta"],
        figure_ids=["deep_input_availability_core", "deep_input_availability_proxy"],
        figure_scope="Source-year positive-value availability; a positive count is not a production-fit admission.",
    ),
    dict(
        id="N09", title="Sequential domain, calendar, and admission funnel", file="N09_funnel.do",
        input_nodes=["G1_N03", "G1_N04"], input_artifacts=["nominal/N03_frozen.dta", "outputs/nominal_coefficients.csv"],
        output_files=["deep_method_funnel.csv"],
        keys_by_output={"deep_method_funnel.csv": ["sector", "method", "sample_id", "source_year", "stage"]},
        grain="Sector × method × own/common sample × source year × sequential gate; OP synthetic-risk intervals are separately labelled rows.",
        denominator="Original source-year rows in N03 for each sector/method/sample cell. Sequential counts use the previous gate; prediction_branch uses pre-lag sample-domain rows; OP risk denominators are synthetic intervals between adjacent supplied calendar years, not production rows.",
        calendar="Funnel covers every supplied source year; OP intervals require adjacent calendar years. Sector universe is ALL plus every sector reported in N03.",
        units={"counts": "source rows or explicitly labelled adjacent-year synthetic risk intervals", "losses": "previous-gate count minus retained count", "admission": "primary-fit status from existing nominal coefficient receipt"},
        missingness="Every gate and unsupported primary fit remains in the funnel. A zero retained count is an empty support cell, not zero productivity. No stage imputes missing values or re-estimates coefficients.",
        suppression="Counts and named denominators are retained. No record identifiers are exported.",
        decision="Show sequential and branch-specific attrition with exact denominator labels; preserve N03 own/common domains and current primary-fit skips.",
        private_intermediates=["intermediate/deep_method_funnel.dta"],
        figure_ids=["deep_op_support"],
        figure_scope="OP gate-support chart from the current nominal support receipt; successful OP coefficient results are reported separately.",
    ),
    dict(
        id="N10", title="Primary prediction coverage, profiles, tails, and histograms", file="N10_profiles.do",
        input_nodes=["G1_N01", "G1_N03", "G1_N04"], input_artifacts=["nominal/N01_source.dta", "nominal/N03_frozen.dta", "nominal/N04_predictions.dta"],
        output_files=["deep_prediction_profiles.csv", "deep_prediction_tails.csv", "deep_prediction_histograms.csv"],
        keys_by_output={"deep_prediction_profiles.csv": ["sector", "method", "sample_id", "source_year", "fit_scope", "measure"], "deep_prediction_tails.csv": ["sector", "method", "sample_id", "source_year", "fit_scope", "measure"], "deep_prediction_histograms.csv": ["sector", "method", "sample_id", "source_year", "fit_scope", "measure", "bin_lower"]},
        grain="Primary prediction summaries by sector × method × sample × production year × fit scope × residual measure; histograms add the lower bin boundary.",
        denominator="N_source is the full N03 source-year sector count; N_domain is the frozen pre-lag method/common domain; N_predicted, N_in_fit, and N_outside_fit are prediction-side counts. Report each separately.",
        calendar="All supported production prediction years; coefficients are pooled across valid dynamic transitions within sector and the pooled fit mean is held fixed across years.",
        units={"raw_and_centered": "natural-log residual points", "index": "exp(centered log residual), dimensionless; geometric mean one in the pooled dynamic fit group, not arithmetic mean one and not physical TFP", "counts": "observations", "share": "bin count / N_total"},
        missingness="Only existing primary predictions are summarized. Preserve unsupported method/sample cells and empty histogram support. Tails are counted without trimming; a missing or zero count is not replaced with a fitted value.",
        suppression="For N<5 suppress exact means, SDs, quantiles, fences, and related exact numeric summaries; retain N, named source/domain/prediction denominators, and fixed-bin counts/bounds. No obs_id or psid is released.",
        decision="Report raw residual, pooled-fit-centered residual, and exp(centered) separately; distinguish all/in-fit/outside-fit records and source/domain/prediction coverage.",
        private_intermediates=["intermediate/primary_predictions.dta", "intermediate/deep_prediction_profiles.dta", "intermediate/deep_prediction_tails.dta", "intermediate/deep_prediction_histograms.dta"],
        figure_ids=["deep_"+m+"_"+f for m in ("op","lp","acf","wrdg") for f in ("histogram","year_sector")]+["deep_common_distribution"],
        figure_scope="Histograms use the existing nominal histogram aggregate; year-sector profiles use the new N10 deep_prediction_profiles.csv. OP and common support failures remain visible in tables and the related support figure.",
    ),
    dict(
        id="N11", title="Balanced fictional-panel paired changes and ranks", file="N11_pairs.do",
        input_nodes=["G1_N03", "G1_N10"], input_artifacts=["base:nominal/N03_frozen.dta", "deep:intermediate/primary_predictions.dta"],
        output_files=["deep_paired_changes.csv", "deep_paired_histograms.csv"],
        keys_by_output={"deep_paired_changes.csv": ["sector", "method", "sample_id", "measure", "year_from", "year_to"], "deep_paired_histograms.csv": ["sector", "method", "sample_id", "measure", "year_from", "year_to", "bin_lower"]},
        grain="Sector × method × sample × measure × year_from × year_to for exact same-psid, same-sector adjacent-calendar pairs;0/0 marks pooled intervals; histogram rows additionally key the 0.25-log-point change bin.",
        denominator="N_from and N_to count supported predictions in the paired endpoint years; N_pairs requires both values for the exact same fictional psid, sector, method, and sample. Preserve N_to in-fit and outside-fit counts.",
        calendar="Every supported exact adjacent-year prediction pair; no bridge across2016. Same pooled coefficients and pooled dynamic fit normalizer across endpoints.",
        units={"raw_and_centered_change": "later-year minus prior-year natural-log residual points", "index_change": "change in exp(centered), dimensionless", "mean_index_ratio": "mean index_to/index_from", "correlations": "dimensionless Pearson/Spearman correlations on exact pairs", "histogram": "0.25-log-point centered-change bins; count and pair share"},
        missingness="Pairs missing either year are excluded only from paired summaries; annual supported counts and pair exclusions remain explicit. All exact-pair changes are retained; no trimming and no causal or real-growth interpretation.",
        suppression="Retain N values, direction counts, and fixed-bin counts. Suppress exact means, quantiles, SDs, correlations, and mean index ratios where N_pairs<5. No identifiers are exported.",
        decision="Describe within-fictional-panel changes under pooled coefficients and fixed pooled normalization; do not describe them as real firm growth or causal effects.",
        private_intermediates=["intermediate/paired_predictions.dta"],
        figure_ids=["deep_"+m+"_paired_change" for m in ("op","lp","acf","wrdg")],
        figure_scope="Paired changes and 0.25-log-point histogram bins from deep_paired_changes.csv and deep_paired_histograms.csv; exact same fictional psid and sector in both years.",
    ),
    dict(
        id="N12", title="Observed-group means and designed arithmetic example", file="N12_worked.do",
        input_nodes=["G1_N10"], input_artifacts=["deep:intermediate/primary_predictions.dta"],
        output_files=["deep_worked_calculations.csv"],
        keys_by_output={"deep_worked_calculations.csv": ["sector", "method", "sample_id", "source_year", "example_type"]},
        grain="Sector × method × own/common × supported prediction year × observed_group_means or illustrative_fixed_log_inputs.",
        denominator="Observed rows are the supported primary prediction group N; exact observed means are emitted only for N≥5. The illustrative row is a constructed arithmetic example and has no firm-record denominator.",
        calendar="Observed calculations use all supported prediction years and the pooled method-specific slopes and reference mean. Illustrative rows use the same estimated slopes and reference.",
        units={"mean_y_mean_l_mean_k": "means of natural-log nominal VA, workers, and beginning capital", "beta_L_beta_K": "dimensionless elasticities", "products_and_residuals": "natural-log points", "exp_centered_and_mean_index": "dimensionless", "illustration": "designed logs y=10, l=3, k=8; not an observed firm"},
        missingness="Observed means are checked against mean(raw residual); use means of logs, not logs of means. exp(mean(centered)) and mean(exp(centered)) are reported as distinct quantities. Hypothetical rows are explicitly typed and have no N.",
        suppression="Suppress observed exact arithmetic when N<5. The designed example is not suppressed as an observed group and remains explicitly labelled illustrative.",
        decision="Show the residual identity mean(y)-beta_L*mean(l)-beta_K*mean(k)=mean(raw); subtract the pooled dynamic fit normalizer for the centered residual. Do not imply individual-firm examples.",
        private_intermediates=[], figure_ids=[], figure_scope="No figure is registered for this table family.",
    ),
    dict(
        id="N13", title="Existing fit sensitivities and bootstrap-draw diagnostics", file="N13_existing_fits.do",
        input_nodes=["G1_N03", "G1_N04", "G1_N05"], input_artifacts=["nominal/N03_frozen.dta", "outputs/nominal_coefficients.csv", "outputs/bootstrap_draws/nominal_<sector>_<method>_<sample>.csv"],
        output_files=["deep_fit_sensitivities.csv", "deep_bootstrap_profiles.csv", "deep_bootstrap_histograms.csv"],
        keys_by_output={"deep_fit_sensitivities.csv": ["sector", "method", "sample_id", "variant"], "deep_bootstrap_profiles.csv": ["sector", "method", "sample_id", "measure"], "deep_bootstrap_histograms.csv": ["sector", "method", "sample_id", "measure", "bin_lower"]},
        grain="Existing fit rows compare each sector/method/sample variant with its primary fit; bootstrap rows summarize successful existing draw values by sector/method/sample/measure, with histogram bins for labor and capital.",
        denominator="All declared sensitivity variants including skipped fits; bootstrap profiles retain requested and successful draw counts. Fit cells and bootstrap draws are not new fits. Objective functions remain method-specific and are not pooled across estimators.",
        calendar="Reuses the owner-authorized all-years assumed-stock nominal fit results and the already executed exploratory synthetic-firm bootstrap draws; no re-estimation or new resampling.",
        units={"beta_L_beta_K": "dimensionless elasticities", "objective": "method-specific objective value; compare variants only under an unchanged objective", "delta": "variant minus primary within cell", "bootstrap_labor_capital": "draw values in fitted source log units", "counts": "requested/successful complete-process draws"},
        missingness="Preserve unsupported variants and failed/missing draws. The objective_below_primary flag is descriptive within a fixed objective; a quadratic variant changes the specification. Keep all successful values and tails without trimming.",
        suppression="Retain declared-cell N and requested/successful draw counts. Suppress exact bootstrap profiles when successful N<5; fixed-bin counts remain aggregate categories.",
        decision="Diagnose start/specification sensitivity and the distribution of previously executed bootstrap draws without pooling objectives or representing diagnostics as accepted-real inference.",
        private_intermediates=["intermediate/deep_bootstrap_profiles.dta", "intermediate/deep_bootstrap_histograms.dta"],
        figure_ids=["deep_"+m+"_"+f for m in ("op","lp","acf","wrdg") for f in ("coefficients","sensitivity")],
        figure_scope="Coefficient intervals reuse existing nominal fit/bootstrap receipts; sensitivity panels show all existing nominal variants. The deep output adds a validated table of fit deltas and successful-draw profiles.",
    ),
]


# WFDOC: Continuity accepts source hash eksekusi atau receipt yang membuktikan insertions-only; hasil numerik tetap terikat ke baseline yang dijalankan.
def executed_source_matches(path: str, executed_hash: str) -> bool:
    """Accept exact execution source or independently proven comment insertions."""
    import ast
    import difflib
    target = ROOT / path
    if not target.is_file():
        return False
    current_hash = sha(target)
    if current_hash == executed_hash:
        return True
    proof_path = MODULE / 'qa/luna-all-years-comment-review.json'
    if not proof_path.is_file():
        return False
    proof = json.loads(proof_path.read_text())
    if proof.get('status') != 'PASS':
        return False
    row = next((r for r in proof.get('files', []) if r.get('path') == path), {})
    if row.get('before_sha256') != executed_hash or row.get('after_sha256') != current_hash:
        return False
    baseline = ROOT / row.get('baseline_snapshot', '')
    if not baseline.is_file() or sha(baseline) != executed_hash:
        return False
    before, after = baseline.read_text(), target.read_text()
    a, b = before.splitlines(keepends=True), after.splitlines(keepends=True)
    marker = '#' if target.suffix == '.py' else '*'
    for op, i, j, k, l in difflib.SequenceMatcher(None, a, b, autojunk=False).get_opcodes():
        if op == 'equal':
            continue
        if op != 'insert' or not all(line.lstrip().startswith(marker) for line in b[k:l]):
            return False
        if target.suffix in {'.do', '.ado'} and i and a[i-1].rstrip().endswith('///'):
            return False
    if target.suffix == '.py' and ast.dump(ast.parse(before)) != ast.dump(ast.parse(after)):
        return False
    return True



def presentation_rerender_matches(path: str, executed_hash: str) -> bool:
    """Verify the single aggregate-only plot revision without relaxing estimator continuity."""
    if path != "work-items/G1/publication/plot_figures.py":
        return False
    receipt_path = MODULE / "qa/base-figure-layout-revision.json"
    if not receipt_path.is_file():
        return False
    receipt = json.loads(receipt_path.read_text())
    if receipt.get("status") != "PASS" or receipt.get("executed_sha256") != executed_hash:
        return False
    if receipt.get("current_sha256") != sha(ROOT / path):
        return False
    baseline = MODULE / "qa/luna-all-years-prepared/publication-baseline/plot_figures.py.txt"
    before = MODULE / "release/qa/nominal-figure-annotations.json"
    old_manifest = MODULE / "release/qa/nominal-plot-data-manifest.json"
    after = MODULE / "publication/provenance/figure-annotations.json"
    new_manifest = MODULE / "publication/provenance/figure-manifest.json"
    run_path = MODULE / "release/run-manifest.json"
    # WFDOC: Daftar minimum bersifat tetap; receipt tidak dapat mengganti baseline eksekusi dengan output baru atau menghilangkan figur.
    required = {relative(f) for f in [baseline, before, old_manifest, after, new_manifest, run_path, ROOT / path]}
    bound = receipt.get("bound_files", [])
    if len(bound) != len(required) or {item["path"] for item in bound} != required:
        return False
    for item in bound:
        candidate = ROOT / item["path"]
        if not candidate.is_file() or sha(candidate) != item["sha256"]:
            return False
    execution = json.loads(run_path.read_text())
    executed_outputs = {row["path"]: row["sha256"] for row in execution["output_files"]}
    executed_code = {row["path"]: row["sha256"] for row in execution["code"]}
    if executed_code.get(path) != executed_hash or sha(baseline) != executed_hash:
        return False
    if sha(before) != executed_outputs.get("qa/nominal-figure-annotations.json"):
        return False
    if sha(old_manifest) != executed_outputs.get("qa/nominal-plot-data-manifest.json"):
        return False
    operands = lambda f: [{k: v for k, v in row.items() if k != "plotting_anchor"}
                          for row in json.loads(f.read_text())]
    old_operands, new_operands = operands(before), operands(after)
    if not old_operands or old_operands != new_operands or len(new_operands) != receipt["annotation_count"]:
        return False
    old = json.loads(old_manifest.read_text())["figures"]
    current = json.loads(new_manifest.read_text())["figures"]
    if not old or [r["figure"] for r in old] != [r["figure"] for r in current]:
        return False
    for previous, figure in zip(old, current):
        if not figure["sources"] or figure["sources"] != previous["sources"]:
            return False
        if not figure["outputs"] or [r["path"] for r in figure["outputs"]] != [r["path"] for r in previous["outputs"]]:
            return False
        for source in figure["sources"]:
            if sha(MODULE / "release" / source["path"]) != source["sha256"]:
                return False
        for asset in figure["outputs"]:
            if sha(MODULE / "publication" / asset["path"]) != asset["sha256"]:
                return False
    return receipt.get("review_scope") == "presentation_only_no_statistical_refit"


# WFDOC: Receipt deep all-years diverifikasi lewat manifest, sentinel, validator, kontrak, dan seluruh hash output; status tidak disimpulkan dari keberadaan file.
def verify_all_years_deep_execution(receipt: dict) -> dict:
    """Validate a fresh calculation without demanding equality to an older specification."""
    manifest_path = ROOT / receipt.get('manifest', {}).get('path', '')
    validation_path = ROOT / receipt.get('validation', {}).get('path', '')
    manifest = json.loads(manifest_path.read_text()) if manifest_path.is_file() else {}
    validation = json.loads(validation_path.read_text()) if validation_path.is_file() else {}
    code = receipt.get('code', [])
    expected = {row['path'] for row in manifest.get('code', [])}
    log = Path(receipt.get('run', '')) / 'deep_execution.log'
    checks = {
        'successful_execution': receipt.get('status') == 'PASS' and receipt.get('exit_code') == 0 and receipt.get('no_refit') is True,
        'completion_sentinel': log.is_file() and 'DEEP_STATA_COMPLETE_NO_REFIT' in log.read_text(),
        'exact_manifest': bool(manifest) and sha(manifest_path) == receipt.get('manifest', {}).get('sha256') and manifest.get('status') == 'VALIDATED',
        'exact_validation': bool(validation) and sha(validation_path) == receipt.get('validation', {}).get('sha256') == manifest.get('validation_sha256') and validation.get('status') == 'PASS',
        'source_code': bool(code) and {row['path'] for row in code} == expected and all(executed_source_matches(row['path'], row['sha256']) for row in code),
        'contract': next((row.get('sha256') for row in manifest.get('code', []) if row.get('path') == relative(DEEP_CONTRACT)), manifest.get('contract_sha256')) == validation.get('contract_sha256') == sha(DEEP_CONTRACT),
        'source_run': manifest.get('run') == receipt.get('run') and manifest.get('base_run') == receipt.get('base_run'),
        'primary_route': 'diagnostics' in receipt.get('argv', []) and str(MODULE / 'stata/G1.do') in receipt.get('argv', []),
        'primary_dispatch_source': receipt.get('primary_do', {}).get('path') == relative(MODULE / 'stata/G1.do') and executed_source_matches(relative(MODULE / 'stata/G1.do'), receipt.get('primary_do', {}).get('sha256')),
    }
    outputs = {row['file']: row for row in manifest.get('outputs', [])}
    validated = {row['file']: row for row in validation.get('files', [])}
    expected_outputs = set(json.loads(DEEP_CONTRACT.read_text())['outputs'])
    checks['complete_output_grid'] = set(outputs) == set(validated) == expected_outputs
    checks['exact_output_files'] = all(
        (DEEP_EVIDENCE_ROOT / 'outputs' / name).is_file()
        and sha(DEEP_EVIDENCE_ROOT / 'outputs' / name) == row.get('sha256') == validated.get(name, {}).get('sha256')
        and row.get('status') == validated.get(name, {}).get('status') == 'PASS'
        for name, row in outputs.items())
    okay = all(checks.values())
    return {'receipt_path': relative(DEEP_FINAL_EXECUTION), 'receipt_sha256': sha(DEEP_FINAL_EXECUTION),
            'receipt': receipt, 'status': 'PASS' if okay else 'PENDING_OR_HASH_MISMATCH',
            'verified': okay, 'checks': checks}


def verify_deep_final_execution(dispatch_receipt: dict | None, dispatch_source_verified: bool) -> dict:
    """Verify the routed post-comment Stata receipt against live source, outputs, and validation files."""
    result = {"receipt_path": relative(DEEP_FINAL_EXECUTION), "receipt_sha256": None, "receipt": None,
              "status": "PENDING", "verified": False, "checks": {}}
    if not DEEP_FINAL_EXECUTION.is_file():
        return result
    receipt = json.loads(DEEP_FINAL_EXECUTION.read_text(encoding="utf-8"))
    if receipt.get('kind') == 'all_years_assumed_stock_execution':
        return verify_all_years_deep_execution(receipt)
    result.update({"receipt": receipt, "receipt_sha256": sha(DEEP_FINAL_EXECUTION)})
    checks = {}
    checks["receipt_pass"] = receipt.get("status") == "PASS" and receipt.get("exit_code") == 0 and receipt.get("sentinel") is True and receipt.get("unchanged_frozen_code") is True and receipt.get("no_refit") is True

    code_rows = receipt.get("code", [])
    code_paths = [row.get("path") for row in code_rows]
    expected_comment_paths = {row.get("path") for row in json.loads((MODULE / "qa/luna-deep-comment-proof.json").read_text(encoding="utf-8")).get("files", [])} if (MODULE / "qa/luna-deep-comment-proof.json").is_file() else set()
    checks["all_comment_frozen_source_hashes_match"] = bool(code_rows) and len(code_paths) == len(set(code_paths)) and set(code_paths) == expected_comment_paths and all((ROOT / row["path"]).is_file() and sha(ROOT / row["path"]) == row.get("sha256") for row in code_rows)

    primary = receipt.get("primary_do") or {}
    dispatch_path = MODULE / "stata/G1.do"
    checks["primary_dispatch_source_matches"] = bool(dispatch_source_verified and primary.get("path") == relative(dispatch_path) and primary.get("sha256") == sha(dispatch_path))
    argv = receipt.get("argv", [])
    checks["argv_uses_diagnostics_route"] = bool("diagnostics" in argv and str(ROOT) in argv and receipt.get("run") in argv and receipt.get("base_run") in argv)

    proof_binding = receipt.get("comment_proof") or {}
    proof_path = ROOT / proof_binding.get("path", "")
    proof = json.loads(proof_path.read_text(encoding="utf-8")) if proof_path.is_file() else {}
    checks["comment_proof_hash_matches"] = bool(proof and sha(proof_path) == proof_binding.get("sha256") and proof.get("status") == "PASS" and len(proof.get("files", [])) == 12)
    dispatch_comment_row = next((row for row in proof.get("files", []) if row.get("path") == relative(dispatch_path)), {})
    checks["comment_proof_reconstructs_routing_revision"] = bool(
        checks["comment_proof_hash_matches"] and dispatch_receipt and
        dispatch_comment_row.get("baseline_sha256") == dispatch_receipt.get("after_sha256") and
        dispatch_comment_row.get("current_sha256") == sha(dispatch_path) and
        not dispatch_comment_row.get("errors"))

    manifest_info = receipt.get("manifest") or {}
    validation_info = receipt.get("validation") or {}
    manifest_path = ROOT / manifest_info.get("path", "")
    validation_path = ROOT / validation_info.get("path", "")
    manifest = json.loads(manifest_path.read_text(encoding="utf-8")) if manifest_path.is_file() else {}
    validation = json.loads(validation_path.read_text(encoding="utf-8")) if validation_path.is_file() else {}
    checks["final_run_manifest_matches_receipt"] = bool(
        manifest and sha(manifest_path) == manifest_info.get("sha256") and manifest.get("status") == "VALIDATED" and
        manifest.get("run") == receipt.get("run") and manifest.get("base_run") == receipt.get("base_run") and manifest.get("no_refit") is True)
    checks["final_validation_matches_receipt"] = bool(
        validation and sha(validation_path) == validation_info.get("sha256") == manifest.get("validation_sha256") and
        validation.get("status") == validation_info.get("status") == "PASS" and
        validation.get("aggregate_cells_compared") == validation_info.get("aggregate_cells_compared"))
    checks["final_validation_cell_count"] = (validation.get("aggregate_cells_compared") if validation else None)
    checks["final_validation_is_340404_cells"] = checks["final_validation_cell_count"] == 340404

    expected_outputs = set(json.loads(DEEP_CONTRACT.read_text(encoding="utf-8")).get("outputs", {}))
    comparisons = receipt.get("output_comparisons", [])
    comparison_paths = [row.get("file") for row in comparisons]
    prior_release = Path(receipt.get("old_release_preserved", ""))
    output_checks = []
    for row in comparisons:
        current_path = DEEP_EVIDENCE_ROOT / "outputs" / row.get("file", "")
        prior_path = prior_release / "outputs" / row.get("file", "")
        current_hash = sha(current_path) if current_path.is_file() else None
        prior_hash = sha(prior_path) if prior_path.is_file() else None
        manifest_row = next((x for x in manifest.get("outputs", []) if x.get("file") == row.get("file")), {})
        validation_row = next((x for x in validation.get("files", []) if x.get("file") == row.get("file")), {})
        output_checks.append(bool(row.get("byte_identical") is True and row.get("before_sha256") == row.get("after_sha256") == current_hash == manifest_row.get("sha256") == validation_row.get("sha256") and prior_hash == row.get("before_sha256")))
    checks["twelve_prior_outputs_preserved_byte_for_byte"] = bool(
        prior_release.is_dir() and len(comparisons) == 12 and len(comparison_paths) == len(set(comparison_paths)) and
        set(comparison_paths) == expected_outputs and all(output_checks))
    result["checks"] = checks
    result["status"] = "PASS" if all(value is True for key, value in checks.items() if key != "final_validation_cell_count") else "PENDING_OR_HASH_MISMATCH"
    result["verified"] = result["status"] == "PASS"
    return result


def deep_evidence_bundle() -> dict:
    """Read the separately screened deep-release receipts; never infer a pass from code presence."""
    result = {
        "release_root": DEEP_EVIDENCE_ROOT,
        "contract": json.loads(DEEP_CONTRACT.read_text(encoding="utf-8")),
        "contract_sha256": sha(DEEP_CONTRACT),
        "manifest": None,
        "validation": None,
        "manifest_sha256": None,
        "validation_sha256": None,
        "manifest_status": "PENDING",
        "validation_status": "PENDING",
        "output_records": {},
        "source_records": [],
        "code_records": [],
        "validator_revision": None,
        "validator_current_hash_match": None,
        "validator_revision_status": "not checked",
        "dispatch_revision": None,
        "dispatch_current_sha256": None,
        "dispatch_revision_verified": False,
        "final_execution": None,
        "final_execution_sha256": None,
        "final_execution_verified": False,
        "final_execution_status": "no routed final execution receipt",
        "dispatch_status": "primary diagnostics dispatch pending",
        "outputs_copied_and_validated": False,
        "source_code_hashes_match_except_documented_validator_revision": False,
    }
    manifest_path = DEEP_EVIDENCE_ROOT / "run-manifest.json"
    validation_path = DEEP_EVIDENCE_ROOT / "qa/deep-validation.json"
    if not manifest_path.is_file() or not validation_path.is_file():
        return result

    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    validation = json.loads(validation_path.read_text(encoding="utf-8"))
    result.update({
        "manifest": manifest, "validation": validation,
        "manifest_sha256": sha(manifest_path), "validation_sha256": sha(validation_path),
        "manifest_status": manifest.get("status", "UNKNOWN"),
        "validation_status": validation.get("status", "UNKNOWN"),
    })
    assert manifest.get("contract_id") == result["contract"].get("id")
    assert manifest.get("input_manifest_sha256") == result["contract"].get("input_manifest_sha256")
    assert manifest.get("contract_sha256") == result["contract_sha256"] if manifest.get("contract_sha256") else True
    assert validation.get("contract_sha256") == result["contract_sha256"]

    manifest_outputs = {row["file"]: row for row in manifest.get("outputs", [])}
    validation_outputs = {row["file"]: row for row in validation.get("files", [])}
    expected_outputs = set(result["contract"].get("outputs", {}))
    result["output_records"] = {}
    output_checks = []
    for filename in sorted(expected_outputs):
        path = DEEP_EVIDENCE_ROOT / "outputs" / filename
        mrow, vrow = manifest_outputs.get(filename), validation_outputs.get(filename)
        current_hash = sha(path) if path.is_file() else None
        okay = bool(path.is_file() and mrow and vrow and
                    mrow.get("status") == "PASS" and vrow.get("status") == "PASS" and
                    current_hash == mrow.get("sha256") == vrow.get("sha256"))
        output_checks.append(okay)
        result["output_records"][filename] = {
            "path": relative(path), "sha256": current_hash,
            "rows": (vrow or mrow or {}).get("rows"), "cells": (vrow or mrow or {}).get("cells"),
            "maximum_scaled_error": (vrow or {}).get("maximum_scaled_error"),
            "validation_status": vrow.get("status") if vrow else "PENDING",
            "manifest_status": mrow.get("status") if mrow else "PENDING",
            "hash_matches_both_receipts": okay,
        }
    result["outputs_copied_and_validated"] = bool(
        expected_outputs and len(expected_outputs) == len(manifest_outputs) == len(validation_outputs)
        and all(output_checks) and manifest.get("status") == "VALIDATED"
        and validation.get("status") == "PASS")

    result["source_records"] = []
    for row in manifest.get("sources", []):
        path = Path(row["path"])
        current_hash = sha(path) if path.is_file() else None
        result["source_records"].append({**row, "current_sha256": current_hash,
                                          "current_hash_matches_receipt": current_hash == row.get("sha256")})
    log_path = DEEP_EVIDENCE_ROOT / "logs/deep_execution.log"
    result["run_log_sha256"] = sha(log_path) if log_path.is_file() else None
    result["release_receipts_self_consistent"] = bool(
        result["manifest_sha256"] and result["validation_sha256"] and
        manifest.get("validation_sha256") == result["validation_sha256"] and
        log_path.is_file() and manifest.get("log_sha256") == result["run_log_sha256"])
    result["all_base_inputs_still_match_receipt"] = bool(result["source_records"]) and all(r["current_hash_matches_receipt"] for r in result["source_records"])

    result["code_records"] = []
    for row in manifest.get("code", []):
        path = ROOT / row["path"]
        current_hash = sha(path) if path.is_file() else None
        result["code_records"].append({**row, "current_sha256": current_hash,
                                       "current_hash_matches_receipt": executed_source_matches(row['path'], row.get('sha256'))})

    current_validator = sha(MODULE / "validate_deep.py") if (MODULE / "validate_deep.py").is_file() else None
    validator_record = next((r for r in result["code_records"] if r["path"].endswith("validate_deep.py")), None)
    validator_revision_path = MODULE / "qa/deep-validator-source-revision.json"
    revision = json.loads(validator_revision_path.read_text(encoding="utf-8")) if validator_revision_path.is_file() else None
    result["validator_revision"] = revision
    result["validator_current_hash_match"] = bool(validator_record and executed_source_matches(validator_record['path'], validator_record.get('sha256')))
    if result["validator_current_hash_match"]:
        result["validator_revision_status"] = "current source matches executed validator"
    elif (revision and validator_record and
          revision.get("pre_sha256") == validator_record.get("sha256") and
          revision.get("post_sha256") == current_validator and
          revision.get("pre_hash_reconstructed_and_matches_original_manifest") is True):
        result["validator_revision_status"] = "documented receipt-routing-only source revision; original pre-revision validator hash reconstructed and matched"
    else:
        result["validator_revision_status"] = "unexplained current-validator hash mismatch"
    other_code_match = all(r["current_hash_matches_receipt"] for r in result["code_records"] if not r["path"].endswith("validate_deep.py"))
    result["source_code_hashes_match_except_documented_validator_revision"] = bool(
        other_code_match and (result["validator_current_hash_match"] or "documented" in result["validator_revision_status"]))
    result["outputs_copied_and_validated"] = bool(result["outputs_copied_and_validated"]
        and result["release_receipts_self_consistent"] and result["all_base_inputs_still_match_receipt"]
        and result["source_code_hashes_match_except_documented_validator_revision"])
    dispatch_path = MODULE / "stata/G1.do"
    dispatch_receipt_path = MODULE / "qa/deep-primary-dispatch-source-revision.json"
    dispatch_receipt = json.loads(dispatch_receipt_path.read_text(encoding="utf-8")) if dispatch_receipt_path.is_file() else None
    dispatch_hash = sha(dispatch_path) if dispatch_path.is_file() else None
    dispatch_snapshot = MODULE / "qa/source-revisions/G1-before-deep-dispatch.do.txt"
    snapshot_matches = bool(dispatch_receipt and dispatch_snapshot.is_file() and
                            sha(dispatch_snapshot) == dispatch_receipt.get("before_sha256"))
    comment_proof_path = MODULE / "qa/luna-deep-comment-proof.json"
    comment_proof = json.loads(comment_proof_path.read_text(encoding="utf-8")) if comment_proof_path.is_file() else {}
    comment_g1 = next((row for row in comment_proof.get("files", []) if row.get("path") == relative(dispatch_path)), {})
    comment_g1_matches = bool(comment_proof.get("status") == "PASS" and not comment_g1.get("errors") and
                               comment_g1.get("baseline_sha256") == (dispatch_receipt or {}).get("after_sha256") and
                               comment_g1.get("current_sha256") == dispatch_hash)
    result["dispatch_revision"] = dispatch_receipt
    result["dispatch_current_sha256"] = dispatch_hash
    result["dispatch_revision_verified"] = bool(dispatch_receipt and dispatch_hash == dispatch_receipt.get("after_sha256") and
                                                 snapshot_matches and dispatch_receipt.get("scope", "").startswith("Primary G1.do dispatch only")) or bool(
                                                 dispatch_receipt and snapshot_matches and comment_g1_matches and dispatch_receipt.get("scope", "").startswith("Primary G1.do dispatch only"))
    final_execution = verify_deep_final_execution(dispatch_receipt, result["dispatch_revision_verified"])
    result["final_execution"] = final_execution.get("receipt")
    result["final_execution_sha256"] = final_execution.get("receipt_sha256")
    result["final_execution_verified"] = final_execution.get("verified", False)
    result["final_execution_status"] = final_execution.get("status", "PENDING")
    if result["final_execution_verified"]:
        result["dispatch_status"] = "Routed primary G1.do execution PASS; exit0, completion sentinel, exact output/contract/source hashes and independent numeric validation. Historical replay and fresh all-years runs retain their distinct receipt kinds."
    elif result["dispatch_revision_verified"]:
        result["dispatch_status"] = "frozen routing-only G1.do revision verified; final routed execution receipt is pending or does not match"
    else:
        result["dispatch_status"] = "primary G1.do diagnostics dispatch has no matching frozen revision/comment-continuity receipt"
    result["final_execution_checks"] = final_execution.get("checks", {})
    return result


def deep_inputs_for_stage(stage: dict, info: dict) -> list[dict]:
    """Resolve a stage's direct artifacts to exact base/deep-run hashes when receipts exist."""
    manifest = info.get("manifest") or {}
    base_run = Path(manifest.get("base_run", "")) if manifest.get("base_run") else None
    deep_run = Path(manifest.get("run", "")) if manifest.get("run") else None
    receipt_sources = {str(Path(row["path"]).relative_to(base_run)): row
                       for row in manifest.get("sources", []) if base_run and Path(row["path"]).is_absolute() and Path(row["path"]).is_relative_to(base_run)}
    resolved = []
    for artifact_spec in stage["input_artifacts"]:
        scope, artifact = (artifact_spec.split(":", 1) if ":" in artifact_spec and artifact_spec.split(":", 1)[0] in ("base", "deep") else ("base", artifact_spec))
        if scope == "deep" or artifact.startswith("intermediate/"):
            path = (deep_run / artifact) if deep_run else None
            resolved.append({"artifact": artifact, "scope": "private deep-run intermediate produced by a preceding deep stage",
                             "path": str(path) if path else None, "sha256": sha(path) if path and path.is_file() else None,
                             "exists": bool(path and path.is_file()), "public": False})
        elif "<" in artifact and base_run:
            pattern = artifact.replace("<sector>", "*").replace("<method>", "*").replace("<sample>", "*")
            matches = []
            for rel, row in receipt_sources.items():
                if fnmatch.fnmatch(rel, pattern):
                    matches.append({"path": rel, "sha256": row.get("sha256"), "bytes": row.get("bytes"),
                                    "current_hash_matches_receipt": row.get("current_hash_matches_receipt")})
            resolved.append({"artifact": artifact, "scope": "existing base-run bootstrap inputs", "matches": matches,
                             "exists": bool(matches), "public": False})
        else:
            root = base_run
            path = root / artifact if root else None
            rel = artifact
            source_row = receipt_sources.get(rel)
            if path and not source_row:
                source_row = next((r for r in info.get("source_records", []) if Path(r["path"]).name == Path(artifact).name), None)
            resolved.append({"artifact": artifact, "scope": "read-only base-run input",
                             "path": str(path) if path else (source_row or {}).get("path"),
                             "sha256": sha(path) if path and path.is_file() else (source_row or {}).get("sha256"),
                             "bytes": path.stat().st_size if path and path.is_file() else (source_row or {}).get("bytes"),
                             "receipt_sha256": (source_row or {}).get("sha256"),
                             "current_hash_matches_receipt": (source_row or {}).get("current_hash_matches_receipt"),
                             "exists": bool((path and path.is_file()) or source_row), "public": False})
    return resolved


def build_deep_contracts(base_evidence: dict, info: dict):
    contract_spec = info["contract"]
    output_schemas = contract_spec["outputs"]
    code_by_path = {row["path"]: row for row in info.get("code_records", [])}
    code_paths = [row["path"] for row in info.get("code_records", [])]
    node_output_rows, triage_rows, decision_rows, edge_rows = [], [], [], []
    producing = {node: edge["id"] for edge in json.loads(PLAN.read_text(encoding="utf-8"))["edges"] for node in edge["output_nodes"]}
    producing.update({"G1_" + stage["id"]: "G1_NE" + stage["id"][1:] for stage in NOMINAL_STAGES})
    producing.update({"G1_" + stage["id"]: "G1_NE" + stage["id"][1:] for stage in DEEP_STAGES})
    for stage in DEEP_STAGES:
        code = "G1_" + stage["id"]
        source_path = MODULE / "stata/deep" / stage["file"]
        source_rel = relative(source_path)
        direct_code = code_by_path.get(source_rel, {})
        output_contracts = []
        for filename in stage["output_files"]:
            receipt = info.get("output_records", {}).get(filename, {})
            output_contracts.append({
                "path": f"deep-release/outputs/{filename}", "schema": output_schemas.get(filename, []),
                "keys": stage["keys_by_output"][filename],
                "grain": stage["grain"], "denominator": stage["denominator"],
                "units": stage["units"], "sha256": receipt.get("sha256"),
                "rows": receipt.get("rows"), "cells_validated": receipt.get("cells"),
                "maximum_scaled_error": receipt.get("maximum_scaled_error"),
                "status": receipt.get("validation_status", "PENDING"),
                "hash_matches_release_and_validation": receipt.get("hash_matches_both_receipts", False),
            })
        private_outputs = []
        manifest = info.get("manifest") or {}
        run = Path(manifest.get("run", "")) if manifest.get("run") else None
        for name in stage["private_intermediates"]:
            path = run / name if run else None
            private_outputs.append({"path_relative_to_external_run": name,
                                    "sha256_at_contract_build": sha(path) if path and path.is_file() else None,
                                    "exists": bool(path and path.is_file()), "publication": "private/local; not copied to deep-release"})
        direct_inputs = deep_inputs_for_stage(stage, info)
        relevant_code = [r for r in info.get("code_records", []) if r["path"] in code_paths]
        validation = info.get("validation") or {}
        if info.get("outputs_copied_and_validated") and info.get("source_code_hashes_match_except_documented_validator_revision"):
            status = ("validated_aggregate_receipt_validator_revision_documented_primary_dispatch_replay_pass_no_refit"
                      if info.get("final_execution_verified") else
                      "validated_aggregate_receipt_validator_revision_documented_primary_dispatch_replay_pending")
        elif info.get("outputs_copied_and_validated"):
            status = "validated_aggregate_receipt_present_source_review_pending"
        else:
            status = "deep_release_receipt_pending"
        contract = {
            "node_id": code, "branch": "nominal_development_deep_diagnostics",
            "material_state_status": status, "state": stage["title"],
            "input_nodes": stage["input_nodes"], "direct_input_artifacts": direct_inputs,
            "source_code": source_rel, "source_code_sha256": sha(source_path),
            "source_code_matches_original_run_manifest": direct_code.get("current_hash_matches_receipt"),
            "runner_entry_point": {"primary_do": "work-items/G1/stata/G1.do", "primary_do_sha256": info.get("dispatch_current_sha256"),
                                   "diagnostics_child_driver": "work-items/G1/stata/deep/G1_deep.do",
                                   "diagnostics_child_driver_sha256": sha(MODULE / "stata/deep/G1_deep.do"),
                                   "dispatch_revision_receipt": "qa/deep-primary-dispatch-source-revision.json" if info.get("dispatch_revision") else None,
                                   "dispatch_source_revision_verified": info.get("dispatch_revision_verified"),
                                   "execution_status": info.get("dispatch_status"),
                                   "final_execution_receipt": "work-items/G1/qa/deep-final-execution.json" if info.get("final_execution") else None,
                                   "final_execution_receipt_sha256": info.get("final_execution_sha256"),
                                   "final_execution_status": info.get("final_execution_status"),
                                   "final_execution_verified": info.get("final_execution_verified"),
                                   "final_execution_checks": info.get("final_execution_checks", {})},
            "executed_code_receipt": {"manifest_path": "deep-release/run-manifest.json", "manifest_sha256": info.get("manifest_sha256"),
                                      "code": relevant_code, "validator_revision_status": info.get("validator_revision_status"),
                                      "validator_source_revision_receipt": "qa/deep-validator-source-revision.json" if info.get("validator_revision") else None,
                                      "final_routed_execution_receipt": "work-items/G1/qa/deep-final-execution.json" if info.get("final_execution") else None,
                                      "final_routed_execution_receipt_sha256": info.get("final_execution_sha256"),
                                      "final_routed_execution_status": info.get("final_execution_status"),
                                      "final_routed_execution_verified": info.get("final_execution_verified")},
            "specification_path": relative(DEEP_CONTRACT), "specification_sha256": info["contract_sha256"],
            "base_run": manifest.get("base_run"), "deep_run": manifest.get("run"),
            "base_run_input_manifest_sha256": contract_spec.get("input_manifest_sha256"),
            "no_new_coefficient_fits": contract_spec.get("no_new_coefficient_fits"),
            "grain": stage["grain"], "keys_by_output": stage["keys_by_output"],
            "output_contracts": output_contracts, "private_intermediates": private_outputs,
            "calendar": stage["calendar"], "units": stage["units"], "denominator": stage["denominator"],
            "missingness": stage["missingness"], "suppression": stage["suppression"],
            "decision": stage["decision"], "figure_scope": stage["figure_scope"],
            "validation": {"status": validation.get("status", "PENDING"), "scope": validation.get("scope"),
                           "aggregate_cells_compared": validation.get("aggregate_cells_compared"),
                           "receipt_path": "deep-release/qa/deep-validation.json",
                           "receipt_sha256": info.get("validation_sha256"),
                           "validator_source_hash_matches_manifest": info.get("validator_current_hash_match"),
                           "validator_source_revision_status": info.get("validator_revision_status"),
                           "output_hashes_match_both_receipts": all(x["hash_matches_release_and_validation"] for x in output_contracts),
                           "routed_primary_execution_receipt_path": "work-items/G1/qa/deep-final-execution.json" if info.get("final_execution") else None,
                           "routed_primary_execution_receipt_sha256": info.get("final_execution_sha256"),
                           "routed_primary_execution_status": info.get("final_execution_status"),
                           "routed_primary_execution_verified": info.get("final_execution_verified")},
            "release_root": "deep-release/ (separate from release/; aggregate evidence only)",
            "primary_real_admission": False,
            "interpretation_limit": "G0.5 nominal-development diagnostics on the official fictional panel. They do not establish real-valued productivity. Unsupported sector cells retain their recorded missing state; N11 is descriptive, not causal.",
            "numerical_output_privacy": "Only aggregate outputs are in deep-release. obs_id/psid are used for exact internal joins and remain in private external-run intermediates.",
            **base_evidence,
        }
        folder = MODULE / "dag/nodes" / code
        dump(folder / "contract.json", contract)
        compared_cells = int((info.get("validation") or {}).get("aggregate_cells_compared", 0))
        status_text = (f"The 12 aggregate CSVs in the separate deep-release pass the hash-bound arithmetic receipt ({compared_cells:,} cells), and the routed primary G1.do diagnostics execution passed with exit 0, a completion sentinel, frozen executed source hashes, and exact output hashes."
                       if info.get("final_execution_verified") else
                       f"The 12 aggregate CSVs in the separate deep-release pass the hash-bound arithmetic receipt ({compared_cells:,} cells); the routed primary G1.do execution receipt is still pending or does not match."
                       if info.get("outputs_copied_and_validated") else "A deep-release aggregate validation receipt is not present or does not match the current release copy; retain this node as pending.")
        write(folder / "triage.md", f"# {code} — triage\n\n{LABEL}\n\nStatus: **{status}**.\n\n{stage['title']}. {status_text}\n\nDirect inputs and hashes, outputs, grain, units, denominators, missingness and suppression rules are in [contract.json](contract.json). This is a separate nominal-development diagnostic branch; the primary real-data state remains unadmitted.\n\nReopen on changed source/specification/evidence hashes, failed independent validation, or owner instruction.\n")
        write(folder / "decision.md", f"# {code} — decision\n\n{LABEL}\n\n**Decision.** {stage['decision']}\n\n**Direct inputs.** {', '.join(stage['input_nodes'])}; see exact resolved source objects and hashes in [contract.json](contract.json).\n\n**Grain.** {stage['grain']}\n\n**Denominator.** {stage['denominator']}\n\n**Calendar.** {stage['calendar']}\n\n**Units.** {json.dumps(stage['units'], ensure_ascii=False)}\n\n**Missingness and disclosure.** {stage['missingness']} {stage['suppression']}\n\n**Execution.** {status}; deep output validation is separately receipt-bound. No new coefficient fits; primary real admission remains false.\n")
        node_output_rows.append(dict(node_id=code, state=stage["title"], material_state_status=status,
                                     grain=stage["grain"], keys={k: v for k, v in stage["keys_by_output"].items()},
                                     units=stage["units"], calendar=stage["calendar"], denominator=stage["denominator"],
                                     input_nodes=stage["input_nodes"], producing_edge="G1_NE" + stage["id"][1:],
                                     contract=relative(folder / "contract.json"), contract_sha256=sha(folder / "contract.json")))
        triage_rows.append(dict(triage_id=code + "-T01", node_id=code, status=status,
                                question=stage["title"], blockers=["Real-primary admission remains separate", "OP/common fit support remains as reported in the frozen fit ledger"],
                                reopen_rule="Changed input/code/contract/output hash, failed validation or owner instruction", triage_file=relative(folder / "triage.md")))
        decision_rows.append(dict(node_id=code, decision_id=code + "-D01", selected_rule=stage["decision"],
                                  material_state_status=status, evidence_file=relative(folder / "contract.json"),
                                  evidence_sha256=sha(folder / "contract.json"), **base_evidence))
        depends_on = [producing[n] for n in stage["input_nodes"] if n in producing]
        edge_rows.append(dict(edge_id="G1_NE" + stage["id"][1:], title=stage["title"],
                              input_nodes=stage["input_nodes"], output_nodes=[code], depends_on=depends_on,
                              primary_do="work-items/G1/stata/G1.do", primary_do_sha256=info.get("dispatch_current_sha256"),
                              diagnostics_child_driver="work-items/G1/stata/deep/G1_deep.do",
                              diagnostics_child_driver_sha256=sha(MODULE / "stata/deep/G1_deep.do"),
                              dispatch_revision_receipt="work-items/G1/qa/deep-primary-dispatch-source-revision.json",
                              dispatch_status=info.get("dispatch_status"),
                              final_execution_receipt="work-items/G1/qa/deep-final-execution.json" if info.get("final_execution") else None,
                              final_execution_receipt_sha256=info.get("final_execution_sha256"),
                              final_execution_status=info.get("final_execution_status"),
                              final_execution_verified=info.get("final_execution_verified"), do_file=source_rel,
                              source_exists=source_path.is_file(), code_sha256=sha(source_path),
                              input_artifacts=stage["input_artifacts"],
                              required_action=stage["decision"], required_validation=stage["denominator"],
                              audit_outputs_relative_to_private_run=["outputs/" + x for x in stage["output_files"]] + stage["private_intermediates"],
                              screened_aggregate_outputs=["deep-release/outputs/" + x for x in stage["output_files"]],
                              numerical_state_status=status, execution_status=info.get("final_execution_status", info.get("validation_status", "PENDING")),
                              primary_real_admission=False))
    dump(MODULE / "registries/deep-execution-evidence.json", {
        "branch": "nominal_development_deep_diagnostics", "contract": relative(DEEP_CONTRACT),
        "contract_sha256": info["contract_sha256"], "screened_release": "deep-release/",
        "run_manifest": {"path": "deep-release/run-manifest.json", "sha256": info.get("manifest_sha256"), "status": info.get("manifest_status")},
        "validation": {"path": "deep-release/qa/deep-validation.json", "sha256": info.get("validation_sha256"),
                       "status": info.get("validation_status"), "aggregate_cells_compared": (info.get("validation") or {}).get("aggregate_cells_compared"),
                       "all_output_hashes_match_both_receipts": info.get("outputs_copied_and_validated")},
        "validator_source_hash_matches_original_run_manifest": info.get("validator_current_hash_match"),
        "validator_source_revision_status": info.get("validator_revision_status"),
        "validator_source_revision_receipt": "qa/deep-validator-source-revision.json" if info.get("validator_revision") else None,
        "source_code_hashes_match_except_documented_validator_revision": info.get("source_code_hashes_match_except_documented_validator_revision"),
        "primary_dispatch": {"path": "work-items/G1/stata/G1.do", "sha256": info.get("dispatch_current_sha256"),
                             "child_driver": "work-items/G1/stata/deep/G1_deep.do",
                             "child_driver_sha256": sha(MODULE / "stata/deep/G1_deep.do"),
                             "revision_receipt": "work-items/G1/qa/deep-primary-dispatch-source-revision.json",
                             "revision_verified": info.get("dispatch_revision_verified"), "execution_status": info.get("dispatch_status"),
                             "final_execution_receipt": "work-items/G1/qa/deep-final-execution.json" if info.get("final_execution") else None,
                             "final_execution_receipt_sha256": info.get("final_execution_sha256"),
                             "final_execution_status": info.get("final_execution_status"),
                             "final_execution_verified": info.get("final_execution_verified"),
                             "final_execution_checks": info.get("final_execution_checks", {})},
        "source_inputs": info.get("source_records", []), "executed_code": info.get("code_records", []),
        "outputs": info.get("output_records", {}), "no_new_coefficient_fits": True,
        "primary_real_admission": False,
    })
    return node_output_rows, triage_rows, decision_rows, edge_rows


def deep_publication_tables() -> dict[str, list[dict]]:
    tables = {
        "N08": [
            ("g1:tab:deep-input-availability", "deep_input_availability.tex", ["deep_input_domains.csv"]),
            ("g1:tab:deep-input-states", "deep_input_states.tex", ["deep_input_domains.csv"]),
            ("g1:tab:deep-input-levels", "deep_input_levels.tex", ["deep_input_distributions.csv"]),
        ],
        "N09": [("g1:tab:deep-funnel", "deep_funnel.tex", ["deep_method_funnel.csv"])],
        "N10": [], "N11": [], "N12": [], "N13": [],
    }
    for method in ("lp", "op", "acf", "wrdg"):
        tables["N08"].append((f"g1:tab:deep-{method}-input-states", f"deep_{method}_input_states.tex", ["deep_input_domains.csv"]))
        tables["N09"].append((f"g1:tab:deep-{method}-sample", f"deep_{method}_sample.tex", ["deep_method_funnel.csv"]))
    for method in ("op", "lp", "acf", "wrdg"):
        tables["N10"].extend([
            (f"g1:tab:deep-{method}-scopes", f"deep_{method}_scopes.tex", ["deep_prediction_profiles.csv"]),
            (f"g1:tab:deep-{method}-quantiles", f"deep_{method}_quantiles.tex", ["deep_prediction_profiles.csv"]),
            (f"g1:tab:deep-{method}-tails", f"deep_{method}_tails.tex", ["deep_prediction_tails.csv"]),
            (f"g1:tab:deep-{method}-annual", f"deep_{method}_annual.tex", ["deep_prediction_profiles.csv"]),
        ])
        tables["N11"].append((f"g1:tab:deep-{method}-paired", f"deep_{method}_paired.tex", ["deep_paired_changes.csv", "deep_paired_histograms.csv"]))
        tables["N11"].append((f"g1:tab:deep-{method}-pair-coverage", f"deep_{method}_pair_coverage.tex", ["deep_paired_changes.csv"]))
        tables["N12"].append((f"g1:tab:deep-{method}-worked", f"deep_{method}_worked.tex", ["deep_worked_calculations.csv"]))
        tables["N13"].append((f"g1:tab:deep-{method}-bootstrap", f"deep_{method}_bootstrap.tex", ["deep_bootstrap_profiles.csv", "deep_bootstrap_histograms.csv"]))
    tables["N13"].append(("g1:tab:sensitivity", "sensitivity.tex", ["deep_fit_sensitivities.csv", "nominal_coefficients.csv"]))
    return tables


def deep_related_publication_tables() -> list[dict]:
    """Tables in the appendix whose sources belong to the frozen N01/N04/N05 branch."""
    rows = []
    for method in ("lp", "op", "acf", "wrdg"):
        rows.append({
            "table_id": f"g1:tab:deep-{method}-mapping", "path": f"publication/tables/deep_{method}_mapping.tex",
            "source_nodes": ["G1_N01"], "source_artifacts": ["nominal/N01_source.dta", "nominal-specification.json", "stata/methods/METHOD-CONTRACT.md"],
            "role": "Declarative method-variable mapping; documents the frozen nominal specification and source fields, not an estimate or deep-stage output.",
        })
    body_path = MODULE / "publication/appendix.tex"
    included = set(re.findall(r"\\GOneInput\{tables/([^}]+)\}", body_path.read_text())) if body_path.is_file() else set()
    for method in ("op", "lp", "acf", "wrdg"):
        regression_files = sorted(name for name in included if re.fullmatch(f"deep_{method}_regression(?:-common)?(?:-\\d+)?\\.tex", name))
        if not regression_files:
            regression_files = [f"deep_{method}_regression.tex"]
        for filename in regression_files:
            rows.append({
                "table_id": "g1:tab:" + filename.removesuffix(".tex").replace("_", "-"),
                "path": "publication/tables/" + filename,
                "source_nodes": ["G1_N04", "G1_N05"], "source_artifacts": ["release/outputs/nominal_coefficients.csv", "release/outputs/nominal_bootstrap_summary.csv"],
                "role": "Existing own/common primary coefficients and successful-draw summaries, including every continuation table actually included in the manuscript; no coefficient fit or bootstrap is run by N08–N13.",
            })
        for suffix in ("attempts", "numerics"):
            rows.append({
                "table_id": f"g1:tab:deep-{method}-{suffix}",
                "path": f"publication/tables/deep_{method}_{suffix}.tex",
                "source_nodes": ["G1_N04"], "source_artifacts": ["release/outputs/nominal_coefficients.csv"],
                "role": "Existing own/common primary fit outcomes or numerical rank and optimization diagnostics; failed and unsupported obligations remain distinct.",
            })
    rows.append({
        "table_id": "g1:tab:deep-op-all-support", "path": "publication/tables/deep_op_all_support.tex",
        "source_nodes": ["G1_N04"], "source_artifacts": ["release/outputs/nominal_coefficients.csv"],
        "role": "Existing OP all-sector support counts; preserves every supported and unsupported cell. Separate regression tables report supported OP estimates.",
    })
    return rows


def build_deep_exhibits(info: dict) -> list[dict]:
    """Register supplementary deep tables/figures without replacing the original 24 families."""
    figure_manifest_path = MODULE / "publication/provenance/deep-figure-manifest.json"
    figure_manifest = json.loads(figure_manifest_path.read_text(encoding="utf-8")) if figure_manifest_path.is_file() else {"figures": []}
    figure_rows = {row["figure"]: row for row in figure_manifest.get("figures", [])}
    all_tables = deep_publication_tables()
    related_table_rows = []
    base_run = Path((info.get("manifest") or {}).get("base_run", ""))
    for mapping in deep_related_publication_tables():
        table_path = MODULE / mapping["path"]
        sources = []
        for source in mapping["source_artifacts"]:
            if source.startswith("release/"):
                source_path = evidence_path(source)
            elif source.startswith("nominal/") and str(base_run) != ".":
                source_path = base_run / source
            else:
                source_path = MODULE / source
            sources.append({"path": relative(source_path) if source_path.is_relative_to(ROOT) else str(source_path),
                            "sha256": sha(source_path) if source_path.is_file() else None,
                            "exists": source_path.is_file()})
        related_table_rows.append({**mapping, "sha256": sha(table_path) if table_path.is_file() else None,
                                   "status": "present" if table_path.is_file() else "pending", "sources": sources})
    rows = []
    for offset, stage in enumerate(DEEP_STAGES, start=25):
        mapped_outputs = []
        output_complete = True
        for filename in stage["output_files"]:
            receipt = info.get("output_records", {}).get(filename, {})
            okay = bool(receipt.get("hash_matches_both_receipts"))
            output_complete = output_complete and okay
            mapped_outputs.append({"path": f"deep-release/outputs/{filename}", **receipt})
        tables = []
        table_complete = True
        for table_id, filename, sources in all_tables[stage["id"]]:
            path = MODULE / "publication/tables" / filename
            exists = path.is_file()
            record = {"table_id": table_id, "path": relative(path), "sha256": sha(path) if exists else None,
                      "status": "present" if exists else "pending", "source_csvs": sources,
                      "source_csv_hashes": {source: (info.get("output_records", {}).get(source, {}).get("sha256") or
                                                        (sha(evidence_path("release/outputs/" + source)) if evidence_path("release/outputs/" + source).is_file() else None)) for source in sources},
                      "namespace_status": "final g1: prefix from portable publication package"}
            tables.append(record)
            table_complete = table_complete and exists
        figures = []
        figure_complete = True
        registered_figure_ids = []
        for base_id in stage["figure_ids"]:
            registered_figure_ids.append(base_id)
            registered_figure_ids.extend(sorted(name for name in figure_rows if re.fullmatch(re.escape(base_id)+r"_p\d+", name)))
        for figure_id in registered_figure_ids:
            manifest_row = figure_rows.get(figure_id)
            if not manifest_row:
                figures.append({"figure_id": figure_id, "status": "pending_manifest"})
                figure_complete = False
                continue
            source_checks = []
            for source in manifest_row.get("sources", []):
                source_name = source["file"]
                if source_name.startswith("deep_"):
                    source_path = DEEP_EVIDENCE_ROOT / "outputs" / source_name
                else:
                    source_path = evidence_path("release/outputs/" + source_name)
                current_source_hash = sha(source_path) if source_path.is_file() else None
                source_checks.append({"file": source_name, "sha256_in_figure_manifest": source.get("sha256"),
                                      "current_sha256": current_source_hash,
                                      "hash_matches": current_source_hash == source.get("sha256")})
            figure_outputs = []
            for artifact in manifest_row.get("outputs", []):
                path = MODULE / "publication" / artifact["path"]
                exists = path.is_file()
                current_hash = sha(path) if exists else None
                figure_outputs.append({"path": relative(path), "sha256_in_figure_manifest": artifact.get("sha256"),
                                       "current_sha256": current_hash, "exists": exists,
                                       "hash_matches": current_hash == artifact.get("sha256")})
            sources_ok = bool(source_checks) and all(x["hash_matches"] for x in source_checks)
            artifacts_ok = bool(figure_outputs) and all(x["exists"] and x["hash_matches"] for x in figure_outputs)
            figure_ok = sources_ok and artifacts_ok
            figure_complete = figure_complete and figure_ok
            figures.append({"figure_id": figure_id, "construction": manifest_row.get("construction"),
                            "visible_legend": manifest_row.get("visible_legend"), "sources": source_checks,
                            "outputs": figure_outputs, "status": "hash_verified" if figure_ok else "source_or_artifact_hash_pending"})
        stage_status = ("deep_aggregate_and_publication_artifacts_hash_verified" if
                        info.get("outputs_copied_and_validated") and output_complete and table_complete and figure_complete
                        else "deep_aggregate_validation_passed_publication_mapping_pending" if
                        info.get("outputs_copied_and_validated") and output_complete
                        else "deep_aggregate_receipt_pending")
        rows.append({
            "exhibit_id": f"G1-X{offset:02d}", "stage_id": stage["id"], "node_id": "G1_" + stage["id"],
            "title": stage["title"], "status": stage_status,
            "scope": "Supplementary nominal-development diagnostics; does not replace, close, or alter the original 24 exhibit families.",
            "grain": stage["grain"], "keys_by_output": stage["keys_by_output"], "calendar": stage["calendar"],
            "denominator": stage["denominator"], "units": stage["units"],
            "missingness": stage["missingness"], "suppression": stage["suppression"],
            "decision_and_triage": stage["decision"], "aggregate_outputs": mapped_outputs,
            "publication_tables": tables, "figure_ids": registered_figure_ids, "figures": figures,
            "primary_real_admission": False, "no_new_coefficient_fits": True,
            "publication_table_ids_frozen_by_method_audit": True,
            "validation_status": info.get("validation_status", "PENDING"),
            "validation_cells": (info.get("validation") or {}).get("aggregate_cells_compared"),
            "validator_source_revision_status": info.get("validator_revision_status"),
            "source_contract_sha256": info.get("contract_sha256"),
            "source_deep_run_manifest_sha256": info.get("manifest_sha256"),
        })
    table(MODULE / "registries/deep-exhibits.csv", rows)
    dump(MODULE / "registries/deep-exhibits.json", {
        "label": LABEL, "status_note": "Supplementary deep diagnostics are separately registered; the original 24 G1 exhibit families remain unchanged.",
        "source_contract": relative(DEEP_CONTRACT), "source_contract_sha256": info.get("contract_sha256"),
        "deep_release": "deep-release/", "deep_figure_manifest": relative(figure_manifest_path) if figure_manifest_path.is_file() else None,
        "deep_figure_manifest_sha256": sha(figure_manifest_path) if figure_manifest_path.is_file() else None,
        "related_existing_branch_tables": related_table_rows,
        "exhibits": rows,
    })
    write(MODULE / "registries/deep-exhibit-reconciliation.md",
          f"# Supplementary N08–N13 diagnostic exhibit mapping\n\n{LABEL}\n\nThis registry adds six supplementary diagnostic families, G1-X25–G1-X30. It does not replace or rewrite the original 24 families in `exhibits.csv` and `exhibits.json`. The exact per-method LaTeX table IDs use the final `g1:tab:` namespace supplied by method audit. A native table is marked pending until its source exists. Output receipts, table placements, figure IDs, files, and hashes are recorded in [deep-exhibits.json](deep-exhibits.json).\n\nThe 12 aggregate CSVs are screened in `deep-release/outputs/`; the external run keeps record-level intermediates private. Output validation is independent of the nominal fit receipts and does not establish real-primary admission or OP/common estimator support. The appendix also contains explicitly cross-referenced tables from the existing N01/N04/N05 branch; those tables are not relabeled as outputs of N08–N13.\n\n| Supplementary family | Stage | Table IDs | Figure IDs | Status |\n|---|---|---|---|---|\n" + "\n".join(f"| {r['exhibit_id']} | {r['stage_id']} | {', '.join(t['table_id'] for t in r['publication_tables']) or '—'} | {', '.join(r['figure_ids']) or '—'} | {r['status']} |" for r in rows) + "\n\n## Related existing-branch tables\n\n| Table ID | Existing source node(s) | Source artifacts | Status |\n|---|---|---|---|\n" + "\n".join(f"| {t['table_id']} | {', '.join(t['source_nodes'])} | {', '.join(t['source_artifacts'])} | {t['status']} |" for t in related_table_rows) + "\n")
    return rows


def update_development_branches(info: dict) -> None:
    path = MODULE / "registries/development-branches.json"
    branches = json.loads(path.read_text(encoding="utf-8")) if path.is_file() else {}
    branches["deep_diagnostics"] = {
        "status": "nominal_development_deep_diagnostics_no_refit",
        "contract": relative(DEEP_CONTRACT), "contract_sha256": info.get("contract_sha256"),
        "screened_evidence_root": "work-items/G1/deep-release/",
        "run_manifest": "work-items/G1/deep-release/run-manifest.json", "run_manifest_sha256": info.get("manifest_sha256"),
        "validation": "work-items/G1/deep-release/qa/deep-validation.json", "validation_sha256": info.get("validation_sha256"),
        "validation_status": info.get("validation_status", "PENDING"),
        "aggregate_cells_compared": (info.get("validation") or {}).get("aggregate_cells_compared"),
        "aggregate_output_count": len(info.get("output_records", {})),
        "all_released_outputs_match_manifest_and_validation": info.get("outputs_copied_and_validated"),
        "validator_source_revision_status": info.get("validator_revision_status"),
        "validator_source_revision_receipt": "work-items/G1/qa/deep-validator-source-revision.json" if info.get("validator_revision") else None,
        "base_run": (info.get("manifest") or {}).get("base_run"), "deep_run": (info.get("manifest") or {}).get("run"),
        "input_manifest_sha256": (info.get("manifest") or {}).get("input_manifest_sha256"),
        "new_coefficient_fits": False, "primary_real_admission": False,
        "primary_G1_dispatch_verified_by_deep_release": info.get("final_execution_verified", False),
        "primary_G1_dispatch_revision_receipt": "work-items/G1/qa/deep-primary-dispatch-source-revision.json" if info.get("dispatch_revision") else None,
        "primary_G1_dispatch_final_execution_receipt": "work-items/G1/qa/deep-final-execution.json" if info.get("final_execution") else None,
        "primary_G1_dispatch_final_execution_receipt_sha256": info.get("final_execution_sha256"),
        "primary_G1_dispatch_final_execution_status": info.get("final_execution_status", "PENDING"),
        "branch_limit": "Uses frozen nominal-development fits/draws on the official fictional panel. OP and common unsupported cells remain unsupported; this branch is not accepted real TFP.",
        "supplementary_exhibits": "registries/deep-exhibits.json",
    }
    dump(path, branches)


def evidence_bound() -> bool:
    coefficients = EVIDENCE_ROOT / "outputs/nominal_coefficients.csv"
    if coefficients.exists():
        with coefficients.open() as stream:
            rows = list(csv.DictReader(stream))
        specification_id = json.loads(NOMINAL_SPEC.read_text())["specification_id"]
        return bool(rows) and all(row.get("input_manifest_sha256") == CURRENT_INPUT_HASH and row.get("specification_id") == specification_id for row in rows)
    manifest = EVIDENCE_ROOT / "run-manifest.json"
    if manifest.exists():
        value = json.loads(manifest.read_text()).get("input", {})
        return value.get("input_sha256") == CURRENT_INPUT_HASH
    return False


def evidence_path(path: str) -> Path:
    if path.startswith("release/"):
        return EVIDENCE_ROOT / path.removeprefix("release/") if evidence_bound() else EVIDENCE_ROOT / "__unbound_prior_version__" / path
    return MODULE / path


def read_aggregate(name: str) -> list[dict]:
    path = evidence_path("release/outputs/" + name)
    if not path.is_file():
        return []
    with path.open() as stream:
        return list(csv.DictReader(stream))


def build_nominal_contracts(base_evidence: dict):
    spec = json.loads(NOMINAL_SPEC.read_text())
    assert spec["input_manifest_sha256"] == CURRENT_INPUT_HASH
    fit = read_aggregate("nominal_coefficients.csv")
    bootstrap = read_aggregate("nominal_bootstrap_summary.csv")
    distributions = read_aggregate("nominal_distribution_quantiles.csv")
    comparisons = read_aggregate("nominal_pairwise_comparisons.csv")
    # WFDOC: Estimator harus cocok dengan source eksekusi atau komentar saja; renderer agregat tunggal boleh memakai revisi layout yang terbukti mempertahankan semua operand.
    execution_path = EVIDENCE_ROOT / "run-manifest.json"
    execution = json.loads(execution_path.read_text()) if execution_path.is_file() and evidence_bound() else {}
    executed_code = {row["path"]: row["sha256"] for row in execution.get("code", [])}
    continuity = [{"path": path, "executed_sha256": digest,
                   "current_sha256": sha(ROOT / path),
                   "executed_or_proven_comment_only": executed_source_matches(path, digest),
                   "presentation_rerender_verified": presentation_rerender_matches(path, digest)}
                  for path, digest in executed_code.items()]
    result_summary = {
        "evidence_root": str(EVIDENCE_ROOT), "evidence_bound_to_current_v3": evidence_bound(),
        "status": "AGGREGATE_RECEIPTS_PRESENT_FINAL_PACKAGE_VALIDATION_SEPARATE" if fit else "CURRENT_NOMINAL_RECEIPTS_NOT_PRESENT_IN_SELECTED_ROOT",
        "specification_id": spec["specification_id"], "input_manifest_sha256": CURRENT_INPUT_HASH,
        "run_id": execution.get("run_id"),
        "run_manifest_sha256": sha(execution_path) if execution else None,
        "source_continuity": continuity,
        "source_continuity_status": "PASS" if continuity and all(row["executed_or_proven_comment_only"] or row["presentation_rerender_verified"] for row in continuity) else "REVIEW_REQUIRED",
        "declared_fit_cells": len(fit) if fit else None,
        "successful_fits": sum(r["status"] == "fit_success" for r in fit) if fit else None,
        "successful_primary_fits": sum(r["status"] == "fit_success" and r["variant"] == "primary" for r in fit) if fit else None,
        "successful_sensitivities": sum(r["status"] == "fit_success" and r["variant"] != "primary" for r in fit) if fit else None,
        "unsupported_cells": sum(r["status"] == "skipped_support" for r in fit) if fit else None,
        "bootstrap_requested": sum(int(float(r["requested"])) for r in bootstrap) if bootstrap else None,
        "bootstrap_successful": sum(int(float(r["successful"])) for r in bootstrap) if bootstrap else None,
        "distribution_ALL_own_raw_counts": {r["method"]: int(float(r["N"])) for r in distributions if r["sector"] == "ALL" and r["sample_id"] == "own" and r["measure"] == "raw"},
        "pairwise_ALL_own_counts": {r["method_a"] + "_" + r["method_b"]: int(float(r["N_compared"])) for r in comparisons if r["sector"] == "ALL" and r["sample_id"] == "own" and r["comparison_scope"] == "pairwise"},
        "four_method_ALL_own_counts": {r["method_a"] + "_" + r["method_b"]: int(float(r["N_compared"])) for r in comparisons if r["sector"] == "ALL" and r["sample_id"] == "own" and r["comparison_scope"] == "four_method"},
        "full_master_attachment_receipt_present": evidence_path("release/outputs/nominal_master_attachment.csv").is_file(),
        "actual_linkage_is_development_blocker": False, "primary_real_admission": False,
        "approximate_real_status": "Separately registered specification/parser/actual-price-table preparation; no approximate-real fit or primary admission claimed",
        "receipt_hashes": {name: sha(evidence_path("release/outputs/" + name)) for name in ["nominal_coefficients.csv", "nominal_bootstrap_summary.csv", "nominal_distribution_quantiles.csv", "nominal_pairwise_comparisons.csv", "nominal_master_attachment.csv"] if evidence_path("release/outputs/" + name).is_file()},
    }
    dump(MODULE / "registries/nominal-execution-evidence.json", result_summary)
    rows, triage, decisions, edges = [], [], [], []
    for index, stage in enumerate(NOMINAL_STAGES):
        code = "G1_" + stage["id"]
        source = MODULE / "stata/nominal" / stage["file"]
        assert source.is_file(), str(source)
        available = ["outputs/" + name for name in stage["public"] if evidence_path("release/outputs/" + name).is_file()]
        private_available = [path for path in stage["outputs"] if "*" not in path and evidence_bound() and (EVIDENCE_ROOT / path).is_file()]
        status = "implemented_aggregate_receipt_present_validation_separate" if available else "implemented_private_artifact_present_validation_separate" if private_available else "implemented_final_run_receipt_pending"
        inputs = ["G1_INPUT_CANONICAL"] if index == 0 else ["G1_" + NOMINAL_STAGES[index-1]["id"]]
        if stage["id"] == "N07":
            inputs.append("G1_INPUT_CANONICAL")
        contract = {"node_id": code, "branch": "nominal_development_compatibility", "material_state_status": status,
                    "state": stage["title"], "inputs": stage["inputs"], "input_nodes": inputs,
                    "outputs_relative_to_external_run": stage["outputs"], "aggregate_outputs_relative_to_external_run": ["outputs/" + n for n in stage["public"]],
                    "available_aggregate_receipts": available, "available_private_artifacts": private_available,
                    "grain": stage["grain"], "keys": stage["keys"], "denominator": stage["denominator"],
                    "units": {"levels": "reported monetary candidate units; no verified conversion or deflation", "logs_and_residuals": "natural-log points; nominal structural residual contains price/measurement/transitory components", "coefficients": "dimensionless elasticities", "counts": "source observations, derivative risk intervals, distinct synthetic firms and draws explicitly distinguished"},
                    "calendar": "Source2010–2015/2017–2022; production2011–2015/2018–2022; dynamic2012–2015/2019–2022; actual delta1", "decision": stage["decision"],
                    "missingness": "Missing/zero/negative remain distinct; no imputation; unsupported statistical results remain missing and every skipped/failed obligation is retained",
                    "source_code": relative(source), "source_code_sha256": sha(source),
                    "executed_source_sha256": executed_code.get(relative(source)),
                    "executed_source_or_proven_comment_only": executed_source_matches(relative(source), executed_code[relative(source)]) if relative(source) in executed_code else False,
                    "specification_path": relative(NOMINAL_SPEC), "specification_sha256": sha(NOMINAL_SPEC),
                    "aggregate_receipt_sha256": {name: sha(EVIDENCE_ROOT / name) for name in available},
                    "execution_evidence_root": str(EVIDENCE_ROOT), "primary_real_admission": False,
                    "panel_mode": "official synthetic_development; real linkage not required or claimed", **base_evidence}
        folder = MODULE / "dag/nodes" / code
        dump(folder / "contract.json", contract)
        write(folder / "triage.md", f"# {code} triage\n\n{LABEL}\n\nStatus: **{status}**.\n\n{stage['title']}. Source code is implemented. Only the named hash-bound receipts establish execution coverage; final package validation remains separate. Missing REAL company linkage is not a development blocker. OP/common support failures remain visible.\n\nReopen on changed source/specification hashes, failed validation, new source evidence or owner instruction.\n")
        write(folder / "decision.md", f"# {code} decision\n\n{stage['decision']}\n\nGrain: {stage['grain']}. Keys: {', '.join(stage['keys'])}.\n\nDenominator: {stage['denominator']}.\n\nCode SHA256 `{sha(source)}`; G0.5 SHA256 `{CURRENT_INPUT_HASH}`; nominal specification SHA256 `{sha(NOMINAL_SPEC)}`. Exact units, input/output paths and receipt hashes: [contract.json](contract.json).\n")
        rows.append(dict(node_id=code, state=stage["title"], material_state_status=status, grain=stage["grain"], keys=stage["keys"], units=contract["units"], calendar=contract["calendar"], denominator=stage["denominator"], input_nodes=inputs, producing_edge="G1_NE" + stage["id"][1:], contract=relative(folder / "contract.json"), contract_sha256=sha(folder / "contract.json")))
        triage.append(dict(triage_id=code+"-T01", node_id=code, status=status, question=stage["title"], blockers="Real-primary acceptance separate; current branch support failures preserved", reopen_rule="New source/code/specification hash, failed validation or owner instruction", triage_file=relative(folder / "triage.md")))
        decisions.append(dict(node_id=code, decision_id=code+"-D01", selected_rule=stage["decision"], material_state_status=status, evidence_file=relative(folder / "contract.json"), evidence_sha256=sha(folder / "contract.json"), **base_evidence))
        edges.append(dict(edge_id="G1_NE" + stage["id"][1:], title=stage["title"], input_nodes=inputs, output_nodes=[code], depends_on=[] if index==0 else ["G1_NE" + NOMINAL_STAGES[index-1]["id"][1:]], primary_do="Separate nominal branch; see runner receipt", do_file=relative(source), source_exists=True, code_sha256=sha(source), required_action=stage["decision"], required_validation=stage["denominator"], audit_outputs_relative_to_private_run=stage["outputs"], numerical_state_status=status, execution_status="Hash-bound aggregate/private artifacts named in node; no code-existence pass"))
    dump(MODULE / "registries/development-branches.json", {"nominal": {"specification": relative(NOMINAL_SPEC), "sha256": sha(NOMINAL_SPEC), "execution_evidence": "registries/nominal-execution-evidence.json"}, "approximate_real": {"specification": "work-items/G1/approx-real-specification.json", "status": "registered_preparation_only_no_Stata_fit", "sha256": sha(MODULE / "approx-real-specification.json"), "price_manifest": "work-items/G1/price-sources/manifest.json", "price_manifest_sha256": sha(MODULE / "price-sources/manifest.json")}, "primary_real_admission": False})
    nominal_variables = [
        ("nom_y", "log(value_added_nominal)", "Positive reported nominal VA; no deflator"),
        ("nom_l", "log(workers)", "Positive reported worker count"),
        ("nom_k", "log(L.capital_stock_nominal)", "Beginning-K equals assumed prior year-end reported stock, exact delta1; original documentary flags preserved"),
        ("nom_i", "log(capital_additions_nominal)", "Positive reported additions assumed as investment candidate; documentary evidence preserved and real-unit/price admission false"),
        ("nom_m", "log(val_rtlvcu)", "Positive raw/supporting materials expenditure candidate"),
        ("nom_risk", "One interval per fictional firm between adjacent supplied calendar years", "Not an invented production observation"),
        ("nom_disappearance", "Official fictional psid unmatched in the next supplied calendar year", "Generator disappearance, not actual economic closure"),
    ]
    table(MODULE / "registries/nominal_variables.csv", [dict(variable=name, operand=operand, interpretation=meaning, measurement_mode="nominal_development", source_manifest_sha256=CURRENT_INPUT_HASH, specification_sha256=sha(NOMINAL_SPEC)) for name,operand,meaning in nominal_variables])
    aliases = []
    for method in ["op", "lp", "acf", "wrdg"]:
        for sample in ["own", "common"]:
            for normalized in [False, True]:
                column = "dev_nominal_" + ("common_" if sample == "common" else "") + ("c_" if normalized else "tfp_") + method
                aliases.append(dict(column=column, method=method, sample_id=sample, variant="primary", production_years=spec["production_years"], specification_id=spec["specification_id"], measurement_mode="nominal_development", normalization="sector-method-sample pooled dynamic fit mean centered" if normalized else "native nominal structural log residual", units="natural-log points", join_key="obs_id/source_year", unsupported_rule="Missing if no supported successful cell or positive prediction domain; consult current fit receipts", empirical_TFP=False))
    table(MODULE / "registries/nominal_column_aliases.csv", aliases)
    return rows, triage, decisions, edges


def nominal_exhibit_maps():
    primary = "Original accepted-real primary remains unadmitted; nominal development evidence does not discharge this scope."
    maps = {
        1: ("delivered", ["registries/methods.svg", "registries/method-contracts.md"], "Four distinct estimator definitions and separately declared development measurement mode.", "Definition only; execution coverage is in nominal receipts."),
        2: ("delivered", ["registries/variables.csv", "registries/development-branches.json"], "Primary variable gates plus frozen nominal and approximate-real preparation specifications.", primary),
        3: ("partial", ["release/outputs/nominal_sample_support.csv", "release/figures/nominal_sample_support.svg"], "Nominal candidate and positive/source-year support under declared technology prefixes.", primary),
        4: ("partial", ["release/outputs/nominal_sample_support.csv", "dag/nodes/G1_N03/contract.json"], "Official v3 fictional panel and exact annual source/production/dynamic/selection denominators.", "Actual finalisation linkage is separate; no calendar-gap compression."),
        5: ("partial", ["release/outputs/nominal_sample_support.csv", "release/outputs/nominal_coefficients.csv"], "OP nominal investment/selection support and explicit threshold failures.", "Any OP coefficient is conditional on assumed investment values and fictional disappearance, not actual economic selection."),
        6: ("partial", ["release/outputs/nominal_sample_support.csv", "release/outputs/nominal_coefficients.csv"], "Declared positive materials domains and LP/ACF/WRDG dynamic support.", primary),
        7: ("delivered", ["registries/method-contracts.md", "registries/pinned_method_contract.json"], "ACF basis, timing, innovation moments and instrument definitions.", "Definition exhibit; numerical results remain conditional development."),
        8: ("delivered", ["registries/method-contracts.md", "registries/pinned_method_contract.json"], "Wooldridge joint equations, instruments, nuisance sharing and weighting.", "Definition exhibit; numerical results remain conditional development."),
        9: ("partial", ["release/outputs/nominal_sample_support.csv", "release/outputs/nominal_coefficients.csv"], "Own/common production and exact dynamic sample support; all unsupported cells retained.", "Common cells must independently satisfy declared thresholds; never pool different sectors for N."),
        17: ("partial", ["release/outputs/nominal_optimizer_diagnostics.csv"], "Complete declared nominal fit grid with actual successes and support skips.", primary),
        18: ("partial", ["release/outputs/nominal_bootstrap_summary.csv"], "99-draw full-process synthetic-firm exploratory uncertainty for successful primary cells.", "Required999-draw accepted-real primary inference is not complete."),
        19: ("partial", ["release/outputs/nominal_master_attachment.csv", "release/outputs/nominal_distribution_quantiles.csv"], "Method/year supported nominal attachment and original-observation prediction coverage.", "Each method and sample retains its actual support/fit outcome; full-master attachment only when its receipt exists."),
        20: ("partial", ["release/outputs/nominal_distribution_quantiles.csv", "release/outputs/nominal_histogram_bins.csv", "release/figures/nominal_residual_distribution.svg"], "Pooled primary dynamic nominal residual distributions, raw/centered and all tails.", "No physical or verified real TFP claim; empty obligations remain explicit."),
        21: ("partial", ["release/outputs/nominal_pairwise_comparisons.csv", "release/outputs/nominal_rank_scatter_bins.csv", "release/figures/nominal_rank_comparison.svg"], "Exact pairwise and four-method comparison denominators; aggregate rank scatters.", "Four-method comparisons require the exact all-method intersection; pairwise evidence cannot replace it."),
        22: ("partial", ["release/outputs/nominal_distribution_quantiles.csv"], "Explicit own/common nominal distribution obligations including any empty common cells.", "Empty support is not zero productivity; supported common records are reported separately."),
        23: ("partial", ["dag/nodes/G1_N07/contract.json", "release/outputs/nominal_master_attachment.csv"], "Full4396-column source attachment code and method/year count receipt when executed.", "Keep unsupported values missing; final all-original-value integrity validation required."),
        24: ("partial", ["registries/nominal-execution-evidence.json", "release/qa/numeric-validation.json", "release/run-manifest.json"], "Exact current-version result/validation receipts, separate from original empirical completion.", primary),
    }
    for n in (10,11,12,13,14,15,16):
        maps[n] = ("partial", ["release/outputs/nominal_coefficients.csv", "release/outputs/nominal_optimizer_diagnostics.csv", "release/outputs/nominal_bootstrap_summary.csv", "release/figures/nominal_coefficients.svg"], "Nominal primary/sensitivity coefficient and rank/convergence receipts; unsupported OP/common cells retained.", primary)
    return maps



if __name__ == "__main__":
    main()
