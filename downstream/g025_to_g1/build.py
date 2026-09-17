#!/usr/bin/env python3
"""Local G0 -> G0.25 independent masking -> G0.5 panel -> freshly estimated G1."""
import os
for key in ['OPENBLAS_NUM_THREADS', 'OMP_NUM_THREADS', 'MKL_NUM_THREADS']:
    os.environ[key] = '1'
import argparse
import datetime
import json
import re
import shutil
import subprocess
import sys
import time
import uuid
from pathlib import Path
import pandas as pd

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'downstream/obscure/strong'))
from seeded import sha
from build import stata, write, log
sys.path.insert(0, str(ROOT / 'downstream/metadata'))
from finish import finish as finish_metadata
from data_guide import write_data_guide

VERSION = 'g025-mask-g05-panel-g1-v1'


def source_files():
    files = list((ROOT / 'downstream/obscure/strong').glob('*.py'))
    files += list((ROOT / 'downstream/g025_to_g1').glob('*.py'))
    files += list((ROOT / 'downstream/metadata').glob('*.py'))
    files += list((ROOT / 'downstream/dag/edges').glob('E06*.do'))
    files += [ROOT / 'downstream/contracts/variable_year_evidence.csv']
    files += list((ROOT / 'harness/g05').glob('*.py'))
    files += list((ROOT / 'work-items/G1').glob('*.py'))
    files += list((ROOT / 'work-items/G1').glob('*.json'))
    files += [p for p in (ROOT / 'work-items/G1/stata').rglob('*')
              if p.is_file() and p.suffix in ['.do', '.ado', '.py', '.json']]
    return sorted(set(files))


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('output_root', type=Path)
    p.add_argument('--resume', type=Path, help='Resume this runner at its existing immutable stages; no source overrides')
    p.add_argument('--source-receipt',type=Path,default=ROOT/'downstream/reports/latest-build.json')
    p.add_argument('--masking-receipt',type=Path,help='Use the separately completed masking/panel stage for these exact source inputs')
    p.add_argument('--seed-file',type=Path,help='Owner-retained masking seed; used only when building a new masking stage')
    p.add_argument('--latest-receipt',type=Path,default=ROOT/'downstream/g025_to_g1/latest.json')
    a = p.parse_args()
    a.output_root.mkdir(parents=True, exist_ok=True)
    if shutil.disk_usage(a.output_root).free < 5 * 1024**3:
        raise RuntimeError('Need 5 GiB temporary/output headroom on output volume')
    run = a.resume or a.output_root / (datetime.datetime.now().strftime('%Y%m%d-%H%M%S') + '-' + uuid.uuid4().hex[:6])
    run.mkdir(exist_ok=bool(a.resume))
    owner = run / 'OWNER-ONLY'; owner.mkdir(exist_ok=True)
    g1 = run / 'G1'
    for folder in ['', 'outputs', 'outputs/bootstrap_draws', 'analysis', 'nominal', 'qa']:
        (g1 / folder).mkdir(parents=True, exist_ok=True)
    public = run / 'SHARE-OBSCURED'; public.mkdir(exist_ok=True)
    log('PIPELINE RUN | ' + str(run))
    code = {str(f.relative_to(ROOT)): sha(f) for f in source_files()}
    attempt_id = datetime.datetime.now().strftime('%Y%m%d-%H%M%S') + '-' + uuid.uuid4().hex[:6]
    for rel in code:
        dest = owner / ('code-' + attempt_id) / rel
        dest.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(ROOT / rel, dest)
    attempt = dict(version=VERSION, state='RUNNING', code=code,
                                  attempt_id=attempt_id,
                                  source_checkout=subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip())
    write(run / ('attempt-' + attempt_id + '.json'), attempt)
    write(run / 'attempt.json', dict(version=VERSION, state='RUNNING', code=code,
                                  source_checkout=subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip()))
    source = json.loads(a.source_receipt.read_text())
    source_pin=owner/'source-input-pin.json'
    selected_source=dict(source_receipt_sha256=sha(a.source_receipt),
                         masking_receipt_sha256=sha(a.masking_receipt) if a.masking_receipt else None)
    if source_pin.exists():
        assert json.loads(source_pin.read_text())==selected_source,'Resume inputs differ from the original run'
    else:
        write(source_pin,selected_source)
    for rec in [source['source_inputs']['actual'], source['outputs']['actual']]:
        assert sha(Path(rec.get('path', rec.get('file')))) == rec['sha256']
    augmented = owner / 'G0_projection_with_industry_status.dta'
    if not augmented.exists():
        log('G0 INPUT | pin accepted G0; add exact source industry-status category')
        stata(owner, '00_complete_g0_projection', f'''use source_year source_row vs_industry_code using "{source['source_inputs']['actual']['path']}", clear
isid source_year source_row
tempfile flags
save "`flags'"
use "{source['outputs']['actual']['file']}", clear
generate long __order=_n
merge 1:1 source_year source_row using "`flags'", assert(match) nogen
sort __order
drop __order
assert _N==33049
save "{augmented}", replace
''')
    augmented_receipt = json.loads(json.dumps(source))
    augmented_receipt['outputs']['actual'].update(file=str(augmented), sha256=sha(augmented), columns=516, bytes=augmented.stat().st_size)
    write(owner / 'source-receipt.json', augmented_receipt)
    masking_receipt = run / 'masking-receipt.json'
    if a.masking_receipt and masking_receipt.exists():
        assert sha(a.masking_receipt)==sha(masking_receipt),'Existing panel receipt differs from supplied panel'
    if a.masking_receipt and not masking_receipt.exists():
        supplied=json.loads(a.masking_receipt.read_text())
        assert supplied['status']=='passed'
        # The separately prepared source projection already has the industry
        # status; require this exact file as the source bound by its mask.
        if supplied['actual_sha256']!=sha(augmented):
            assert supplied['actual_sha256']==source['outputs']['actual']['sha256']
            check=pd.read_stata(augmented,convert_categoricals=False)
            pinned=pd.read_stata(source['outputs']['actual']['file'],convert_categoricals=False)
            pd.testing.assert_frame_equal(check,pinned,check_exact=True)
            shutil.copyfile(source['outputs']['actual']['file'],augmented)
            augmented_receipt['outputs']['actual'].update(sha256=sha(augmented),bytes=augmented.stat().st_size)
            write(owner/'source-receipt.json',augmented_receipt)
        assert supplied['actual_sha256']==sha(augmented)
        shutil.copyfile(a.masking_receipt,masking_receipt)
    if not masking_receipt.exists():
        log('G0.25 -> G0.5 | independent masking, derived formulas, then fictional panel; no second noise pass')
        seed_args=['--seed-file',str(a.seed_file)] if a.seed_file else []
        subprocess.run([sys.executable, str(ROOT / 'downstream/obscure/strong/build.py'), str(run / 'MASK-STAGES'),
                        '--source-receipt', str(owner / 'source-receipt.json'), '--latest-receipt', str(masking_receipt),
                        '--retain-intermediates',*seed_args], check=True, cwd=ROOT)
    masked = json.loads(masking_receipt.read_text())
    assert masked['actual_sha256']==sha(augmented),'Masking is not bound to this source projection'
    stage_root = Path(masked['run'])
    g025 = stage_root / 'owner-work/numeric.dta'
    g05 = stage_root / 'OBSCURED-ONLY/obscured_dummy.dta'
    assert masked['status'] == 'passed' and sha(g05) == masked['masked_sha256'] and g025.exists()
    before = pd.read_stata(g05, convert_categoricals=False)
    original_columns = list(before)
    keys = set(zip(before.psid, before.source_year))
    lag1 = sum((f, y - 1) in keys for f, y in keys)
    manifest = dict(version=VERSION, rows=len(before), firms=int(before.psid.nunique()), lag1_rows=lag1,
                    order=['G0', 'G0.25', 'G0.5', 'G1'], extra_g05_numeric_noise=False,
                    g0_sha256=source['source_inputs']['actual']['sha256'],
                    g0_projection_sha256=sha(augmented), g025_sha256=sha(g025), g05_sha256=sha(g05),
                    masking_receipt_sha256=sha(masking_receipt), categories_retained=True,
                    g05_panel_scope='fictional development links formed after strong numeric masking',
                    g1_scope='re-estimated nominal development on the exact masked G0.5 panel')
    write(g1 / 'input-manifest.json', manifest)
    config = json.loads((ROOT / 'work-items/G1/config.json').read_text())
    assert set(config['input_columns']) <= set(before)
    if not (g1/'input.dta').exists() or not (g1/'full_input.dta').exists():
        stata(g1, '00_prepare_masked_input', f'''use "{g05}", clear
assert g1_results_attached==0
drop dev_nominal_* g1_results_attached
label data "G0.25 MASKED -> G0.5 FICTIONAL PANEL; no second perturbation"
save "{g1/'full_input.dta'}", replace
keep {' '.join(config['input_columns'])}
isid obs_id
isid psid source_year
assert psid_status=="synthetic_development"
label data "G0.25 MASKED -> G0.5 INPUT FOR G1"
save "{g1/'input.dta'}", replace
''')
    with pd.io.stata.StataReader(g1 / 'full_input.dta') as sr:
        full_columns = len(sr.variable_labels())
    input_contract = dict(version=VERSION, rows=manifest['rows'], firms=manifest['firms'], lag1_rows=lag1,
                          full_columns=full_columns, manifest_sha256=sha(g1 / 'input-manifest.json'),
                          input_sha256=sha(g1 / 'input.dta'), full_input_sha256=sha(g1 / 'full_input.dta'),
                          extra_g05_numeric_noise=False)
    if (g1/'input-contract.json').exists():
        assert json.loads((g1/'input-contract.json').read_text())==input_contract,'Prepared estimation inputs changed'
    write(g1 / 'input-contract.json', input_contract)
    master = f'''version 17
clear all
set more off
set varabbrev off
set type double
set maxvar 5000
global G1_ROOT "{ROOT}"
global G1_RUN "{g1}"
global G1_MODE "development"
global G1_CODE "$G1_ROOT/work-items/G1/stata"
global G1_INPUT_MANIFEST_SHA256 "{input_contract['manifest_sha256']}"
cd "$G1_ROOT"
capture log close _all
log using "$G1_RUN/G1_execution.log", text replace
use "$G1_RUN/input.dta", clear
assert psid_status=="synthetic_development"
isid obs_id
isid psid source_year
display "G1 START | FRESH FIT ON G0.25 MASKED VALUES; NO LEGACY SECOND NOISE"
forvalues e=1/19 {{
    local edge : display %02.0f `e'
    display "G1_E`edge' START"
    do "$G1_CODE/edges/G1_E`edge'.do"
    display "G1_E`edge' END"
}}
foreach child in N01_inputs N02_risk N03_samples N04_fits N05_bootstrap N06_outputs N07_master {{
    display "G1_`child' START"
    do "$G1_CODE/nominal/`child'.do"
    display "G1_`child' END"
}}
display "MASKED_PIPELINE_G1_COMPLETE"
log close
exit, clear
'''
    (g1 / '00_MASTER_MASKED_G1.do').write_text(master)
    runlog = g1 / 'G1_execution.log'
    estimation_code = {p: h for p, h in code.items() if p.startswith('work-items/G1/stata/')}
    estimation_pin = g1 / 'executed-estimation-code.json'
    if runlog.exists() and '\nMASKED_PIPELINE_G1_COMPLETE\n' in runlog.read_text():
        assert json.loads(estimation_pin.read_text()) == estimation_code, 'Cannot reuse estimates after estimation-code changes'
    if not runlog.exists() or '\nMASKED_PIPELINE_G1_COMPLETE\n' not in runlog.read_text():
        write(estimation_pin, estimation_code)
        log('G1 | run E01-E19 plus N01-N07, all four estimators, sensitivity fits and 99-draw bootstrap')
        # Legacy native edges use unquoted tempfile macros. Keep all bytes on
        # the SSD while giving Stata a temp path without spaces.
        tempdir = g1 / 'stata-tmp'; tempdir.mkdir(exist_ok=True)
        temp_alias = Path('/private/tmp') / ('kolega-g1-' + uuid.uuid4().hex)
        temp_alias.symlink_to(tempdir, target_is_directory=True)
        env = dict(os.environ, STATATMP=str(temp_alias))
        proc = subprocess.Popen(['/Applications/Stata/StataSE.app/Contents/MacOS/stata-se', '-b', 'do', '00_MASTER_MASKED_G1.do'], cwd=g1, env=env)
        printed_status = 0
        while proc.poll() is None:
            time.sleep(20)
            if runlog.exists():
                lines = runlog.read_text(errors='replace').splitlines()
                status = [x for x in lines if re.match(r'^G1_', x)]
                for current in status[printed_status:]:
                    log('G1 PROGRESS | ' + current)
                printed_status = len(status)
        temp_alias.unlink(missing_ok=True)
        if proc.returncode or '\nMASKED_PIPELINE_G1_COMPLETE\n' not in runlog.read_text():
            raise RuntimeError('G1 did not complete: ' + str(runlog))
    log('QA | independent source, calendar, model-residual, bootstrap and full-master reconciliation')
    for script, args in [('validate.py', [str(g1)]), ('validate_nominal.py', ['--run', str(g1)]), ('validate_master.py', [str(g1)])]:
        result = subprocess.run([sys.executable, str(ROOT / 'work-items/G1' / script), *args], cwd=ROOT,
                                stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
        (g1 / 'qa' / (script + '.log')).write_text(result.stdout)
        if result.returncode:
            raise RuntimeError(script + ': ' + result.stdout[-2500:])
        log('QA PASS | ' + script)
    stata(g1, '99_publish', f'''use "{g1/'analysis/G1_main_with_tfp.dta'}", clear
generate byte g1_results_attached=1
assert g1_real_tfp_ready==0 & panel_empirical_ready==0 & all_downstream_ready==0
order {' '.join(original_columns)}
isid obs_id
isid firm_id year
xtset firm_id year
label data "G0 -> G0.25 OBSCURED -> G0.5 DUMMY PANEL -> G1 RE-ESTIMATED"
char _dta[lineage] "G0 -> G0.25 strong mask -> G0.5 fictional panel -> G1 nominal re-estimation"
char _dta[input_manifest_sha256] "{input_contract['manifest_sha256']}"
compress
save "{g1/'analysis/G1_final_values.dta'}", replace
''')
    log('FINISH | E064 definitions -> E065 Stata labels/notes -> E066 unchanged-data validation')
    metadata = finish_metadata(g1 / 'analysis/G1_final_values.dta', public, run / 'METADATA')
    final = pd.read_stata(public / 'analysis_obscured_with_g1.dta', convert_categoricals=False)
    assert list(final) == original_columns
    untouched = [x for x in before if not x.startswith('dev_nominal_') and x != 'g1_results_attached']
    # xtset sorts the delivered view by firm/year. Match observation keys,
    # never physical row positions, when proving every input cell unchanged.
    assert before.obs_id.is_unique and final.obs_id.is_unique
    assert set(before.obs_id) == set(final.obs_id)
    final_aligned = final.set_index('obs_id', drop=False).loc[before.obs_id].reset_index(drop=True)
    pd.testing.assert_frame_equal(before[untouched], final_aligned[untouched], check_dtype=False, check_exact=True)
    counts = {m: int(final['dev_nominal_tfp_' + m].notna().sum()) for m in ['op', 'lp', 'acf', 'wrdg']}
    assert all(v > 0 for v in counts.values()), counts
    assert code == {str(f.relative_to(ROOT)): sha(f) for f in source_files()}, 'Source changed during run'
    output_inventory = [{'path': str(f.relative_to(run)), 'sha256': sha(f), 'bytes': f.stat().st_size}
                        for f in sorted(g1.rglob('*.dta')) if not f.name.startswith('._')]
    receipt = dict(status='PASS', version=VERSION, run=str(run), stages=manifest,
                   rows=len(final), columns=len(final.columns), firms=int(final.firm_id.nunique()),
                   g1_nonmissing=counts, final_file=str(public / 'analysis_obscured_with_g1.dta'),
                   final_sha256=sha(public / 'analysis_obscured_with_g1.dta'),
                   g1_input_manifest_sha256=input_contract['manifest_sha256'],
                   no_post_estimation_perturbation=True, g05_added_noise=False,
                   source_and_category_cells_preserved_through_g1=True,
                   g1_estimates_freshly_computed=True, real_empirical_panel_admitted=False,
                   metadata_finishing=metadata,
                   masking_run=str(stage_root), code=code, executed_estimation_code=estimation_code,
                   g1_intermediates=output_inventory,
                   qa={f: json.loads((g1/'qa'/f).read_text())['status'] for f in ['numeric-validation.json', 'nominal-validation.json', 'full-master-validation.json']})
    public_receipt = {k: v for k, v in receipt.items() if k not in ['run', 'final_file', 'masking_run', 'g1_intermediates']}
    public_receipt['metadata_finishing'] = {k: v for k, v in metadata.items() if k not in ['parent_file', 'final_file']}
    write(public / 'LINEAGE.json', public_receipt)
    (public / '00_OPEN.do').write_text('version 17\nset more off\nuse "analysis_obscured_with_g1.dta", clear\nxtset firm_id year\nsummarize workers value_added_nominal dev_nominal_tfp_*\n')
    (run / '00_OPEN_FINAL.do').write_text(f'version 17\nset more off\nuse "{public/"analysis_obscured_with_g1.dta"}", clear\nxtset firm_id year\nsummarize workers value_added_nominal dev_nominal_tfp_*\n')
    shutil.copytree(stage_root / 'OBSCURED-ONLY/reports', public / 'masking-reports', dirs_exist_ok=True)
    (public / 'intermediate').mkdir(exist_ok=True)
    shutil.copyfile(g05, public / 'intermediate/G05_obscured_panel.dta')
    log('DOCUMENTATION | E067 dataset metadata and nonbinding downstream recommendations')
    receipt['data_guide'] = write_data_guide(public)
    write(run / 'COMPLETE.json', receipt)
    write(a.latest_receipt, receipt)
    log('COMPLETE | ' + json.dumps({k: receipt[k] for k in ['status', 'run', 'rows', 'columns', 'firms', 'g1_nonmissing', 'final_file']}))


if __name__ == '__main__':
    main()
