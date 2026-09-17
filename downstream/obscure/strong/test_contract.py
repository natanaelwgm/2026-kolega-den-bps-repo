"""Focused boundary and authenticated-recovery regression tests; fixture seed only."""
import tempfile,unittest
from pathlib import Path
import numpy as np,pandas as pd
from cryptography.exceptions import InvalidTag
from seeded import factor,encrypt_recovery,decrypt_recovery
from build import factor_frame

class MaskingContractTests(unittest.TestCase):
    seed=bytes(range(32))

    def test_draws_are_repeatable_bounded_and_variable_specific(self):
        for i in range(1000):
            a=factor(self.seed,'fixture-source',i,'money')
            self.assertEqual(a,factor(self.seed,'fixture-source',i,'money'))
            self.assertNotEqual(a,factor(self.seed,'fixture-source',i,'workers'))
            self.assertTrue(.2<=abs(a-1)<=.3)

    def test_integer_and_percentage_boundaries(self):
        d=pd.DataFrame({'obs_id':[f'T{i}' for i in range(12)],
          'workers':[0,1,2,3,4,5,80,100,101,120,1000,10000],
          'production_workers':[0,1,1,2,3,4,79,100,100,110,900,9000],
          'rd_workers':[0,0,1,1,1,2,3,7,10,100,100,100],
          'export_share_pct':[0,100,1,10,90,99,50,5,80,30,40,565.3],
          'foreign_ownership_pct':[0,100,1,9.99,10,99,50,5,80,30,40,60]})
        factors,columns,exceptions=factor_frame(d,[],self.seed,'fixture')
        for n in ['workers','production_workers','rd_workers']:
            v=np.where(d[n]>0,np.maximum(1,np.floor(d[n]*factors[columns[n]]+.5)),d[n])
            if n=='workers':
                total=v;np.testing.assert_array_equal(v>100,d[n]>100)
            else:self.assertTrue((v<=total).all())
        self.assertEqual(exceptions['workers'],3)
        for n in ['export_share_pct','foreign_ownership_pct']:
            y=np.where(~d[n].isin([0,100]),d[n]*factors[columns[n]],d[n])
            valid=d[n].between(0,100)
            self.assertTrue(((y[valid]>=0)&(y[valid]<=100)).all())
            if n=='foreign_ownership_pct':np.testing.assert_array_equal(y>=10,d[n]>=10)
            else:self.assertGreater(y[-1],100)

    def test_authenticated_exact_recovery(self):
        with tempfile.TemporaryDirectory() as t:
            p=Path(t)/'recover.aesgcm';original={'actual.dta':b'\0\1EXACT-ORIGINAL\xff','mapping':b'private'}
            encrypt_recovery(self.seed,original,p)
            self.assertEqual(decrypt_recovery(self.seed,p),original)
            with self.assertRaises(InvalidTag):decrypt_recovery(bytes(32),p)
            data=bytearray(p.read_bytes());data[-1]^=1;p.write_bytes(data)
            with self.assertRaises(InvalidTag):decrypt_recovery(self.seed,p)

if __name__=='__main__':unittest.main()
