#!/usr/bin/env python3
"""Compare both input modes locally without publishing actual observation values."""
import argparse
from functools import partial
import hashlib
import json
from pathlib import Path
import sys

import pandas as pd

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from harness.data_source import load_data
from build_development import sha, save

FIELDS = ['source_year', 'gross_output_nominal', 'value_added_nominal', 'workers',
          'capital_nominal', 'energy_expenditure_rp000', 'total_gj_s1', 'co2_total_s1',
          'ln_output_nominal', 'r_output_per_worker_nominal', 'obs_id', 'psid', 'psid_status']


def verify(actual, package=None):
    package = Path(package) if package else ROOT / 'data/g0-5-development'
    loader = partial(load_data, development_path=package)
    d = loader(columns=FIELDS)
    a = loader(mode='actual', actual_path=actual, columns=FIELDS)
    assert len(a) == len(d) == 33049
    assert a.dtypes.astype(str).to_dict() == d.dtypes.astype(str).to_dict()
    measurements = [name for name in FIELDS if name not in {'psid','psid_status'}]
    pd.testing.assert_frame_equal(a[measurements].isna(), d[measurements].isna())
    pd.testing.assert_frame_equal(a[['obs_id', 'workers', 'source_year']], d[['obs_id', 'workers', 'source_year']])
    assert d.obs_id.is_unique and d.psid.notna().all() and a.psid.isna().all()
    assert d.psid_status.eq('synthetic_development').all()
    assert a.psid_status.eq('unverified_no_longitudinal_crosswalk').all()
    mask = a.gross_output_nominal.notna() & a.gross_output_nominal.ne(0)
    ratio = (d.loc[mask, 'gross_output_nominal'] / a.loc[mask, 'gross_output_nominal'] - 1).abs()
    assert ratio.between(.001 - 1e-12, .005 + 1e-12).all()
    wave = loader(years=2017, columns=FIELDS)
    actual_wave = loader(mode='actual', actual_path=actual, years=2017, columns=FIELDS)
    assert len(wave) == len(actual_wave) == 3357
    assert wave.obs_id.tolist() == actual_wave.obs_id.tolist() == d.loc[d.source_year.eq(2017), 'obs_id'].tolist()
    try:
        loader(mode='actual', actual_path=actual, columns=['source_year', 'obs_id'], require_panel=True)
    except ValueError as error:
        assert 'Panel identity' in str(error)
    else:
        raise AssertionError('Unverified actual panel was accepted')
    dev_panel = loader(columns=['source_year','psid','obs_id'], require_panel=True)
    assert len(dev_panel) == 33049 and not dev_panel.duplicated(['psid','source_year']).any()
    actual_ids = loader(mode='actual', actual_path=actual, years=2022,
                          columns=['obs_id','psid','dev_cluster_id','dev_prev_obs_id','dev_link_distance'])
    assert actual_ids.psid.isna().all() and actual_ids.dev_link_distance.isna().all()
    assert actual_ids.dev_cluster_id.eq('').all() and actual_ids.dev_prev_obs_id.eq('').all()
    manifest = json.loads((package / 'manifest.json').read_text())
    report = {'status': 'PASS', 'scope': 'actual/development input adapter integration; no estimation',
              'rows_each': len(a), 'columns_checked': FIELDS, 'dtypes_match': True, 'measurement_missingness_match': True,
              'observation_ids_match': True, 'obs_id_unique': True, 'development_psid_nonmissing': len(d),
              'actual_psid_nonmissing': 0, 'synthetic_linkage_never_copied_to_actual': True,
              'actual_source_checksums_verified': True, 'all_nonzero_output_values_changed_within_bounds': True,
              'selected_wave_2017_rows': len(wave), 'panel_gate_refuses_unverified_actual_identity': True,
              'panel_gate_accepts_declared_development_identity': True,
              'source_g0_manifest_sha256': manifest['source_g0_manifest_sha256'],
              'development_part_index_sha256': hashlib.sha256(json.dumps(manifest['parts'], sort_keys=True).encode()).hexdigest(),
              'verification_code_sha256': sha(__file__), 'adapter_code_sha256': sha(ROOT / 'harness/data_source.py'),
              'actual_observation_values_in_report': False}
    target = package / 'adapter-verification.json'
    save(target, report)
    metadata = {x['path']: x for x in manifest['metadata_files']}
    metadata[target.name] = {'path': target.name, 'sha256': sha(target)}
    manifest['metadata_files'] = list(metadata.values())
    save(package / 'manifest.json', manifest)
    print(json.dumps(report, indent=2))


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--actual', type=Path, required=True)
    parser.add_argument('--package', type=Path)
    args = parser.parse_args()
    verify(args.actual, args.package)
