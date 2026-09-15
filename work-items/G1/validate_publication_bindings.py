#!/usr/bin/env python3
"""Independently check publication operand, display, asset and compile bindings.

This checks traced calculations and exact source identities. Scientific prose and
page layout require the separate human-readable method and visual review receipts.
"""
# WFDOC: Audit ini mengikat tabel/prosa/label grafik ke operand sumber, format dan file gambar serta memeriksa receipt PDF yang sudah dibangun.
# WFDOC: Ia bukan pemeriksaan bahasa ilmiah atau tata halaman; review semantik/prosa/visual tetap berada pada receipt manusia terpisah.
# WFDOC: Sumber trace berada di publication/provenance; hasil validasi ditulis ke qa/publication-bindings-validation.json.
# WFDOC: Kegagalan identitas file, row key, rumus terdaftar, format, label, hash asset atau compile log menghentikan PASS.
from pathlib import Path
import csv
import hashlib
import json
import math
import re
from collections import defaultdict
from datetime import datetime, timezone

HERE = Path(__file__).resolve().parent
PUB = HERE / 'publication'
ROOT = HERE.parents[1]


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def equal(a, b):
    if a is None or b is None:
        return a is None and b is None
    if isinstance(a, (int, float)) and isinstance(b, (int, float)):
        return math.isclose(a, b, rel_tol=1e-12, abs_tol=1e-13)
    return a == b


