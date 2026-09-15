#!/usr/bin/env python3
"""Check exact panel regeneration using only the active GitHub G0.5 package."""
import argparse
import json
from pathlib import Path

import pandas as pd
import pyarrow.parquet as pq

from build_development import sha, save
from build_panel_package import read_features, replay_external
from panel_generator import NEW_COLUMNS, strata


def validate_reused_identity(features, panel):
    """Check supplied continuity without pretending to recover it by matching."""
    if not panel.obs_id.is_unique or set(panel.obs_id) != set(features.obs_id):
        raise ValueError('Reused identity does not cover the observation universe')
    aligned = features.set_index('obs_id').loc[panel.obs_id].reset_index()
    block, valid = strata(aligned)
    if not valid.all() or not block.reset_index(drop=True).equals(panel.dev_panel_stratum.reset_index(drop=True)):
        raise ValueError('Reused identity has an invalid compulsory block')
    if (panel.psid.isna().any() or not panel.psid.between(1, 2**48).all()
            or not panel.psid.eq(panel.psid.astype('int64')).all()
            or panel.duplicated(['psid', 'source_year']).any()
            or panel.groupby('psid').dev_panel_stratum.nunique().gt(1).any()):
        raise ValueError('Invalid reused firm-year identity')
    ordered = panel.sort_values(['psid', 'source_year']).reset_index(drop=True)
    prior = ordered.groupby('psid').shift()
    if not ordered.dev_prev_obs_id.equals(prior.obs_id.fillna('')):
        raise ValueError('Reused predecessor differs from supplied firm continuity')
    pd.testing.assert_series_equal(ordered.dev_prev_year, prior.source_year, check_names=False, check_dtype=False)
    if not ordered.dev_link_distance.isna().all():
        raise ValueError('Reused continuity must not claim an estimated distance')
    linked = prior.obs_id.notna()
    if not (ordered.loc[linked, 'dev_link_status'].eq('reused_existing_link').all()
            and ordered.loc[~linked, 'dev_link_status'].eq('new_from_existing_identity').all()
            and ordered.psid_status.eq('synthetic_development').all()):
        raise ValueError('Reused continuity labels are inconsistent')
    return {'synthetic_firms': int(panel.psid.nunique()), 'matched_links': int(linked.sum())}


def replay(package, output):
    package, output = Path(package), Path(output)
    if output.exists(): raise ValueError('Choose a new receipt path')
    manifest = json.loads((package / 'manifest.json').read_text())
    columns = ['obs_id','source_year','psid','psid_status',*NEW_COLUMNS]
    expected = pd.concat([pq.ParquetFile(package/p['path']).read(columns=columns,use_threads=False).to_pandas()
                          for p in manifest['parts']], ignore_index=True)
    features = read_features(package)
    basis = json.loads((package / 'panel-generation.json').read_text())['identity_workflow']
    if basis == 'generate_external_identity':
        actual, report = replay_external(features, expected)
        pd.testing.assert_frame_equal(expected.sort_values('obs_id').reset_index(drop=True),
                                      actual[columns].sort_values('obs_id').reset_index(drop=True),check_exact=True,check_dtype=False)
    elif basis == 'reuse_existing':
        report = validate_reused_identity(features, expected)
    else:
        raise ValueError('Unknown identity workflow')
    result = {'status':'PASS','rows':len(expected),'version':manifest['version'],
              'exact_assignment_replay':basis == 'generate_external_identity',
              'identity_basis':basis,
              'scope':('Exact matching replay' if basis == 'generate_external_identity' else 'Consistency of explicitly reused input continuity; not matching replay'),
              'source':'Only active G0.5 parts; no raw Excel or private identity map',
              'synthetic_firms':report['synthetic_firms'],'matched_links':report['matched_links'],
              'generator_sha256':sha(Path(__file__).with_name('panel_generator.py'))}
    save(output,result); print(json.dumps(result))


if __name__ == '__main__':
    p=argparse.ArgumentParser();p.add_argument('--package',type=Path,default=Path(__file__).resolve().parents[2]/'data/g0-5-development')
    p.add_argument('--output',type=Path,required=True);a=p.parse_args();replay(a.package,a.output)
