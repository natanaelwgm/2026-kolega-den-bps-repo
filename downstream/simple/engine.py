#!/usr/bin/env python3
"""Small preparation interface; retain and verify the original scientific code."""
import os
for key in ('OPENBLAS_NUM_THREADS','OMP_NUM_THREADS','MKL_NUM_THREADS'):
    os.environ[key]='1'
import argparse, csv, datetime, hashlib, importlib.util, json, re, shutil, subprocess, sys, uuid, zipfile
from pathlib import Path

ROOT=Path(__file__).resolve().parents[2]
BLOCK=ROOT/'20260917-run/block-0-data-preparation'
YEARS=(2010,2011,2012,2013,2014,2015,2017,2018,2019,2020,2021,2022)
STATA=os.environ.get('KOLEGA_STATA','/Applications/Stata/StataSE.app/Contents/MacOS/stata-se')

def sha(path):
    with Path(path).open('rb') as f:return hashlib.file_digest(f,'sha256').hexdigest()

def write(path,obj):
    path=Path(path);path.parent.mkdir(parents=True,exist_ok=True)
    path.write_text(json.dumps(obj,ensure_ascii=False,indent=2)+'\n')

def load(path):return json.loads(Path(path).read_text())

def sq(value):
    value=str(value)
    if any(x in value for x in ('"','`','$','\n','\r')):raise ValueError('Paths cannot contain quotes, backticks, dollar signs, or newlines')
    return '"'+value+'"'

def call(command):
    subprocess.run([str(x) for x in command],check=True,cwd=ROOT)

def native(work,name,body):
    work=Path(work);work.mkdir(parents=True,exist_ok=True)
    script=work/(name+'.do')
    script.write_text('version 17\nset more off\nset varabbrev off\n'+body+'\ndisplay "PREPARATION_NATIVE_PASS"\nexit, clear\n')
    temp=work/'temp';temp.mkdir(exist_ok=True)
    alias=Path('/private/tmp')/('kolega-simple-'+uuid.uuid4().hex[:12])
    alias.symlink_to(temp,target_is_directory=True)
    try:
        p=subprocess.run([STATA,'-b','do',script.name],cwd=work,env=dict(os.environ,STATATMP=str(alias)))
    finally:alias.unlink(missing_ok=True)
    log=(work/(name+'.log')).read_text(errors='replace')
    if p.returncode or '\nPREPARATION_NATIVE_PASS\n' not in log:
        errors=re.findall(r'^r\([0-9]+\);$',log,re.M)
        raise RuntimeError(f'Stata stopped: {name}; {errors[-1:]}; see {work/(name+".log")}')

def check_pin(path):
    x=load(path)
    for item in x.get('files',[]):
        if sha(item['path'])!=item['sha256']:raise ValueError('Intermediate output changed: '+item['path'])
    return x

def pin(run,number,files,**extra):
    rec=dict(status='PASS',stage=number,finished_at=datetime.datetime.now().astimezone().isoformat(),
             files=[dict(path=str(p),sha256=sha(p),bytes=Path(p).stat().st_size) for p in files],**extra)
    write(run/f'step-{number}.json',rec)
    return rec

def raw_driver(run,rawrun):
    """Resume only at whole, validated stages; a partial stage is rerun."""
    stages=load(ROOT/'overall/g0-source/registry/stages.json')
    done=[x['id'] for x in load(rawrun/'overall.json')['stages']]
    if done!=[x['id'] for x in stages[:len(done)]]:raise ValueError('Completed cleaning stages do not match the source order')
    lines=['* Generated from the source stage registry; every call is displayed in Stata.']
    if not done:lines.append('do "$OVERALL_REPO/overall/code/01_raw_imports.do"')
    for i,x in enumerate(stages[len(done):],start=len(done)+1):
        if x['id']=='V090':lines.append('global WF_REPORT_VALUES_30_EXACT 0')
        lines += [f'display as result "Clean data {i}/{len(stages)} | {x["path"]}"',
                  'cd "$OVERALL_G0"',f'do "$OVERALL_G0/{x["path"]}"']
        if x['id']=='V090':lines.append('if "$WF_REPORT_VALUES_30_EXACT"!="1" exit 9')
        lines += [
                  'quietly do "$B0_HOME/support/progress.do"',
                  f'demo_shell "$OVERALL_PYTHON" "$OVERALL_REPO/overall/scripts/overall.py" stage "$OVERALL_RUN" "{x["id"]}"',
                  'if $DEMO_HELPER_RC!=0 exit $DEMO_HELPER_RC']
    path=run/'private/clean_data_resume.do';path.write_text('\n'.join(lines)+'\n')
    return 'global B0_RAW_DRIVER '+sq(path)+'\n'

