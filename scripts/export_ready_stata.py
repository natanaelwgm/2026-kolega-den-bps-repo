#!/usr/bin/env python3
"""Export the small native Stata package from this repository, without running it."""
from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import tempfile
import zipfile

from ready_stata_format import no_pdf, render_master

ROOT = Path(__file__).resolve().parents[1]
RECIPE = ROOT / "distribution/ready-stata"
DEFAULT_DATA = ROOT / "20260917-run/block-0-data-preparation/analysis_ready_data.dta"


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as source:
        for chunk in iter(lambda: source.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def source_file(relative: str) -> Path:
    path = (ROOT / relative).resolve()
    if not path.is_relative_to(ROOT) or not path.is_file():
        raise ValueError(f"Required repository file is missing or outside the repository: {relative}")
    return path


def git_commit() -> str | None:
    # A GitHub source ZIP has no .git; do not inherit an unrelated parent repo.
    if not (ROOT / ".git").exists():
        return None
    return subprocess.check_output(
        ["git", "-C", str(ROOT), "rev-parse", "HEAD"], text=True
    ).strip()


def assemble(destination: Path, ready_data: Path | None) -> dict:
    modules = json.loads((RECIPE / "modules.json").read_text(encoding="utf-8"))
    if (len(modules) != 34 or len({m["id"] for m in modules}) != 34
            or len({m["path"] for m in modules}) != 34):
        raise ValueError("Expected the 34 declared analysis groups.")
    records = []
    # Copy only source files directly in each declared analysis folder. Never
    # recurse into inputs, outputs, logs, raw preparation or local run folders.
    for module in modules:
        entry = source_file(module["path"] + "/00_run.do")
        for source in sorted(entry.parent.iterdir()):
            if not source.is_file() or source.suffix not in {".do", ".ado", ".md"}:
                continue
            relative = source.relative_to(ROOT).as_posix()
            source = source_file(relative)
            target = destination / "kode" / relative
            target.parent.mkdir(parents=True, exist_ok=True)
            removed = []
            if source.suffix == ".do":
                code, removed = no_pdf(source.read_text(encoding="utf-8-sig"))
                target.write_text(code, encoding="utf-8", newline="\n")
            else:
                shutil.copyfile(source, target)
            records.append({
                "path": relative,
                "source_sha256": sha256(source),
                "packaged_sha256": sha256(target),
                "omitted_pdf_lines": removed,
            })

    ado_manifest = json.loads((RECIPE / "ado-manifest.json").read_text(encoding="utf-8"))
    unique_ado = {}
    for item in ado_manifest["files"]:
        name = item["file"]
        if Path(name).name != name:
            raise ValueError(f"Invalid add-on filename: {name}")
        if name in unique_ado and unique_ado[name] != item["sha256"]:
            raise ValueError(f"Conflicting add-on versions: {name}")
        unique_ado[name] = item["sha256"]
    (destination / "ado").mkdir()
    for name, expected in sorted(unique_ado.items()):
        source = source_file("distribution/ready-stata/ado/" + name)
        if sha256(source) != expected:
            raise ValueError(f"Bundled add-on changed: {name}; update its reviewed manifest.")
        shutil.copyfile(source, destination / "ado" / name)
    shutil.copyfile(RECIPE / "ado/SOURCE-PACKAGES.txt", destination / "ado/SOURCE-PACKAGES.txt")
    for name in ["modules.json", "ado-manifest.json", "BACA-DULU.txt"]:
        shutil.copyfile(RECIPE / name, destination / name)

    data_record = None
    if ready_data is not None:
        if not ready_data.is_file() or ready_data.suffix.lower() != ".dta":
            raise ValueError(f"Ready data must be an existing .dta file: {ready_data}")
        (destination / "data").mkdir()
        target = destination / "data/analysis_ready_data.dta"
        shutil.copyfile(ready_data, target)
        data_record = {"file": "data/analysis_ready_data.dta", "sha256": sha256(target)}
    else:
        guide = destination / "BACA-DULU.txt"
        text = guide.read_text(encoding="utf-8")
        text = text.replace(
            "Data ready sudah ada di data/analysis_ready_data.dta.",
            "Paket ini tidak membawa data. Isi READY_DATA dengan lokasi berkas .dta kamu.",
        )
        guide.write_text(text, encoding="utf-8", newline="\n")

    master = render_master(modules, [record["path"] for record in records])
    (destination / "00_JALANKAN_SEMUA.do").write_text(master, encoding="utf-8", newline="\n")
    manifest = {"source_commit": git_commit(), "files": records, "ready_data": data_record}
    (destination / "code-manifest.json").write_text(
        json.dumps(manifest, indent=2) + "\n", encoding="utf-8", newline="\n"
    )
    return {"analysis_files": len(records), "analysis_groups": len(modules),
            "add_on_files": len(unique_ado), "ready_data": data_record}


def export(output: Path, ready_data: Path | None) -> dict:
    output = output.resolve()
    if output.exists():
        raise FileExistsError(f"Output already exists; choose another --output: {output}")
    output.parent.mkdir(parents=True, exist_ok=True)
    with tempfile.TemporaryDirectory(prefix="si-ready-export-", dir=output.parent) as temporary:
        work = Path(temporary)
        bundle = work / "SI-Ready-STATA"
        bundle.mkdir()
        summary = assemble(bundle, ready_data)
        archive = work / "package.zip"
        files = sorted(path for path in bundle.rglob("*") if path.is_file())
        with zipfile.ZipFile(archive, "x", zipfile.ZIP_DEFLATED) as zipped:
            for path in files:
                # Fixed metadata makes repeated exports of the same inputs identical.
                name = "SI-Ready-STATA/" + path.relative_to(bundle).as_posix()
                info = zipfile.ZipInfo(name, date_time=(1980, 1, 1, 0, 0, 0))
                info.compress_type = zipfile.ZIP_DEFLATED
                info.create_system = 3
                info.external_attr = 0o100644 << 16
                with zipped.open(info, "w") as target, path.open("rb") as source:
                    shutil.copyfileobj(source, target, 1024 * 1024)
        with zipfile.ZipFile(archive) as zipped:
            if zipped.testzip() is not None:
                raise ValueError("ZIP integrity check failed.")
            names = zipped.namelist()
            forbidden = {".py", ".command", ".cmd", ".pdf", ".log", ".smcl", ".xlsx", ".csv"}
            if any(Path(name).suffix.lower() in forbidden for name in names):
                raise ValueError("Unexpected file type in the standalone package.")
        # Exclusive creation preserves any existing export, including a concurrent one.
        with output.open("xb") as target, archive.open("rb") as source:
            shutil.copyfileobj(source, target, 1024 * 1024)
        output.chmod(0o600)
    return {**summary, "zip": str(output), "files": len(files),
            "bytes": output.stat().st_size, "sha256": sha256(output)}


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, default=ROOT / "dist/SI-Ready-STATA.zip")
    data = parser.add_mutually_exclusive_group()
    data.add_argument("--ready-data", type=Path, default=DEFAULT_DATA)
    data.add_argument("--without-data", action="store_true")
    arguments = parser.parse_args()
    ready = None if arguments.without_data else arguments.ready_data.expanduser().resolve()
    try:
        print(json.dumps(export(arguments.output, ready), indent=2))
    except (OSError, ValueError, subprocess.CalledProcessError) as error:
        parser.exit(1, f"Export failed: {error}\n")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
