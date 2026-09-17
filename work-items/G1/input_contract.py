"""Explicit hash-bound input contracts for local pipeline variants.

Absent a new contract, retain all original G0.5-v3 validation expectations.
"""
import hashlib
import json


def sha(path):
    with path.open('rb') as f:
        return hashlib.file_digest(f, 'sha256').hexdigest()


def load_input_contract(run):
    path = run / 'input-contract.json'
    if not path.exists():
        return dict(rows=33049, firms=10395, lag1_rows=20579, full_columns=4396,
                    manifest_sha256='060b0ee0a2158a9c94b0e7e68fcfba719eda37561422855471a99da6810ba260')
    c = json.loads(path.read_text())
    assert c['version'] == 'g025-mask-g05-panel-g1-v1'
    assert c['rows'] == 33049 and c['firms'] > 0
    assert c['extra_g05_numeric_noise'] is False
    assert sha(run / 'input-manifest.json') == c['manifest_sha256']
    assert sha(run / 'input.dta') == c['input_sha256']
    assert sha(run / 'full_input.dta') == c['full_input_sha256']
    m = json.loads((run / 'input-manifest.json').read_text())
    assert c['rows'] == m['rows'] and c['firms'] == m['firms']
    assert c['lag1_rows'] == m['lag1_rows']
    return c
