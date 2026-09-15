"""The owner's synthetic DTA exception must not weaken the original-data publication boundary."""
import unittest,tempfile,hashlib
from pathlib import Path
from manage import ROOT,synthetic_publication_allowed
class PublicationBoundary(unittest.TestCase):
 def test_exact_file_hash_kind_and_scope(self):
  with tempfile.TemporaryDirectory(dir=ROOT/'data/synthetic-development/g0-pipeline') as d:
   p=Path(d)/'fictional.dta';p.write_bytes(b'fictional-test');rel=str(p.relative_to(ROOT));r={rel:{'kind':'executed_synthetic_Stata_state','sha256':hashlib.sha256(p.read_bytes()).hexdigest()}}
   self.assertTrue(synthetic_publication_allowed(p,r))
   self.assertFalse(synthetic_publication_allowed(p,{}))
   r[rel]['kind']='actual_WPI_reference_no_company_observations';self.assertFalse(synthetic_publication_allowed(p,r))
   r[rel]['kind']='unknown';self.assertFalse(synthetic_publication_allowed(p,r));r[rel]['kind']='executed_synthetic_Stata_state'
   p.write_bytes(b'changed');self.assertFalse(synthetic_publication_allowed(p,r))
  with tempfile.TemporaryDirectory(dir=ROOT/'harness') as d:
   p=Path(d)/'other.dta';p.write_bytes(b'fictional-test');r={str(p.relative_to(ROOT)):{'kind':'executed_synthetic_Stata_state','sha256':hashlib.sha256(p.read_bytes()).hexdigest()}}
   self.assertFalse(synthetic_publication_allowed(p,r))
if __name__=='__main__':unittest.main()
