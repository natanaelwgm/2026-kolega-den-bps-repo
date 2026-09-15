"""Package a verified master without changing the retained economic values.

This is storage/privacy preparation, not statistical analysis. It refuses to
read the master until the actual Stata run has a passed post-exit receipt.
"""
from pathlib import Path
import argparse, csv, datetime, hashlib, json, shutil
import numpy as np
import pandas as pd
from pandas.io.stata import StataMissingValue

HERE = Path(__file__).resolve().parent
FOUNDATION = HERE.parent / 'G0-wave-foundation-v2'

def sha(path):
    h = hashlib.sha256()
    with Path(path).open('rb') as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b''):
            h.update(block)
    return h.hexdigest()

def write_json(path, value):
    path.write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    receipt_path = HERE / 'master-acceptance.json'
    receipt_sha = sha(receipt_path)
    receipt = json.loads(receipt_path.read_text())
    assert receipt['status'] == 'passed' and receipt['owned_process_exited']
    assert receipt['scope'] == 'DATA_PREPARATION_ONLY'
    assert receipt['exit_code'] == 0 and receipt['schema_comparison_status'] == 'passed'
    wave_path = FOUNDATION / 'runtime/wave-output-manifest.json'
    wave_sha = sha(wave_path)
    assert wave_sha == receipt['wave_manifest_sha256']
    wave_manifest = json.loads(wave_path.read_text())
    assert wave_manifest['status'] == 'passed' and wave_manifest['parent_process_exited']
    master_record = wave_manifest['master']
    master = FOUNDATION / master_record['path']
    assert master.resolve() == (FOUNDATION / 'data/analysis/G0_analysis_ready.dta').resolve()
    final_outputs = {item['path']: item['sha256'] for item in receipt['output_hashes']}
    assert final_outputs.get(master_record['path']) == master_record['sha256']
    validation_path = FOUNDATION / 'runtime/V085-latest.json'
    validation_sha = sha(validation_path)
    assert validation_sha == next(item['receipt_sha256'] for item in receipt['stage_receipts'] if item['stage'] == 'V085')
    validation = json.loads(validation_path.read_text())
    assert validation['status'] == 'passed' and validation['owned_process_exited']
    assert validation['exit_code'] == 0 and validation['success_marker_present']
    assert validation['implementation_manifest_sha256'] == receipt['implementation_manifest_sha256']
    verified_master = validation['validation']['artifact']
    assert verified_master['path'] == master_record['path']
    assert verified_master['sha256'] == master_record['sha256']
    assert validation['validation']['schema_status'] == 'passed'
    assert sha(master) == master_record['sha256']
    proposal = json.loads((HERE / 'privacy-field-proposal.json').read_text())
    fields = master_record['schema']['fields']
    names = [field['name'] for field in fields]
    assert len(names) == 4593 and master_record['schema']['rows'] == 33049
    denied = set(proposal['denylist_fields'])
    assert denied <= set(names) and 'source_year' not in denied
    keep = [name for name in names if name not in denied]
    assert not args.output.exists(), 'Use a new output directory; never overwrite a published package.'
    args.output.mkdir(parents=True)
    (args.output / 'data').mkdir()
    shutil.copy2(HERE / 'load_data.py', args.output / 'load_data.py')
    rows = 0
    parts = []
    missing_records = []
    year_counts = {}
    with pd.read_stata(master, iterator=True, convert_categoricals=False,
                       convert_dates=False, convert_missing=True,
                       preserve_dtypes=True, columns=keep, chunksize=2000) as reader:
        labels = reader.value_labels()
        for number, frame in enumerate(reader, 1):
            frame = frame.reset_index(drop=True)
            # Missing values in Stata have a plain dot or a letter. Preserve
            # letter codes separately; Parquet uses null for numerical missing.
            for name in frame.select_dtypes(include=['object']).columns:
                column = frame[name]
                is_missing = column.map(lambda value: isinstance(value, StataMissingValue))
                if is_missing.any():
                    for index, value in column[is_missing].items():
                        if value.string != '.':
                            missing_records.append({'package_row': rows + int(index),
                                                    'column': name, 'stata_missing': value.string})
                    frame[name] = pd.to_numeric(column.mask(is_missing, np.nan), errors='raise')
            for year, count in frame['source_year'].value_counts().items():
                year_counts[str(int(year))] = year_counts.get(str(int(year)), 0) + int(count)
            output = args.output / 'data' / f'part-{number:03d}.parquet'
            frame.to_parquet(output, index=False, compression='zstd')
            restored = pd.read_parquet(output)
            pd.testing.assert_frame_equal(frame, restored, check_exact=True)
            assert output.stat().st_size < 45 * 1024**2, 'Part too large for ordinary Git transport.'
            parts.append({'path': str(output.relative_to(args.output)), 'rows': len(frame),
                          'sha256': sha(output), 'bytes': output.stat().st_size})
            rows += len(frame)
            print(json.dumps({'part': number, 'rows_checked': rows, 'total_rows': 33049}), flush=True)
    assert rows == 33049 and len(year_counts) == 12 and '2016' not in year_counts
    dictionary = []
    for position, field in enumerate(fields, 1):
        dictionary.append({'original_position': position, 'name': field['name'],
                           'included_in_cloud': field['name'] in keep,
                           'stata_storage': field['storage'], 'label': field['label'],
                           'display_format': field['display_format'], 'value_label': field['value_label']})
    with (args.output / 'dictionary.csv').open('w', newline='') as stream:
        writer = csv.DictWriter(stream, fieldnames=list(dictionary[0]))
        writer.writeheader(); writer.writerows(dictionary)
    used_labels = {field['value_label'] for field in fields if field['name'] in keep}
    # Stata label codes arrive as NumPy integers; JSON object keys are text.
    # Convert only the key representation, preserving every category label.
    write_json(args.output / 'value-labels.json', {key: {str(int(code)): label for code, label in value.items()} for key, value in labels.items() if key in used_labels})
    write_json(args.output / 'stata-missing-codes.json', missing_records)
    write_json(args.output / 'excluded-columns.json', proposal['denylist'])
    assert sha(master) == master_record['sha256'], 'Master changed during packaging.'
    assert sha(receipt_path) == receipt_sha and sha(wave_path) == wave_sha
    assert sha(validation_path) == validation_sha, 'Validation metadata changed during packaging.'
    sidecars = ['dictionary.csv', 'value-labels.json', 'stata-missing-codes.json', 'excluded-columns.json']
    manifest = {'status': 'PASS', 'created_at': datetime.datetime.now(datetime.timezone.utc).isoformat(),
                'source': 'G0_analysis_ready.dta', 'source_sha256': master_record['sha256'],
                'source_execution_receipt_sha256': receipt_sha, 'source_acceptance_scope': receipt['scope'],
                'source_wave_manifest_sha256': wave_sha, 'source_validation_receipt_sha256': validation_sha,
                'metadata_files': [{'path': name, 'sha256': sha(args.output / name)} for name in sidecars],
                'source_rows': 33049,
                'source_columns': 4593, 'rows': rows, 'columns': len(keep), 'column_names': keep,
                'excluded_columns': len(denied), 'year_counts': year_counts, 'parts': parts,
                'retained_values_roundtrip': 'exact', 'random_noise_added': False,
                'stata_extended_missing_records': len(missing_records),
                'privacy': 'Direct identifiers and selected free text removed. Not a guarantee of anonymity. Private repository only.',
                'identity': 'Row order is package-local only; no verified longitudinal plant identity is asserted.',
                'analytical_parent': 'Only the verified consolidated master; parts are storage chunks, not analytical waves.'}
    write_json(args.output / 'manifest.json', manifest)
    shutil.copy2(HERE / 'README.md', args.output / 'README.md')
    shutil.copy2(HERE / 'GPT-PRO-PROMPT.md', args.output / 'GPT-PRO-PROMPT.md')
    print(json.dumps({'status': 'PASS', 'rows': rows, 'columns': len(keep), 'parts': len(parts)}))

if __name__ == '__main__':
    main()
