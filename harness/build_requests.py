#!/usr/bin/env python3
"""Build 44 source-faithful task packets and a portable dependency registry.

Documentation only: this program does not invoke Stata or compute estimates.
"""
from pathlib import Path
from datetime import datetime
from zoneinfo import ZoneInfo
from urllib.parse import quote
import csv, json, os, re

ROOT=Path(__file__).resolve().parents[1]
BASE=ROOT/'research/1014'
LEDGER=BASE/'04-working-understanding/20260908-deasy-word-review/request-ledger.json'
PLAN=BASE/'04-working-understanding/20260909-planning-only/row-plan.json'
DAG='research/1014/05-analysis/analytical-dag'
G0REPORT=DAG+'/dag/reports/word_data/G0/20260910-code-verification'
CURRENT_HASH='38d4a06b5a42321f2c292f2e57cf77f8b32dccfba3c6a13fce58c23e226e8e09'
BASELINE_HASH='433e847336046c41f7fab51408fa57fe24e04a69005db0e8a3da097c15b8b9c3'
SLUGS={
 'G0':'data/00-main-dataset','G1':'data/01-tfp','G2':'data/02-quality-checks','G3':'data/03-old-new-si',
 'G4':'descriptive/general/04-all-variables','G5':'descriptive/general/05-sector-2-digit','G6':'descriptive/general/06-sector-5-digit',
 'G7':'descriptive/general/07-firm-characteristics','G8':'descriptive/general/08-exporters','G9':'descriptive/general/09-importers',
 'G10':'descriptive/general/10-four-trade-groups','G11':'descriptive/general/11-fdi-domestic','G12':'descriptive/general/12-soe-private',
 'G13':'descriptive/general/13-size','G14':'descriptive/general/14-sectors','G15':'descriptive/general/15-location',
 'G16':'descriptive/general/16-energy','G17':'descriptive/general/17-emissions','G18':'descriptive/general/18-materials',
 'G19':'descriptive/general/19-proman','G20':'descriptive/general/20-covid-trajectories',
 'G21a':'descriptive/general/21a-product-scope','G21b':'descriptive/general/21b-export-destinations',
 'D1':'descriptive/decarbonisation/01-aggregate-trends','D2':'descriptive/decarbonisation/02-carbon-intensity-identity',
 'D3':'descriptive/decarbonisation/03-emissions-concentration','D4':'descriptive/decarbonisation/04-fhk-melitz-polanec',
 'D5':'descriptive/decarbonisation/05-energy-mix-transitions','D6':'descriptive/decarbonisation/06-self-generation',
 'D7':'descriptive/decarbonisation/07-internationalisation-gradient','D8':'descriptive/decarbonisation/08-rd-environment',
 'D9':'descriptive/decarbonisation/09-employment-changes','D10':'descriptive/decarbonisation/10-regional',
 'R1':'estimation/01-paris-internationalisation','R2':'estimation/02-replicate-energy-efficiency',
 'R3':'estimation/03-energy-emissions-correlates','R4':'estimation/04-covid-survival',
 'R5':'estimation/05-foreign-climate-policy','R6':'estimation/06-exporter-adjustment-margins',
 'R7':'estimation/07-foreign-acquisition','R8':'estimation/08-export-entry-products',
 'R9':'estimation/09-decarbonisation-decomposition','R10':'estimation/10-covid-resilience',
 'R11':'estimation/11-decarbonisation-employment'}

