#!/usr/bin/env python3
"""G0 -> G0.5: bounded, coherent development perturbation; no estimators run."""
from __future__ import annotations

import argparse
from collections import Counter, defaultdict
import csv
from datetime import datetime, timezone
import hashlib
import hmac
import json
import math
from pathlib import Path
import resource
import secrets
import sys

import numpy as np
import pandas as pd
import pyarrow as pa
import pyarrow.parquet as pq

from column_policy import classify, VERSION, MIN_CHANGE, MAX_CHANGE

pa.set_cpu_count(1)
pa.set_io_thread_count(1)


def sha(path):
    digest = hashlib.sha256()
    with Path(path).open('rb') as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b''):
            digest.update(block)
    return digest.hexdigest()


def save(path, value):
    Path(path).write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')


def factors(key, source_hash, start, count):
    values = []
    for number in range(start, start + count):
        value = hmac.new(key, f'{VERSION}:{source_hash}:{number}'.encode(), hashlib.sha256).digest()
        u = int.from_bytes(value[:8], 'big') / 2**64
        sign = -1 if value[8] & 1 else 1
        values.append(1 + sign * (MIN_CHANGE + (MAX_CHANGE - MIN_CHANGE) * u))
    return np.asarray(values)


def numeric(series):
    if pd.api.types.is_numeric_dtype(series):
        return series.to_numpy(dtype=float, na_value=np.nan)
    return pd.to_numeric(series.astype('string').str.strip().str.replace(',', '', regex=False), errors='coerce').to_numpy(dtype=float, na_value=np.nan)


def transform_column(series, rule, factor):
    action = rule['action']
    if action == 'preserve':
        return series.copy(), np.zeros(len(series), dtype=bool)
    value = numeric(series)
    finite = np.isfinite(value)
    target = value.copy()
    if action == 'scale':
        target[finite] *= factor[finite]
    elif action == 'log_shift':
        target[finite] += np.log(factor[finite])
    else:
        raise ValueError('Unknown action: ' + action)
    changed = finite & (target != value)
    if pd.api.types.is_numeric_dtype(series):
        # Both development and actual adapters expose transformed numeric fields
        # as float64; status/count fields retain their original logical types.
        output = pd.Series(target, index=series.index, name=series.name)
    else:
        output = series.copy()
        for i in np.flatnonzero(changed):
            output.iloc[i] = format(target[i], '.17g')
    return output, changed


def coherence_relations(names):
    """Only equations grounded in the existing naming/code contracts."""
    available = set(names)
    relations = []
    aliases = {'output_nominal': 'gross_output_nominal', 'va_nominal': 'value_added_nominal',
               'inputs_nominal': 'intermediate_inputs_nominal', 'energy_expenditure': 'energy_expenditure_rp000',
               'import_nominal': 'import_value_nominal'}
    per_worker = {'labor_productivity_nominal': 'value_added_nominal',
                  'output_per_worker_nominal': 'gross_output_nominal',
                  'capital_per_worker_nominal': 'capital_nominal',
                  'inputs_per_worker_nominal': 'intermediate_inputs_nominal',
                  'rd_cost_per_worker_nominal': 'rd_cost_nominal',
                  'energy_cost_per_worker': 'energy_expenditure_rp000',
                  'total_gj_per_worker': 'total_gj_s1', 'co2_per_worker': 'co2_total_s1',
                  'capital_stock_per_worker': 'capital_stock_nominal',
                  'capital_additions_per_worker': 'capital_additions_nominal'}
    for name in names:
        original = name[2:] if name.startswith('r_') else name
        if original.startswith('ln_'):
            base = aliases.get(original[3:], original[3:])
            if base in available:
                relations.append({'output': name, 'operation': 'log', 'inputs': [base]})
        elif original.startswith('pw_') and original[3:] in available and 'workers' in available:
            relations.append({'output': name, 'operation': 'ratio', 'inputs': [original[3:], 'workers']})
        elif original in per_worker and {per_worker[original], 'workers'} <= available:
            relations.append({'output': name, 'operation': 'ratio', 'inputs': [per_worker[original], 'workers']})
    fixed = [
        ('value_added_share_of_output', 'ratio', ['value_added_nominal', 'gross_output_nominal']),
        ('energy_intensity_monetary', 'ratio', ['energy_expenditure_rp000', 'value_added_nominal']),
        ('energy_intensity_gj_nominal', 'ratio', ['total_gj_s1', 'value_added_nominal']),
        ('co2_intensity_nominal', 'ratio', ['co2_total_s1', 'value_added_nominal']),
        ('gross_output_real', 'ratio', ['gross_output_nominal', 'deflator_output']),
        ('value_added_real', 'ratio', ['value_added_nominal', 'deflator_output']),
    ]
    for name, op, inputs in fixed:
        if {name, *inputs} <= available:
            relations.append({'output': name, 'operation': op, 'inputs': inputs})
    return relations


