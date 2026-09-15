"""Prove identity preparation can run from Excel with no G0 dataset or execution."""
import contextlib
import io
import json
from pathlib import Path
import sys
import tempfile
import unittest
from unittest.mock import patch

from openpyxl import Workbook
import pandas as pd

sys.path.insert(0,str(Path(__file__).resolve().parent))
from build_development import sha
from panel_generator import FEATURES
from prepare_external_identity import prepare
from replay_panel import validate_reused_identity


class ExternalIdentityTests(unittest.TestCase):
    def test_excel_only_before_g0_preserves_sources_and_produces_private_spine(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp);inventory=[]
            for year in [2014,2015]:
                path=root/f'synthetic-{year}.xlsx';wb=Workbook();ws=wb.active
                stems=['Dprovi','Disic5']+[x[2] for x in FEATURES.values()]
                ws.append([x+str(year)[-2:] for x in stems])
                for i in range(5):ws.append([31,10100]+[(i+1.)*(j+1) for j in range(len(FEATURES))])
                wb.save(path);wb.close()
                inventory.append({'year':year,'path':str(path),'sha256':sha(path),'sheet':'Sheet','max_row':6})
            ip=root/'inventory.json';ip.write_text(json.dumps(inventory))
            key=root/'local.key';key.write_bytes(bytes(range(32)))
            with patch('prepare_external_identity.inspect_g0',side_effect=AssertionError('G0 must not be required')):
                with contextlib.redirect_stdout(io.StringIO()):prepare(ip,key,root/'identity')
            m=json.loads((root/'identity/manifest.json').read_text())
            d=pd.read_parquet(root/'identity/private-identity-spine.parquet')
            self.assertTrue(m['private_only']);self.assertEqual(len(d),10)
            self.assertTrue(d.psid.notna().all());self.assertTrue(d.dev_identity_key.is_unique)
            self.assertFalse(d.duplicated(['psid','source_year']).any())
            for item in inventory:self.assertEqual(sha(Path(item['path'])),item['sha256'])

    def test_existing_g0_continuity_is_portable_and_original_id_values_stay_private(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp); inventory=[]; records=[]
            for year in [2014,2017]:
                path=root/f'synthetic-{year}.xlsx';wb=Workbook();ws=wb.active
                ws.append([x+str(year)[-2:] for x in ['Dprovi','Disic5']+[v[2] for v in FEATURES.values()]])
                for i in range(5):
                    ws.append([31,10100]+[(i+1.)*(j+1) for j in range(len(FEATURES))])
                    # Reverse existing associations across years, deliberately
                    # different from the feature-similarity matching result.
                    records.append(dict(source_year=year,source_row=i+1,province_code='31',industry_code='10100',
                                        psid=100+(i if year==2014 else 4-i),psid_status='verified'))
                wb.save(path);wb.close()
                inventory.append({'year':year,'path':str(path),'sha256':sha(path),'sheet':'Sheet','max_row':6})
            ip=root/'inventory.json';ip.write_text(json.dumps(inventory));key=root/'local.key';key.write_bytes(bytes(range(32)))
            g0=root/'G0.dta';original=pd.DataFrame(records);original.to_stata(g0,write_index=False,version=118)
            g0_hash=sha(g0)
            with contextlib.redirect_stdout(io.StringIO()):prepare(ip,key,root/'identity',g0)
            panel=pd.read_parquet(root/'identity/private-identity-spine.parquet')
            report=json.loads((root/'identity/identity-report.json').read_text())
            self.assertEqual(report['identity_workflow'],'reuse_existing')
            joined=panel.merge(original,on=['source_year','source_row'],suffixes=('','_original'),validate='one_to_one')
            self.assertTrue(joined.groupby('psid_original').psid.nunique().eq(1).all())
            self.assertTrue(joined.groupby('psid').psid_original.nunique().eq(1).all())
            self.assertFalse(set(joined.psid) & set(joined.psid_original))
            self.assertEqual(validate_reused_identity(panel,panel),{'synthetic_firms':5,'matched_links':5})
            bad=panel.copy();linked=bad.index[bad.dev_prev_obs_id.ne('')][0];bad.loc[linked,'dev_prev_obs_id']='wrong'
            with self.assertRaisesRegex(ValueError,'predecessor'):validate_reused_identity(panel,bad)
            self.assertEqual(sha(g0),g0_hash)

    def test_cached_workflow_can_wait_for_g0_without_execution(self):
        from external_workflow import run
        from build_development import save
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp);spine=root/'spine';spine.mkdir();source=root/'source.xlsx';source.write_bytes(b'fixture')
            (spine/'private-identity-spine.parquet').write_bytes(b'checked-cache-fixture')
            save(spine/'identity-report.json',{'source_excel':[{'year':2014,'source_sha256':sha(source)}],
                                             'rows':1,'identity_workflow':'generate_external_identity'})
            save(spine/'manifest.json',{'status':'PASS','identity_spine_sha256':sha(spine/'private-identity-spine.parquet'),
                                       'report_sha256':sha(spine/'identity-report.json')})
            save(root/'inventory.json',[{'year':2014,'path':str(source)}])
            save(root/'config.json',{'identity_output':str(spine),'g0_master':str(root/'not-yet.dta'),
                                     'excel_inventory':str(root/'inventory.json')})
            with patch('external_workflow.prepare',side_effect=AssertionError('Do not rebuild accepted identity')):
                result=run(root/'config.json','all',root/'receipt.json')
            self.assertEqual(result['status'],'IDENTITY_READY_AWAITING_G0_OUTPUT')
            self.assertFalse(result['g0_executed']);self.assertFalse(result['g0_modified'])
            source.write_bytes(b'changed-input')
            with self.assertRaisesRegex(ValueError,'Excel sources changed'):
                run(root/'config.json','all',root/'receipt-2.json')


if __name__=='__main__':unittest.main(verbosity=2)