def init(output,raw,witness,seed,resume,reply,accepted_raw):
    output=Path(output).expanduser().resolve()
    if output.is_relative_to(ROOT):raise ValueError('Set WORK_DIR outside the repository; actual data remain local')
    output.mkdir(parents=True,exist_ok=True)
    if os.statvfs(output).f_frsize>65536:
        raise ValueError('WORK_DIR uses large allocation units. Use an APFS volume with small allocation units; see documentation/REBUILD_GUIDE.md.')
    if resume:
        run=Path(resume).resolve();state=load(run/'settings.json')
        if state['repository']!=str(ROOT):raise ValueError('Resume folder belongs to a different repository')
        if Path(state['output_root'])!=output:raise ValueError('WORK_DIR differs from the resumed run')
        for field,value in [('raw_dir',raw),('witness_dir',witness),('seed_file',seed),('accepted_raw_run',accepted_raw)]:
            if value and str(Path(value).expanduser().resolve())!=state.get(field):
                raise ValueError('Configuration changed for '+field+'; start a new run')
    else:
        if not raw or not witness:raise ValueError('Set RAW_DATA and REFERENCE_DATA in settings.do')
        if shutil.disk_usage(output).free<5*1024**3:raise ValueError('WORK_DIR needs at least 5 GiB free for the next stage')
        run=output/(datetime.datetime.now().strftime('%Y%m%d-%H%M%S')+'-'+uuid.uuid4().hex[:6])
        run.mkdir()
        state=dict(repository=str(ROOT),output_root=str(output),raw_dir=str(Path(raw).resolve()),
                   witness_dir=str(Path(witness).resolve()),seed_file=str(Path(seed).expanduser().resolve()) if seed else str(output/'private/seed.key'),
                   accepted_raw_run=str(Path(accepted_raw).resolve()) if accepted_raw else '',created_at=datetime.datetime.now().astimezone().isoformat())
        if Path(state['seed_file']).is_relative_to(ROOT):raise ValueError('The seed must remain outside the repository')
        for folder in ['logs','intermediate','output','private']:(run/folder).mkdir()
        write(run/'settings.json',state)
    Path(reply).write_text('global B0_RUN '+sq(run)+'\n')
    print('Run folder: '+str(run),flush=True)

