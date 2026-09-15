"""Berkas buatan saja; tidak membuka data perusahaan atau menjalankan Stata."""
import importlib.util, json, tempfile, unittest, hashlib, fcntl, os, uuid
from pathlib import Path
from unittest.mock import patch
from types import SimpleNamespace
SPEC = importlib.util.spec_from_file_location('replay', Path(__file__).parents[1] / 'replay_preparation.py')
a = importlib.util.module_from_spec(SPEC); SPEC.loader.exec_module(a)

def put(p, data):
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_bytes(data if isinstance(data, bytes) else (json.dumps(data) + '\n').encode())


class ReplayTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix='replay-toy-')
        self.base = Path(self.temp.name).resolve(); self.root = self.base / 'foundation'; self.root.mkdir()
        (self.base / 'G0-rebuild/runtime').mkdir(parents=True)
        self.nostata = patch.object(a, 'no_stata'); self.nostata.start()
        self.space = patch.object(a.shutil, 'disk_usage', return_value=SimpleNamespace(free=100 * a.GIB)); self.space.start()
        r = self.root
        put(r/'code/science.do', b'display "synthetic fixture only"\n')
        put(self.base/'original.fixture', b'original source bytes')
        put(r/'reference.fixture', b'primitive reference')
        f={'status':'READY_FOR_IMPLEMENTATION','files':[]}; put(r/'plan-freeze.json',f)
        paths=['data/analysis/G0_analysis_ready.dta']+[f'data/waves/wave_{y}.dta' for y in range(2010,2023) if y!=2016]
        for i,p in enumerate(paths):put(r/p, (f'synthetic bytes {i}\n'*100).encode())
        put(r/'data/child.dta', b'synthetic child')
        nodes=[{'path':p,'role':'company','producer':'toy'} for p in paths+['data/child.dta']]
        nodes.extend([{'path':'reference.fixture','role':'reference','producer':None},
                      {'path':'reference.fixture','role':'company','producer':'collision'},
                      {'path':'code/science.do','role':'company','producer':'collision'},
                      {'path':str(self.base/'original.fixture'),'role':'upstream_raw','producer':None}])
        put(r/'registry/dag.json',{'nodes':nodes,'edges':[]})
        m={'plan_freeze_sha256':a.sha(r/'plan-freeze.json'),
           'code_files':[{'path':'code/science.do','sha256':a.sha(r/'code/science.do')}],
           'input_files':[{'path':str(self.base/'original.fixture'),'sha256':a.sha(self.base/'original.fixture')} ]}
        put(r/'implementation-manifest.json',m); self.mh=a.sha(r/'implementation-manifest.json')
        put(r/'implementation-review/static-review.json',{'status':'PASS','implementation_manifest_sha256':self.mh})
        out=[{'path':p,'sha256':a.sha(r/p),'bytes':(r/p).stat().st_size} for p in paths]
        put(r/'runtime/wave-output-manifest.json',{'status':'passed','parent_process_exited':True,'master':out[0],'waves':out[1:]})
        self.attempt='runtime/run-20260913T010101Z'
        overall={'status':'passed','owned_process_exited':True,'pid':999999999,'exit_code':0,'success_marker_present':True,
                 'attempt':self.attempt,'implementation_manifest_sha256':self.mh,'output_hashes':out}
        put(r/'runtime/latest.json',overall);put(r/self.attempt/'receipt.json',overall)
        self.receipt=self.attempt+'/F010/receipt.json'
        self.entry='run_WF_20260913T010101Z_F010.do'
        put(r/self.entry,b'* generated fixture entry\n')
        self.batch=r/self.attempt/'F010/batch.log';put(self.batch,b'complete synthetic log\n'*100)
        self.hot=r/Path(self.entry).with_suffix('.log');put(self.hot,self.batch.read_bytes())
        put(self.batch.parent/'console.log',b'')
        stage={'status':'passed','owned_process_exited':True,'pid':999999999,'exit_code':0,'success_marker_present':True,
               'implementation_manifest_sha256':self.mh,'attempt':str(self.batch.parent.relative_to(r)), 'entry':self.entry,
               'disk_samples':[{'bytes':1000}],
               'batch_relay':{'status':'passed','sha256':a.sha(self.batch),'bytes_streamed':self.batch.stat().st_size},
               'console_relay':{'status':'passed','sha256':hashlib.sha256(b'').hexdigest(),'bytes_streamed':0}}
        put(r/self.receipt,stage);put(r/'runtime/F010-latest.json',stage)
        self.arc=self.base/'cold archive'
    def tearDown(self):
        self.space.stop(); self.nostata.stop(); self.temp.cleanup()
    def digest_tree(self):
        return {str(p.relative_to(self.base)):a.sha(p) for p in self.base.rglob('*') if p.is_file()}
    def test_archive_restore_roundtrip_and_sources_preserved(self):
        before=a.sha(self.root/'data/analysis/G0_analysis_ready.dta')
        out=a.prepare(self.root,self.arc,self.mh)
        self.assertEqual(out['status'],'READY_FOR_FULL_RERUN')
        self.assertFalse((self.root/'data/child.dta').exists())
        self.assertTrue((self.root/'runtime/latest.json').exists())
        self.assertTrue((self.root/'code/science.do').exists())
        self.assertTrue((self.root/'reference.fixture').exists())
        a.restore(self.arc,'data/analysis/G0_analysis_ready.dta')
        self.assertEqual(a.sha(self.root/'data/analysis/G0_analysis_ready.dta'),before)
    def test_dry_run_writes_nothing(self):
        before=self.digest_tree();a.prepare(self.root,self.arc,self.mh,True)
        self.assertEqual(self.digest_tree(),before);self.assertFalse(self.arc.exists())
    def test_protected_nodes_excluded(self):
        x=a.inventory(self.root,self.mh)
        self.assertEqual(x['excluded_protected_generated'],['code/science.do','reference.fixture'])
    def test_symlink_rejected(self):
        p=self.root/'data/child.dta';p.unlink();p.symlink_to(self.base/'original.fixture')
        with self.assertRaises(RuntimeError):a.inventory(self.root,self.mh)
    def test_external_produced_path_rejected(self):
        p=self.root/'registry/dag.json'; j=json.loads(p.read_text());j['nodes'].append({'path':str(self.base/'original.fixture'),'producer':'bad','role':'company'});put(p,j)
        with self.assertRaises(RuntimeError):a.inventory(self.root,self.mh)
    def test_busy_lock_no_mutation(self):
        lock=self.base/'G0-rebuild/runtime/stata-owned.lock'
        with lock.open('a+') as f:
            fcntl.flock(f,fcntl.LOCK_EX|fcntl.LOCK_NB)
            with self.assertRaises(BlockingIOError):a.prepare(self.root,self.arc,self.mh)
        self.assertFalse(self.arc.exists())
    def test_running_receipt_no_archive(self):
        p=self.root/'runtime/latest.json';j=json.loads(p.read_text());j['status']='running';put(p,j)
        with self.assertRaises(RuntimeError):a.prepare(self.root,self.arc,self.mh)
        self.assertFalse(self.arc.exists())
    def test_changed_hot_not_released(self):
        plan=a.inventory(self.root,self.mh);self.arc.mkdir();(self.arc/'objects').mkdir()
        p=self.root/'data/child.dta';item=a.save_object(p,self.arc);p.write_bytes(b'changed')
        with self.assertRaises(RuntimeError):a.release_hot(self.root,'data/child.dta',item,self.arc,plan)
        self.assertEqual(p.read_bytes(),b'changed')
    def test_corrupt_archive_does_not_lose_hot(self):
        plan=a.inventory(self.root,self.mh);self.arc.mkdir();(self.arc/'objects').mkdir()
        p=self.root/'data/child.dta';item=a.save_object(p,self.arc);(self.arc/item['object']).write_bytes(b'bad gzip')
        with self.assertRaises(Exception):a.release_hot(self.root,'data/child.dta',item,self.arc,plan)
        self.assertTrue(p.exists())
    def test_dedupe_exact_complete_copy(self):
        x=a.dedupe_log(self.root,self.receipt,self.base/'dedupe.json')
        self.assertEqual(x['status'],'DUPLICATE_REMOVED_COMPLETE_ATTEMPT_LOG_RETAINED')
        self.assertFalse(self.hot.exists());self.assertTrue(self.batch.exists())
    def test_dedupe_different_log_rejected(self):
        self.hot.write_bytes(b'different')
        with self.assertRaises(RuntimeError):a.dedupe_log(self.root,self.receipt,self.base/'dedupe.json')
        self.assertTrue(self.hot.exists());self.assertTrue(self.batch.exists())
    def test_dedupe_dry_run_no_write(self):
        before=self.digest_tree();a.dedupe_log(self.root,self.receipt,self.base/'dedupe.json',True)
        self.assertEqual(before,self.digest_tree())
    def test_dedupe_running_receipt_rejected(self):
        p=self.root/self.receipt;j=json.loads(p.read_text());j['owned_process_exited']=False;put(p,j)
        with self.assertRaises(RuntimeError):a.dedupe_log(self.root,self.receipt,self.base/'dedupe.json')
        self.assertTrue(self.hot.exists())
    def test_compact_logs_one_full_object_per_content(self):
        x=a.compact_stage(self.root,self.receipt,self.arc,self.mh)
        self.assertEqual(x['status'],'COMPLETE_LOGS_COLD_EXACT_BYTES')
        i=x['logical_paths'];self.assertEqual(i[str(self.hot.relative_to(self.root))]['object'],i[str(self.batch.relative_to(self.root))]['object'])
        self.assertFalse(self.hot.exists());self.assertFalse(self.batch.exists());self.assertTrue((self.root/self.receipt).exists())
        a.restore(self.arc,str(self.batch.relative_to(self.root)));self.assertEqual(self.batch.read_bytes(),b'complete synthetic log\n'*100)
    def tmp_case(self, content=None):
        stage='FAKE'+uuid.uuid4().hex
        attempt='runtime/run-20991231T235959Z/'+stage
        entry='run_WF_20991231T235959Z_'+stage+'.do'
        r=json.loads((self.root/self.receipt).read_text());r.update(attempt=attempt,entry=entry)
        put(self.root/entry,b'* synthetic entry only')
        put(self.root/attempt/'batch.log',self.batch.read_bytes())
        put(self.root/Path(entry).with_suffix('.log'),self.batch.read_bytes())
        t=Path('/private/tmp')/Path(entry).with_suffix('.log').name
        r['batch_relay']['source_path']=str(t)
        with t.open('xb') as f:f.write(self.batch.read_bytes() if content is None else content)
        self.addCleanup(lambda:t.unlink(missing_ok=True))
        rp=attempt+'/receipt.json';put(self.root/rp,r)
        return rp,t
    def test_absolute_old_peak_does_not_block_new_readiness(self):
        p=self.root/self.receipt;j=json.loads(p.read_text());j['disk_samples']=[{'bytes':11148120957}];put(p,j)
        put(self.root/'runtime/F010-latest.json',j)
        x=a.prepare(self.root,self.arc,self.mh)
        self.assertEqual(x['status'],'READY_FOR_FULL_RERUN')
        self.assertEqual(x['observed_prior_peak_bytes_diagnostic_only'],11148120957)
        self.assertEqual(x['required_free_bytes'],22*a.GIB+2*x['largest_observed_completed_batch_log_bytes'])
    def test_reused_unrelated_pid_does_not_block_exited_receipt(self):
        a.completed({'status':'passed','owned_process_exited':True,'exit_code':0,'success_marker_present':True,'pid':os.getpid()},True)
    def test_exact_private_tmp_archive_restore(self):
        rp,t=self.tmp_case();expected=t.read_bytes()
        x=a.compact_stage(self.root,rp,self.arc,self.mh)
        key='external_private_tmp/'+t.name
        self.assertFalse(t.exists());self.assertIn(key,x['logical_paths'])
        a.restore(self.arc,key);self.assertEqual(t.read_bytes(),expected)
    def test_private_tmp_hash_mismatch_preserves_everything(self):
        rp,t=self.tmp_case(b'wrong log')
        with self.assertRaises(RuntimeError):a.compact_stage(self.root,rp,self.arc,self.mh)
        self.assertTrue(t.exists());self.assertFalse(self.arc.exists())
    def test_unobserved_tmp_alias_never_deleted(self):
        rp,t=self.tmp_case();p=self.root/rp;j=json.loads(p.read_text());j['batch_relay']['source_path']='/tmp/'+t.name;put(p,j)
        a.compact_stage(self.root,rp,self.arc,self.mh)
        self.assertTrue(t.exists())
    def test_private_tmp_symlink_rejected_without_target_loss(self):
        rp,t=self.tmp_case();t.unlink();t.symlink_to(self.base/'original.fixture')
        with self.assertRaises(RuntimeError):a.compact_stage(self.root,rp,self.arc,self.mh)
        self.assertTrue((self.base/'original.fixture').exists());self.assertFalse(self.arc.exists())
    def test_insufficient_free_space_is_explicit_and_archive_restores(self):
        a.shutil.disk_usage.return_value=SimpleNamespace(free=21*a.GIB)
        x=a.prepare(self.root,self.arc,self.mh)
        self.assertEqual(x['status'],'ARCHIVED_BUT_SPACE_INSUFFICIENT')
        a.restore(self.arc,'data/child.dta');self.assertEqual((self.root/'data/child.dta').read_bytes(),b'synthetic child')
    def test_active_stata_gate_blocks_before_archive_creation(self):
        a.no_stata.side_effect=RuntimeError('synthetic active Stata fixture')
        with self.assertRaises(RuntimeError):a.prepare(self.root,self.arc,self.mh)
        self.assertFalse(self.arc.exists());self.assertTrue((self.root/'data/child.dta').exists())
    def install_continuity(self, numeric=False):
        r=self.root; oldmanifest=(r/'implementation-manifest.json').read_bytes(); oldhash=self.mh
        oldcode=(r/'code/science.do').read_bytes();put(r/'provenance/old-manifest.json',oldmanifest);put(r/'provenance/old-science.do',oldcode)
        put(r/'code/science.do',oldcode+(b'display 42\n' if numeric else b'* new human explanation // WFDOC-INJECTED\n'))
        m=json.loads(oldmanifest);m['code_files'][0]['sha256']=a.sha(r/'code/science.do');put(r/'implementation-manifest.json',m);self.mh=a.sha(r/'implementation-manifest.json')
        delta={'status':'PASS_ROOT_REVIEWED_COMMENT_METADATA_CONTINUITY','old_implementation_manifest_sha256':oldhash,'current_implementation_manifest_sha256':self.mh,
          'changed_files':[{'path':'code/science.do','old_sha256':hashlib.sha256(oldcode).hexdigest(),'new_sha256':a.sha(r/'code/science.do'),'kind':'comments_only','old_preserved_path':'provenance/old-science.do'}]}
        put(r/'provenance/delta.json',delta)
        desc={'status':'PASS_FOR_ARCHIVING_PRIOR_COMPLETED_RUN','reviewer':'/root','current_implementation_manifest_sha256':self.mh,'prior_execution_manifest_path':'provenance/old-manifest.json','prior_execution_manifest_sha256':oldhash,
          'final_receipt_path':self.attempt+'/receipt.json','final_receipt_sha256':a.sha(r/'runtime/latest.json'),'wave_output_manifest_sha256':a.sha(r/'runtime/wave-output-manifest.json'),
          'reviewed_delta_manifest_path':'provenance/delta.json','reviewed_delta_manifest_sha256':a.sha(r/'provenance/delta.json'),'delta_classes':['comments_only'],'reviewed_metadata_paths':[]}
        put(r/'implementation-review/static-review.json',{'status':'PASS','implementation_manifest_sha256':self.mh,'storage_replay_continuity':desc})
    def test_exact_reviewed_comment_continuity_accepts_archival(self):
        self.install_continuity();x=a.prepare(self.root,self.arc,self.mh)
        self.assertEqual(x['storage_replay_continuity']['complete_changed_file_count'],1)
    def test_seal_difference_without_descriptor_rejected(self):
        self.install_continuity();put(self.root/'implementation-review/static-review.json',{'status':'PASS','implementation_manifest_sha256':self.mh})
        with self.assertRaises(RuntimeError):a.prepare(self.root,self.arc,self.mh)
        self.assertFalse(self.arc.exists())
    def test_numeric_change_cannot_claim_comments_only(self):
        self.install_continuity(True)
        with self.assertRaises(RuntimeError):a.prepare(self.root,self.arc,self.mh)
        self.assertFalse(self.arc.exists())
    def test_unpinned_delta_rejected(self):
        self.install_continuity();p=self.root/'provenance/delta.json';j=json.loads(p.read_text());j['changed_files']=[];put(p,j)
        with self.assertRaises(RuntimeError):a.prepare(self.root,self.arc,self.mh)
        self.assertFalse(self.arc.exists())
    def test_restore_no_overwrite(self):
        a.prepare(self.root,self.arc,self.mh);p=self.root/'data/child.dta';p.write_bytes(b'new rerun')
        with self.assertRaises(RuntimeError):a.restore(self.arc,'data/child.dta')
        self.assertEqual(p.read_bytes(),b'new rerun')
    def test_seal_drift_rejected(self):
        with self.assertRaises(RuntimeError):a.prepare(self.root,self.arc,'0'*64)
        self.assertFalse(self.arc.exists())

if __name__=='__main__':unittest.main(verbosity=2)
