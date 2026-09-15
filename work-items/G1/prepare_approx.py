#!/usr/bin/env python3
"""Freeze and inspect narrow G0.5 approximate-real inputs. No Stata or fitting.

Record-level exports remain in a new external directory. Published output from
this script is limited to aggregate parser/domain-of-measurement diagnostics.
"""
from __future__ import annotations

import argparse
from collections import Counter
from datetime import datetime, timezone
import json
import math
from pathlib import Path
import re
import shutil
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(ROOT))
from harness.data_source import load_data, sha, write_run_receipt
import pandas as pd
import pyarrow as pa

pa.set_cpu_count(1)
pa.set_io_thread_count(1)
MAX_STATA_DOUBLE = 8.988465674311579e307


def write_json(path, value):
    path.write_text(json.dumps(value, indent=2, ensure_ascii=False, allow_nan=False) + "\n")


def parse_value(value, parser):
    """Independent metadata inspection implementing the frozen Stata grammar."""
    if pd.isna(value):
        return None, 0
    text = str(value).strip(" ")
    if text == "":
        return None, 0
    if text in parser["missing_tokens"]:
        return None, 1
    if re.fullmatch(parser["accepted_pattern"], text) is None:
        return None, 2
    try:
        number = float(text.replace(",", ""))
    except (ValueError, OverflowError):
        return None, 3
    if not math.isfinite(number) or abs(number) > MAX_STATA_DOUBLE:
        return None, 3
    return number, 4 if number == 0 else 5 if number < 0 else 6