def clean_prepare(run,reply):
    state=load(run/'settings.json')
    if (run/'step-1.json').exists():
        check_pin(run/'step-1.json')
        Path(reply).write_text('global B0_CLEAN_REUSED 1\n')
        print('Clean data verified; reusing the same checkpoint.',flush=True);return
    adopted=state.get('accepted_raw_run')
    prepared=state.get('raw_run')
    if prepared and not adopted:
        rawrun=Path(prepared)
        m=load(rawrun/'overall.json')
        for item in m['raw_inputs']:
            if sha(rawrun/item['path'])!=item['sha256']:raise ValueError('Raw input changed; start a new run')
        setup=f'global OVERALL_RUN {sq(rawrun)}\nglobal OVERALL_RAW {sq(rawrun/"raw")}\nglobal OVERALL_G0 {sq(rawrun/"G0-wave-foundation-v2")}\n'
        Path(reply).write_text('global B0_CLEAN_REUSED 0\nglobal B0_RAW_REUSED 0\n'+setup+raw_driver(run,rawrun))
        print('Resume cleaning with the same inputs and working folder.',flush=True)
        return
    if adopted:
        rawrun=Path(adopted)
        proof=load(rawrun/'RAW_PROBE_RESULT.json')
        if proof['status']!='PASS':raise ValueError('The selected raw rebuild has not passed validation')
        m=load(rawrun/'overall.json')
        expected=[x['id'] for x in load(ROOT/'overall/g0-source/registry/stages.json')]
        if [x['id'] for x in m['stages']]!=expected:raise ValueError('Raw cleaning stages are incomplete')
        for item in m['raw_inputs']:
            if sha(rawrun/item['path'])!=item['sha256']:raise ValueError('Validated raw input changed')
        for item in m['raw_inputs']:
            candidate=Path(state['raw_dir'])/Path(item['path']).name
            if sha(candidate)!=item['sha256']:raise ValueError('RAW_DATA differs from the selected validated rebuild')
        print('Reuse the raw rebuild that passed all stages: '+str(rawrun),flush=True)
        setup=f'global OVERALL_RUN {sq(rawrun)}\nglobal OVERALL_RAW {sq(rawrun/"raw")}\nglobal OVERALL_G0 {sq(rawrun/"G0-wave-foundation-v2")}\n'
        skip='1'
    else:
        raw=Path(state['raw_dir'])
        annual=list(csv.DictReader((BLOCK/'support/input_files.csv').open()))
        if [int(x['year']) for x in annual]!=list(YEARS):raise ValueError('Input list must declare all 12 supported waves')
        if any(x['sheet']!='Sheet1' for x in annual):raise ValueError('Current adapters use Sheet1; changing sheets requires an adapter review')
        archive=run/'private/annual-inputs.zip'
        expected_raw=[p.name for p in raw.iterdir() if p.is_file() and not p.name.startswith('.')]
        source_by_name={f'sampel_mfg{x["year"]}_aman.xlsx':raw/x['filename'] for x in annual}
        for name in expected_raw:
            if name not in {x['filename'] for x in annual}:source_by_name[name]=raw/name
        if len(source_by_name)!=17:raise ValueError('Expected 12 annual Excel files and 5 reference files; check the input list')
        for name,p in source_by_name.items():
            if not p.is_file():raise FileNotFoundError(str(p))
        with zipfile.ZipFile(archive,'x',zipfile.ZIP_DEFLATED) as z:
            for name,p in source_by_name.items():z.write(p,name)
        spec=importlib.util.spec_from_file_location('simple_overall',ROOT/'overall/scripts/overall.py')
        mod=importlib.util.module_from_spec(spec);spec.loader.exec_module(mod)
        work=run/'private/raw-build';work.mkdir()
        response=run/'private/raw-setup.do'
        mod.prepare(work,archive,state['witness_dir'],response)
        setup=response.read_text();rawrun=Path(re.search(r'global OVERALL_RUN "([^"]+)"',setup)[1]);skip='0'
    state['raw_run']=str(rawrun);write(run/'settings.json',state)
    Path(reply).write_text('global B0_CLEAN_REUSED 0\nglobal B0_RAW_REUSED '+skip+'\n'+setup+raw_driver(run,rawrun))

