#!/usr/bin/env python3
"""Append a reproducible fictional panel to the existing disturbed Excel derivative.

Identity is prepared separately from Excel and ported by verified G0 lineage.
The builder preserves disturbed measurements and attaches the screened payload.
Published normalized ranks and keyed tokens support GitHub-only matching replay.
"""
from __future__ import annotations

import argparse
import csv
from datetime import datetime, timezone
import json
from pathlib import Path
import resource
import shutil

import numpy as np
import pandas as pd
import pyarrow as pa
import pyarrow.parquet as pq
from openpyxl import Workbook, load_workbook
from openpyxl.styles import Font, PatternFill
from openpyxl.workbook.properties import CalcProperties

from build_development import sha, save
from panel_generator import FEATURES, INPUT_COLUMNS, NEW_COLUMNS, RANK_COLUMNS, STATUS, VERSION, generate

IDENTITY_UPDATES = {
    'identity_mode': 'dummy', 'identity_is_dummy': 1., 'identity_real_link_verified': 0.,
    'identity_xtset_ready': 1., 'identity_method': 'province_sector_external_excel_v3',
    'identity_seed': 20260913., 'identity_eligibility': 'synthetic_development_only',
}


def read_features(source):
    manifest = json.loads((source / 'manifest.json').read_text())
    if manifest.get('status') != 'PASS' or manifest.get('data_kind') != 'perturbed-development':
        raise ValueError('Expected accepted disturbed G0.5 package')
    for item in manifest['metadata_files']:
        if sha(source / item['path']) != item['sha256']:
            raise ValueError('Source metadata hash mismatch: ' + item['path'])
    frames = []
    for item in manifest['parts']:
        if sha(source / item['path']) != item['sha256']:
            raise ValueError('Source part hash mismatch')
        frames.append(pq.ParquetFile(source / item['path']).read(columns=INPUT_COLUMNS, use_threads=False).to_pandas())
    return pd.concat(frames, ignore_index=True)


def workbook(path, frame):
    """A small usable annual Excel view; full 4,396-field data remain in Parquet."""
    wb = Workbook(); wb.calculation = CalcProperties(calcMode='auto', fullCalcOnLoad=True, forceFullCalc=True)
    ws = wb.active; ws.title = 'G05_DEVELOPMENT'
    ws.append(list(frame.columns))
    for row in frame.itertuples(index=False, name=None):
        ws.append([None if pd.isna(v) else v for v in row])
    ws.freeze_panes = 'A2'; ws.auto_filter.ref = ws.dimensions
    for cell in ws[1]:
        cell.font = Font(bold=True, color='FFFFFF'); cell.fill = PatternFill('solid', fgColor='183153')
        ws.column_dimensions[cell.column_letter].width = min(44, max(18, len(str(cell.value)) + 2))
    for col in ['psid', 'source_year', 'dev_prev_year']:
        if col in frame:
            for cells in ws.iter_cols(min_col=frame.columns.get_loc(col)+1, max_col=frame.columns.get_loc(col)+1, min_row=2):
                for cell in cells: cell.number_format = '0'
    note = wb.create_sheet('READ_ME')
    for row in [
        ['Scope', 'Fictional panel on perturbed G0.5 values; development only.'],
        ['Panel key', 'psid; one record per psid and source_year.'],
        ['Cluster', 'dev_cluster_id is year-specific and is NOT a firm ID.'],
        ['Boundary', 'Province x 2-digit sector; malformed codes receive isolated IDs.'],
        ['Continuity', 'Similarity-based simulated links, not verified actual firms.'],
        ['Full data', 'All original projection columns are in the adjacent Parquet parts.'],
        ['Missing year', '2016 absent; 2015 to 2017 remains a two-calendar-year gap.'],
    ]: note.append(row)
    note.column_dimensions['A'].width = 20; note.column_dimensions['B'].width = 110
    wb.save(path); wb.close()
    check = load_workbook(path, read_only=True, data_only=True)
    try:
        sheet = check['G05_DEVELOPMENT']
        assert sheet.max_row == len(frame) + 1 and sheet.max_column == len(frame.columns)
        rows = sheet.iter_rows(min_row=2, values_only=True)
        for expected, actual in zip(frame.itertuples(index=False, name=None), rows):
            for a, b in zip(expected, actual):
                if pd.isna(a) or a == '': assert b in {None, ''}
                elif isinstance(a, (float, int, np.number)): assert np.isclose(a, b, rtol=1e-14, atol=1e-12)
                else: assert a == b
    finally: check.close()