def inspect_components(frame, columns, parser):
    values, fields = [], []
    for field in columns:
        parsed = [parse_value(v, parser) for v in frame[field]]
        counts = Counter(status for _, status in parsed)
        values.append([value for value, _ in parsed])
        fields.append({"field": field, "N": len(frame),
                       "source_null": int(frame[field].isna().sum()),
                       "status_counts": {str(k): counts[k] for k in range(7)}})
    positive = []
    totals = Counter()
    for row in zip(*values):
        complete = all(value is not None for value in row)
        nonnegative = complete and all(value >= 0 for value in row)
        totals["complete"] += int(complete)
        totals["complete_nonnegative"] += int(nonnegative)
        total = sum(row) if nonnegative else None
        finite = total is not None and math.isfinite(total) and total <= MAX_STATA_DOUBLE
        totals["sum_overflow"] += int(nonnegative and not finite)
        totals["measured_zero_sum"] += int(finite and total == 0)
        positive.append(bool(finite and total > 0))
    totals["positive_sum"] = sum(positive)
    return fields, dict(totals), positive


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--run-id", default="approx-prepare-" + datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ"))
    args = parser.parse_args()
    if Path(args.run_id).name != args.run_id or args.run_id in {".", ".."}:
        parser.error("run-id must be a simple new directory name")
    spec_path = HERE / "approx-real-specification.json"
    spec = json.loads(spec_path.read_text())
    assert spec["actual_finalisation_allowed"] is False
    assert sha(ROOT / "data/g0-5-development/manifest.json") == spec["input_manifest_sha256"]
    price_manifest_path = ROOT / spec["prices"]["manifest_path"]
    assert sha(price_manifest_path) == spec["prices"]["manifest_sha256"]
    price_manifest = json.loads(price_manifest_path.read_text())
    price_path = ROOT / spec["prices"]["table_path"]
    assert sha(price_path) == spec["prices"]["table_sha256"] == price_manifest["table"]["sha256"]
    evidence = spec["documentary_evidence"]
    assert sha(ROOT / evidence["annual_metadata_path"]) == evidence["annual_metadata_sha256"]
    raw_columns = spec["stock_components"] + sum(spec["gross_additions_components_by_year"].values(), [])
    policy = json.loads((ROOT / "data/g0-5-development/column-policy.json").read_text())
    rules = {item["name"]: item for item in policy["columns"]}
    assert all(rules[name]["action"] == "preserve" for name in raw_columns)
    source_verification = []
    for item in price_manifest["sources"]:
        path = Path(item["local_source_pdf"])
        # Stable publication URL + hash remains a receipt if a temporary cache expires.
        if path.exists():
            assert sha(path) == item["sha256"]
        source_verification.append({"year": item["source_year"], "sha256": item["sha256"],
                                    "cached_pdf_hash_rechecked": path.exists()})
    run = ROOT.parent / (ROOT.name + "-g1-runs") / args.run_id
    run.mkdir(parents=True, exist_ok=False)
    (run / "approx").mkdir()
    (run / "qa").mkdir()
    (run / "outputs").mkdir()
    code_files = [spec_path, price_manifest_path, price_path, Path(__file__),
                  HERE / "stata/approx/A01_inputs.do", ROOT / "harness/data_source.py"]
    pins = [{"path": str(path.relative_to(ROOT)), "sha256": sha(path)} for path in code_files]
    # Freeze the parser and specifications before looking at any value representations.
    for path in [spec_path, price_manifest_path, HERE / "stata/approx/A01_inputs.do"]:
        target_name = "price-source-manifest.json" if path == price_manifest_path else path.name
        shutil.copy2(path, run / "approx" / target_name)
    shutil.copy2(price_path, run / "approx/prices.csv")
    write_json(run / "preparation-start.json", {"started_utc": datetime.now(timezone.utc).isoformat(),
               "specification_id": spec["specification_id"], "pins": pins,
               "scope": "Frozen before narrow source parsing; no Stata or estimates"})
    frame = load_data(mode="development", columns=spec["input_columns"],
                      years=spec["history_years"], require_panel=True)
    assert frame.attrs["deasy_data"]["input_sha256"] == spec["input_manifest_sha256"]
    frame.to_stata(run / "approx/S01_input.dta", write_index=False, version=118,
                   data_label="G0.5 DEVELOPMENT approximate-real selected inputs")
    write_run_receipt(run / "approx/S01_input.dta.receipt.json", frame, code_path=__file__)
    aggregate = []
    for year in spec["history_years"]:
        wave = frame.loc[frame.source_year.eq(year)]
        stock_fields, stock_totals, stock_positive = inspect_components(wave, spec["stock_components"], spec["numeric_parser"])
        investment_fields, investment_totals, investment_positive = inspect_components(
            wave, spec["gross_additions_components_by_year"][str(year)], spec["numeric_parser"])
        canonical_positive = [pd.notna(v) and math.isfinite(float(v)) and v > 0 for v in wave.capital_additions_nominal]
        aggregate.append({"source_year": year, "N": len(wave), "stock_fields": stock_fields,
                          "stock_construction": stock_totals, "investment_fields": investment_fields,
                          "investment_construction": investment_totals,
                          "canonical_gross_additions_positive": sum(canonical_positive),
                          "nonland_positive_and_canonical_nonpositive_or_missing": sum(a and not b for a, b in zip(investment_positive, canonical_positive)),
                          "canonical_positive_and_nonland_not_positive": sum(b and not a for a, b in zip(investment_positive, canonical_positive))})
    write_json(run / "outputs/approx_parser_aggregate.json", {
        "scope": "Aggregate measurement parsing/positivity only; no lags, domain counts, fit support or Stata execution inferred",
        "specification_id": spec["specification_id"], "parser": spec["numeric_parser"],
        "source_absent_columns": [], "years": aggregate})
    assert all(sha(ROOT / pin["path"]) == pin["sha256"] for pin in pins), "Preparation code changed during inspection"
    result = {"finished_utc": datetime.now(timezone.utc).isoformat(), "status": "PREPARED_NARROW_INPUTS_PARSER_INSPECTED_NO_STATA_NO_FITS",
              "run": str(run), "input": frame.attrs["deasy_data"], "pins": pins,
              "input_dta_sha256": sha(run / "approx/S01_input.dta"),
              "aggregate_sha256": sha(run / "outputs/approx_parser_aggregate.json"),
              "source_pdf_verification": source_verification, "actual_finalisation_allowed": False,
              "publication_scope": "Only aggregate outputs may be screened for repository publication; input and A01 intermediates remain external"}
    write_json(run / "preparation-manifest.json", result)
    print(json.dumps({"run": str(run), "status": result["status"], "rows": len(frame),
                      "columns": len(frame.columns), "years": [{"year": row["source_year"],
                      "N": row["N"], "nonland_stock_positive": row["stock_construction"]["positive_sum"],
                      "nonland_investment_positive": row["investment_construction"]["positive_sum"],
                      "canonical_investment_positive": row["canonical_gross_additions_positive"],
                      "nonland_only_positive": row["nonland_positive_and_canonical_nonpositive_or_missing"]} for row in aggregate]}))


if __name__ == "__main__":
    main()