def clean_finish(run):
    state=load(run/'settings.json');rawrun=Path(state['raw_run'])
    m=load(rawrun/'overall.json')
    expected=[x['id'] for x in load(ROOT/'overall/g0-source/registry/stages.json')]
    assert [x['id'] for x in m['stages']]==expected,'Cleaning is incomplete'
    parent=rawrun/'G0-wave-foundation-v2/data/analysis/G0_analysis_ready.dta'
    projection=run/'intermediate/clean_data.dta'
    print('Select analysis variables and retain every source observation.',flush=True)
    native(run/'logs','01_select_variables',f'''set maxvar 10000
global DS_ROOT {sq(ROOT)}
global DS_RUN {sq(run)}
global DS_ACTUAL {sq(parent)}
do "$DS_ROOT/downstream/code/01_project_source.do" actual
do "$DS_ROOT/downstream/code/02_identity.do" actual
do "$DS_ROOT/downstream/code/03_features.do" actual
sort _source_order
drop _source_order
tempfile projected
save "`projected'"
use source_year source_row vs_industry_code using "$DS_ACTUAL", clear
isid source_year source_row
tempfile flags
save "`flags'"
use "`projected'", clear
generate long __order=_n
merge 1:1 source_year source_row using "`flags'", assert(match) nogen
sort __order
drop __order
isid obs_id
compress
save {sq(projection)}, replace
''')
    import pandas as pd
    with pd.io.stata.StataReader(projection) as reader:
        rows=reader._nobs;columns=len(reader.variable_labels())
    source=dict(source_inputs={'actual':dict(path=str(parent),sha256=sha(parent),bytes=parent.stat().st_size)},
                outputs={'actual':dict(file=str(projection),sha256=sha(projection),bytes=projection.stat().st_size,rows=rows,columns=columns)},
                source_boundary='Fresh raw Excel imports and all validated original G0 stages',raw_run=str(rawrun))
    write(run/'private/clean-source.json',source)
    pin(run,1,[projection,run/'private/clean-source.json'],raw_run=str(rawrun))
    print(f'COMPLETE 1/4 | Clean data: {rows:,} observations.',flush=True)

def mask(run):
    check_pin(run/'step-1.json')
    if (run/'step-2.json').exists():check_pin(run/'step-2.json');print('Numeric checkpoint verified; no additional obscuring applied.',flush=True);return
    state=load(run/'settings.json')
    call([sys.executable,ROOT/'downstream/obscure/strong/build.py',run/'private/masking',
          '--source-receipt',run/'private/clean-source.json','--latest-receipt',run/'private/numeric-receipt.json',
          '--seed-file',state['seed_file'],'--through','numeric','--retain-intermediates'])
    numeric=load(run/'private/numeric-receipt.json')
    path=Path(numeric['run'])/'owner-work/numeric.dta'
    checkpoint=run/'intermediate/obscured_values.dta'
    shutil.copyfile(path,checkpoint)
    assert sha(path)==sha(checkpoint)
    pin(run,2,[path,checkpoint,run/'private/numeric-receipt.json'],masking_run=numeric['run'])
    print('COMPLETE 2/4 | Values obscured; categories retained; exact numerical replay verified.',flush=True)

def panel(run):
    stage=check_pin(run/'step-2.json')
    if (run/'step-3.json').exists():check_pin(run/'step-3.json');print('Panel checkpoint verified; reusing the same identifiers.',flush=True);return
    state=load(run/'settings.json')
    completed=Path(stage['masking_run'])/'COMPLETE.json'
    if completed.exists():
        rec=load(completed)
        assert rec['status']=='passed'
        assert rec['actual_sha256']==load(run/'private/clean-source.json')['outputs']['actual']['sha256']
        assert rec['source_code_sha256']=={p.name:sha(p) for p in (ROOT/'downstream/obscure/strong').glob('*.py')}
        assert rec['masked_sha256']==sha(Path(stage['masking_run'])/'OBSCURED-ONLY/obscured_dummy.dta')
        write(run/'private/panel-receipt.json',rec)
        print('Completed panel verified; recovering its step receipt.',flush=True)
    else:
        call([sys.executable,ROOT/'downstream/obscure/strong/build.py',run/'private/masking',
              '--source-receipt',run/'private/clean-source.json','--latest-receipt',run/'private/panel-receipt.json',
              '--seed-file',state['seed_file'],'--resume',stage['masking_run'],'--retain-intermediates'])
    rec=load(run/'private/panel-receipt.json')
    panelpath=Path(rec['run'])/'OBSCURED-ONLY/obscured_dummy.dta'
    checkpoint=run/'intermediate/panel.dta'
    shutil.copyfile(panelpath,checkpoint)
    assert sha(panelpath)==sha(checkpoint)
    pin(run,3,[panelpath,checkpoint,run/'private/panel-receipt.json'])
    print('COMPLETE 3/4 | Panel constructed without a second obscuring pass.',flush=True)

