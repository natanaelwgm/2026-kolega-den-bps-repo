#!/usr/bin/env python3
"""Rebind the amended release tree while preserving its historical receipt scope."""
import json
from pathlib import Path
from build_development import sha, save

ROOT = Path(__file__).resolve().parents[2]
RELEASE = ROOT / 'releases/2026-09-13-data-foundation'


def refresh():
    target = RELEASE / 'publication-manifest.json'
    manifest = json.loads(target.read_text())
    retirement = json.loads((RELEASE / 'cloud-data/retirement.json').read_text())
    assert retirement['checksum_verified_local_backup'] and len(retirement['retired_parts']) == 17
    assert not list((RELEASE / 'cloud-data/data').glob('*.parquet'))
    assert (ROOT / 'data/g0-5-development/package-verification.json').is_file()
    records = []
    for path in sorted(RELEASE.rglob('*')):
        if not path.is_file() or path == target or '__pycache__' in path.parts or path.name == '.DS_Store':
            continue
        records.append({'path': str(path.relative_to(RELEASE)), 'sha256': sha(path), 'bytes': path.stat().st_size})
    manifest.update({'status': 'FILES_VERIFIED_G05_CURRENT_INPUT_POLICY', 'files': records,
        'data_scope': 'Current actual microdata parts retired; historical actual aggregate results, receipts and source code retained. Development data reside in data/g0-5-development.',
        'historical_receipts_scope': 'Original G0 actual execution; G0.5 does not regenerate these results.',
        'pre_g05_historical_commit': retirement['historical_commit'],
        'historical_manifest_path': retirement['historical_manifest_path'],
        'retirement_receipt': 'cloud-data/retirement.json', 'current_active_dataset': 'data/g0-5-development/manifest.json',
        'all_44_modules_executed': False})
    save(target, manifest)
    print(json.dumps({'current_release_files_hash_bound': len(records), 'actual_parts_in_current_release': 0}))


if __name__ == '__main__':
    refresh()
