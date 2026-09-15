"""Meaningful numerical-contract and wrong-source failure tests, using toy data only."""
import contextlib
import csv
import io
import json
from pathlib import Path
import sys
import tempfile
import unittest

import numpy as np
import pandas as pd

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))
sys.path.insert(0, str(HERE.parents[1]))
from build_development import build, factors, sha, save, transform_column
from attach_ids import attach
from column_policy import classify, MAX_CHANGE
from harness.data_source import load_data, write_run_receipt, export_data


class G05ContractTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.temp = tempfile.TemporaryDirectory(prefix='g05-contract-')
        root = Path(cls.temp.name)
        cls.actual, cls.stage, cls.dev = root / 'actual', root / 'measurements', root / 'development'
        cls.actual.mkdir()
        cls.key = root / 'private' / 'key'
        frame = pd.DataFrame({
            'source_year': [2010] * 4 + [2011] * 4,
            'gross_output_nominal': [100., 200., 0., np.nan, 500., 600., 700., 800.],
            'value_added_nominal': [40., 80., -2., np.nan, 200., 240., 280., 320.],
            'workers': [10., 20., 1., 1., 50., 60., 70., 80.],
            'export_any_binary': [0., 1., 0., np.nan, 1., 0., 1., 0.],
            'val_costrd': [1., 2., 0., np.nan, 1., 2., 1., 2.],
            'raw_output10': ['100', '200', '0', '***', '', '', '', ''],
            'raw_dprovi10': ['01', '02', '03', '04', '', '', '', ''],
        })
        with np.errstate(all='ignore'):
            frame['ln_output_nominal'] = np.log(frame.gross_output_nominal.where(frame.gross_output_nominal > 0))
        frame['r_output_per_worker_nominal'] = frame.gross_output_nominal / frame.workers
        cls.original = frame
        records = []
        for i, sub in enumerate([frame.iloc[:3], frame.iloc[3:]], 1):
            path = cls.actual / f'part-{i}.parquet'
            sub.to_parquet(path, index=False)
            records.append({'path': path.name, 'rows': len(sub), 'sha256': sha(path), 'bytes': path.stat().st_size})
        dictionary = []
        for i, name in enumerate(frame.columns, 1):
            dictionary.append({'original_position': i, 'name': name, 'included_in_cloud': True,
                               'stata_storage': '16' if name.startswith('raw_') else 'd',
                               'label': name, 'display_format': '', 'value_label': ''})
        with (cls.actual / 'dictionary.csv').open('w', newline='') as stream:
            writer = csv.DictWriter(stream, fieldnames=list(dictionary[0])); writer.writeheader(); writer.writerows(dictionary)
        save(cls.actual / 'excluded-columns.json', [])
        save(cls.actual / 'value-labels.json', {})
        save(cls.actual / 'stata-missing-codes.json', [])
        sidecars = ['dictionary.csv', 'excluded-columns.json', 'value-labels.json', 'stata-missing-codes.json']
        save(cls.actual / 'manifest.json', {'status': 'PASS', 'random_noise_added': False, 'source_sha256': 'f' * 64,
                                         'rows': len(frame), 'columns': len(frame.columns), 'column_names': list(frame.columns),
                                         'parts': records, 'year_counts': {'2010': 4, '2011': 4},
                                         'metadata_files': [{'path': p, 'sha256': sha(cls.actual / p)} for p in sidecars]})
        cls.before = {p.name: sha(p) for p in cls.actual.iterdir()}
        with contextlib.redirect_stdout(io.StringIO()):
            build(cls.actual, cls.stage, cls.key)
            attach(cls.stage, cls.dev, cls.key, root / 'private' / 'map.csv')

    @classmethod
    def tearDownClass(cls):
        cls.temp.cleanup()

    def test_source_never_changes(self):
        self.assertEqual(self.before, {p.name: sha(p) for p in self.actual.iterdir()})

    def test_real_values_change_but_code_and_null_structure_do_not(self):
        a = load_data(mode='actual', actual_path=self.actual, development_path=self.dev)
        d = load_data(development_path=self.dev)
        self.assertEqual(list(a.columns), list(d.columns))
        self.assertEqual(a.dtypes.astype(str).to_dict(), d.dtypes.astype(str).to_dict())
        pd.testing.assert_frame_equal(a[['workers', 'export_any_binary', 'val_costrd', 'raw_dprovi10']], d[['workers', 'export_any_binary', 'val_costrd', 'raw_dprovi10']])
        pd.testing.assert_frame_equal(a.isna(), d.isna())
        changed = a.gross_output_nominal.notna() & a.gross_output_nominal.ne(0)
        ratio = (d.loc[changed, 'gross_output_nominal'] / a.loc[changed, 'gross_output_nominal'] - 1).abs()
        self.assertTrue(ratio.between(.001 - 1e-12, .005 + 1e-12).all())

    def test_same_analysis_expression_and_derived_columns_agree(self):
        for mode in ['actual', 'development']:
            frame = load_data(mode=mode, actual_path=self.actual if mode == 'actual' else None, development_path=self.dev)
            np.testing.assert_allclose(frame.gross_output_nominal / frame.workers, frame.r_output_per_worker_nominal, equal_nan=True)
            good = frame.gross_output_nominal > 0
            np.testing.assert_allclose(np.log(frame.loc[good, 'gross_output_nominal']), frame.loc[good, 'ln_output_nominal'])

    def test_observation_ids_match_actual_and_development_but_psid_is_not_invented(self):
        a = load_data(mode='actual', actual_path=self.actual, development_path=self.dev)
        d = load_data(development_path=self.dev)
        self.assertTrue(d.obs_id.is_unique)
        self.assertEqual(a.obs_id.tolist(), d.obs_id.tolist())
        self.assertTrue(d.psid.isna().all())
        self.assertTrue(d.psid_status.eq('unverified_no_longitudinal_crosswalk').all())

    def test_wave_filter_preserves_identity(self):
        d = load_data(development_path=self.dev)
        s = load_data(development_path=self.dev, years=2011, columns=['obs_id', 'gross_output_nominal'])
        self.assertEqual(s.obs_id.tolist(), d.loc[d.source_year.eq(2011), 'obs_id'].tolist())
        a = load_data(mode='actual', actual_path=self.actual, development_path=self.dev, years=2011, columns=['obs_id'])
        self.assertEqual(a.obs_id.tolist(), s.obs_id.tolist())

    def test_noise_is_independent_of_storage_chunk_boundaries(self):
        key = bytes(range(32))
        combined = factors(key, 'parent', 0, 8)
        split = np.concatenate([factors(key, 'parent', 0, 3), factors(key, 'parent', 3, 5)])
        np.testing.assert_array_equal(combined, split)

    def test_non_numeric_missing_tokens_and_zero_survive(self):
        source = pd.Series(['1,000', '***', '', None, '0', '-250', 'N/A'])
        actual, _ = transform_column(source, classify('raw_output10'), np.full(7, 1.003))
        self.assertAlmostEqual(float(actual.iloc[0]), 1003.)
        self.assertAlmostEqual(float(actual.iloc[5]), -250.75)
        self.assertEqual(actual.iloc[[1, 2, 3, 4, 6]].tolist(), source.iloc[[1, 2, 3, 4, 6]].tolist())

    def test_structural_counts_and_treatment_are_not_noised(self):
        for name in ['source_year', 'workers', 'val_costrd', 'raw_costrd17', 'psid', 'r_total_gj_s1_n', 'export_any_binary', 'identity_real_link_verified']:
            self.assertEqual(classify(name)['action'], 'preserve', name)

    def test_actual_mode_requires_explicit_input_and_rejects_development(self):
        with self.assertRaisesRegex(ValueError, 'explicit'):
            load_data(mode='actual', development_path=self.dev)
        with self.assertRaisesRegex(ValueError, 'refuses'):
            load_data(mode='actual', actual_path=self.dev, development_path=self.dev)

    def test_panel_and_unavailable_wave_fail_clearly(self):
        with self.assertRaisesRegex(ValueError, 'Panel identity'):
            load_data(development_path=self.dev, require_panel=True)
        with self.assertRaisesRegex(ValueError, 'wave unavailable'):
            load_data(development_path=self.dev, years=2016)

    def test_finalisation_refuses_development_before_writing(self):
        d = load_data(development_path=self.dev)
        with self.assertRaisesRegex(ValueError, 'Finalisation refuses'):
            write_run_receipt(Path(self.temp.name) / 'bad-final.json', d, code_path=__file__, purpose='final')
        self.assertFalse((Path(self.temp.name) / 'bad-final.json').exists())

    def test_tampered_part_is_rejected(self):
        manifest = json.loads((self.dev / 'manifest.json').read_text())
        part = self.dev / manifest['parts'][0]['path']
        original = part.read_bytes()
        try:
            part.write_bytes(original + b'changed')
            with self.assertRaisesRegex(ValueError, 'hash mismatch'):
                load_data(development_path=self.dev)
        finally:
            part.write_bytes(original)

    def test_stata_export_keeps_ids_and_mode_label(self):
        frame = load_data(development_path=self.dev)
        path = Path(self.temp.name) / 'development-check.dta'
        export_data(frame, path)
        restored = pd.read_stata(path, convert_categoricals=False)
        self.assertEqual(restored.obs_id.tolist(), frame.obs_id.tolist())
        with pd.read_stata(path, iterator=True) as reader:
            self.assertEqual(reader.data_label, 'DEASY G0.5 DEVELOPMENT')

    def test_invalid_export_purpose_writes_nothing(self):
        target = Path(self.temp.name) / 'invalid-purpose.csv'
        with self.assertRaisesRegex(ValueError, 'purpose must'):
            export_data(load_data(development_path=self.dev), target, purpose='typo')
        self.assertFalse(target.exists())

    def test_private_material_is_rejected_inside_git_checkout(self):
        private = HERE.parents[1] / 'never-created.key'
        with self.assertRaises(ValueError):
            build(self.actual, Path(self.temp.name) / 'bad-key-build', private)
        with self.assertRaisesRegex(ValueError, 'Git checkout'):
            attach(self.stage, Path(self.temp.name) / 'bad-map-build', self.key, private)
        self.assertFalse(private.exists())


if __name__ == '__main__':
    unittest.main(verbosity=2)