def estimate(run):
    check_pin(run/'step-3.json')
    if (run/'step-4.json').exists():check_pin(run/'step-4.json');print('Productivity results and final dataset verified.',flush=True);return
    latest=run/'private/estimation-receipt.json'
    estimation=run/'private/estimation/working'
    estimation.mkdir(parents=True,exist_ok=True)
    call([sys.executable,ROOT/'downstream/g025_to_g1/build.py',run/'private/estimation',
          '--resume',estimation,
          '--source-receipt',run/'private/clean-source.json',
          '--masking-receipt',run/'private/panel-receipt.json','--latest-receipt',latest])
    rec=load(latest);assert rec['status']=='PASS'
    source=Path(rec['final_file']);dest=run/'output/analysis_ready_data.dta'
    shutil.copyfile(source,dest);assert sha(source)==sha(dest)
    for name in ['metadata','masking-reports']:
        shutil.copytree(source.parent/name,run/'output/documentation'/name,dirs_exist_ok=True)
    for name in ['LINEAGE.json','METADATA.json']:
        shutil.copyfile(source.parent/name,run/'output/documentation'/name)
    provenance=run/'output/documentation/provenance';provenance.mkdir(exist_ok=True)
    for name in ['README.md','METADATA.json']:
        shutil.copyfile(source.parent/name,provenance/name)
    shutil.copyfile(source.parent/'metadata/DATA_GUIDE_VALIDATION.json',provenance/'DATA_GUIDE_VALIDATION.json')
    metadata=load(run/'output/documentation/METADATA.json')
    metadata['recommended_entry_file']='../analysis_ready_data.dta'
    metadata['dataset_catalogue']=[dict(x,file='../analysis_ready_data.dta') for x in metadata['dataset_catalogue'] if x['contains_fresh_g1_results']]
    for entry in metadata['downstream_starting_points']:
        if entry['file']==source.name:
            entry['file']='../analysis_ready_data.dta'
        else:
            entry['available_in_delivery']=False
    write(run/'output/documentation/METADATA.json',metadata)
    (run/'output/README.md').write_text("""# Analysis dataset

Open **analysis_ready_data.dta** in Stata. Each row represents a fictional firm in a calendar year; the key is `firm_id year`. Values were obscured before panel construction and productivity estimation.

The [variable dictionary](documentation/metadata/variable_dictionary.csv) provides definitions. [Metadata](documentation/METADATA.json) describes coverage and nonbinding analytical recommendations. Fictional links and nominal residuals support development; they do not establish actual firm identity or real TFP.

`COMPLETE.json` records the validated file hash and source run.
""")
    write(run/'output/documentation/metadata/DATA_GUIDE_VALIDATION.json',dict(status='PASS',
        dataset_files=1,final_sha256=sha(dest),recommendations_are_binding=False,
        files={name:sha(run/'output'/name) for name in ['README.md','documentation/METADATA.json']},
        original_receipt='../provenance/DATA_GUIDE_VALIDATION.json'))
    write(run/'output/COMPLETE.json',dict(status='PASS',file=dest.name,sha256=sha(dest),rows=rec['rows'],variables=rec['columns'],source_run=str(run),
        order=['clean_data','obscure_values','construct_panel','estimate_productivity'],obscured=True,no_post_estimation_masking=True))
    pin(run,4,[dest,run/'output/COMPLETE.json'])
    print(f'COMPLETE 4/4 | {rec["rows"]:,} rows x {rec["columns"]} variables',flush=True)
    print('ANALYSIS DATA | '+str(dest),flush=True)

def main():
    a=sys.argv[1:]
    if a[0]=='init':init(*a[1:]);return
    run=Path(a[1]).resolve()
    if a[0]=='clean-prepare':clean_prepare(run,Path(a[2]))
    elif a[0]=='clean-finish':clean_finish(run)
    elif a[0]=='mask':mask(run)
    elif a[0]=='panel':panel(run)
    elif a[0]=='estimate':estimate(run)
    else:raise ValueError(a[0])

if __name__=='__main__':main()