# Concrete completion contracts for the 29 descriptive rows. Exact requests,
# historical findings and source locators are joined from the audited Word ledger.
DESIGN={
 'G4':('Generate the full variable × transformation × pooled/year × statistic grid. Counts distinguish observed, zero, negative, missing and structurally unavailable. Levels and positive-domain logs use explicitly named samples; monetary levels remain nominal until an appropriate deflator is connected.',
        ['all_variable_statistics.csv','log_domain_coverage.csv'],['annual_coverage.png','selected_distributions.png']),
 'G5':('Reuse the G4 table contract within every reported two-digit industry. Preserve raw coding vintage and separate harmonised-sector results. Pooled comparisons require a cross-revision classification decision; display sparse and unknown cells.',
        ['sector2_statistics.csv','sector2_classification_coverage.csv'],['sector2_coverage.png','sector2_distribution_comparison.png']),
 'G6':('Extend G4 to every five-digit industry, including empty/unsupported cells in the specification. Report cell sizes and code vintage; set a disclosure/sparse-cell policy before any external full-data release. Do not substitute the ten largest industries for the requested universe.',
        ['sector5_statistics.csv','sector5_support.csv'],['sector5_coverage.png','sector5_selected_distributions.png']),
 'G7':('Build one shared outcome matrix for all listed characteristics. Separate available working values from verified-only values using G0 status companions. Include TFP as explicit pending cells until G1 is validated. This is the common descriptive engine, not a causal design.',
        ['characteristics_pooled_year.csv','outcome_availability_matrix.csv'],['characteristics_over_time.png','availability_by_family.png']),
 'G8':('Compare observed exporters and nonexporters over the full G7 matrix; retain unknown status and show working versus verified-only sensitivity. Treat 2022 direct exports separately: no direct export does not prove no exports of any kind. Group gaps are descriptive.',
        ['exporter_comparison.csv','export_classification_coverage.csv'],['exporter_outcome_gaps.png','export_status_coverage.png']),
 'G9':('Use the verified imported-material-value definition, maintaining zero versus missing. Apply G7 to importers/nonimporters, and document that using imported-origin materials is not automatically direct customs import participation.',
        ['importer_comparison.csv','import_definition_coverage.csv'],['importer_outcome_gaps.png','importer_share_by_year.png']),
 'G10':('Define four mutually exclusive groups only where both trade indicators are observed: neither, exporter only, importer only, both. Retain a fifth unknown group outside the four known groups and reconcile group counts to the population. Produce the G7 outcome grid.',
         ['four_trade_groups.csv','trade_group_reconciliation.csv'],['trade_group_shares.png','trade_group_outcomes.png']),
 'G11':('Record the FDI threshold before comparing with domestic firms. Current G0 offers >=10%; any foreign ownership is a distinct sensitivity. Preserve unknown ownership and report yearly source breaks before treating variation as economic change.',
         ['fdi_domestic_comparison.csv','ownership_threshold_sensitivity.csv'],['fdi_outcome_gaps.png','foreign_ownership_distribution.png']),
 'G12':('Construct state ownership from central and local government share fields after annual codebook checks. Define majority/minority/mixed/private and unknown categories explicitly. Retained raw ownership fields are inputs, not an already completed SOE classifier.',
         ['state_ownership_definition_audit.csv','soe_private_comparison.csv'],['state_ownership_coverage.png','soe_private_outcomes.png']),
 'G13':('Use the Word boundary strictly: large means workers >100. Report firms exactly at 100 separately and preserve the wording ambiguity small/medium. Do not silently use the old >=100 or quartile classifications. Produce all G7 requested comparisons.',
         ['size_group_comparison.csv','worker_100_boundary_audit.csv'],['size_distribution.png','size_group_outcomes.png']),
 'G14':('Reuse G5 industry definitions and add every G7 outcome family. Keep this separate request and its acceptance mapping, while sharing calculations to avoid two conflicting sector summaries.',
         ['sector_characteristics.csv','sector_outcome_coverage.csv'],['sector_characteristics.png','sector_trends.png']),
 'G15':('Map province codes to labels and Java/non-Java with an explicit boundary-year convention. District and subdistrict outputs require usable source geography; masked values remain unavailable. Produce sector and characteristic comparisons over the documented region-year universe.',
         ['province_java_statistics.csv','geography_availability.csv'],['province_comparison.png','java_nonjava_trends.png']),
 'G16':('Use physical energy on a common GJ basis and separate fuel, purchased electricity and total. Apply current coal/coke units, state the nine-fuel boundary and unresolved extra-fuel coverage. Define dominant fuel using energy shares, not expenditure or raw quantities in incompatible units.',
         ['energy_scope_characteristics.csv','fuel_mix_coverage.csv'],['energy_scope_trends.png','fuel_mix_by_sector.png']),
 'G17':('Report Scope 1, Scope 2 and total separately using a named factor scenario and component-completeness rule. State whether emissions are CO2 or CO2e. Current outputs are partial and post-2014 grid factors carry an assumption; do not label them verified national emissions.',
         ['emissions_scope_characteristics.csv','emissions_factor_coverage.csv'],['emissions_scope_trends.png','emissions_by_sector.png']),
 'G18':('Separate the available firm-level imported-material totals from the unprovided material-product-origin module. Validate the denominator as materials, not total IINPUT by default. Varieties, origins and sourcing concentration need linked detailed records, with shares reconciled to firm totals.',
         ['materials_linkage_feasibility.csv','imported_material_shares.csv','sourcing_variety_concentration.csv'],['imported_material_share_distribution.png','sourcing_by_industry.png']),
 'G19':('Obtain and document the Proman firm-product-year module, its domestic/export production values and destinations. Reconcile product totals to firm totals and separate direct versus indirect exports. A sparse aggregate share multiplied by output does not recreate missing product records.',
         ['proman_coverage_reconciliation.csv','production_export_characteristics.csv','product_destination_summary.csv'],['proman_reporting_coverage.png','production_export_mix.png']),
 'G20':('Use the same observed pre-COVID cohort and trajectory definitions as R4/R10. Distinguish nonresponse and disappearance from verified closure; follow return and recovery through 2022. Descriptive counts can precede a survival model, but longitudinal classification requires genuine firm links.',
         ['covid_cohort_flow.csv','recovery_trajectory_characteristics.csv'],['cohort_flow.png','recovery_paths.png']),
 'G21a':('Use the same product-grain contract as R8: harmonised positive-output products, value shares, HHI, core share and true product entry/exit. Missing product modules are not zero product scope. Trade and ownership group comparisons require reconciled coverage.',
          ['product_scope_summary.csv','product_restructuring.csv','product_reporting_coverage.csv'],['product_scope_distribution.png','product_entry_exit.png']),
 'G21b':('Build firm-destination-year values with exhaustive geographic group membership and documented time-varying EU/ASEAN conventions. Compute concentration/diversification with known denominators; define the high-environmental-standard classification independently of outcomes. Link feasibility to R5.',
          ['destination_group_shares.csv','destination_concentration.csv','market_classification.csv'],['destination_composition.png','destination_diversification.png']),
 'D1':('Use population-qualified annual and sector totals and ratio-of-totals. Define the exact scale/intensity accounting convention, real VA/output price basis and constant component universe. Safe-sample totals answer a sample exercise; national decarbonisation needs full/representative data.',
        ['annual_sector_energy_emissions.csv','scale_intensity_components.csv','population_coverage.csv'],['aggregate_trends.png','scale_intensity_decomposition.png']),
 'D2':('Verify CO2/VA = (GJ/VA) × (CO2/GJ) on the identical eligible sample, weights and scope. For change attribution specify a log or exact finite-change convention and residual tolerance. Zero/negative VA or zero GJ need separate status, not arbitrary replacement.',
        ['carbon_energy_identity.csv','intensity_change_components.csv'],['efficiency_carbon_content_trends.png','identity_decomposition.png']),
 'D3':('Rank a common emissions population, define top-share ties and weighting, and use the same ranked firms for output/VA/employment/export shares. Produce every requested percentile inside KBLI5 and Lorenz/Gini with nonnegative emissions and explicit coverage.',
        ['top_emitter_shares.csv','sector5_intensity_percentiles.csv','lorenz_gini.csv'],['emissions_lorenz.png','top_emitter_shares.png']),
 'D4':('Share the FHK/Melitz–Polanec implementation with R9. Define incumbent, entrant and exiting sets using real survey/firm coverage; choose denominator-consistent weights. Components must sum to the observed aggregate change for each requested grouping.',
        ['fhk_components.csv','melitz_polanec_components.csv','component_reconciliation.csv'],['within_reallocation_entry_exit.png','decomposition_by_group.png']),
 'D5':('Build a comparable annual energy-share vector before classifying dominant fuels. State thresholds and a mixed class; separate source-unit uncertainty from true switches. Real firm links are required for transition matrices, with 2016 missing rather than an invented one-year transition.',
        ['annual_energy_mix.csv','fuel_class_definitions.csv','transition_matrices.csv'],['fuel_mix_by_year.png','fuel_transition_matrix.png']),
 'D6':('Audit generation ownership, capacity, generated electricity, generator fuel and reporting coverage independently. Denominator for own-electricity share includes purchased and generated electricity on compatible units; avoid double counting fuel plus its generated electricity in total primary energy.',
        ['self_generation_coverage.csv','self_generation_characteristics.csv','electricity_accounting.csv'],['self_generation_share.png','generation_by_sector.png']),
 'D7':('Translate the seven Word categories into explicit predicates before computing shares. The list omits an FDI importer-only case and can overlap; retain residual and unknown groups and obtain a classification decision. Shares must reconcile to their stated eligible universe.',
        ['internationalisation_groups.csv','group_shares_reconciliation.csv','group_productivities.csv'],['internationalisation_shares.png','productivity_gradient.png']),
 'D8':('Use the current G0 verified-only and working companions for R&D, innovation, environmental management and waste. IRDVCU is R&D money; COSTRD is a funding indicator. Use the correct 1/2,3/4,5/6,7/8 code pairs and conditional waste universe. Restrict each table to years/questions actually supplied.',
        ['rd_environment_cross_tabs.csv','rd_spending_ratios.csv','question_universe_coverage.csv'],['capability_incidence.png','capability_by_trade_group.png']),
 'D9':('Define the within-firm intensity-change window and falling/rising threshold before comparing employment, production/nonproduction, sex composition, wages and worker ratios. Separate availability/selection and common numerator effects; describe associations, not job effects of a treatment.',
        ['intensity_change_groups.csv','workforce_changes.csv','workforce_coverage.csv'],['employment_by_intensity_change.png','workforce_composition_changes.png']),
 'D10':('Reuse G15 geography and D1 aggregation contracts for VA, energy, emissions, intensity, trade, FDI and mix. Do province/Java results only where supported; district output remains explicitly unavailable on masked geography. National representativeness is a separate gate.',
         ['regional_decarbonisation.csv','regional_coverage.csv'],['province_intensity.png','regional_energy_mix.png'])}

