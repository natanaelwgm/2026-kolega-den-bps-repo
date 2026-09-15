#!/usr/bin/env python3
"""Run hash-pinned G0.5 primary gates and declared nominal production estimates.

The real primary specification and nominal development compatibility are distinct.
All record-level data remain outside the checkout. Every run gets a new directory.
"""
# WFDOC: Runner ini memisahkan gate sumber riil dari estimasi nominal development; mode actual ditolak sampai bukti penerimaan diperbarui.
from __future__ import annotations
import argparse
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
from datetime import datetime, timezone

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(ROOT))
from harness.data_source import load_data, write_run_receipt, sha


def write_json(path, value):
    path.write_text(json.dumps(value, indent=2, ensure_ascii=False) + "\n")


def hashes(paths):
    return [{"path": str(p.relative_to(ROOT)), "sha256": sha(p)} for p in sorted(paths) if p.is_file()]


def export_stata(frame, path):
    # WFDOC: attrs pandas dikosongkan hanya selama ekspor biner agar metadata tidak disalin berulang; blok finally memulihkannya sebelum receipt dan hash dibuat.
    """Avoid repeatedly copying large provenance attributes per Stata column."""
    metadata = frame.attrs
    try:
        frame.attrs = {}
        frame.to_stata(path, write_index=False, version=118, data_label="DEASY G0.5 DEVELOPMENT")
    finally:
        frame.attrs = metadata


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--run-id", default=datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ"))
    parser.add_argument("--mode", choices=["development", "actual"], default="development")
    parser.add_argument("--actual-path", type=Path)
    parser.add_argument("--publish", action="store_true", help="Copy screened aggregates to release/, retain old release locally")
    args = parser.parse_args()
    if Path(args.run_id).name != args.run_id or args.run_id in {".", ".."}:
        parser.error("run-id must be a simple directory name")
    config = json.loads((HERE / "config.json").read_text())
    assert sha(ROOT / "data/g0-5-development/manifest.json") == config["input_manifest_sha256"], "Input version changed: review gates first"
    gate_sources = json.loads((HERE / "source-gates.json").read_text())
    for item in gate_sources["sources"]:
        assert sha(ROOT / item["path"]) == item["sha256"], "Source admission evidence changed: review frozen gates first"
    # This release is explicitly scoped to the frozen development input. An
    # actual path is never loaded merely because its command-line option exists.
    if args.mode == "actual":
        parser.error("Actual finalisation is not admitted by this release: accept panel/measurement/price receipts and revise the gates, then rerun this same analysis body explicitly. No development relabelling.")
    # WFDOC: Setiap percobaan memakai direktori baru di luar checkout; DTA baris, log Stata, dan analisis tetap di lokasi run.
    run = ROOT.parent / (ROOT.name + "-g1-runs") / args.run_id
    run.mkdir(parents=True, exist_ok=False)
    for folder in ["outputs", "analysis", "figures", "qa", "nominal"]:
        (run / folder).mkdir()
    (run / "outputs/bootstrap_draws").mkdir()
    started = datetime.now(timezone.utc).isoformat()
    # WFDOC: Pin kode mencakup runner, validator dan plot, seluruh do/ado, serta builder adapter dan overlay komentarnya.
    code_files = [HERE / name for name in ["config.json", "source-gates.json", "nominal-specification.json", "run.py", "validate.py", "validate_nominal.py", "validate_master.py", "plot.py", "plot_nominal.py", "publication/plot_figures.py"]]
    code_files += [ROOT / "harness/data_source.py", ROOT / "harness/g05/use_data.do", *[p for p in HERE.joinpath("stata").rglob("*.do") if "deep" not in p.relative_to(HERE / "stata").parts], *HERE.joinpath("stata").rglob("*.ado"), HERE / "stata/methods/build_adapter.py", HERE / "stata/methods/adapter-commentary.json"]
    code_pin = hashes(code_files)
    # WFDOC: Ekspor master 4.396 kolom lebih dahulu, lalu proyeksi input terpilih; psid synthetic_development bukan identitas perusahaan aktual.
    print("G1 E00 | exporting complete 4,396-column master through shared adapter", flush=True)
    full = load_data(mode=args.mode, actual_path=args.actual_path, require_panel=True)
    export_stata(full, run / "full_input.dta")
    write_run_receipt(run / "full_input.dta.receipt.json", full, code_path=__file__)
    del full
    import gc
    gc.collect()
    print(f"G1 E00 | loading {len(config['input_columns'])} selected columns through shared adapter", flush=True)
    frame = load_data(mode=args.mode, actual_path=args.actual_path, columns=config["input_columns"], require_panel=True)
    # Format118 supports Stata SE for both the full master and this projection.
    export_stata(frame, run / "input.dta")
    write_run_receipt(run / "input.dta.receipt.json", frame, code_path=__file__)
    assert frame.psid_status.eq(config["development_panel_status"]).all()
    assert not frame.duplicated(["psid","source_year"]).any()
    panel_gate = {"status": "PASS_SYNTHETIC_DEVELOPMENT_PANEL", "rows": len(frame), "firms": int(frame.psid.nunique()), "firm_year_duplicates": 0, "actual_identity_verified": False}
    write_json(run / "qa/panel_adapter_gate.json", panel_gate)
    write_json(run / "attempt-manifest.json", {"started_utc": started, "run_id": args.run_id, "input": frame.attrs["deasy_data"], "code": code_pin, "source_gate_evidence": gate_sources, "status": "ATTEMPT_STARTED_NOT_YET_VALIDATED"})
    print("G1 E01-E19 + N01-N07 | one Stata process; real gates and nominal fits kept explicit", flush=True)
    stata = shutil.which("stata-se") or shutil.which("stata")
    if not stata:
        raise RuntimeError("Stata executable is required")
    # WFDOC: Satu proses Stata menjalankan G1.do; kode keluar, log dan sentinel akhir wajib cocok sebelum audit dan plot Python.
    proc = subprocess.run([stata, "-b", "do", str(HERE / "stata/G1.do"), str(ROOT), str(run), args.mode], cwd=run, timeout=14400)
    log = run / "G1_execution.log"
    # WFDOC: Sentinel dan exit code diperiksa sebelum validator/plot Python dipanggil; log gagal tetap disimpan di run baru untuk audit.
    if proc.returncode or not log.exists() or "G1_DEVELOPMENT_COMPLETE_PRIMARY_REAL_NOT_ADMITTED" not in log.read_text():
        raise RuntimeError(f"Stata did not complete. Retained failed run: {run}")
    env = dict(os.environ, MPLCONFIGDIR=str(run / "mpl-cache"), OMP_NUM_THREADS="1", OPENBLAS_NUM_THREADS="1")
    subprocess.run([sys.executable, str(HERE / "validate.py"), str(run)], check=True, env=env)
    subprocess.run([sys.executable, str(HERE / "validate_nominal.py"), "--run", str(run)], check=True, env=env)
    subprocess.run([sys.executable, str(HERE / "validate_master.py"), str(run)], check=True, env=env)
    subprocess.run([sys.executable, str(HERE / "plot.py"), str(run)], check=True, env=env)
    subprocess.run([sys.executable, str(HERE / "plot_nominal.py"), str(run)], check=True, env=env)
    # WFDOC: Manifest akhir mengikat input, kode, status dan hash output; opsi publish menyalin aggregate, QA, figur serta log setelah validasi.
    inventory = [{"path": str(p.relative_to(run)), "bytes": p.stat().st_size, "sha256": sha(p), "publication": "local_record_level"} for p in sorted(run.rglob("*.dta"))]
    write_json(run / "qa/intermediate_inventory.json", inventory)
    import pandas as pd
    fits = pd.read_csv(run / "outputs/nominal_coefficients.csv")
    attachment = pd.read_csv(run / "outputs/nominal_master_attachment.csv")
    receipt = {
        "started_utc": started, "finished_utc": datetime.now(timezone.utc).isoformat(),
        "run_id": args.run_id, "input": frame.attrs["deasy_data"],
        "development_status": "DEVELOPMENT_NOMINAL_ESTIMATES_EXECUTED_REAL_PRIMARY_NOT_ADMITTED",
        "actual_finalisation_status": "NOT_RUN_NOT_ADMITTED", "stata": stata,
        "stata_exit_code": proc.returncode, "code": code_pin,
        "git_base": subprocess.check_output(["git", "rev-parse", "HEAD"], cwd=ROOT, text=True).strip(),
        "model_fits_attempted": int(fits.attempted.sum()), "successful_primary_models": int((fits.variant.eq("primary") & fits.status.eq("fit_success")).sum()),
        "numerical_tfp_count": int(attachment[["N_op","N_lp","N_acf","N_wrdg"]].sum().sum()),
        "source_gate_evidence": gate_sources,
        "output_files": [{"path": str(p.relative_to(run)), "bytes": p.stat().st_size, "sha256": sha(p)} for folder in ["outputs", "figures", "qa"] for p in sorted((run / folder).rglob("*")) if p.is_file()],
        "logs": [{"path": log.name, "sha256": sha(log)}],
        "private_outputs": str(run / "analysis"),
        "private_output_scope": "Complete 4,396-column adapter master plus nominal development residual sidecar; all record-level intermediates outside checkout"
    }
    write_json(run / "run-manifest.json", receipt)
    # WFDOC: Perbandingan code pin sesudah validasi menolak receipt bila sumber berubah selama run; publikasi hanya menyalin output setelah gerbang ini lolos.
    assert code_pin == hashes(code_files), "Code changed during run"
    if args.publish:
        release = HERE / "release"
        if release.exists() and any(release.iterdir()):
            shutil.copytree(release, run / "previous-release")
        release.mkdir(exist_ok=True)
        # Replace only this runner's generated subdirectories after preserving
        # the prior release; obsolete figures must not survive into a new run.
        for folder in ["outputs", "figures", "qa", "logs"]:
            if (release / folder).exists():
                shutil.rmtree(release / folder)
        for folder in ["outputs", "figures", "qa"]:
            shutil.copytree(run / folder, release / folder)
        (release / "logs").mkdir(exist_ok=True)
        shutil.copy2(log, release / "logs/G1_execution.log")
        shutil.copy2(run / "run-manifest.json", release / "run-manifest.json")
    print(json.dumps({"run": str(run), "status": receipt["development_status"], "published_aggregates": args.publish}), flush=True)


if __name__ == "__main__":
    main()
