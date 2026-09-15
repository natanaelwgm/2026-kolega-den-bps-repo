"""Compatibility entry point: the active input is now G0.5 development."""
from pathlib import Path
import sys

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE.parents[2]))
from harness.data_source import load_data as _load


def load_data(folder=None, **kwargs):
    # Old callers sometimes pass this release directory explicitly. Keep them
    # on the new development default instead of reaching for historical data.
    if folder is not None and Path(folder).resolve() != HERE:
        if 'development_path' in kwargs:
            raise ValueError('Pass either folder or development_path, not both')
        kwargs['development_path'] = folder
    return _load(**kwargs)


if __name__ == '__main__':
    data = load_data(columns=['source_year', 'obs_id', 'psid'])
    print(f'G0.5 development: {len(data):,} rows; obs_id unique={data.obs_id.is_unique}; psid verified=False.')
    print('Use harness.data_source.load_data() for the full 4,379-column dataset.')
