#!/usr/bin/env python3
"""Build readable source/code/workbook indices and dependency documentation."""
from pathlib import Path
from urllib.parse import quote
from collections import Counter
import csv,json,os,re
import openpyxl
ROOT=Path(__file__).resolve().parents[1]

DEPENDENCIES={
'C_RAW':('Current intake','12 safe-sample annual waves 2010–15 and 2017–22; 2016 absent. Original 17-source intake also includes full2010 reference and four supporting concordances. Raw/microdata excluded from Git.','Local inputs available; restricted'),
'C_CODEBOOK':('Annual definitions','TOAR layout workbook 2010–15, IBS questionnaires, BPS dictionaries and newer form evidence. Capital definitions beyond verified years, 2017/18 binary directions, 2019 export keys and 2018/19 fuel units still need exact annual closure.','Partly verified; evidence included'),
'C_ID':('Source identity','Provenance key source_year/source_row exists; masked original identifiers do not establish a crosswave firm link. Keep source ID and observation ID distinct.','Source-record key ready; panel key unresolved'),
'C_REAL_PANEL':('Longitudinal firm panel','Genuine stable firm identifier/crosswalk, duplicate policy, year gaps and observation universe. No synthetic or optional dummy identity may support a substantive panel claim.','Not connected in current safe-sample analysis'),
'C_MAIN':('Current G0 interface','33,049 × 3,776 candidate, hash 38d4a06b5a42321f2c292f2e57cf77f8b32dccfba3c6a13fce58c23e226e8e09; stable working values plus verified-only companions. File remains local.','Working schema published; semantic gates remain'),
'C_QA':('Quality eligibility','G2 September 9 audit on hash 433e847336046c41f7fab51408fa57fe24e04a69005db0e8a3da097c15b8b9c3. Refresh after G0 September 10 before asserting downstream acceptance.','Baseline outputs available; current refresh pending'),
'C_WPI':('Price deflators','Toar reported a new upload September 4; exact new file not located/integrated. Legacy output WPI through 2012, input WPI through 2016 and LUDI IHPB workbooks are references, not a verified full 2010–22 series. Check base year, annual/industry coverage and variable-specific price basis.','Historical references available; current integration missing'),
'C_CLASSIFICATION':('Industry/product/geography bridges','Raw industry and province codes exist; HS/BTKI concordances do not automatically harmonise SI industry revisions. State code vintage, group membership and cross-revision evidence. District/subdistrict fields remain masked/unavailable.','Partial reference inputs; semantic bridges pending'),
'C_ENERGY_FACTORS':('Physical energy and emissions','LUDI nine-fuel method plus current unit recodes; separate fuel/electricity scopes. Validate missing components, extra fuels, units and electricity accounting. Post-2014 grid carry-forward is an assumption, not an observed annual factor series.','Existing partial construction; full coverage/factors pending'),
'C_OLD_VINTAGES':('SI old/new pairs','LUDI old annual 2010–14 available; old2015 not found in the bounded search. New2010–15 safe samples and old annual population differ. Align variables/units/universe before interpreting vintage differences.','Five old years located; equality not established'),
'C_POLICY_TIMING':('Paris exposure/timing','Define pre-period 2013–14, transition2015 and post as in proposed Word alternative, acknowledging missing2016. A common policy date does not create staggered adoption. Separate causal and adjusted-comparison estimands.','Design decision; no validated policy effect'),
'C_REPLICATION_SPEC':('Prior paper design','Read July manuscript and BJS sustained-entry code; distinguish final-paper tables from diagnostics, older data scope and alternative estimators. Preserve entry/reversal/control and support rules.','Substantial code/reference evidence available'),
'C_ENTRY_EVENTS':('Export/import entry','A real history is required to infer event timing; first observed trading is not necessarily first ever trading. Define sustained participation and reversals/left censoring.','Depends on real panel and trade semantics'),
'C_ENV_GOODS':('Environmental-goods imports','Firm×product import values, product codes, environmental-goods classification and time-consistent linkage; aggregate imported-material value cannot reveal goods type.','Detailed linked source not registered'),
'C_COVID_FRAME':('COVID observation universe','Pre-COVID roster, survey coverage/nonresponse, verified closure if available, return after absence and real growth measures. Absence is not automatically death.','Real observation-spell data and definitions pending'),
'C_COVID_COHORT':('Common COVID cohort','Share R4 baseline/trajectory definitions with R10 and G20; freeze internationalisation before shock and separate survivors from the original cohort.','Not built on a validated current panel'),
'C_DESTINATIONS':('Export destinations','Firm/product/destination values, direct/indirect export concept, code concordance and denominator. Do not infer destinations from export participation alone.','Linked source not supplied/registered'),
'C_FOREIGN_POLICY':('Foreign climate-policy exposure','Select a concrete policy, dates within available outcomes, exposed products/markets and predetermined exposure weights; establish comparison design before estimating.','Policy/exposure design not specified'),
'C_ACQUISITIONS':('Foreign acquisitions','Time-varying ownership and credible domestic-to-foreign acquisition dates, threshold/measurement/reversal rules. A cross-sectional FDI flag is insufficient.','Ownership levels partly available; events not validated'),
'C_PRODUCTS':('Proman / firm-product panel','Firm×product×year values/quantities, scope/reporting thresholds, product revisions and reconciliation to firm totals. Missing module is not zero products.','Detailed module not supplied/registered'),
'C_WORKFORCE':('Workforce and wages','Total/production/nonproduction workers, sex composition and wages with annual definitions, units and coverage. Separate growth/composition and avoid mechanical ratio relationships.','Raw/canonical fields partly available; full harmonisation pending')}

