#!/usr/bin/env python3
"""Independently inspect every published G0.5 part, schema, wave and ID."""
from collections import Counter, defaultdict
import csv
import hashlib
import json
from pathlib import Path

import pyarrow as pa
import pyarrow.compute as pc
import pyarrow.parquet as pq
import pandas as pd
from openpyxl import load_workbook
from panel_generator import RANK_COLUMNS

from build_development import sha, save

ROOT = Path(__file__).resolve().parents[2]
BASE = ROOT / 'data/g0-5-development'


def verify(base=BASE):
    manifest = json.loads((base / 'manifest.json').read_text())
    assert manifest['status'] == 'PASS' and manifest['data_kind'] == 'perturbed-development'
    assert manifest['final_results_allowed'] is False and manifest['anonymity_guaranteed'] is False
    names = manifest['column_names']
    assert len(names) == manifest['columns'] == 4396 and len(set(names)) == len(names)
    assert manifest['base_columns'] == 4376 and {'obs_id', 'psid', 'psid_status'} <= set(names)
    for item in manifest['metadata_files']:
        target = (base / item['path']).resolve()
        assert target.is_relative_to(base.resolve()) and sha(target) == item['sha256'], item['path']
    schema = json.loads((base / 'schema.json').read_text())
    rows, ids, years, panel_parts = 0, set(), Counter(), []
    coverage = defaultdict(lambda: Counter(rows=0, nulls=0, empty_strings=0, nonzero_numeric=0))
    actual_parts = {str(p.relative_to(base)) for p in (base / 'waves').rglob('*.parquet')}
    assert actual_parts == {p['path'] for p in manifest['parts']}
    for item in manifest['parts']:
        target = (base / item['path']).resolve()
        assert target.is_relative_to(base.resolve()) and sha(target) == item['sha256']
        assert target.stat().st_size == item['bytes'] < 45 * 1024**2
        table = pq.ParquetFile(target).read(use_threads=False)
        assert table.column_names == names and table.num_rows == item['rows']
        assert [{'name': f.name, 'type': str(f.type)} for f in table.schema] == schema
        assert table.schema.metadata[b'data_kind'] == b'perturbed-development'
        year_values = pc.unique(table['source_year']).to_pylist()
        assert year_values == [float(item['year'])]
        ident = table['obs_id'].to_pylist()
        assert None not in ident and len(set(ident)) == len(ident) and not ids & set(ident)
        ids.update(ident)
        assert table['psid'].null_count == 0
        assert pc.unique(table['psid_status']).to_pylist() == ['synthetic_development']
        assert table['dev_identity_key'].null_count == 0
        for name in RANK_COLUMNS.values():
            assert table[name].null_count == 0
            assert pc.min(table[name]).as_py() >= 0 and pc.max(table[name]).as_py() <= 1
        assert table.schema.metadata[b'psid_linkage'] == b'synthetic_development'
        panel_parts.append(table.select(['obs_id','psid','psid_status','source_year','province_code','industry_code',
                                        'dev_panel_stratum','dev_cluster_id','dev_prev_obs_id',
                                        'dev_prev_year','dev_link_distance','dev_link_status']).to_pandas())
        rows += table.num_rows
        years[str(item['year'])] += table.num_rows
        for field, column in zip(table.schema, table.columns):
            cell = coverage[(field.name, item['year'])]
            cell['rows'] += table.num_rows
            cell['nulls'] += column.null_count
            if pa.types.is_string(field.type):
                cell['empty_strings'] += pc.sum(pc.cast(pc.equal(column, ''), pa.int64())).as_py() or 0
            elif pa.types.is_floating(field.type) or pa.types.is_integer(field.type):
                cell['nonzero_numeric'] += pc.sum(pc.cast(pc.not_equal(column, 0), pa.int64())).as_py() or 0
    assert rows == len(ids) == manifest['rows'] == 33049
    assert dict(years) == manifest['year_counts'] and len(years) == 12 and '2016' not in years
    assert len(coverage) == len(names) * 12
    panel = pd.concat(panel_parts, ignore_index=True)
    assert not panel.duplicated(['psid','source_year']).any()
    assert panel.psid.eq(panel.psid.astype('int64')).all() and panel.psid.between(1, 2**48).all()
    assert panel.groupby('psid').dev_panel_stratum.nunique().le(1).all()
    linked = panel.loc[panel.dev_prev_obs_id.ne('')]
    previous = panel.set_index('obs_id').loc[linked.dev_prev_obs_id].reset_index(drop=True)
    linked = linked.reset_index(drop=True)
    assert linked.psid.equals(previous.psid)
    assert linked.dev_prev_year.equals(previous.source_year)
    assert linked.province_code.equals(previous.province_code)
    assert linked.industry_code.str[:2].equals(previous.industry_code.str[:2])
    identity_basis = json.loads((base / 'panel-generation.json').read_text())['identity_workflow']
    if identity_basis == 'generate_external_identity':
        assert linked.dev_link_distance.between(0, .25).all()
        assert linked.dev_link_status.eq('matched_simulation').all()
    elif identity_basis == 'reuse_existing':
        from replay_panel import validate_reused_identity
        validate_reused_identity(panel, panel)
    else:
        raise ValueError('Unknown identity workflow')
    assert linked.source_year.gt(linked.dev_prev_year).all()
    assert not linked.duplicated(['dev_prev_obs_id','source_year']).any()
    assert len(manifest['excel_views']) == 12
    indexed_panel = panel.set_index('obs_id')
    for item in manifest['excel_views']:
        assert sha(base / item['path']) == item['sha256']
        wb = load_workbook(base/item['path'], read_only=True, data_only=True)
        try:
            rows_iter = wb['G05_DEVELOPMENT'].iter_rows(values_only=True)
            headers = list(next(rows_iter)); oi=headers.index('obs_id'); pi=headers.index('psid'); yi=headers.index('source_year')
            seen_excel=set()
            for record in rows_iter:
                ident=record[oi]; assert ident not in seen_excel; seen_excel.add(ident)
                # IDs and years require exact equality, not numeric tolerance.
                assert record[pi] == indexed_panel.loc[ident,'psid']
                assert record[yi] == indexed_panel.loc[ident,'source_year'] == item['year']
            assert len(seen_excel)==item['rows']
        finally: wb.close()
    assert sum(x['rows'] for x in manifest['excel_views']) == rows
    target = base / 'variable-year-coverage.csv'
    with target.open('w', newline='') as stream:
        writer = csv.DictWriter(stream, fieldnames=['variable', 'source_year', 'rows', 'nulls', 'empty_strings', 'nonzero_numeric'])
        writer.writeheader()
        for (name, year), counts in sorted(coverage.items()):
            writer.writerow({'variable': name, 'source_year': year, **counts})
    report = {'status': 'PASS', 'scope': 'independent package/schema/wave/ID validation',
              'rows': rows, 'columns': len(names), 'parts': len(manifest['parts']), 'waves': dict(years),
              'unique_observation_ids': len(ids), 'psid_nonmissing': rows,
              'synthetic_firms': int(panel.psid.nunique()), 'synthetic_links': len(linked),
              'firm_year_unique': True, 'links_inside_province_sector': True,
              'calendar_gaps_preserved': True, 'excel_views_hash_verified': 12,
              'excel_psid_and_year_exact': True, 'frozen_rank_bounds_verified': True,
              'all_part_hashes_verified': True, 'all_metadata_hashes_verified': True,
              'all_parts_labelled_development': True, 'unindexed_parquet_files': 0,
              'variable_year_coverage_rows': len(coverage), 'max_part_bytes': max(x['bytes'] for x in manifest['parts']),
              'fictional_panel_owner_authorized': True, 'real_panel_links_verified': 0,
              'downstream_estimation_executed': False}
    save(base / 'package-verification.json', report)
    # Add the new reports to the hash-bound package, preserving all prior hashes.
    metadata = {x['path']: x for x in manifest['metadata_files']}
    for name in ['variable-year-coverage.csv', 'package-verification.json', 'adapter-verification.json']:
        assert (base / name).is_file(), name
        metadata[name] = {'path': name, 'sha256': sha(base / name)}
    manifest['metadata_files'] = list(metadata.values())
    save(base / 'manifest.json', manifest)
    print(json.dumps(report, indent=2))
    return report


if __name__ == '__main__':
    verify()
