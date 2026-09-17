#!/usr/bin/env python3
"""Strong, owner-recoverable masking; native Stata applies quantitative edges."""
import os
for k in ['OPENBLAS_NUM_THREADS','OMP_NUM_THREADS','MKL_NUM_THREADS']:os.environ[k]='1'
from pathlib import Path
import argparse,csv,datetime,hashlib,io,json,math,re,secrets,shutil,subprocess,sys,uuid
import numpy as np
import pandas as pd
from policy import VERSION,COUNTS,PERCENTAGES,CATEGORY_EXCEPTIONS,IDENTITY,EXTRA,contract
from seeded import factor,digest,sha,encrypt_recovery,decrypt_recovery

REPO=Path(__file__).resolve().parents[3]
sys.path.insert(0,str(REPO/'harness/g05'))
from panel_generator import generate,INPUT_COLUMNS

def write(p,x):Path(p).write_text(json.dumps(x,indent=2,default=str)+'\n')
def log(s):print(s,flush=True)
def same(a,b):return a.eq(b)|(a.isna()&b.isna())

def stata(work,name,code):
    script=work/(name+'.do');script.write_text('version 17\nset more off\nset varabbrev off\nset maxvar 5000\n'+code+'\ndisplay "STRONG_EDGE_PASS"\n')
    log('STATA | '+name)
    env=os.environ.copy();env['STATATMP']=str(work)
    result=subprocess.run(['/Applications/Stata/StataSE.app/Contents/MacOS/stata-se','-b','do',script.name],cwd=work,env=env)
    output=(work/(name+'.log')).read_text()
    if result.returncode or '\nSTRONG_EDGE_PASS\n' not in output:raise RuntimeError(name+'\n'+output.split('\n. do ',1)[-1][-2500:])
    log('STATA PASS | '+name)

def eval_relation(df,s):
    cols=s['inputs'];v=df[cols].astype(float);op=s['op']
    if op=='alias':return v.iloc[:,0]
    if op=='constant':return v.iloc[:,0]*s['constants'][0]
    if op=='product':return v.prod(axis=1,min_count=len(cols))
    if op=='difference':return v.iloc[:,0]-v.iloc[:,1]
    if op=='sum_strict':return v.sum(axis=1,min_count=len(cols))
    if op=='sum_nonnegative':return v.where(v.ge(0)).sum(axis=1,min_count=1)
    if op=='sum_source_valid':
        for c in cols:v.loc[~df['st_'+c].isin([0,1]),c]=np.nan
        return v.where(v.ge(0)).sum(axis=1,min_count=1)
    if op=='fallback':return v.iloc[:,0].where(v.iloc[:,0].ge(0)).fillna(v.iloc[:,1])
    with np.errstate(all='ignore'):
        if op=='ratio':return v.iloc[:,0]/v.iloc[:,1]
        if op=='log':return np.log(v.iloc[:,0])
    raise ValueError(op)

def expression(s):
    a=s['inputs'];op=s['op']
    if op=='alias':return a[0]
    if op=='constant':return f'{a[0]}*{s["constants"][0]:.17g}'
    if op=='product':return '*'.join(a)
    if op=='difference':return '-'.join(a)
    if op=='sum_strict':return '+'.join(a)
    if op=='ratio':return '/'.join(a)
    if op=='log':return f'ln({a[0]})'
    if op=='fallback':return f'cond({a[0]}>=0 & !missing({a[0]}),{a[0]},{a[1]})'
    terms=[]
    for c in a:
        valid=f'{c}>=0 & !missing({c})'
        if op=='sum_source_valid':valid+=f' & inlist(st_{c},0,1)'
        terms.append(f'cond({valid},{c},0)')
    return '+'.join(terms)

