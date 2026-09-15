"""Mocked runner only: no Stata or real foundation cleanup."""
import importlib.util, json, tempfile, unittest, datetime, hashlib
from pathlib import Path
from unittest.mock import patch
sp=importlib.util.spec_from_file_location('outer',Path(__file__).parents[1]/'run_reviewed_preparation.py')
o=importlib.util.module_from_spec(sp);sp.loader.exec_module(o)

class OuterTests(unittest.TestCase):
    def setUp(self):
        self.t=tempfile.TemporaryDirectory();self.base=Path(self.t.name).resolve();self.root=self.base/'foundation';self.root.mkdir()
        (self.root/'runtime').mkdir();(self.root/'registry').mkdir()
        self.ids=['T000']+['F'+str(i) for i in range(15)]+['H090']
        self.stages=[{'id':x,'path':'code/'+x+'.do'} for x in self.ids]
        (self.root/'registry/stages.json').write_text(json.dumps(self.stages));(self.root/'implementation-manifest.json').write_text('{}')
        (self.root/'run_preparation.command').write_text('# synthetic only')
        self.helper=o.load_helper(hashlib.sha256(o.HELPER.read_bytes()).hexdigest());self.hs=self.helper.sha(o.HELPER);self.ms=self.helper.sha(self.root/'implementation-manifest.json')
        self.arc=self.base/'archive';self.calls=[]
    def tearDown(self):self.t.cleanup()
    def prepare(self,root,archive,msha,dry_run=False):
        if dry_run:return {'active_status':'passed','generated':[]}
        archive.mkdir();return {'status':'READY_FOR_FULL_RERUN'}
    def runner(self,cmd,check):
        sid=cmd[3];self.calls.append(sid);idx=self.ids.index(sid);ap='runtime/run-20990101T0000'+f'{idx:02}'
        p=self.root/ap/sid;p.mkdir(parents=True)
        r={'stage':sid,'status':'passed','owned_process_exited':True,'exit_code':0,'success_marker_present':True,'implementation_manifest_sha256':self.ms,
           'started_utc':datetime.datetime.now(datetime.timezone.utc).isoformat(),'attempt':ap+'/'+sid,'actual_stage_path':'code/'+sid+'.do','input_code_hashes_unchanged':True}
        data=json.dumps(r).encode();(p/'receipt.json').write_bytes(data);(self.root/'runtime'/f'{sid}-latest.json').write_bytes(data)
        if sid=='H090':
            f=dict(r,attempt=ap,output_hashes=[]);b=json.dumps(f).encode();(self.root/ap/'receipt.json').write_bytes(b);(self.root/'runtime/latest.json').write_bytes(b)
    def test_all_17_fresh_calls_then_compaction(self):
        with patch.object(o,'load_helper',return_value=self.helper),patch.object(self.helper,'prepare',side_effect=self.prepare),patch.object(self.helper,'compact_stage',return_value={'status':'COMPLETE_LOGS_COLD_EXACT_BYTES'}) as compact,patch.object(o.subprocess,'run',side_effect=self.runner):
            out=o.run(self.root,self.arc,self.ms,self.hs,True)
        self.assertEqual(out['status'],'PASSED_FRESH_17_STAGE_REPLAY');self.assertEqual(self.calls,self.ids);self.assertEqual(compact.call_count,17)
    def test_old_receipt_rejected(self):
        self.runner(['/bin/zsh','unused','--from-stage','T000'],True);o.h=self.helper
        prior=self.helper.sha(self.root/'runtime/T000-latest.json')
        with self.assertRaises(RuntimeError):o.fresh_stage(self.root,'T000',prior,datetime.datetime.now(datetime.timezone.utc),self.ms,'code/T000.do')
    def test_wrong_helper_rejected_before_import(self):
        with self.assertRaises(RuntimeError):o.load_helper('0'*64)

if __name__=='__main__':unittest.main(verbosity=2)