def replay_external(frame, payload):
    """Reproduce source-independent IDs from published HMAC tokens and ranks."""
    matching = frame.copy()
    aligned = payload.set_index('obs_id').loc[frame.obs_id]
    matching['obs_id'] = aligned.dev_identity_key.to_numpy()
    ranks = payload.set_index('dev_identity_key')[list(RANK_COLUMNS.values())].rename(columns={v:k for k,v in RANK_COLUMNS.items()})
    generated, report = generate(matching, rank_inputs=ranks)
    translation = dict(zip(payload.dev_identity_key, payload.obs_id))
    generated['obs_id'] = generated.obs_id.map(translation)
    mask = generated.dev_prev_obs_id.ne('')
    generated.loc[mask,'dev_prev_obs_id'] = generated.loc[mask,'dev_prev_obs_id'].map(translation)
    return generated, report


def build(source, output, identity_payload=None):
    source, output = Path(source).resolve(), Path(output).resolve()
    if output.exists():
        raise ValueError('Output must be new; preserve previous release')
    inputs = read_features(source)
    if identity_payload is None:
        raise ValueError('Supply the separately prepared and ported --identity-payload; G0 is not rerun here')
    payload_path = Path(identity_payload)
    pm = json.loads((payload_path/'manifest.json').read_text())
    if pm['status']!='PASS' or sha(payload_path/'identity-payload.parquet')!=pm['payload_sha256']:
        raise ValueError('External identity payload hash mismatch')
    if sha(payload_path/'identity-report.json')!=pm['report_sha256']:
        raise ValueError('External identity report hash mismatch')
    ids = pd.read_parquet(payload_path/'identity-payload.parquet')
    if set(ids.obs_id)!=set(inputs.obs_id) or not ids.obs_id.is_unique:
        raise ValueError('External identity must cover every frozen observation exactly once')
    ids=ids.set_index('obs_id').loc[inputs.obs_id].reset_index()
    report=json.loads((payload_path/'identity-report.json').read_text())
    if pm['g0_master_sha256']!=json.loads((source/'manifest.json').read_text())['source_g0_master_sha256']:
        raise ValueError('External identity and G0.5 parent differ')
    print(json.dumps({k: report[k] for k in ['rows', 'synthetic_firms', 'matched_links', 'invalid_code_rows']}), flush=True)
    # Reordering is a real source of identity corruption: test the entire input,
    # not only a toy fixture, before publishing a single changed data partition.
    if report['identity_workflow']=='generate_external_identity':
        replay, _ = replay_external(inputs.sample(frac=1, random_state=77),ids)
        pd.testing.assert_frame_equal(ids.sort_values('obs_id').reset_index(drop=True),
                                      replay[ids.columns].sort_values('obs_id').reset_index(drop=True), check_exact=True,check_dtype=False)
    else:
        # Existing continuity was ported, not estimated by the similarity rule.
        assert not ids.duplicated(['psid','source_year']).any()
    report['full_input_reorder_replay_exact'] = report['identity_workflow']=='generate_external_identity'
    manifest = json.loads((source / 'manifest.json').read_text())
    output.mkdir(parents=True)
    for item in manifest['metadata_files']:
        target = output / item['path']; target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(source / item['path'], target)
    save(output / 'pre-panel-manifest.json', manifest)
    save(output / 'pre-panel-verification.json', json.loads((source / 'verification.json').read_text()))
    idmap = ids.set_index('obs_id')
    parts = []
    changed_identity = set(IDENTITY_UPDATES) | {'psid', 'psid_status', 'demo_province', 'demo_industry2'}
    for item in manifest['parts']:
        frame = pq.ParquetFile(source / item['path']).read(use_threads=False).to_pandas()
        original = frame.copy(deep=False)
        mapped = idmap.loc[frame.obs_id]
        for col in ['psid', 'psid_status', *NEW_COLUMNS]: frame[col] = mapped[col].to_numpy()
        for col, value in IDENTITY_UPDATES.items():
            if col in frame: frame[col] = value
        if 'demo_province' in frame: frame['demo_province'] = frame.dev_panel_stratum.str.split(':').str[0]
        if 'demo_industry2' in frame: frame['demo_industry2'] = frame.dev_panel_stratum.str.split(':').str[-1]
        unchanged = [col for col in original if col not in changed_identity]
        pd.testing.assert_frame_equal(original[unchanged], frame[unchanged], check_exact=True)
        target = output / item['path']; target.parent.mkdir(parents=True, exist_ok=True)
        table = pa.Table.from_pandas(frame, preserve_index=False)
        # Keep the original logical string/double interface, including all-null
        # strings, rather than letting pandas infer a different Arrow schema.
        old_schema = json.loads((source / 'schema.json').read_text())
        schema = pa.schema([pa.field(x['name'], pa.float64() if x['type'] == 'double' else pa.string()) for x in old_schema]
                           + [pa.field(col, pa.float64() if col in {'dev_prev_year', 'dev_link_distance', 'dev_n_features', *RANK_COLUMNS.values()} else pa.string()) for col in NEW_COLUMNS])
        table = table.cast(schema).replace_schema_metadata({b'data_kind': b'perturbed-development',
                 b'g05_version': VERSION.encode(), b'final_results_allowed': b'false', b'psid_linkage': STATUS.encode()})
        pq.write_table(table, target, compression='zstd')
        restored = pq.ParquetFile(target).read(use_threads=False).to_pandas()
        pd.testing.assert_frame_equal(frame, restored, check_exact=True, check_dtype=False)
        assert target.stat().st_size < 45 * 1024**2
        parts.append({**item, 'bytes': target.stat().st_size, 'sha256': sha(target)})
    manifest['parts'] = parts
    manifest['version'] = VERSION
    manifest['schema_version'] = 4
    manifest['created_at'] = datetime.now(timezone.utc).isoformat()
    manifest['column_names'] += NEW_COLUMNS
    manifest['columns'] = len(manifest['column_names'])
    manifest['identity'] = {
        'observation_key': 'obs_id', 'longitudinal_key': 'psid', 'status_column': 'psid_status',
        'status': STATUS, 'verified_links': 0, 'synthetic_firms': report['synthetic_firms'],
        'psid_values': 'All rows have exactly representable positive fictional firm IDs.',
        'panel_estimators_allowed': True, 'panel_estimators_scope': 'development_only_subject_to_other_input_requirements',
        'real_panel_estimators_allowed': False, 'original_identifiers_published': False,
        'reverse_map_published': False, 'row_order_is_not_company_identity': True,
        'actual_adapter': 'Transfer only frozen obs_id; never copy synthetic psid or cluster/link metadata into actual mode.',
        'report': 'panel-generation.json'}
    manifest['panel_parent_manifest_sha256'] = sha(source / 'manifest.json')
    save(output / 'schema.json', [{'name': field.name, 'type': str(field.type)} for field in schema])
    policy = json.loads((output / 'column-policy.json').read_text())
    for entry in policy['columns']:
        if entry['name'] in changed_identity:
            entry.update(action='explicit_fictional_development_identity', reason='Owner-authorized province-sector similarity panel; not actual identity')
    policy['columns'] += [{'name': col, 'action': 'fictional_panel_metadata', 'reason': 'Reproducible development linkage audit',
                          'finite_cells': 0, 'changed_cells': 0} for col in NEW_COLUMNS]
    save(output / 'column-policy.json', policy)
    with (output / 'dictionary.csv').open() as stream:
        reader = csv.DictReader(stream); fields = reader.fieldnames; dictionary = list(reader)
    labels = {'psid': 'Fictional development firm ID, not verified actual company', 'psid_status': STATUS}
    for item in dictionary:
        if item['name'] in labels: item['label'] = labels[item['name']]
    for col in NEW_COLUMNS:
        dictionary.append({'original_position': len(dictionary)+1, 'name': col, 'included_in_cloud': True,
                           'stata_storage': 'd' if col in {'dev_prev_year','dev_link_distance','dev_n_features',*RANK_COLUMNS.values()} else '80',
                           'label': 'G0.5 fictional panel: ' + col, 'display_format': '', 'value_label': ''})
    with (output / 'dictionary.csv').open('w', newline='') as stream:
        writer = csv.DictWriter(stream, fieldnames=fields); writer.writeheader(); writer.writerows(dictionary)
    excel = inputs.merge(ids.drop(columns='source_year'), on='obs_id', validate='one_to_one')
    views = []
    for year, group in excel.groupby('source_year', sort=True):
        path = output / f'waves/{int(year)}/G05-development-panel-{int(year)}.xlsx'
        workbook(path, group)
        views.append({'path': str(path.relative_to(output)), 'year': int(year), 'rows': len(group),
                      'columns': len(group.columns), 'sha256': sha(path), 'bytes': path.stat().st_size})
    manifest['excel_views'] = views
    verification = json.loads((output / 'verification.json').read_text())
    verification.update(columns=manifest['columns'], psid_nonmissing=len(ids), fake_longitudinal_links_created=True,
                        fictional_links_owner_authorized=True, measurement_payload_unchanged_from_g05_v1=True,
                        identity_extension_columns=['obs_id','psid','psid_status',*NEW_COLUMNS],
                        identity_fields_updated=sorted(changed_identity), panel_generation='panel-generation.json')
    save(output / 'verification.json', verification)
    report.update(generator_sha256=sha(Path(__file__).with_name('panel_generator.py')),
                  builder_sha256=sha(__file__), parent_manifest_sha256=manifest['panel_parent_manifest_sha256'],
                  input_basis='Standalone original Excel identity stage; frozen normalized ranks and HMAC keys make GitHub-only replay possible',
                  port_verification=pm,
                  all_measurements_unchanged_from_g05_v1=True, original_excel_files_modified=False,
                  excel_views_roundtrip_verified=len(views), peak_rss_bytes=resource.getrusage(resource.RUSAGE_SELF).ru_maxrss)
    save(output / 'panel-generation.json', report)
    # Old adapter/package receipts describe v1. Keep them explicitly historical
    # until the revised verifier produces fresh evidence for the active version.
    for name in ['package-verification.json', 'adapter-verification.json']:
        if (output / name).exists():
            (output / name).rename(output / ('pre-panel-' + name))
    paths = [item['path'] for item in manifest['metadata_files'] if item['path'] not in {'package-verification.json','adapter-verification.json'}]
    paths += ['pre-panel-manifest.json','pre-panel-verification.json','pre-panel-package-verification.json',
              'pre-panel-adapter-verification.json','panel-generation.json']
    manifest['metadata_files'] = [{'path': p, 'sha256': sha(output / p)} for p in dict.fromkeys(paths) if (output / p).is_file()]
    save(output / 'manifest.json', manifest)
    print(json.dumps({'status': 'BUILT_PENDING_INDEPENDENT_VALIDATION', 'rows': len(ids), 'columns': manifest['columns'],
                      'synthetic_firms': report['synthetic_firms'], 'matched_links': report['matched_links'], 'excel_views': len(views)}), flush=True)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--source', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--identity-payload', type=Path, required=True)
    args = parser.parse_args()
    build(args.source, args.output, args.identity_payload)