def factor_frame(before,base,seed,sourcehash):
    channels=base+EXTRA+COUNTS+PERCENTAGES
    f=pd.DataFrame({'obs_id':before.obs_id})
    exceptions={}; workers_new=None
    observations=before.obs_id.tolist()
    original_workers=before.workers.to_numpy(dtype=float)
    for j,n in enumerate(channels):
        if n not in COUNTS+PERCENTAGES:
            f[f'__f{j}']=[factor(seed,sourcehash,obs,n) for obs in observations]
            exceptions[n]=0
            if j%10==0:log(f'FACTORS | {j+1}/{len(channels)} variable channels')
            continue
        vals=[];exception_count=0
        original=before[n].to_numpy(dtype=float)
        for i,obs in enumerate(observations):
            x=original[i]
            picked=None
            for attempt in range(128):
                candidate=factor(seed,sourcehash,obs,n,attempt)
                if n not in COUNTS+PERCENTAGES or not np.isfinite(x) or x==0 or (n in PERCENTAGES and x==100):
                    picked=candidate;break
                y=math.floor(x*candidate+.5) if n in COUNTS else x*candidate
                valid=abs(y/x-1)>=.20-1e-12 and abs(y/x-1)<=.30+1e-12
                if n in COUNTS:
                    valid=valid and y>=1
                    if n=='workers':valid=valid and ((x>100)==(y>100))
                    elif x<=original_workers[i]:valid=valid and y<=workers_new[i]
                else:
                    valid=valid and ((0<y<100) if 0<x<100 else (y>100 if x>100 else y<0))
                    if n=='foreign_ownership_pct':valid=valid and ((x>=10)==(y>=10))
                if valid:picked=candidate;break
            if picked is None:
                # Tiny integer values have no admissible integer in the requested
                # relative band. Round the seeded proposal; never invent people.
                if n not in COUNTS:raise ValueError(('No feasible percentage',n,i))
                target=max(1,math.floor(x*factor(seed,sourcehash,obs,n)+.5))
                if n=='workers':target=min(target,100) if x<=100 else max(target,101)
                elif x<=original_workers[i]:target=min(target,workers_new[i])
                picked=target/x;exception_count+=1
            vals.append(picked)
        f[f'__f{j}']=vals
        if n=='workers':workers_new=np.where(before.workers>0,np.floor(before.workers.to_numpy()*np.array(vals)+.5),before.workers.to_numpy())
        exceptions[n]=exception_count
        log(f'FACTORS | {n} complete; integer fallback count {exception_count}')
    return f,dict(zip(channels,[f'__f{j}' for j in range(len(channels))])),exceptions