def main():
    # WFDOC: Cache frame dan hash mencegah pembacaan ulang; receipt menghitung cakupan trace yang benar-benar diuji.
    frames, hashes = {}, {}
    counts = defaultdict(int)

    # WFDOC: Pilih hanya calon path lokal yang SHA-nya persis dengan sumber provenance; kemiripan nama tidak cukup.
    def resolve(name, expected):
        candidates = [Path(name), ROOT / name, PUB / name]
        candidates += [HERE / folder / 'outputs' / Path(name).name for folder in ['release', 'deep-release']]
        for path in candidates:
            if path.is_file():
                if path not in hashes:
                    hashes[path] = sha(path)
                if hashes[path] == expected:
                    return path
        raise AssertionError(f'No exact source for {name} SHA256 {expected}')

    def rows(path):
        if path not in frames:
            with path.open() as stream:
                frames[path] = list(csv.DictReader(stream))
        return frames[path]

    def matching(row, key):
        for field, value in key.items():
            if row[field] == str(value):
                continue
            try:
                if float(row[field]) == float(value):
                    continue
            except (TypeError, ValueError):
                pass
            return False
        return True

    # WFDOC: Operand berupa nilai baris CSV, pointer JSON, atau deklarasi desain; tipe terakhir dihitung untuk review semantic terpisah.
    def operand(o):
        path = resolve(o['source_file'], o['source_sha256'])
        counts['source_operands'] += 1
        if 'csv_line' in o:
            source = rows(path)[int(o['csv_line']) - 2]
            assert matching(source, o['row_key']), o
            assert source[o['field']] == o['source_text'], o
            if o['value'] is None:
                assert source[o['field']] in ('', '.'), o
            elif isinstance(o['value'], (int, float)):
                assert equal(float(source[o['field']]), o['value']), o
            else:
                assert source[o['field']] == o['value'], o
        elif 'json_pointer' in o:
            source = json.loads(path.read_text())
            for key in o['json_pointer'].strip('/').split('/'):
                key = key.replace('~1', '/').replace('~0', '~')
                source = source[int(key)] if isinstance(source, list) else source[key]
            assert equal(source, o['value']), o
        elif 'declared_calculation' in o:
            counts['design_declarations_requiring_semantic_review'] += 1
        else:
            raise AssertionError(f'Unrecognized operand contract: {o}')
        return o['value']

    # WFDOC: Hitung ulang operasi yang diizinkan dan render format skala; reject operasi tak dikenal atau teks angka yang berubah.
    for trace_name in ['table-cells.json', 'numerical-prose.json']:
        trace = json.loads((PUB / 'provenance' / trace_name).read_text())
        for entry in trace:
            vals = [operand(o) for o in entry['operands']]
            operation = entry['operation']
            if operation in ('identity', 'label mapping'):
                expected = vals[0]
            elif operation == 'count distinct admitted sector codes':
                expected = len(set(vals))
            elif operation in ('count admitted own-domain primary coefficient rows',
                               'count successful fixed-variant coefficient rows'):
                expected = len(vals)
            elif operation == 'sum successful resamples over all admitted primary cells':
                expected = sum(vals)
            elif operation.startswith('maximum absolute'):
                groups = defaultdict(dict)
                for o in entry['operands']:
                    key = o['row_key']
                    group = tuple(sorted((k, v) for k, v in key.items() if k != 'variant')) + (('field', o['field']),)
                    groups[group][key['variant']] = o['value']
                differences = []
                for group in groups.values():
                    assert 'primary' in group
                    differences.extend(abs(v - group['primary']) for k, v in group.items() if k != 'primary')
                expected = max(differences)
            else:
                raise AssertionError(f'Unreviewed publication operation: {operation}')
            assert equal(expected, entry['unrounded_value']), entry['anchor']
            fmt = entry['format']
            if re.fullmatch(r',?\.\d+[feg]', fmt):
                printed = '---' if expected is None else format(expected * entry['scale'], fmt)
                assert printed == entry['printed_string'], entry['anchor']
                counts['table_and_prose_numeric_formats'] += 1
            else:
                counts['text_or_design_formats_semantic_review_separate'] += 1
            counts['table_cells' if trace_name == 'table-cells.json' else 'prose_entries'] += 1

    # WFDOC: Tiap annotation harus menunjuk satu row/source dan nilai cetak yang tepat; legenda serta seluruh asset harus match manifest.
    for trace_name, manifest_name in [('figure-annotations.json', 'figure-manifest.json'),
                                      ('deep-figure-annotations.json', 'deep-figure-manifest.json')]:
        if not (PUB / 'provenance' / trace_name).exists():
            continue
        trace = json.loads((PUB / 'provenance' / trace_name).read_text())
        for item in trace:
            path = resolve(item['source_file'], item['source_sha256'])
            selected = [r for r in rows(path) if matching(r, item['row_key'])]
            assert len(selected) == 1, (item['figure'], item['row_key'], len(selected))
            value = float(selected[0][item['field']])
            assert equal(value, item['unrounded_value']), item
            assert format(value * item['display_scale'], item['decimal_format']) == item['printed_string'], item
            assert len(item['plotting_anchor']) == 2 and all(math.isfinite(float(x)) for x in item['plotting_anchor'])
            counts['figure_annotations'] += 1
        manifest = json.loads((PUB / 'provenance' / manifest_name).read_text())
        for figure in manifest['figures']:
            assert figure['visible_legend'], figure['figure']
            for asset in figure['outputs']:
                assert sha(PUB / asset['path']) == asset['sha256'], asset
                counts['figure_assets'] += 1
            for source in figure['sources']:
                resolve(source.get('file', source.get('path')), source['sha256'])
            counts['generated_figures'] += 1

    # WFDOC: Validasi PDF hanya mengaudit build receipt/label/compile yang ada; skrip tidak menjalankan kompilasi ulang.
    receipt = json.loads((PUB / 'provenance/pdf-build.json').read_text())
    for item in receipt['files']:
        assert sha(PUB / item['path']) == item['sha256'], item['path']
    log = (PUB / 'provenance/compile.log').read_text()
    bad = [line for line in log.splitlines() if re.search(r'Overfull|undefined references|Reference .* undefined|multiply defined', line)]
    assert not bad, bad
    body = (PUB / 'appendix.tex').read_text()
    assert '@@' not in body, 'Unexpanded manuscript token'
    aux = (PUB / 'provenance/compiled-labels.aux').read_text()
    labels = re.findall(r'\\newlabel\{([^}]+)\}', aux)
    assert len(labels) == len(set(labels)), 'Duplicate compiled labels'
    counts['numbered_figures_in_pdf'] = sum(bool(re.search(r'(?:^|:)fig:', x)) for x in labels)
    counts['numbered_tables_in_pdf'] = sum(bool(re.search(r'(?:^|:)tab:', x)) for x in labels)
    counts['numbered_equations_in_pdf'] = sum(bool(re.search(r'(?:^|:)eq:', x)) for x in labels)
    # WFDOC: Status PASS terbatas pada trace exact, operasi/display, asset dan binding compile; prose ilmiah/desain tetap review manual.
    result = {'status': 'PASS', 'created_utc': datetime.now(timezone.utc).isoformat(),
              'scope': 'Exact traced source values, declared arithmetic, display formats, figure assets and successful compiled-source identities; scientific prose, semantic design declarations and page layout reviewed separately',
              'counts': dict(counts), 'pdf_sha256': sha(PUB / 'G1-Appendix.pdf'),
              'validator_sha256': sha(Path(__file__))}
    (HERE / 'qa/publication-bindings-validation.json').write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps(result))


if __name__ == '__main__':
    main()
