#!/usr/bin/env python3
"""Read original Excel headers/coverage; publish only aggregate source evidence.

The inventory argument is local and can contain private absolute paths. Those
paths and all record values are excluded from the output. Source files stay
unchanged. This audit does not assign IDs or claim verified source semantics.
"""
import argparse
import hashlib
import json
import math
from pathlib import Path
import re

from openpyxl import load_workbook
from panel_generator import FEATURES


def audit(inventory_path, output):
    inventory = json.loads(Path(inventory_path).read_text())
    waves = []
    for item in inventory:
        path = Path(item['path']); before = hashlib.sha256(path.read_bytes()).hexdigest()
        assert before == item['sha256']
        wb = load_workbook(path, read_only=True, data_only=True)
        try:
            ws = wb[item['sheet']]
            rows = ws.iter_rows(values_only=True); headers = list(next(rows))
            selected = {}
            for name, (_, _, stem) in FEATURES.items():
                pattern = re.compile(r'^' + stem + '(' + str(item['year'])[-2:] + r')?(\.\.\.\d+)?$', re.I)
                found = [i for i, h in enumerate(headers) if pattern.fullmatch(str(h))]
                if len(found) != 1: raise ValueError(f'Ambiguous/missing Excel mapping: {item["year"]} {name}')
                selected[name] = found[0]
            count = 0
            stats = {name: {'finite': 0, 'negative': 0, 'zero': 0} for name in FEATURES}
            for row in rows:
                count += 1
                for name, position in selected.items():
                    try: value = float(str(row[position]).strip().replace(',', ''))
                    except (ValueError, TypeError): continue
                    if math.isfinite(value):
                        stats[name]['finite'] += 1
                        stats[name]['negative'] += int(value < 0)
                        stats[name]['zero'] += int(value == 0)
            assert count == item['max_row'] - 1
            waves.append({'year': item['year'], 'source_filename': path.name, 'source_sha256': before,
                          'rows': count, 'features': [{'name': name, 'excel_header': headers[position], **stats[name]}
                                                     for name, position in selected.items()]})
        finally: wb.close()
        assert hashlib.sha256(path.read_bytes()).hexdigest() == before
    report = {'status': 'PASS', 'scope': 'Original Excel header/coverage audit; no record values or source IDs published',
              'waves': waves, 'source_files': len(waves), 'source_rows': sum(x['rows'] for x in waves),
              'source_files_unchanged': True, 'source_values_in_report': False,
              'semantic_label_scope': 'Existing G0 source mappings; code vintages and payroll definitions remain provisional.'}
    Path(output).parent.mkdir(parents=True, exist_ok=True)
    Path(output).write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps({'status': 'PASS', 'waves': len(waves), 'rows': report['source_rows'],
                      'feature_wave_cells': len(waves)*len(FEATURES), 'original_excel_files_unchanged': True}), flush=True)


if __name__ == '__main__':
    p = argparse.ArgumentParser(); p.add_argument('--inventory', required=True); p.add_argument('--output', required=True)
    a = p.parse_args(); audit(a.inventory, a.output)