def write(path,text):path.parent.mkdir(parents=True,exist_ok=True);path.write_text(text.rstrip()+'\n')
def link(base,target,label=None):return '['+(label or Path(target).name)+']('+quote(os.path.relpath(ROOT/target,base),safe='/._-')+')'

def main():
    sources=json.loads((ROOT/'catalog/source-files.json').read_text());included=[r for r in sources if r['disposition']=='included'];tasks=json.loads((ROOT/'requests/registry.json').read_text())
    rows=[]
    for r in included:
        if Path(r['repository_path']).suffix.lower() not in {'.do','.ado'}:continue
        body=(ROOT/r['repository_path']).read_text(errors='replace').lower()
        tags=[x for x,p in {'TFP/prodest':r'\bprodest\b','BJS':r'\bdid_imputation\b','Sun-Abraham':r'\beventstudyinteract\b','dCDH':r'\bdid_multiplegt','CS-DID':r'\bcsdid\b','energy/emissions':r'co2|total_gj|carbon|emission','WPI/deflation':r'\bwpi|deflat','quality':r'assert |missingness|quality'}.items() if re.search(p,body)]
        rows.append({'collection':r['collection'],'repository_path':r['repository_path'],'source':r['source'],'sha256':r['sha256'],'bytes':r['bytes'],'method_keyword_tags':'; '.join(tags)})
    with (ROOT/'catalog/code.csv').open('w',newline='') as f:
        w=csv.DictWriter(f,fieldnames=list(rows[0]));w.writeheader();w.writerows(rows)
    counts=Counter(r['collection'] for r in included);doccounts=Counter(r['collection'] for r in included if Path(r['repository_path']).suffix.lower() in {'.pdf','.docx','.pptx'});codecounts=Counter(r['collection'] for r in rows)
    txt='# Research references and predecessor code\n\nAll folders are frozen source copies. Existing titles such as FINAL or COMPLETE describe their historical scope; consult the current task registry before applying their results to SI 2010–2022. Datasets and private runtime material are excluded.\n\n## Recommended reading order\n\n'
    keys=[
      ('Latest Word','references/deasy-word/List do file yang perlu dibuat.docx'),
      ('July manuscript','references/july-replication/00_reference/final_docx/20260707_Can_Internationalization_Improve_Environmental_Performance.docx'),
      ('July end-to-end package','references/july-end-to-end/README.md'),
      ('TOAR SI construction','references/july-end-to-end/provenance/original_legacy_support/002-TOAR/12apr2026/code/01_clean_SI_trade_panel.do'),
      ('TOAR old/new value comparison','references/july-end-to-end/provenance/original_legacy_support/002-TOAR/12apr2026/code/02c_compare_data_values.do'),
      ('TOAR original layout workbook','references/july-end-to-end/provenance/original_legacy_support/002-TOAR/12apr2026/docs/layout IBS Lama (1975-2015).xlsx'),
      ('LUDI raw-to-energy/emissions handover','references/ludi-handover/HANDOVER-README FIRST.md'),
      ('LUDI emissions construction','references/ludi-handover/dofiles/10_carbon_convert.do'),
      ('Legacy TFP implementation','references/cips-harness/files/ART-01-65f84f83/C850_build_csis_prodest_tfp.do'),
      ('Legacy TFP method summary','references/cips-harness/files/ART-01-0828a8fc/850_csis_prodest_tfp_method_summary.csv'),
      ('Legacy CIPS panel builder','references/cips-harness/files/ART-01-736cac09/01_build_cips_replication_panel.do'),
      ('Legacy CIPS estimation','references/cips-harness/files/ART-01-9846ff6b/02_estimate_export_cips_results.do'),
      ('August CSIS revision','references/csis-august/README.md')]
    missing=[]
    for label,path in keys:
        if (ROOT/path).exists():txt+='- '+link(ROOT/'references',path,label)+'.\n'
        else:missing.append({'label':label,'path':path})
    txt+='\n## All source collections\n\n| Collection | Included files | Stata files | Documents |\n|---|---:|---:|---:|\n'
    for col,n in counts.items():
        root='research/1014' if col=='project' else 'references/'+col.replace('_','-')
        txt+='| '+link(ROOT/'references',root,col)+' | '+str(n)+' | '+str(codecounts[col])+' | '+str(doccounts[col])+' |\n'
    txt+='\n## Search and provenance\n\n'+link(ROOT/'references','catalog/code.csv','All Stata code with method-keyword tags')+' · '+link(ROOT/'references','catalog/documents.csv','Every paper/document and text companion')+' · '+link(ROOT/'references','catalog/workbook-screening.json','Workbook sheets and screening')+' · '+link(ROOT/'references','catalog/source-files.csv','Every source inclusion/exclusion and original path')+'.\n\nKeyword tags are discovery aids, not proof that a method is correctly implemented or executed. Identical hashes identify repeated package copies. Text companions preserve searchable prose; the original file remains authoritative for layout, tables, track changes and equations.\n\n## Source coverage limits\n\nThe original cips-csis-research, CSIS_v2, CIPS_v2 and coauthor-harness roots were unavailable at their historical paths; available mirror and replication copies are included. The July end-to-end provenance contains seven actual TOAR Stata files and the original layout workbook. Direct Toar WhatsApp export ZIPs inspected here contain chat only, not attached WPI/code files. This does not prove the later shared-folder WPI is absent. Unrelated attachments from other coauthor exports were not copied.\n\nThe external-drive source mixes in a separate China-shock/poverty study: only four IBS questionnaires are included from it. Live Optimum databases/raw chats/full session or Home bodies are omitted; its relevant research code, documents and evidence mirror remain available.\n\nOpaque original ZIPs containing datasets are not uploaded. LUDI was selectively extracted; project and July ZIP families are represented by their existing expanded source trees. The source catalogue retains the archive locators without claiming the local patched ZIP equals an earlier sent attachment.\n'
    write(ROOT/'references/README.md',txt)
    doc_index=json.loads((ROOT/'catalog/documents.json').read_text()) if (ROOT/'catalog/documents.json').exists() else []
    workbooks=[r for r in included if r['repository_path'].lower().endswith('.xlsx')]
    readme='# Publication catalogue\n\nThe catalogue records actual inspected files; it does not infer missing attachments or declare every historical result current.\n\n'
    readme+=f'- {len(sources):,} source entries considered; {len(included):,} included; {len(sources)-len(included):,} excluded.\n- {len(rows):,} Stata source-file copies (including generated nodes and repeated package copies).\n- {len(workbooks):,} included Excel workbooks, opened with openpyxl for sheet/grain screening; copies are unchanged and are not claimed freshly recalculated or visually reviewed.\n- {len(doc_index):,} retained PDF/DOCX/PPTX source copies indexed; text extraction status is recorded per unique document.\n\n'
    readme+='| File | Purpose |\n|---|---|\n| [source-files.csv](source-files.csv) / [JSON](source-files.json) | Exact source path, repository destination, size, hash and inclusion/exclusion reason. Dataset contents are absent. |\n| [code.csv](code.csv) | Every retained Stata file; keyword-based method discovery. |\n| [documents.csv](documents.csv) / [JSON](documents.json) | Original document and searchable text companion, extraction coverage/status. |\n| [workbook-screening.json](workbook-screening.json) | Sheet dimensions and inclusion decisions. |\n| [snapshot-summary.json](snapshot-summary.json) | Snapshot counts and read errors. |\n| [validation.json](validation.json) | Independent final Word, source-hash, navigation and publication-boundary checks. |\n\nExclusions cover datasets, firm-level diagnostics, raw safe-sample Excel, private communications/Home/session payloads, live databases, unavailable symlinks and unrelated projects/runtime files. Price-index/concordance workbooks and aggregate tables are eligible; anonymised microdata remains excluded.\n\nHistorical source files retain exact bytes, so old absolute links may still point to local sources. Resolve them with `python3 harness/manage.py find-source NAME` from the repository root. New navigation is checked separately.\n'
    write(ROOT/'catalog/README.md',readme)
    deps='# Input and shared-method dependencies\n\nThese are acceptance contracts, not evidence that missing data has been obtained. All requirements below are represented in the request packets. G0 working fields can support bounded tables while full panel/causal/population gates remain open.\n\n'
    for k,(title,definition,state) in DEPENDENCIES.items():
        uses=[r['request_id'] for r in tasks if k in r['dependency_ids']]
        deps+=f'## {k} — {title}\n\n**State:** {state}.\n\n{definition}\n\nCore request dependencies: '+(', '.join(uses) or 'See per-row specific data dependencies; may be used by descriptive extensions.')+'\n\n'
    deps+='## Descriptive branches need row-specific inputs too\n\nEvery descriptive packet includes its own `specific_data_dependencies`; the common C_MAIN/C_QA pair is not the complete dependency list. Product/destination/entry-exit/decomposition/geography rows cannot be implemented from a generic firm table without their detailed source contracts. G1 TFP is required for the TFP cells of repeated descriptive matrices, but other eligible outcomes can be reported separately if the owner selects a bounded scope and missing TFP cells remain explicit.\n'
    write(ROOT/'docs/DEPENDENCIES.md',deps)
    write(ROOT/'data/README.md','''# Data stays in a separately controlled local environment

This repository intentionally contains no establishment/firm-level datasets. That includes the anonymised safe-sample Excel files, prepared Stata inputs, analysis candidates, TFP predictions, panel CSVs and firm-level mismatch reports. Code, aggregate results and data documentation are included.

## Locate and connect inputs

1. Read the chosen row's input/dependency contract and docs/CURRENT-STATE.md.
2. Locate the source in catalog/source-files.csv or the original Stata source registries under research/1014. Excluded inputs retain source paths/sizes; source-provided hashes are available in historical manifests. The publication catalogue does not pretend to have freshly hashed every excluded multi-GB dataset.
3. Copy local-inputs.example.json to ignored local-inputs.json and populate permitted local paths. This is documentation/configuration, not an automatic data downloader.
4. A data-run worker checks availability, input versions, schema, key, units and expected universe before any authorised Stata execution. Do not fabricate missing input files to make a run succeed.

## Current version boundary

Current G0: 33,049 records × 3,776 columns, SHA256 38d4a06b5a42321f2c292f2e57cf77f8b32dccfba3c6a13fce58c23e226e8e09.

G2/G3 and the September 9 flat snapshot used the earlier 3,496-column G0, SHA256 433e847336046c41f7fab51408fa57fe24e04a69005db0e8a3da097c15b8b9c3. An accepted prior run does not validate a later upstream candidate. Keep both versions locally and record the exact dependency for each run.

The flat September 9 snapshot starts from prepared annual DTA inputs. It requires 23 prepared/reference inputs and is sample-specific; it is not a fresh raw-Excel/full-BPS release. Original paths/hashes and input-name conventions are documented in the retained snapshot metadata.

## Safe reference content

Price indices, classification concordances, empty forms, source-layout/codebook workbooks and aggregate result workbooks can be retained. A metadata field named psid in a variable dictionary is not an observation; a table of psid/year/TFP values is microdata. The source screening distinguishes those cases. One TOAR comparison workbook contains a Detailed Mismatches sheet and is withheld as a whole; its layout codebook is included separately.

Private GitHub access does not change the dataset exclusion. Never commit credentials, dataset ZIPs, live application databases, raw chat exports or complete shared Home content. Do not reverse masked IDs or infer linkage from row order.
''')
    (ROOT/'data/local-inputs.example.json').write_text(json.dumps({'schema_version':1,'note':'Replace only with permitted local paths. This file contains no data and does not run Stata.','g0_current_candidate':'/YOUR/LOCAL/DATA/G0_main_candidate.dta','g0_current_expected_sha256':'38d4a06b5a42321f2c292f2e57cf77f8b32dccfba3c6a13fce58c23e226e8e09','g0_september9_baseline':'/YOUR/LOCAL/DATA/G0_main_accepted_20260909.dta','prepared_annual_directory':'/YOUR/LOCAL/DATA/staged','old_si_annual_directory':'/YOUR/LOCAL/DATA/old-si','verified_wpi_path':None,'real_firm_crosswalk_path':None,'product_proman_directory':None},indent=2)+'\n')
    (ROOT/'harness/requirements.txt').write_text('openpyxl=='+openpyxl.__version__+'\n')
    write(ROOT/'harness/README.md','''# Repository tooling

`manage.py` is the safe entrypoint: list/show requests, print review prompts, find sources and validate the repository. It uses Python's standard library. No command starts analysis or another agent.

Build order in the original owner workspace:

1. `build_source_snapshot.py`: uses the ignored local metadata inventory to screen/copy sources and build provenance. Requires openpyxl. Original sources never change; excluded staged copies are preserved in local withheld-staging, outside publication.
2. `index_documents.py`: creates searchable companions for included PDF/DOCX/PPTX. Uses pdftotext for PDFs and XML extraction for Office files; no new PDF rendering.
3. `build_requests.py`: joins exact Word rows, prior detailed plans and current state into 44 packets.
4. `build_catalogue.py`: indices and input contracts.
5. `build_readme.py`: comprehensive entrypoint from the current request registry.
6. `manage.py validate`: exact Word comparison, source hashes, file/privacy boundaries and new navigation.

These are documentation/packaging tools. Archived Stata code and result builders have their own execution/input requirements. A fresh clone already contains the complete publication snapshot and does not need the local inventory to read/review it. Rebuilding the source snapshot requires original source roots and a fresh manager-approved inventory; never blindly replace newer accepted clone edits.

Word source/PIC and current-vs-historical status are validated separately. Document extraction logs explicitly distinguish no text layer or invalid source files; it is not a claim of substantive full-paper review. Original workbook bytes are retained; screening opens their sheets without recalculating or changing formulas.
''')
    print(json.dumps({'included':len(included),'stata_files':len(rows),'workbooks':len(workbooks),'key_reference_paths_missing':missing},indent=2))

if __name__=='__main__':main()
