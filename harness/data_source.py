#!/usr/bin/env python3
"""One explicit data interface for G0.5 development and local actual finalisation.

Example: from harness.data_source import load_data, write_run_receipt
Development is the default. Actual mode never falls back to a repository file.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import os
from pathlib import Path
from datetime import datetime, timezone

import pandas as pd
import pyarrow.parquet as pq

ROOT = Path(__file__).resolve().parents[1]
DEFAULT_DEVELOPMENT = ROOT / 'data/g0-5-development'


def sha(path):
    h = hashlib.sha256()
    with Path(path).open('rb') as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b''):
            h.update(block)
    return h.hexdigest()


def _within(base, relative):
    target = (base / relative).resolve()
    if not target.is_relative_to(base.resolve()):
        raise ValueError('Manifest path leaves the package')
    return target


def _manifest(base):
    manifest = json.loads((base / 'manifest.json').read_text())
    if manifest.get('status') != 'PASS':
        raise ValueError('Data package is not accepted')
    for item in manifest.get('metadata_files', []):
        if sha(_within(base, item['path'])) != item['sha256']:
            raise ValueError('Data metadata hash mismatch: ' + item['path'])
    return manifest


def load_data(*, mode=None, actual_path=None, columns=None, years=None, development_path=None, require_panel=False):
    """Return the same named-column interface in development and actual modes.

    actual_path must explicitly name either the accepted original local G0 DTA
    or a verified local cloud projection package. It is never inferred.
    """
    mode = mode or os.environ.get('DEASY_DATA_MODE', 'development')
    if mode not in {'development', 'actual'}:
        raise ValueError('mode must be development or actual')
    development = Path(development_path or DEFAULT_DEVELOPMENT).resolve()
    dev = _manifest(development)
    if dev.get('data_kind') != 'perturbed-development' or dev.get('final_results_allowed') is not False:
        raise ValueError('Expected a labelled G0.5 development package')
    names = dev['column_names']
    base_names = dev.get('base_column_names', names)
    identity_names = [n for n in names if n not in base_names]
    selected = names if columns is None else list(columns)
    if not selected or len(set(selected)) != len(selected) or not set(selected) <= set(names):
        raise ValueError('Unknown, repeated or empty selected columns')
    wanted_years = None if years is None else sorted({int(years)} if isinstance(years, int) else {int(y) for y in years})
    if wanted_years is not None and (not wanted_years or not set(map(str, wanted_years)) <= set(dev['year_counts'])):
        raise ValueError('Requested wave unavailable; supplied waves are ' + ', '.join(dev['year_counts']))
    needed = selected + (['source_year'] if wanted_years is not None or mode == 'actual' or require_panel else [])
    if require_panel:
        needed += ['psid', 'psid_status']
    reading = list(dict.fromkeys(needed))
    actual_reading = [n for n in reading if n in base_names]
    source = development
    manifest = dev
    input_sha = sha(source / 'manifest.json')
    if mode == 'actual':
        explicit = actual_path or os.environ.get('DEASY_ACTUAL_DATA')
        if not explicit:
            raise ValueError('Actual mode requires explicit local actual_path or DEASY_ACTUAL_DATA; no automatic fallback')
        source = Path(explicit).expanduser().resolve()
        if source.is_dir():
            manifest = _manifest(source)
            input_sha = sha(source / 'manifest.json')
            if manifest.get('random_noise_added') is not False or manifest.get('data_kind') == 'perturbed-development':
                raise ValueError('Actual mode refuses perturbed/development input')
            if input_sha != dev['source_g0_manifest_sha256']:
                raise ValueError('Actual G0 version differs; rebuild/validate G0.5 against the new G0 first')
        else:
            if source.suffix.lower() != '.dta' or not source.is_file():
                raise ValueError('Actual input must be a verified local package or accepted G0 .dta')
            input_sha = sha(source)
            if input_sha != dev['source_g0_master_sha256']:
                raise ValueError('Actual G0 DTA checksum differs from the accepted parent')
    if mode == 'actual' and source.is_file():
        frame = pd.read_stata(source, columns=actual_reading, convert_categoricals=False, convert_dates=False)
    else:
        if manifest.get('column_names') != (base_names if mode == 'actual' else names):
            raise ValueError('Actual/development column interface differs')
        frames, expected = [], 0
        for item in manifest['parts']:
            if mode == 'development' and wanted_years is not None and item.get('year') is not None and int(item['year']) not in wanted_years:
                continue
            path = _within(source, item['path'])
            if sha(path) != item['sha256']:
                raise ValueError('Data part hash mismatch: ' + item['path'])
            table = pq.ParquetFile(path).read(columns=actual_reading if mode == 'actual' else reading, use_threads=False)
            if table.num_rows != item['rows']:
                raise ValueError('Data part row count mismatch')
            if mode == 'development' and (table.schema.metadata or {}).get(b'data_kind') != b'perturbed-development':
                raise ValueError('Unlabelled part in the development package')
            frames.append(table.to_pandas())
            expected += item['rows']
        if not frames:
            raise ValueError('No matching data parts')
        frame = pd.concat(frames, ignore_index=True)
        if len(frame) != expected:
            raise ValueError('Combined row count mismatch')
    if mode == 'actual' and identity_names:
        # Exact parent checksum plus exact row order binds this observation map.
        # This transfers observation identity, never inferred firm linkage.
        id_frames = []
        for item in dev['parts']:
            path = _within(development, item['path'])
            if sha(path) != item['sha256']:
                raise ValueError('Identity-map package hash mismatch')
            id_frames.append(pq.ParquetFile(path).read(columns=['source_year', 'obs_id'], use_threads=False).to_pandas())
        ids = pd.concat(id_frames, ignore_index=True)
        if len(ids) != len(frame) or not (ids['source_year'].to_numpy() == frame['source_year'].to_numpy()).all():
            raise ValueError('Actual source order differs from the frozen observation map')
        schema_types = {x['name']: x['type'] for x in json.loads((development / 'schema.json').read_text())}
        for name in identity_names:
            # Fictional continuity belongs exclusively to development. Reusing
            # it on actual measurements would silently fabricate empirical lags.
            if name == 'obs_id':
                frame[name] = ids[name].to_numpy()
            elif name == 'psid_status':
                frame[name] = 'unverified_no_longitudinal_crosswalk'
            else:
                frame[name] = float('nan') if schema_types[name] in {'double', 'float'} else ''
    if wanted_years is not None:
        frame = frame.loc[frame['source_year'].isin(wanted_years)].reset_index(drop=True)
    expected_rows = sum(dev['year_counts'][str(y)] for y in wanted_years) if wanted_years is not None else dev['rows']
    if len(frame) != expected_rows:
        raise ValueError('Selected wave coverage differs from the accepted package')
    if require_panel:
        expected_status = ('synthetic_development' if mode == 'development'
                           and dev.get('identity', {}).get('status') == 'synthetic_development' else 'verified')
        if frame['psid'].isna().any() or not frame['psid_status'].eq(expected_status).all() or frame.duplicated(['psid', 'source_year']).any():
            raise ValueError('Panel identity unavailable for this mode; development requires declared synthetic IDs, actual requires verified real links')
    schema = {item['name']: item['type'] for item in json.loads((development / 'schema.json').read_text())}
    for name in reading:
        kind = schema[name]
        if kind in {'double', 'float'}:
            frame[name] = pd.to_numeric(frame[name], errors='raise').astype('float64')
        elif kind in {'string', 'large_string'}:
            # String is part of the source interface (including numeric text).
            frame[name] = frame[name].astype('object')
        elif kind.startswith('int') and not frame[name].isna().any():
            frame[name] = frame[name].astype(kind)
    if 'analysis_contract' in frame:
        frame['analysis_contract'] = ('G0.5 DEVELOPMENT: perturbed actual-derived data; not final empirical results' if mode == 'development' else 'G0 ACTUAL: local accepted source; final results still require module validation')
    frame = frame.loc[:, selected]
    frame.attrs['deasy_data'] = {'mode': mode, 'data_kind': 'perturbed-development' if mode == 'development' else 'actual',
                               'input_sha256': input_sha, 'g05_version': dev['version'], 'rows': len(frame),
                               'columns': selected, 'years': wanted_years or sorted(map(int, dev['year_counts'])),
                               'final_results_allowed_by_data_mode': mode == 'actual',
                               'panel_identity_verified': False,
                               'panel_identity_kind': (dev.get('identity', {}).get('status', 'unverified') if mode == 'development' else 'unverified'),
                               'panel_development_ready': mode == 'development' and dev.get('identity', {}).get('status') == 'synthetic_development'}
    return frame


def write_run_receipt(output, frame, *, code_path, purpose='development'):
    """Tie output to input mode and exact code; development cannot be labelled final."""
    metadata = frame.attrs.get('deasy_data')
    if not metadata:
        raise ValueError('Missing input provenance; load data through harness.data_source first')
    if purpose not in {'development', 'final'}:
        raise ValueError('purpose must be development or final')
    if purpose == 'final' and metadata['mode'] != 'actual':
        raise ValueError('Finalisation refuses development data; rerun the same code on explicit local actual input')
    path = Path(output)
    if path.exists():
        raise ValueError('Receipt exists; use a new run output path')
    path.parent.mkdir(parents=True, exist_ok=True)
    receipt = {'created_at': datetime.now(timezone.utc).isoformat(), 'purpose': purpose,
               'input': metadata, 'code_sha256': sha(code_path),
               'scope': 'Data/code provenance only; does not certify estimation validity or module completion'}
    path.write_text(json.dumps(receipt, ensure_ascii=False, indent=2) + '\n')
    return receipt


def export_data(frame, target, *, purpose='development', code_path=__file__):
    """Export the selected input for the same downstream Stata/Python/R code."""
    metadata = frame.attrs.get('deasy_data', {})
    if not metadata:
        raise ValueError('Input provenance missing')
    if purpose not in {'development', 'final'}:
        raise ValueError('purpose must be development or final')
    # Validate the code reference before writing any data file.
    if not Path(code_path).is_file():
        raise ValueError('A readable code_path is required for output provenance')
    if purpose == 'final' and metadata.get('mode') != 'actual':
        raise ValueError('Cannot export development input for finalisation')
    target = Path(target).resolve()
    if target.exists() or target.with_suffix(target.suffix + '.receipt.json').exists():
        raise ValueError('Output exists; choose a new filename')
    if metadata['mode'] == 'actual' and target.is_relative_to(ROOT):
        raise ValueError('Actual-data exports must be outside the Git checkout')
    target.parent.mkdir(parents=True, exist_ok=True)
    if target.suffix == '.dta':
        # Numeric input interface is stable; Stata picks sufficient string widths.
        frame.to_stata(target, write_index=False, version=118 if len(frame.columns) <= 32767 else 119,
                       data_label='DEASY G0.5 DEVELOPMENT' if metadata['mode'] == 'development' else 'DEASY G0 ACTUAL')
    elif target.suffix == '.parquet':
        frame.to_parquet(target, index=False, compression='zstd')
    elif target.suffix == '.csv':
        frame.to_csv(target, index=False)
    else:
        raise ValueError('Supported output formats: .dta, .parquet, .csv')
    write_run_receipt(target.with_suffix(target.suffix + '.receipt.json'), frame, code_path=code_path, purpose=purpose)
    return target


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--mode', choices=['development', 'actual'], default=None)
    parser.add_argument('--actual-path', type=Path)
    parser.add_argument('--development-path', type=Path)
    parser.add_argument('--require-panel', action='store_true', help='Require panel identity appropriate to the selected mode')
    parser.add_argument('--year', type=int, action='append')
    parser.add_argument('--columns', help='Comma-separated column names; omission reads all columns')
    parser.add_argument('--export', type=Path)
    parser.add_argument('--purpose', choices=['development', 'final'], default='development')
    args = parser.parse_args()
    frame = load_data(mode=args.mode, actual_path=args.actual_path, development_path=args.development_path,
                      years=args.year, columns=args.columns.split(',') if args.columns else None,
                      require_panel=args.require_panel)
    if args.purpose == 'final' and frame.attrs['deasy_data']['mode'] != 'actual':
        parser.error('Final purpose requires explicit actual mode')
    if args.export:
        export_data(frame, args.export, purpose=args.purpose)
    print(json.dumps({'rows': len(frame), 'columns': len(frame.columns), 'mode': frame.attrs['deasy_data']['mode'],
                      'years': frame.attrs['deasy_data']['years'], 'export': str(args.export) if args.export else None}))
