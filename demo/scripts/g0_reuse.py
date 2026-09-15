"""Rebind accepted G0 table code to the selected input; do not rewrite formulas."""
from pathlib import Path
import re
from workflow import SOURCE_RELEASE,sha,write_json,load,schema,quoted

OLD='/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2'
SELECTED=[
 'rows/G0/corrections/C160_publication_summaries.do',
 'rows/G0/publication/G0_X07_reported_accounting_diagnostics.do',
 'rows/G0/publication/G0_X08_worker_denominator_domains.do',
 'rows/G0/publication/G0_X09_capital_definition_coverage.do',
 'rows/G0/publication/G0_X10_log_domain_losses.do',
 'code/reports/rebuild_signed_thresholds.do',
 'rows/G0/publication/G0_X11_outlier_sensitivity.do',
 'rows/G0/publication/G0_X12_export_definition_states.do',
 'rows/G0/publication/G0_X13_rd_definition_states.do',
 'rows/G0/publication/G0_X18_nominal_real_gate.do',
 'rows/G0/publication/G0_X20_energy_component_coverage.do',
 'rows/G0/publication/G0_X21_electricity_and_own_generation.do',
 'rows/G0/publication/G0_X22_grid_assumption_coverage.do',
 'rows/G0/publication/G0_X23_energy_cost_reconciliation.do',
 'rows/G0/corrections/C170_flag_rates.do',
 'rows/G0/corrections/C180_export_roundtrip.do',
]


def prepare_tables(run):
    run=Path(run);state=load(run/'run.json');source=Path(state['config']['repo'])/SOURCE_RELEASE
    main=(source/SELECTED[0]).read_text()
    required=set(re.findall(r'generate double __v=([a-zA-Z_][a-zA-Z_0-9]*)',main))
    required |= {'obs_id','source_year','p99_econ_va','va_signed_nominal','out_checked_va','vs_rd_indicator_raw'}
    missing=sorted(required-set(schema(state['input'])['names']))
    report={'source_release':SOURCE_RELEASE,'input_sha256':sha(state['input']),
            'data_mode':state['config']['mode'],'original_G0_unchanged':True,
            'scope':'Recalculate selected G0 post-master statistical tables; not raw-source G0 construction or all 30 provenance reports.'}
    if missing:
        report.update(status='not_applicable',missing_columns=missing,
                      instruction='Use RUN_INPUT=g05_full for the complete frozen G0.5 contract. The Excel view supports the general summaries/coverage/panel modules.')
        write_json(run/'reports/g0-reuse.json',report)
        return False
    target=run/'g0'
    for folder in ['rows/G0/corrections','rows/G0/publication','code/reports','corrections/reports','corrections/data','corrections/logs','data/analysis']:
        (target/folder).mkdir(parents=True,exist_ok=True)
    records=[]
    files=['rows/G0/corrections/_utils.do',*SELECTED]
    for rel in files:
        text=(source/rel).read_text()
        # Owner-facing stage timing replaces the old per-statement logger.
        # Original explanatory WFDOC comments and all number-moving code remain.
        out='\n'.join(l for l in text.splitlines() if 'WFLOG-INJECTED' not in l)+'\n'
        out=out.replace(OLD,str(target))
        # Source-row provenance was screened from G0.5. These reports only retain it
        # in a use-list or an observation key: use the true observation key instead.
        out=re.sub(r'\bsource_row\b','obs_id',out)
        out=out.replace('"data/analysis/G0_analysis_ready.dta"',quoted(state['input']))
        if rel.endswith('/_utils.do'):
            old=[l for l in out.splitlines() if 'assert strpos' in l and 'c(tmpdir)' in l]
            if len(old)!=1: raise ValueError('Unexpected scratch guard in frozen G0 helper')
            out=out.replace(old[0],'* The owner may use Stata GUI scratch; inputs and outputs remain explicitly bound.\nassert `"`c(tmpdir)\'"\'!=""')
        dest=target/rel;dest.write_text(out)
        records.append({'source':str(source/rel),'source_sha256':sha(source/rel),'generated':str(dest.relative_to(run)),
                        'generated_sha256':sha(dest),'changes':['path rebinding','source_row -> obs_id observation key','statement logger removed; comments retained']})
    lines=['version 17',f'cd {quoted(target)}']
    for module_number,rel in enumerate(SELECTED,1): lines += [f'noisily display "G0 TABLE | modul {module_number}/{len(SELECTED)} | {Path(rel).stem}"',f'do {quoted(target/rel)}']
    (run/'code/g0_tables_generated.do').write_text('\n'.join(lines)+'\n')
    report.update(status='prepared',files=records,selected_original_modules=len(SELECTED),
                  excluded='Original ID acceptance and historical provenance-only reports are not re-labelled as current development results.')
    write_json(run/'reports/g0-reuse.json',report)
    return True


def collect_tables(run):
    import shutil
    run=Path(run);report=load(run/'reports/g0-reuse.json')
    if report['status']=='not_applicable': return
    target=run/'tables/g0';target.mkdir(exist_ok=True)
    paths=sorted((run/'g0/corrections/reports').glob('*.csv'))
    if not paths: raise ValueError('G0 code produced no CSV tables')
    for p in paths: shutil.copy2(p,target/p.name)
    report.update(status='passed',tables=[{'path':str((target/p.name).relative_to(run)),'sha256':sha(target/p.name)} for p in paths])
    write_json(run/'reports/g0-reuse.json',report)
