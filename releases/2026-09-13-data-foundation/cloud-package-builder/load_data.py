"""Read all checked storage parts as one analytical dataset."""
from pathlib import Path
import hashlib, json
import pandas as pd

def load_data(folder=None):
    root = Path(folder) if folder else Path(__file__).resolve().parent
    manifest = json.loads((root / 'manifest.json').read_text())
    assert manifest['status'] == 'PASS'
    for metadata in manifest['metadata_files']:
        path = root / metadata['path']
        assert hashlib.sha256(path.read_bytes()).hexdigest() == metadata['sha256'], path.name
    frames = []
    for part in manifest['parts']:
        path = root / part['path']
        assert hashlib.sha256(path.read_bytes()).hexdigest() == part['sha256'], path.name
        frame = pd.read_parquet(path)
        assert len(frame) == part['rows']
        frames.append(frame)
    data = pd.concat(frames, ignore_index=True)
    assert data.shape == (manifest['rows'], manifest['columns'])
    assert list(data.columns) == manifest['column_names']
    return data

if __name__ == '__main__':
    data = load_data()
    print(f'Data terbaca: {len(data):,} baris, {len(data.columns):,} kolom.')
    print('Seluruh bagian sudah digabung. Pilih tahun setelah langkah ini.')
