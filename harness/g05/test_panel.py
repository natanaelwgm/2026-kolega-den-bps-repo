"""Behavior tests for fictional panel assignment; no real observations embedded."""
import unittest
import sys
from pathlib import Path

import numpy as np
import pandas as pd

sys.path.insert(0, str(Path(__file__).resolve().parent))
from panel_generator import FEATURES, generate, choose_pairs, normalise
from prepare_external_identity import reusable_ids


def fixture():
    records = []
    for year, count in [(2014, 5), (2015, 3), (2017, 4)]:
        for province in ['31', '32']:
            for sector in ['10100', '20100']:
                for i in range(count):
                    row = dict(obs_id=f'obs_{year}_{province}_{sector}_{i}', source_year=year,
                               province_code=province, industry_code=sector)
                    row.update({name: (i + 1.) * (k + 1.) for k, name in enumerate(FEATURES)})
                    records.append(row)
    return pd.DataFrame(records)


class PanelTests(unittest.TestCase):
    def test_hard_blocks_one_to_one_and_calendar_gap(self):
        original = fixture(); panel, report = generate(original)
        joined = panel.merge(original[['obs_id','province_code','industry_code']], on='obs_id', validate='one_to_one')
        self.assertTrue(panel.psid.notna().all())
        self.assertFalse(panel.duplicated(['psid','source_year']).any())
        self.assertTrue(joined.groupby('psid').province_code.nunique().eq(1).all())
        self.assertTrue(joined.groupby('psid').industry_code.nunique().eq(1).all())
        self.assertTrue(report['matched_links'] > 0)
        links = panel[panel.dev_prev_obs_id.ne('')]
        self.assertEqual(set(links.loc[links.source_year.eq(2017), 'dev_prev_year']), {2015.})
        self.assertNotIn(2016, set(panel.source_year))
        self.assertEqual(len(panel), len(original))
        self.assertTrue(panel.psid.le(2**48).all())
        self.assertTrue(panel.psid.eq(panel.psid.astype('int64')).all())

    def test_reorder_and_partition_reassembly_are_exact(self):
        original = fixture()
        shuffled = pd.concat([original.iloc[::2], original.iloc[1::2]]).sample(frac=1, random_state=4)
        a, _ = generate(original); b, _ = generate(shuffled)
        pd.testing.assert_frame_equal(a.sort_values('obs_id').reset_index(drop=True),
                                      b.sort_values('obs_id').reset_index(drop=True))

    def test_optional_unmatched_does_not_force_bad_pairs(self):
        distance = np.array([[.02, .95], [.80, .90], [.7, .8]])
        self.assertEqual(choose_pairs(distance, distance, .25), [(0, 0)])
        self.assertEqual(choose_pairs(np.array([[np.inf]]), np.array([[np.inf]]), .25), [])

    def test_invalid_codes_and_missing_features_do_not_link(self):
        frame = fixture()
        frame['industry_code'] = '1010'
        panel, report = generate(frame)
        self.assertEqual(panel.psid.nunique(), len(panel))
        self.assertEqual(report['invalid_code_rows'], len(panel))
        frame = fixture(); frame[list(FEATURES)[2:]] = np.nan
        panel, report = generate(frame)
        self.assertEqual(panel.psid.nunique(), len(panel))
        self.assertEqual(report['insufficient_feature_rows'], len(panel))

    def test_zero_is_observed_and_seed_is_reproducible(self):
        frame = fixture(); frame[list(FEATURES)[-1]] = 0.
        a, _ = generate(frame, seed=123); b, _ = generate(frame, seed=123)
        pd.testing.assert_frame_equal(a, b)
        self.assertTrue(a.dev_n_features.eq(9).all())

    def test_repeated_observation_id_fails(self):
        frame = fixture(); frame.loc[1,'obs_id'] = frame.loc[0,'obs_id']
        with self.assertRaisesRegex(ValueError, 'unique'):
            generate(frame)

    def test_existing_complete_panel_is_reused_but_partial_or_row_ids_are_not(self):
        frame=fixture()
        frame['psid']=frame.groupby(['province_code','industry_code',frame.obs_id.str.rsplit('_',n=1).str[-1]]).ngroup()+100
        frame['psid_status']='synthetic_development'
        ids,decision=reusable_ids(frame)
        pd.testing.assert_series_equal(ids,frame.psid)
        self.assertEqual(decision[-1]['decision'],'reuse')
        partial=frame.copy();partial.loc[0,'psid']=np.nan
        self.assertIsNone(reusable_ids(partial)[0])
        row_only=frame.copy();row_only['psid']=np.arange(len(frame))
        self.assertIsNone(reusable_ids(row_only)[0])

    def test_frozen_excel_ranks_replay_after_downstream_measurement_noise(self):
        frame=fixture();_,ranks=normalise(frame)
        ranks.index=frame.obs_id
        expected,_=generate(frame)
        disturbed=frame.copy()
        rng=np.random.default_rng(4)
        for name in FEATURES:disturbed[name] *= rng.uniform(.3,4,len(frame))
        replay,_=generate(disturbed,rank_inputs=ranks)
        pd.testing.assert_frame_equal(expected,replay)
        disturbed.loc[0,'workers']=np.nan
        with self.assertRaisesRegex(ValueError,'availability'):
            generate(disturbed,rank_inputs=ranks)


if __name__ == '__main__':
    unittest.main(verbosity=2)
