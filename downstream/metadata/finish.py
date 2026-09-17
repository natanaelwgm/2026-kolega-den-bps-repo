#!/usr/bin/env python3
"""Run E064-E066 metadata finishing; numerical parent is immutable."""
import argparse, json, os, shutil, subprocess, sys
from pathlib import Path
import pandas as pd
from compile_metadata import ROOT, VERSION, compile_metadata, sha, write_json

def finish(input_file, output_dir, work_dir):
    input_file=Path(input_file).resolve();public=Path(output_dir);work=Path(work_dir)
    public.mkdir(parents=True,exist_ok=True);work.mkdir(parents=True,exist_ok=True)
    final=public/'analysis_obscured_with_g1.dta'
    assert final.resolve()!=input_file, 'Do not overwrite the immutable numerical parent'
    before_hash=sha(input_file)
    print('E064 | compile reviewed labels and full variable notes',flush=True)
    rows,contract=compile_metadata(input_file,work/'contract')
    stage=work/'G1_labelled.dta'
    edge=ROOT/'downstream/dag/edges/E065_apply_variable_metadata.do'
    code=f'version 17\nset more off\ndo "{edge}" "{input_file}" "{work/"contract/labels_and_notes.do"}" "{stage}" "{work/"contract/verify_metadata.do"}"\ndisplay "FINISH_NATIVE_PASS"\n'
    (work/'00_finish.do').write_text(code)
    env=dict(os.environ,STATATMP=str(work))
    print('E065 | Stata labels, notes, idempotence and exact data comparison',flush=True)
    p=subprocess.run(['/Applications/Stata/StataSE.app/Contents/MacOS/stata-se','-b','do','00_finish.do'],cwd=work,env=env)
    log=(work/'00_finish.log').read_text(errors='replace')
    if p.returncode or '\nFINISH_NATIVE_PASS\n' not in log or '\nE065_METADATA_PASS\n' not in log:
        raise RuntimeError(log[-4500:])
    print('E066 | independent all-cell, schema, label and lineage validation',flush=True)
    before=pd.read_stata(input_file,convert_categoricals=False,convert_missing=True)
    after=pd.read_stata(stage,convert_categoricals=False,convert_missing=True)
    pd.testing.assert_frame_equal(before,after,check_exact=True)
    with pd.io.stata.StataReader(stage) as r:
        actual=r.variable_labels()
        assert actual=={d['name']:d['label'] for d in rows}
        value_labels_after=r.value_labels()
    with pd.io.stata.StataReader(input_file) as r:
        assert r.value_labels()==value_labels_after, 'Existing category labels must be preserved'
    assert sha(input_file)==before_hash
    # Publish only after validation. Preserve the input hash and executable metadata.
    shutil.copyfile(stage,final)
    shutil.copytree(work/'contract',public/'metadata',dirs_exist_ok=True)
    receipt=dict(status='PASS',version=VERSION,parent_file=str(input_file),parent_sha256=before_hash,
        final_file=str(final),final_sha256=sha(final),rows=len(after),columns=len(after.columns),
        cells_unchanged=int(after.size),all_values_types_order_missingness_unchanged=True,
        all_variable_labels_exact=True,all_variable_notes_verified_by_stata=True,
        existing_value_labels_preserved=True,idempotent_reapplication_passed=True,
        native_log_sha256=sha(work/'00_finish.log'),metadata_contract=contract,
        edge_sha256=sha(edge),finisher_sha256=sha(Path(__file__)),
        g1_reestimated=False,seed_changed=False)
    write_json(work/'VALIDATION.json',receipt)
    write_json(public/'metadata/VALIDATION.json',{k:v for k,v in receipt.items() if k not in ['parent_file','final_file']})
    print('FINISH PASS | '+str(len(rows))+' labels and notes; '+str(after.size)+' cells unchanged',flush=True)
    return receipt

if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('input',type=Path);p.add_argument('output',type=Path);p.add_argument('--work',type=Path,required=True)
    a=p.parse_args();finish(a.input,a.output,a.work)