def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('output_root',type=Path)
    p.add_argument('--seed-file',type=Path,default=Path('/Users/natanaelmassie/Downloads/.kolega-private/strong-v2/seed.key'))
    a=p.parse_args()
    source_receipt=json.loads((REPO/'downstream/reports/latest-build.json').read_text())
    src=Path(source_receipt['outputs']['actual']['file']);sourcehash=sha(src)
    assert sourcehash==source_receipt['outputs']['actual']['sha256']
    a.output_root.mkdir(parents=True,exist_ok=True)
    if shutil.disk_usage(a.output_root).free<2*1024**3:raise ValueError('Need 2 GiB headroom')
    run=a.output_root/(datetime.datetime.now().strftime('%Y%m%d-%H%M%S')+'-'+uuid.uuid4().hex[:6]);run.mkdir()
    work=run/'owner-work';work.mkdir()
    public=run/'OBSCURED-ONLY';public.mkdir();(public/'reports').mkdir()
    owner=run/'OWNER-ONLY';owner.mkdir()
    seedpath=a.seed_file.resolve()
    assert not seedpath.is_relative_to(run) and not seedpath.is_relative_to(REPO)
    seedpath.parent.mkdir(parents=True,exist_ok=True,mode=0o700)
    if not seedpath.exists():
        with seedpath.open('xb') as f:f.write(secrets.token_bytes(32))
        seedpath.chmod(0o600)
    seed=seedpath.read_bytes();assert len(seed)==32
    backup=seedpath.with_suffix('.backup.key')
    if backup.exists():assert backup.read_bytes()==seed
    else:
        with backup.open('xb') as f:f.write(seed)
        backup.chmod(0o600)
    seed_id=hashlib.sha256(seed).hexdigest()
    write(seedpath.parent/'OWNER-RECOVERY.json',{'seed_file':str(seedpath),'backup_seed_file':str(backup),'seed_id':seed_id,'run':str(run),'state':'building'})
    log('RUN | '+str(run));log('PRIVATE SEED | retained; contents never printed')
    before=pd.read_stata(src,convert_categoricals=False)
    base,derived=contract(before.columns)
    assert before.accounting_gap.abs().lt(1e-6).all(),'Material accounting residual requires a separate contract'
    numeric=set(base)|set(derived)|set(COUNTS)|set(PERCENTAGES)
    assert not numeric & CATEGORY_EXCEPTIONS
    protected=[n for n in before if n not in numeric|IDENTITY]
    for n in protected:
        if pd.api.types.is_numeric_dtype(before[n]) and before[n].nunique()>20:
            raise ValueError(('Unclassified varying numeric field',n))
    # Fail closed on source equations. Derived output can retain source missing
    # masks but must not quietly change a different definition.
    source_equations={}
    for n,s in derived.items():
        expected=eval_relation(before,s);mask=before[n].notna()
        good=np.isclose(before.loc[mask,n],expected[mask],rtol=1e-7,atol=1e-7)
        source_equations[n]={'observed':int(mask.sum()),'source_mismatches':int((~good).sum())}
        if not good.all():raise ValueError(('Source equation needs audit',n,int((~good).sum())))
    factors,channels,exceptions=factor_frame(before,base,seed,sourcehash)
    factors.to_stata(work/'factors.dta',write_index=False,version=118)
    log(f'POLICY | {len(base)} independent continuous fields, 3 integer counts, 2 percentages, {len(derived)} derived fields')
    parent=source_receipt['source_inputs']['actual']['path']
    assert sha(parent)==source_receipt['source_inputs']['actual']['sha256']
    setup=f'''use source_year source_row {' '.join(EXTRA)} using "{parent}", clear
isid source_year source_row
tempfile extra
save "`extra'"
use "{src}", clear
generate long __order=_n
merge 1:1 source_year source_row using "`extra'", assert(match) nogen
merge 1:1 obs_id using "{work/'factors.dta'}", assert(match) nogen
sort __order
'''
    code=setup
    for n in base+EXTRA:
        code+=f'recast double {n}\nquietly replace {n}={n}*{channels[n]} if !missing({n})\n'
    for n in COUNTS:
        code+=f'recast double {n}\nquietly replace {n}=max(1,floor({n}*{channels[n]}+.5)) if {n}>0 & !missing({n})\nassert {n}==floor({n}) if !missing({n})\n'
    for n in PERCENTAGES:
        code+=f'recast double {n}\nquietly replace {n}={n}*{channels[n]} if !missing({n}) & !inlist({n},0,100)\n'
    for n,s in derived.items():
        code+=f'recast double {n}\nquietly replace {n}={expression(s)} if !missing({n})\n'
    code+='drop __f*\nsort __order\n'
    stata(work,'01_mask_and_derive',code+f'save "{work/"numeric.dta"}", replace\n')
    # Full native numerical replay with newly regenerated draws, same private seed.
    regen,regen_channels,regen_exceptions=factor_frame(before,base,seed,sourcehash)
    pd.testing.assert_frame_equal(factors,regen,check_exact=True)
    assert regen_channels==channels and regen_exceptions==exceptions
    regen.to_stata(work/'factors.dta',write_index=False,version=118)
    stata(work,'02_replay_numeric',code+f'cf _all using "{work/"numeric.dta"}", all\n')
    numeric_df=pd.read_stata(work/'numeric.dta',convert_categoricals=False)
    mapping=pd.DataFrame({'actual_obs_id':before.obs_id,'obs_id':['M'+digest(seed,sourcehash,o,'public-observation-id').hex()[:24] for o in before.obs_id]})
    assert mapping.obs_id.is_unique
    match=numeric_df[INPUT_COLUMNS].copy();match['obs_id']=mapping.obs_id
    panel_seed=int.from_bytes(digest(seed,sourcehash,'','dummy-panel')[:8],'big')
    ids,report=generate(match,seed=panel_seed,progress=lambda r:log('PANEL | '+json.dumps(r)))
    ids_again,report_again=generate(match,seed=panel_seed)
    pd.testing.assert_frame_equal(ids,ids_again,check_exact=True)
    assert report==report_again
    report['parameters'].pop('seed');report['parameters']['seed']='private domain-separated seed retained by owner'
    write(public/'reports/dummy_panel.json',report)
    # Identity metadata uses only masked keys. Source row positions are re-keyed.
    id_cols=['obs_id','psid','psid_status','dev_panel_stratum','dev_prev_obs_id','dev_prev_year','dev_link_status']
    attachment=ids[id_cols].copy();attachment=attachment.merge(mapping,on='obs_id',validate='one_to_one')
    yearmap=dict(zip(before.obs_id,before.year));attachment['year']=attachment.actual_obs_id.map(yearmap)
    attachment=attachment.sort_values(['year','obs_id'])
    attachment['new_source_row']=attachment.groupby('year').cumcount()+1
    attachment=attachment.drop(columns='year').rename(columns={'obs_id':'masked_obs_id','actual_obs_id':'obs_id'})
    attachment.to_stata(work/'ids.dta',write_index=False,version=118)
    stata(work,'03_publish_masked',f'''use "{work/'numeric.dta'}", clear
drop psid psid_status dev_panel_stratum dev_prev_obs_id dev_prev_year dev_link_status
merge 1:1 obs_id using "{work/'ids.dta'}", assert(match) nogen
drop obs_id
rename masked_obs_id obs_id
replace source_row=new_source_row
drop new_source_row __order {' '.join(EXTRA)}
recast double firm_id
replace firm_id=psid
replace dataset_mode="obscured"
replace panel_id_synthetic=1
replace panel_key_available=1
assert panel_empirical_ready==0 & all_downstream_ready==0 & g1_results_attached==0
isid obs_id
isid firm_id year
xtset firm_id year
generate double __L=L.va_signed_nominal
assert missing(__L) if year==2017
drop __L
sort year obs_id
order {' '.join(before.columns)}
label data "SEEDED 20-30% MASKED DEVELOPMENT; fictional IDs; not actual inference"
label variable source_row "Dummy row sequence within year; original mapping retained privately"
label variable obs_id "Private-key pseudonymous observation ID; original key not released"
label variable firm_id "Fictional panel ID; no verified actual linkage"
char _dta[scope] "Masked development only; categories are source categories; rerun G1"
compress
save "{public/'obscured_dummy.dta'}", replace
''')
    after_public=pd.read_stata(public/'obscured_dummy.dta',convert_categoricals=False)
    after=after_public.copy().set_index('obs_id').loc[mapping.obs_id].reset_index()
    after=after[list(before.columns)]
    assert list(after_public)==list(before) and len(after)==len(before)
    for n in protected:assert same(before[n],after[n]).all(),('Category/reference changed',n)
    for n in set(before)-IDENTITY:assert before[n].isna().equals(after[n].isna()),('Missingness changed',n)
    for n in CATEGORY_EXCEPTIONS:assert same(before[n],after[n]).all(),n
    assert set(before.obs_id).isdisjoint(set(after.obs_id))
    assert after.source_year.equals(after.year)
    assert not after[['firm_id','year']].duplicated().any()
    assert after.groupby('firm_id').dev_panel_stratum.nunique().le(1).all()
    assert not set(after.dev_prev_obs_id)-set(after.obs_id)-{''}
    equation_checks={}
    for n,s in derived.items():
        expected=eval_relation(after,s);mask=after[n].notna()
        assert np.isclose(after.loc[mask,n],expected[mask],rtol=1e-7,atol=1e-7).all(),n
        equation_checks[n]=int(mask.sum())
    changes=[]
    for n in before:
        action='preserve_category_or_reference'
        if n in base:action='independent_continuous_20_30'
        elif n in COUNTS:action='integer_20_30_or_documented_rounding'
        elif n in PERCENTAGES:action='bounded_percentage_20_30_except_anchors'
        elif n in derived:action='recomputed_derived'
        elif n in IDENTITY:action='dummy_identity_metadata'
        row={'variable':n,'action':action,'changed_cells':int((~same(before[n],after[n])).sum())}
        if n in numeric:
            mask=before[n].notna()&before[n].ne(0)
            rel=(after.loc[mask,n]/before.loc[mask,n]-1).abs()
            row.update({'nonzero_observed':int(mask.sum()),'outside_20_30':int((~rel.between(.20-1e-10,.30+1e-10)).sum())})
        if n in base:
            assert row['outside_20_30']==0,n
            assert np.array_equal(np.sign(before.loc[mask,n]),np.sign(after.loc[mask,n])),n
            assert after.loc[before[n].eq(0),n].eq(0).all(),n
        if n in COUNTS:
            assert after[n].dropna().eq(np.floor(after[n].dropna())).all(),n
            # A constraint fallback can itself land inside the target band;
            # distinguish fallback events from actual out-of-band results.
            assert row['outside_20_30']<=exceptions[n],(n,row,exceptions[n])
            if n!='workers':
                valid=before[n].le(before.workers)&before[n].notna()
                assert after.loc[valid,n].le(after.loc[valid,'workers']).all(),n
        if n in PERCENTAGES:
            valid=before[n].between(0,100);assert after.loc[valid,n].between(0,100).all(),n
            invalid=before[n].notna()&~valid
            assert (~after.loc[invalid,n].between(0,100)).all(),n
            row['inherited_invalid_domain']=int(invalid.sum())
            mask=before[n].notna()&~before[n].isin([0,100])
            assert (after.loc[mask,n]/before.loc[mask,n]-1).abs().between(.2-1e-10,.3+1e-10).all()
        changes.append(row)
    assert (before.workers>100).equals(after.workers>100)
    assert (before.foreign_ownership_pct>=10).equals(after.foreign_ownership_pct>=10)
    # Targeted known-value attack: an original anchor must not unlock unrelated
    # independently masked base quantities. This is not a general privacy proof.
    attacks=[]
    for anchor,target in [('value_added_nominal','capital_stock_nominal'),('value_added_nominal','intermediate_inputs_nominal'),('fuel_diesel_ltr','fuel_diesel_rp000'),('elec_pln_kwh','elec_pln_rp000')]:
        mask=before[anchor].gt(0)&before[target].gt(0)
        inferred=after.loc[mask,target]/(after.loc[mask,anchor]/before.loc[mask,anchor])
        error=(inferred/before.loc[mask,target]-1).abs()
        recovered=int(np.isclose(inferred,before.loc[mask,target],rtol=1e-12,atol=0).sum())
        assert recovered==0,(anchor,target,recovered)
        attacks.append({'known_original':anchor,'target':target,'tested':int(mask.sum()),'recovered_at_1e_12':recovered,'within_1pct':int(error.le(.01).sum()),'median_relative_error':float(error.median())})
    groupcols=['year','province_code','industry_code']
    groups=before.groupby(groupcols,dropna=False).size()
    privacy={'common_factor_attack':attacks,'category_singleton_records':int(groups.eq(1).sum()),'category_grouping':groupcols,
             'strong_anonymity_claim':False,'limitations':['Retained categories and missingness permit linkage; rare categories remain exact.','Zeros, percentage anchors and some small counts remain inferable.','Known ranges, external knowledge, related identities and repeated releases may narrow originals.','This is bounded masking, not differential privacy or fully synthetic data.']}
    write(public/'reports/privacy_checks.json',privacy)
    pd.DataFrame(changes).to_csv(public/'reports/column_policy_and_changes.csv',index=False)
    write(public/'reports/equations.json',{'source':source_equations,'masked_checked':equation_checks,'graph':derived})
    # Recovery archive contains exact original bytes AND cell deltas/mapping.
    # All original-bearing material is encrypted; the seed never enters delivery.
    mapping['actual_source_row']=before.source_row
    mapping['dummy_source_row']=after.source_row
    delta_columns={'actual_obs_id':before.obs_id,'masked_obs_id':mapping.obs_id}
    delta_columns.update({n:after[n].to_numpy(dtype=float)-before[n].to_numpy(dtype=float) for n in sorted(numeric)})
    deltas=pd.DataFrame(delta_columns)
    def parquet_bytes(frame):
        b=io.BytesIO();frame.to_parquet(b,index=False,compression='zstd');return b.getvalue()
    recovery_manifest={'version':VERSION,'actual_sha256':sourcehash,'masked_sha256':sha(public/'obscured_dummy.dta'),
                       'seed_id':seed_id,'run':str(run),'delta_direction':'masked minus actual; original bytes retained to reverse rounding exactly'}
    files={'actual.dta':src.read_bytes(),'identity_mapping.parquet':parquet_bytes(mapping),'numeric_deltas.parquet':parquet_bytes(deltas),'manifest.json':json.dumps(recovery_manifest).encode()}
    archive=owner/'recovery.aesgcm'
    encrypt_recovery(seed,files,archive)
    restored=decrypt_recovery(seed,archive)
    assert set(restored)==set(files)
    for n in files:assert restored[n]==files[n],n
    try:decrypt_recovery(b'\0'*32,archive)
    except Exception:pass
    else:raise AssertionError('Wrong seed accepted')
    tampered=owner/'tamper-test.aesgcm';payload=bytearray(archive.read_bytes());payload[-1]^=1;tampered.write_bytes(payload)
    try:decrypt_recovery(seed,tampered)
    except Exception:pass
    else:raise AssertionError('Tampered archive accepted')
    tampered.unlink()
    shutil.copyfile(src,owner/'actual.dta');assert sha(owner/'actual.dta')==sourcehash
    seed_record={'seed_file':str(seedpath),'backup_seed_file':str(backup),'seed_id':seed_id,'run':str(run),'recovery_archive':str(archive),'recovery_sha256':sha(archive),'state':'passed'}
    write(seedpath.parent/'OWNER-RECOVERY.json',seed_record)
    summary={'status':'passed','version':VERSION,'run':str(run),'rows':len(before),'columns':len(before.columns),'protected_fields_exact':len(protected),
             'independent_continuous_fields':len(base),'derived_fields_checked':len(derived),'changed_numeric_fields':sum(r['changed_cells']>0 and r['variable'] in numeric for r in changes),
             'integer_band_exceptions':{r['variable']:r['outside_20_30'] for r in changes if r['variable'] in COUNTS},
             'integer_fallback_events':{n:exceptions[n] for n in COUNTS},'dummy_firms':int(after.firm_id.nunique()),
             'numeric_stata_replay_exact':True,'panel_replay_exact':True,'byte_exact_recovery':True,'wrong_seed_rejected':True,'tampering_rejected':True,
             'actual_sha256':sourcehash,'masked_sha256':sha(public/'obscured_dummy.dta'),'seed_id':seed_id,'seed_contents_published':False,
             'g1_reestimated':False,'privacy_checks':privacy,'source_code_sha256':{p.name:sha(p) for p in Path(__file__).parent.glob('*.py')}}
    write(run/'COMPLETE.json',summary);write(REPO/'downstream/obscure/strong/latest.json',summary)
    public_receipt={k:v for k,v in summary.items() if k not in ['run','actual_sha256','seed_id']}
    write(public/'COMPLETE.json',public_receipt)
    (public/'README.md').write_text('''# Obscured development data — 20–30% seeded masking

This folder contains only the masked dataset and aggregate documentation.
The actual dataset, private seed, cell mapping and recovery archive are outside it.
Research categories, years, source-quality flags and missingness are retained.
Observation IDs and source-row positions have been replaced with dummy keys.

Independent continuous base cells change by ±20–30%. People counts use integers;
tiny counts may have no valid integer in that band. Valid percentages stay in [0,100],
and pre-existing out-of-domain percentages remain out-of-domain and are counted;
retain zero/full-share anchors and the FDI 10% category. The worker >100 category
is retained. These constraints can reveal information and are documented.
Totals, emissions, logs, and ratios are recalculated from masked components;
their relative changes may be outside 20–30%. Source flags remain source flags.

The retained seed reproduces the changes exactly. Exact restoration after
rounding requires the owner's encrypted recovery archive as well as the seed.

This is bounded masking, NOT guaranteed anonymisation or fully synthetic data.
See reports/privacy_checks.json for targeted attack results and residual risks.
No real company linkage is asserted. G1 needs re-estimation for these values;
its columns remain missing rather than reusing stale estimates.

Open Stata in this folder and run 00_OPEN.do, or use obscured_dummy.dta directly.
''')
    (public/'00_OPEN.do').write_text('version 17\nset more off\nuse "obscured_dummy.dta", clear\nisid obs_id\nxtset firm_id year\nsummarize workers value_added_nominal gross_output_nominal\n')
    (run/'00_OPEN_OBSCURED.do').write_text(f'version 17\nset more off\nuse "{public/"obscured_dummy.dta"}", clear\nxtset firm_id year\nsummarize workers value_added_nominal\n')
    (run/'01_OPEN_ACTUAL.do').write_text(f'version 17\nset more off\nuse "{owner/"actual.dta"}", clear\nisid obs_id\n')
    (owner/'RECOVERY.md').write_text(f'''# Owner-only exact recovery

Seed file: `{seedpath}`. Backup: `{backup}`.
Keep both. Never put them into OBSCURED-ONLY or GitHub.
The encrypted archive also retains original DTA bytes, per-cell numerical deltas
and actual-to-masked identity mapping. Recovery does not depend on the old source.

Run:
```
python "{Path(__file__).parent/'recover.py'}" --seed-file "{seedpath}" --archive "{archive}" --output "/path/to/new/restored_actual.dta"
```
Use --audit-directory /new/private/folder to extract the mapping and deltas too.
Recovered DTA hash must be `{sourcehash}`.
''')
    # Only delete this build's private intermediates AFTER authenticated recovery
    # and deterministic replay pass. Seed and recovery are permanent deliverables.
    # exFAT removes an AppleDouble sidecar when its main file is deleted;
    # a directory iterator may still yield that now-absent sidecar.
    for p in list(work.glob('*.dta')):p.unlink(missing_ok=True)
    log('COMPLETE | '+json.dumps({k:v for k,v in summary.items() if k!='privacy_checks'}))

if __name__=='__main__':main()