def dump(path,obj):
    path.parent.mkdir(parents=True,exist_ok=True);path.write_text(json.dumps(obj,ensure_ascii=False,indent=2)+'\n')
def write(path,s):
    path.parent.mkdir(parents=True,exist_ok=True);path.write_text(s.rstrip()+'\n')
def link(fromdir,target,label=None):
    rel=os.path.relpath(ROOT/target,fromdir)
    return '['+(label or Path(target).name)+']('+quote(rel,safe='/._-')+')'
def bullets(items):return '\n'.join('- '+str(a) for a in items)

def main():
    old=json.loads(LEDGER.read_text()); plans={a['review_id']:a for a in json.loads(PLAN.read_text())}
    source_structure=json.loads((BASE/'04-working-understanding/20260908-deasy-word-review/evidence/docx-structure.json').read_text())
    sources=json.loads((ROOT/'catalog/source-files.json').read_text())
    mapped={r['source']:r['repository_path'] for r in sources if r['disposition']=='included'}
    def translate(path):
        if path in mapped:return mapped[path]
        if not path.startswith('/') and (BASE/path).is_file():return 'research/1014/'+path
        return None
    all_tasks=[]; registry=[]
    for row in old:
        # The older ledger trimmed PIC whitespace. Restore exact DOCX cell text
        # while keeping display labels stripped for readable tables.
        row=dict(row)
        source_table=next(t for t in source_structure['tables'] if t['table']==row['table'])
        source_row=next(r for r in source_table['rows'] if r['row']==row['physical_row'])
        cells=[c['text'] for c in source_row['cells']]
        row['source_pic']=cells[5] if row['table']==3 else cells[3]
        rid=row['review_id']; plan=plans.get(rid); path='requests/'+SLUGS[rid]; folder=ROOT/path
        group='data' if rid in {'G0','G1','G2','G3'} else 'estimation' if rid.startswith('R') else 'descriptive'
        state='awaiting_owner_selection' if group=='descriptive' else 'planning_only'
        status='partial_foundation' if row['status']=='partial' else 'no_row_output'
        current='The 8 September assessment below is historical. This row has not been executed as a complete Word request. Current G0 supplies more fields; a retained raw field or predecessor table is not completion of this row.'
        existing=[];charts=[]
        if rid=='G0':
            state='bounded_working_interface_published';status='partial_full_word_request'
            current='10 September 11:25 WIB: stable working candidate published, 33,049 rows × 3,776 fields, with all 2,545 raw fields preserved. Named working indicators have verified-only companions; vs_=10 marks provisional values. R&D money is IRDVCU; COSTRD is funding status. Coal/coke unit corrections and conditional environment/waste recodes are incorporated. 2,796 source verification nodes and 108 working-value nodes exist as worker fragments. WPI, genuine panel links and complete energy/emissions verification remain open. Bounded stages ran; the full composite primary has not been rerun end-to-end. This is schema/working-value readiness, not proof that the entire Word row is finished.'
            existing=[G0REPORT+'/'+n for n in ['OWNER-READINESS.md','G0-ANALYSIS-CONTRACT.md','G0_schema_contract.csv','G0_variable_year_workbook.xlsx','candidate-publication.json','final-publication-validation.json','variable_year_registry_fragment.csv','analysis_tunnel_registry_fragment.csv']]
        elif rid=='G1':
            state='legacy_reuse_design_pending';status='legacy_methods_available_not_integrated'
            current='Legacy C850 contains actual prodest Wooldridge, LP and LP-ACF and stored coefficient/method-summary evidence. OP has no executed branch and needs a valid positive investment design. The old TFP prediction dataset is intentionally excluded from GitHub. Those estimates cover earlier data, not SI 2010–2022. Current 1014 O004 is nominal OLS demo TFP. Review calendar gaps, production-function specification, deflators, capital stock/additions and sample selection before adapting the legacy builder. No TFP estimator was run for this publication task.'
            existing=[r['repository_path'] for r in sources if r['disposition']=='included' and Path(r['source_relative_path']).name in {'C850_build_csis_prodest_tfp.do','850_csis_prodest_tfp_method_summary.csv','20260515-151939-csis-prodest-results-final.md'}]
        elif rid=='G2':
            state='baseline_complete_refresh_needed';status='sample_quality_outputs_available'
            current='9 September: primary plus five children audited 97 fields / 1,164 field-year cells against candidate '+BASELINE_HASH+'. Quality workbook has 16 sheets and three charts. This was accepted for the 3,496-field baseline. G0 changed on 10 September, including R&D, export and fuel units; a new G2 refresh and receipt against '+CURRENT_HASH+' are still required. The existing workbook is useful historical evidence and must not be presented as the current G0 verification.'
            existing=[DAG+'/dag/reports/word_data/G2/'+n for n in ['README.md','G2_quality_workbook.xlsx','run-manifest.json','release-manifest.json','source-evidence.md']]
        elif rid=='G3':
            state='baseline_diagnostics_available';status='partial_comparability_not_established'
            current='9 September: four children produced 169 descriptive rows and 78 year-measure comparisons. Old annual SI 2010–2014 is available; old 2015 was not found in the bounded source search. New 2010–2015 consists of safe sample records, whereas the old annual files cover a different population. All six years are displayed, with absent/comparability flags. No equality, linkage or national-total claim is warranted. These results use the earlier G0 baseline and have not been revalidated after the 10 September update.'
            existing=[DAG+'/dag/reports/word_data/G3/'+n for n in ['README.md','G3_vintage_comparison.xlsx','run_manifest.json','source_manifest.csv','source_discovery_decisions.md']]
        elif rid in {'D8','G7','G8','G16','G17'}:
            current+=' The 10 September G0 update materially improves working R&D/environment/export and fuel-unit inputs; retain verified/provisional distinctions and refresh downstream tables before claiming new coverage.'
        design=plan['design'] if plan else DESIGN[rid][0]
        qa=list(plan['qa']) if plan else [
            'Every combination requested in the exact Word text has a numeric output or an explicit unavailable/unsupported status; no silent omission.',
            'Counts, grouping, units, price basis, zero/negative/missing rules and eligible denominators are shown and reconcile to the named input version.',
            'Every table and chart is reproducible from the row primary; figures read its saved tables. Real panel, population and source-code gates are respected.',
            'Working/provisional values and verified-only sensitivity are distinguished; sample statistics are not labelled national BPS findings.']
        outputs=list(plan['outputs']) if plan else ['outputs/'+rid+'/'+n for n in DESIGN[rid][1]]
        charts=(['coverage_by_year.png','source_status.png'] if group=='data' else ['main_result.png','support_or_sensitivity.png']) if plan else DESIGN[rid][2]
        if rid=='G0':qa+=['Stable working and verified-only contracts, raw-value preservation, 2016 absence, real-ID/WPI gates and version hashes independently checked.','Integrate the 10 September registry fragments and revalidate the composite entrypoint when separately authorised; do not substitute the 9 September flattened release.']
        if rid=='G2':qa+=['Refresh against the exact current G0 hash; newly corrected units/recodes and all eligibility decisions reconcile to that version.']
        if rid=='G3':qa+=['Display all six requested years; old2015 remains missing until actually sourced. A different sample/population is explicitly non-comparable for equality.']
        primary=plan['proposed_primary_path'] if plan else '05-analysis/analytical-dag/dag/edges/word_rows/'+rid+'_descriptive.do'
        actual_primary=translate(primary)
        evidence=[]
        # Detailed plan links are richer than the compact review ledger.
        for e in (plan.get('baseline_evidence',[]) if plan else row['implementation_and_output_paths']):
            if isinstance(e,str):src=e;ln=None
            else:src=e.get('path','');ln=e.get('line')
            dst=translate(src)
            evidence.append({'original_path':src,'line':ln,'repository_path':dst,'availability':'included' if dst else 'local_data_or_unavailable_locator'})
        deps=plan['dependencies'] if plan else ['C_MAIN','C_QA']
        task={
            'schema_version':1,'request_id':rid,'family':group,'folder':path,'title':row['title'],
            'source_number':row['source_number'],'source_locator':row['source_locator'],'source_pic':row['source_pic'],
            'source_request':row['source_request'],'source_strategy':row['source_strategy'],'source_notes':row['source_notes'],
            'source_completion_cell':row['source_completion_cell'],'execution_stage':state,'readiness':status,
            'current_assessment':current,'assessment_as_of':'2026-09-10 Asia/Jakarta',
            'historical_20260908_assessment':row['assessment'],'historical_20260908_status':row['status'],
            'manager_proposed_method':design,'definition_of_done':qa,'dependency_ids':deps,
            'specific_data_dependencies':row['dependencies'],'primary_do':actual_primary,
            'proposed_primary_do':'research/1014/'+primary,'primary_exists':bool(actual_primary),
            'planned_child_do_files':plan.get('children',[]) if plan else [],
            'planned_outputs':outputs,'planned_charts':charts,'existing_outputs':[p for p in existing if (ROOT/p).exists()],
            'source_evidence':evidence,'priority':plan['priority'] if plan else row['priority'],
            'next_action':('Review current G0 integration and refresh downstream receipts; preserve both candidate versions.' if rid=='G0' else 'Refresh G2 against the 10 September candidate, with owner-authorised data execution.' if rid=='G2' else row['next_action']),
            'execution_authorized_by_this_repository_build':False,
            'worker':{'G0':'1014 Data 0 - Dataset / ws-9aa52312cd1d','G2':'1014 Data 2 - Quality / ws-61576c3b8605','G3':'1014 Data 3 - SI Comparison / ws-08cf550d7231'}.get(rid),
            'source_sha256':'027fbf675aa8001a50060561781930440ee4d9697cc790ba593452fe528edd92'}
        dump(folder/'task.json',task)
        source_text='# '+rid+' — teks asli Word\n\nLokasi: `'+row['source_locator']+'`. Nomor asli: **'+row['source_number']+'**. PIC asli: **'+(row['source_pic'].strip() or 'kosong')+'**.\n\nNomor internal '+rid+' hanya pembeda; nomor dan teks sumber tidak diganti.\n\n## Permintaan\n\n```text\n'+row['source_request']+'\n```\n\n## Usulan strategi identifikasi dalam Word\n\n```text\n'+row['source_strategy']+'\n```\n\n## Catatan dalam Word\n\n```text\n'+row['source_notes']+'\n```\n\n## Kolom sudah/belum\n\n```text\n'+row['source_completion_cell']+'\n```\n\nKolom kosong tetap kosong; tidak berarti Deasy menyatakan tugas belum dikerjakan. Lihat DOCX asli dan ekstraksi lengkap untuk paragraf/penomoran internal.\n'
        write(folder/'SOURCE.md',source_text)
        ref_lines=[]
        for e in evidence:
            ref_lines.append((link(folder,e['repository_path']) if e['repository_path'] else '`'+e['original_path']+'` — dataset lokal atau locator yang belum tersedia')+(' — baris '+str(e['line']) if e['line'] else ''))
        write(folder/'EVIDENCE.md','# '+rid+' — implementation and evidence\n\nThe older audit is retained as dated evidence. Use the current assessment in README for later changes. All original paths map through `catalog/source-files.csv`; excluded datasets remain local.\n\n'+bullets(ref_lines or ['No implementation/output path was verified for this row in the original audit.'])+'\n\n## Current retained products\n\n'+bullets([link(folder,p) for p in task['existing_outputs']] or ['No complete row-specific result has been produced. Planned filenames are specifications, not delivered files.']))
        write(folder/'README.md',f'# {rid} — {row["title"]}\n\n'+
            f'**Nomor Word:** {row["source_number"]} · **PIC Word:** {row["source_pic"].strip() or "belum ditetapkan"} · **Status:** `{state}`.\n\n'+
            f'{current}\n\n'+
            '## Mulai dari permintaan Deasy\n\n'+link(folder,path+'/SOURCE.md','Teks asli seluruh baris, strategi, catatan dan PIC')+'. '+link(folder,path+'/task.json','Kontrak terstruktur')+'.\n\n'+
            '## Metode yang disebut Deasy\n\n'+(row['source_strategy'].strip() or ('OP, LP, ACF, Wooldridge disebut dalam teks permintaan.' if rid=='G1' else 'Tidak ada kolom strategi terpisah yang terisi. Metode/operasi yang ada di dalam permintaan tetap dipertahankan dalam SOURCE.md.'))+'\n\n'+
            '## Usul kerja dan batas interpretasi\n\n'+design+'\n\n'+
            '## Input dan ketergantungan\n\n'+row['dependencies']+'\n\n'+bullets(['`'+d+'` — lihat '+link(folder,'docs/DEPENDENCIES.md','kontrak input bersama') for d in deps])+'\n\n'+
            '## Satu do-file utama\n\n'+(link(folder,actual_primary)+' sudah ada. Semua proses rinci tetap memiliki source/triage/decision.' if actual_primary else '`'+task['proposed_primary_do']+'` adalah nama rencana; do-file lengkap untuk baris ini belum dibuat. Jangan menganggap nama file sebagai implementasi.')+'\n\n'+
            '## Hasil yang sudah ada\n\n'+bullets([link(folder,p) for p in task['existing_outputs']] or ['Belum ada hasil lengkap untuk baris Word ini. Kode/tabel pendahulu hanya bukti penggunaan ulang; lihat EVIDENCE.md.'])+'\n\n'+
            '## Definition of done\n\n'+bullets(['[ ] '+q for q in qa])+'\n\n'+
            '## Hasil yang harus diserahkan setelah eksekusi\n\n'+bullets(['`'+p+'`' for p in outputs]+['Chart: `'+n+'` (atau alasan substantif bila grafik tidak membantu).' for n in charts]+['README interpretasi, Stata log, input/output hashes, kamus kolom dan denominator, QA dan decision/triage yang diperbarui.'])+'\n\n'+
            '## Langkah berikut\n\n'+task['next_action']+'\n\n'+
            '**Status otorisasi:** pembuatan repo ini tidak menjalankan atau mengotorisasi estimator baru. Data 0/2/3 memiliki riwayat otorisasi sendiri; perbaikan yang belum dijalankan tetap diberi status pending. Deskriptif menunggu pilihan owner.\n\n'+
            '## Audit sebelumnya — 8 September, bukan status terbaru\n\n'+row['assessment']+'\n\n'+link(folder,path+'/EVIDENCE.md','Jalur kode dan bukti')+' · '+link(folder,'requests/README.md','Semua 44 permintaan')+' · '+link(folder,'README.md','README utama'))
        write(folder/'triage.md',f'# {rid} — triage\n\nAs of 10 September 2026 WIB.\n\n- Observed state: `{state}`; readiness `{status}`.\n- Evidence: README current assessment, EVIDENCE.md and exact source text.\n- Gap: '+row['dependencies']+'\n- Decision: retain existing work, preserve missing/provisional values and run boundaries; do not mark the full request complete based on a predecessor result.\n- Next: '+task['next_action']+'\n- Close only after every definition-of-done item is verified against an exact input version.\n')
        write(folder/'decision.md',f'# {rid} — decision record\n\n10 September 2026, Asia/Jakarta.\n\nThe owner requested a portable, private research repository and complete per-request handoffs. This packet preserves Word numbering/PIC and separates the suggested Word method, manager proposal, historical evidence and current implementation.\n\nThe row is `{state}`. The repository build is documentation/packaging only. Its definition of done is a proposed acceptance contract for subsequent authorised work, not a claim of results.\n\nOne primary Stata do-file owns this row. Shared calculations may serve overlapping rows if each row records its own coverage and acceptance; no duplicated inconsistent estimates.\n\nEvidence: SOURCE.md, EVIDENCE.md, task.json, root docs/CURRENT-STATE.md and docs/DECISIONS.md.\n')
        write(folder/'outputs/README.md',f'# {rid} output contract\n\nThese are planned deliverables. Existing outputs are linked in the row README; no placeholder is a computed result.\n\n'+bullets(outputs)+'\n\nCharts: '+', '.join(charts)+'.\n\nEach numeric table must identify: request ID, input version/hash, variable/outcome, year/window, group, unit/price basis, sample/coverage denominator, statistic or estimator, value, observed N and status. Estimation tables also need SE/CI, cohort/event time as applicable, specification and identification limits.\n\nA chart must be generated from a saved numeric table and disclose sample/provisional/missing-year limitations. Firm-level intermediate data stays outside Git.\n')
        all_tasks.append(task)
        registry.append({k:task[k] for k in ['request_id','family','source_number','source_locator','source_pic','title','execution_stage','readiness','folder','primary_exists','proposed_primary_do']})
    assert len(all_tasks)==44 and len({x['request_id'] for x in all_tasks})==44
    dump(ROOT/'requests/registry.json',all_tasks)
    with (ROOT/'requests/registry.csv').open('w',newline='') as f:
        w=csv.DictWriter(f,fieldnames=list(registry[0]));w.writeheader();w.writerows(registry)
    intro='# Semua 44 permintaan Deasy\n\n**4 Data + 19 deskriptif umum + 10 deskriptif dekarbonisasi + 11 Estimation = 44.** Sebanyak 15 baris inti adalah Data 0–3 dan Estimation 1–11. Dua baris umum sama-sama bernomor **21** di Word; ID G21a/G21b membedakannya tanpa mengganti penomoran sumber. Baris kosong 22 dan baris kosong setelah Estimation 11 tidak dihitung sebagai permintaan.\n\nSetiap folder berisi teks sumber, metode, konteks, jalur bukti, input, hasil/kontrak output, triage, decision dan definition of done. `primary_exists=false` berarti nama do-file masih rencana. PIC di sini adalah atribusi Word, bukan penunjukan baru.\n\n| ID | Nomor Word | PIC Word | Permintaan | Status |\n|---|---|---|---|---|\n'
    for t in all_tasks:
        intro+=f'| {t["request_id"]} | {t["source_number"]} | {t["source_pic"].strip() or "kosong"} | '+link(ROOT/'requests',t['folder']+'/README.md',t['title'])+f' | `{t["execution_stage"]}` |\n'
    write(ROOT/'requests/README.md',intro)
    print('Built',len(all_tasks),'request packets; existing primaries:',[t['request_id'] for t in all_tasks if t['primary_exists']])

if __name__=='__main__':main()