def check_coherence(before, after, relations, counters):
    with np.errstate(all='ignore'):
        for relation in relations:
            target = relation['output']
            inputs = relation['inputs']
            old = np.log(numeric(before[inputs[0]])) if relation['operation'] == 'log' else numeric(before[inputs[0]]) / numeric(before[inputs[1]])
            new = np.log(numeric(after[inputs[0]])) if relation['operation'] == 'log' else numeric(after[inputs[0]]) / numeric(after[inputs[1]])
            old_target, new_target = numeric(before[target]), numeric(after[target])
            mask = np.isfinite(old) & np.isfinite(old_target) & np.isclose(old_target, old, rtol=1e-7, atol=1e-8)
            counters[target]['source_applicable'] += int(mask.sum())
            passed = np.isfinite(new_target) & np.isclose(new_target, new, rtol=1e-7, atol=1e-8)
            failed = mask & ~passed
            counters[target]['new_failures'] += int(failed.sum())
            if failed.any():
                raise ValueError(f'G0.5 broke {target} on {int(failed.sum())} previously coherent cells')


def build(source, output, private_key):
    source, output, private_key = map(lambda p: Path(p).resolve(), [source, output, private_key])
    if output.exists():
        raise ValueError('Output already exists; use a new version directory.')
    if private_key.is_relative_to(output) or private_key.is_relative_to(Path(__file__).resolve().parents[2]):
        raise ValueError('Private seed must not be stored in the published package.')
    manifest_path = source / 'manifest.json'
    manifest = json.loads(manifest_path.read_text())
    if manifest.get('random_noise_added') is not False or manifest.get('status') != 'PASS':
        raise ValueError('Expected the verified actual G0 cloud projection, not another development package.')
    source_hash = sha(manifest_path)
    names = manifest['column_names']
    if manifest['rows'] != sum(p['rows'] for p in manifest['parts']):
        raise ValueError('Source manifest row mismatch')
    for item in manifest['metadata_files']:
        if sha(source / item['path']) != item['sha256']:
            raise ValueError('Source metadata hash mismatch: ' + item['path'])
    with (source / 'dictionary.csv').open() as stream:
        dictionary = list(csv.DictReader(stream))
    fields = {r['name']: r for r in dictionary if r['included_in_cloud'] == 'True'}
    if list(fields) != names:
        raise ValueError('Column dictionary order does not match the master projection')
    # Stata integers with missing values arrive as float in some source parts.
    # A single declared logical schema avoids part-dependent integer/null casts.
    numeric_names = {n for n in names if fields[n]['stata_storage'] in {'b', 'h', 'l', 'f', 'd'}}
    arrow_schema = pa.schema([pa.field(n, pa.float64() if n in numeric_names else pa.string()) for n in names])
    if private_key.exists():
        key = private_key.read_bytes()
    else:
        private_key.parent.mkdir(parents=True, exist_ok=True)
        key = secrets.token_bytes(32)
        with private_key.open('xb') as stream:
            stream.write(key)
        private_key.chmod(0o600)
    if len(key) != 32:
        raise ValueError('Invalid private seed')
    policies = {name: classify(name, fields[name]['stata_storage']) for name in names}
    output.mkdir(parents=True)
    parts, wave_counts, wave_number = [], Counter(), Counter()
    changed_by_column, valid_by_column = Counter(), Counter()
    row_changes, rows, logical_schema = 0, 0, None
    relations = coherence_relations(names)
    coherence = defaultdict(lambda: {'source_applicable': 0, 'new_failures': 0})
    for part_number, item in enumerate(manifest['parts'], 1):
        path = source / item['path']
        if sha(path) != item['sha256']:
            raise ValueError('Actual source part hash mismatch: ' + item['path'])
        table = pq.ParquetFile(path).read(use_threads=False)
        before = table.to_pandas().reset_index(drop=True)
        if list(before.columns) != names or len(before) != item['rows']:
            raise ValueError('Unexpected source part schema/rows')
        factor = factors(key, source_hash, rows, len(before))
        columns, any_changed = {}, np.zeros(len(before), dtype=bool)
        for name in names:
            transformed, changed = transform_column(before[name], policies[name], factor)
            if not before[name].isna().equals(transformed.isna()):
                raise ValueError('Missingness changed: ' + name)
            if policies[name]['action'] == 'preserve' and not transformed.equals(before[name]):
                raise ValueError('Protected field changed: ' + name)
            if policies[name]['action'] != 'preserve':
                original, modified = numeric(before[name]), numeric(transformed)
                finite = np.isfinite(original)
                valid_by_column[name] += int(finite.sum())
                if not np.array_equal(np.isfinite(original), np.isfinite(modified)):
                    raise ValueError('Parsing/domain changed: ' + name)
                if policies[name]['action'] == 'scale':
                    if not np.array_equal(np.sign(original[finite]), np.sign(modified[finite])):
                        raise ValueError('Sign/zero changed: ' + name)
                    nonzero = finite & (original != 0)
                    difference = np.abs(modified[nonzero] / original[nonzero] - 1)
                    if np.any(difference > MAX_CHANGE + 1e-12):
                        raise ValueError('Noise limit exceeded: ' + name)
            columns[name] = transformed
            changed_by_column[name] += int(changed.sum())
            any_changed |= changed
        after = pd.DataFrame(columns)
        check_coherence(before, after, relations, coherence)
        # Metadata label replaces a description, without adding/changing the input schema.
        if 'analysis_contract' in after:
            after['analysis_contract'] = 'G0.5 DEVELOPMENT: perturbed actual-derived data; not final empirical results'
        for name in numeric_names:
            after[name] = after[name].astype('float64')
        # Keep company_data_is_synthetic unchanged: its source meaning is a fully
        # synthetic company fixture, which is not what this derivative is.
        row_changes += int(any_changed.sum())
        for year in sorted(after['source_year'].unique()):
            year = int(year)
            subset = after.loc[after['source_year'].eq(year)].reset_index(drop=True)
            wave_number[year] += 1
            relative = f'waves/{year}/part-{wave_number[year]:03d}.parquet'
            target = output / relative
            target.parent.mkdir(parents=True, exist_ok=True)
            exported = pa.Table.from_pandas(subset, schema=arrow_schema, preserve_index=False)
            current_schema = [{'name': f.name, 'type': str(f.type)} for f in exported.schema]
            if logical_schema is None:
                logical_schema = current_schema
            if current_schema != logical_schema:
                raise ValueError('Inconsistent output schema across partitions')
            exported = exported.replace_schema_metadata({b'data_kind': b'perturbed-development', b'g05_version': VERSION.encode(), b'final_results_allowed': b'false'})
            pq.write_table(exported, target, compression='zstd')
            restored = pq.ParquetFile(target).read().to_pandas()
            pd.testing.assert_frame_equal(subset, restored, check_exact=True)
            if target.stat().st_size >= 45 * 1024**2:
                raise ValueError('Output part exceeds the 45 MiB package limit')
            parts.append({'path': relative, 'year': year, 'rows': len(subset), 'bytes': target.stat().st_size, 'sha256': sha(target)})
            wave_counts[str(year)] += len(subset)
        rows += len(before)
        print(json.dumps({'source_part': part_number, 'of': len(manifest['parts']), 'rows': rows, 'rows_changed': row_changes, 'rss_peak_bytes': resource.getrusage(resource.RUSAGE_SELF).ru_maxrss}), flush=True)
        del before, after, columns, table, exported, restored, subset
    if rows != manifest['rows'] or dict(wave_counts) != manifest['year_counts']:
        raise ValueError('Source wave coverage was not preserved')
    if not sum(changed_by_column.values()):
        raise ValueError('No actual measurements were changed')
    if sha(manifest_path) != source_hash:
        raise ValueError('Source manifest changed during the build')
    for item in manifest['parts']:
        if sha(source / item['path']) != item['sha256']:
            raise ValueError('Original source changed during the build: ' + item['path'])
    for name in ['dictionary.csv', 'value-labels.json', 'excluded-columns.json', 'stata-missing-codes.json']:
        (output / name).write_bytes((source / name).read_bytes())
    # Row partitioning keeps original order within each wave. Existing package
    # has no extended missing sidecar entries; future cases must be remapped.
    if json.loads((source / 'stata-missing-codes.json').read_text()):
        raise ValueError('Nonempty Stata extended-missing locations require explicit row remapping')
    policy_records = [{'name': n, **p, 'finite_cells': valid_by_column[n], 'changed_cells': changed_by_column[n]} for n, p in policies.items()]
    save(output / 'column-policy.json', {'version': VERSION, 'columns': policy_records})
    save(output / 'schema.json', logical_schema)
    verification = {'status': 'PASS', 'scope': 'G0.5_DEVELOPMENT_PACKAGE_ONLY', 'rows': rows,
                    'columns': len(names), 'year_counts': dict(wave_counts), 'rows_with_measurement_changes': row_changes,
                    'changed_measurement_cells': sum(changed_by_column.values()),
                    'columns_with_changed_measurements': sum(v > 0 for v in changed_by_column.values()),
                    'policy_counts': dict(Counter(p['action'] for p in policies.values())),
                    'missingness_preserved': True, 'protected_fields_preserved_except_analysis_contract_label': True,
                    'scale_signs_and_zeros_preserved': True, 'scale_absolute_relative_change_max': MAX_CHANGE,
                    'coherence_checks': dict(coherence), 'new_coherence_failures': 0,
                    'parquet_roundtrip_exact': True, 'original_source_parts_hash_verified': len(manifest['parts']),
                    'original_source_unmodified': True, 'private_seed_published': False,
                    'peak_rss_bytes': resource.getrusage(resource.RUSAGE_SELF).ru_maxrss,
                    'downstream_estimations_executed': False, 'anonymity_guaranteed': False}
    save(output / 'verification.json', verification)
    sidecars = ['dictionary.csv', 'value-labels.json', 'excluded-columns.json', 'stata-missing-codes.json', 'column-policy.json', 'schema.json', 'verification.json']
    published = {'status': 'PASS', 'schema_version': 1, 'data_kind': 'perturbed-development',
                 'version': VERSION, 'created_at': datetime.now(timezone.utc).isoformat(),
                 'source_g0_manifest_sha256': source_hash, 'source_g0_master_sha256': manifest['source_sha256'],
                 'rows': rows, 'columns': len(names), 'column_names': names, 'year_counts': dict(wave_counts),
                 'parts': parts, 'metadata_files': [{'path': p, 'sha256': sha(output / p)} for p in sidecars],
                 'random_noise_added': True, 'noise': {'method': 'coherent per-record multiplicative level jitter', 'absolute_relative_min': MIN_CHANGE, 'absolute_relative_max': MAX_CHANGE, 'log_rule': 'log(x) + log(record_factor)'},
                 'final_results_allowed': False, 'private_repository_only': True,
                 'anonymity_guaranteed': False, 'not_fully_synthetic': True,
                 'unchanged_data': 'Categories, counts, missingness, reference parameters, dimensionless ratios and unclassified fields remain actual-derived and may be unchanged.',
                 'identity': 'No longitudinal company identity is created or certified.',
                 'analytical_parent': 'Development: this G0.5 derivative of G0. Actual finalisation: explicitly selected local G0 using the same schema adapter.'}
    save(output / 'manifest.json', published)
    return verification


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--source', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--private-key', type=Path, required=True)
    args = parser.parse_args()
    report = build(args.source, args.output, args.private_key)
    print(json.dumps({k: v for k, v in report.items() if k != 'coherence_checks'}, indent=2))
