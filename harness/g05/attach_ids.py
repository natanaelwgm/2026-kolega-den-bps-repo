#!/usr/bin/env python3
"""Add stable observation IDs; never manufacture longitudinal company links."""
from collections import Counter
import argparse
import csv
import hashlib
import hmac
import json
from pathlib import Path
import shutil

import numpy as np
import pandas as pd
import pyarrow as pa
import pyarrow.parquet as pq

from build_development import sha, save

IDENTITY_NAMES = ['obs_id', 'psid', 'psid_status']


def observation_id(key, source_hash, position):
    return 'obs_' + hmac.new(key, f'G05-observation-v1:{source_hash}:{position}'.encode(), hashlib.sha256).hexdigest()[:20]


def attach(source, output, private_key, private_map):
    source, output, private_key, private_map = map(lambda p: Path(p).resolve(), [source, output, private_key, private_map])
    if output.exists() or private_map.exists():
        raise ValueError('Choose new output and private-map paths')
    repo = Path(__file__).resolve().parents[2]
    if any(p.is_relative_to(root) for p in [private_map, private_key] for root in [output, repo]):
        raise ValueError('Identity key and reverse map must remain outside the package and Git checkout')
    key = private_key.read_bytes()
    if len(key) != 32:
        raise ValueError('Invalid private key')
    manifest = json.loads((source / 'manifest.json').read_text())
    if manifest.get('status') != 'PASS' or manifest.get('data_kind') != 'perturbed-development' or set(IDENTITY_NAMES) & set(manifest['column_names']):
        raise ValueError('Expected G0.5 measurement derivative before ID extension')
    for item in manifest['metadata_files']:
        if sha(source / item['path']) != item['sha256']:
            raise ValueError('Measurement package metadata hash mismatch')
    source_schema = json.loads((source / 'schema.json').read_text())
    if any(x['type'] not in {'double', 'string'} for x in source_schema):
        raise ValueError('Unexpected measurement schema; explicit type review required')
    output_schema = pa.schema([pa.field(x['name'], pa.float64() if x['type'] == 'double' else pa.string()) for x in source_schema]
                             + [pa.field('obs_id', pa.string()), pa.field('psid', pa.float64()), pa.field('psid_status', pa.string())])
    output.mkdir(parents=True)
    private_map.parent.mkdir(parents=True, exist_ok=True)
    seen, position, parts, years = set(), 0, [], Counter()
    with private_map.open('x', newline='') as stream:
        private_map.chmod(0o600)
        writer = csv.DictWriter(stream, fieldnames=['obs_id', 'source_g0_master_sha256', 'source_g0_row_index', 'source_year'])
        writer.writeheader()
        for part in manifest['parts']:
            if sha(source / part['path']) != part['sha256']:
                raise ValueError('Measurement package part hash mismatch')
            frame = pq.ParquetFile(source / part['path']).read(use_threads=False).to_pandas()
            ids = [observation_id(key, manifest['source_g0_master_sha256'], i) for i in range(position, position + len(frame))]
            if seen & set(ids) or len(set(ids)) != len(ids):
                raise ValueError('Observation identifier collision')
            seen.update(ids)
            frame['obs_id'] = ids
            frame['psid'] = np.nan
            frame['psid_status'] = 'unverified_no_longitudinal_crosswalk'
            for i, (ident, year) in enumerate(zip(ids, frame['source_year'])):
                writer.writerow({'obs_id': ident, 'source_g0_master_sha256': manifest['source_g0_master_sha256'],
                                 'source_g0_row_index': position + i, 'source_year': int(year)})
                years[str(int(year))] += 1
            target = output / part['path']
            target.parent.mkdir(parents=True, exist_ok=True)
            table = pa.Table.from_pandas(frame, schema=output_schema, preserve_index=False)
            metadata = dict(table.schema.metadata or {})
            metadata.update({b'data_kind': b'perturbed-development', b'g05_version': manifest['version'].encode(),
                             b'final_results_allowed': b'false', b'psid_linkage': b'unverified'})
            pq.write_table(table.replace_schema_metadata(metadata), target, compression='zstd')
            restored = pq.ParquetFile(target).read().to_pandas()
            pd.testing.assert_frame_equal(frame, restored, check_exact=True)
            if target.stat().st_size >= 45 * 1024**2:
                raise ValueError('Oversize wave partition')
            parts.append({**part, 'bytes': target.stat().st_size, 'sha256': sha(target)})
            position += len(frame)
    if position != manifest['rows'] or dict(years) != manifest['year_counts']:
        raise ValueError('Identity stage changed wave coverage')
    for item in manifest['metadata_files']:
        shutil.copy2(source / item['path'], output / item['path'])
    manifest['base_column_names'] = manifest['column_names'][:]
    manifest['base_columns'] = manifest['columns']
    manifest['column_names'] += IDENTITY_NAMES
    manifest['columns'] += len(IDENTITY_NAMES)
    manifest['schema_version'] = 2
    manifest['parts'] = parts
    manifest['identity'] = {'observation_key': 'obs_id', 'observation_scope': 'one frozen G0 record; stable within this parent version',
                            'longitudinal_key': 'psid', 'status_column': 'psid_status', 'verified_links': 0,
                            'psid_values': 'all missing until an evidence-backed company crosswalk is accepted',
                            'original_identifiers_published': False, 'reverse_map_published': False,
                            'panel_estimators_allowed': False, 'row_order_is_not_company_identity': True,
                            'actual_adapter': 'reuse obs_id in the same exact parent row order; source hash is mandatory'}
    schema = json.loads((output / 'schema.json').read_text())
    schema.extend([{'name': 'obs_id', 'type': 'string'}, {'name': 'psid', 'type': 'double'}, {'name': 'psid_status', 'type': 'string'}])
    save(output / 'schema.json', schema)
    policy = json.loads((output / 'column-policy.json').read_text())
    policy['columns'].extend([
        {'name': 'obs_id', 'action': 'stable_observation_surrogate', 'reason': 'Private keyed stable frozen-row identifier; not a firm ID', 'finite_cells': 0, 'changed_cells': 0},
        {'name': 'psid', 'action': 'unverified_missing', 'reason': 'No accepted longitudinal crosswalk; never infer from row order', 'finite_cells': 0, 'changed_cells': 0},
        {'name': 'psid_status', 'action': 'explicit_unverified_status', 'reason': 'Source records do not establish panel identity', 'finite_cells': 0, 'changed_cells': 0},
    ])
    save(output / 'column-policy.json', policy)
    with (output / 'dictionary.csv').open() as stream:
        reader = csv.DictReader(stream); fieldnames = reader.fieldnames; dictionary = list(reader)
    additions = [('obs_id', '24', 'G0.5 stable observation surrogate, not firm identity'),
                 ('psid', 'd', 'Longitudinal pseudonymous firm ID; missing until verified'),
                 ('psid_status', '40', 'Longitudinal linkage status; currently unverified')]
    for name, storage, label in additions:
        dictionary.append({'original_position': len(dictionary) + 1, 'name': name, 'included_in_cloud': True,
                           'stata_storage': storage, 'label': label, 'display_format': '', 'value_label': ''})
    with (output / 'dictionary.csv').open('w', newline='') as stream:
        writer = csv.DictWriter(stream, fieldnames=fieldnames); writer.writeheader(); writer.writerows(dictionary)
    verification = json.loads((output / 'verification.json').read_text())
    verification.update({'base_columns': manifest['base_columns'], 'columns': manifest['columns'],
                         'observation_ids_unique': len(seen) == position, 'observation_ids': len(seen),
                         'psid_nonmissing': 0, 'fake_longitudinal_links_created': False,
                         'identity_extension_columns': IDENTITY_NAMES, 'private_reverse_map_published': False})
    save(output / 'verification.json', verification)
    manifest['metadata_files'] = [{'path': item['path'], 'sha256': sha(output / item['path'])} for item in manifest['metadata_files']]
    save(output / 'manifest.json', manifest)
    print(json.dumps({'status': 'PASS', 'rows': position, 'columns': manifest['columns'], 'unique_obs_ids': len(seen), 'psid_nonmissing': 0, 'parts': len(parts)}))


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    for option in ['source', 'output', 'private-key', 'private-map']:
        parser.add_argument('--' + option, type=Path, required=True)
    args = parser.parse_args()
    attach(args.source, args.output, args.private_key, args.private_map)
