"""Version the 44 frozen row plans with the owner-required wave input boundary."""
from pathlib import Path
from copy import deepcopy
import hashlib,json,datetime
ROOT=Path(__file__).resolve().parents[1]
OLD=ROOT.parent/'plans'/'rows'
OUT=ROOT/'row-plans'
YEARS=[2010,2011,2012,2013,2014,2015,2017,2018,2019,2020,2021,2022]
def digest(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def dump(p,o):p.write_text(json.dumps(o,ensure_ascii=False,indent=2)+'\n')

def main():
 OUT.mkdir(exist_ok=True)
 files=sorted(OLD.glob('*.json'))
 assert len(files)==44
 records=[]
 rule=('Every company-data operand in analysis must be the single published consolidated master or a declared '
       'derivative whose entire company-data ancestry ends at that consolidated master. Direct annual-wave reads are prohibited in analysis; only the master builder may append annual waves. '
       'Raw/staged/legacy/cached final company files cannot be numerical analysis parents. '
       'A required field missing from the wave is an upstream preparation failure; never repair '
       'it by opening an external company file inside this row. Comparison-only validators may '
       'read older data but may not feed construction or estimates. External reference and '
       'metadata inputs retain explicit non-company roles.')
 for p in files:
  old=json.loads(p.read_text());a=deepcopy(old);rid=a['row_id']
  a['plan_revision']={'id':'wave-foundation-v2','supersedes_boundary_of_sha256':digest(p),
   'scope':'Input boundary, readable code comments and hierarchical execution visibility; exact original Word request and statistical plan retained.',
   'implementation_status':'This revision does not execute this assignment row.'}
  a['code_readability_and_progress_contract']={
   'comments':'Non-executable Stata comments explain purpose, actual inputs, outputs and failure checks at file, block and subblock levels in simple Indonesian. Do not invent scientific interpretations.',
   'runtime':'Every file, block, subblock, iteration and deepest step prints start, finish or explicit early/error outcome, x/X, percent, elapsed time and exact location; stream live and save the same log.',
   'clock':'Date-aware native Stata wall clock, one-second resolution; preserve scientific timers and fail certification on backward clock.',
   'semantics':'Original operative source remains exactly recoverable; verify r(), e(), _rc, conditional branches and early transfers with a constructed runtime fixture before company execution.',
   'rerun':'A documented launcher must run the actual preparation with visible progress before declaring data prep ready.'}
  a['wave_input_contract']={
   'rule':rule,'boundary_role':'producer_and_diagnostics' if rid=='G0' else 'consumer',
   'release_root':str(ROOT),'annual_paths':[f'data/waves/wave_{y}.dta' for y in YEARS],
   'master_path':'data/analysis/G0_analysis_ready.dta','wave_count':12,'key':['source_year','source_row'],'expected_rows':33049,
   'expected_columns':4593,'original_projection_columns':4591,
   'new_columns':['rd17_own_token_class','rd17_external_token_class'],
   'root_plan':str(ROOT/'PLAN.md'),'root_plan_sha256':digest(ROOT/'PLAN.md'),
   'input_release_status':'Not certified until actual build, value comparisons and read-boundary checks pass.',
   'scientific_gates':'All existing field-specific, identity, unit, price, scope and source gates remain binding.'}
  if rid=='G0':
   a['wave_input_contract']['producer_override']='For this repair, physical implementation order in PLAN.md and plans/foundation.md controls: per-variable files → intermediate annual merges → complete preparation/corrections → ready annual waves → single consolidated master → company diagnostics. Original broader G0 science requirements remain open.'
  if rid=='G3':
   a['wave_input_contract']['old_vintage']='Historical-vintage company data must first pass its own versioned upstream annual adapter and consolidated master publication before comparative analysis. Comparison-only tests may inspect historical witnesses without feeding estimates. Building additional vintage adapters is not part of this G0 repair.'
  for d in a.get('dependencies',[]):
   if d['id'] in ('C_MAIN','G0'):
    d['numerical_binding']='wave_input_contract.master_path or a declared derivative'
    d['gate']+=' '+rule
  bound=[]
  for n in a.get('nodes',[]):
   if n['id'].endswith(('_INPUT_CANONICAL','_N_source_release')):
    n['numerical_binding']='wave_input_contract.master_path or a declared derivative'
    n['input_receipt']='Require actual current wave release receipt plus this row-specific eligibility and field contracts.'
    bound.append(n['id'])
   if rid=='G3' and n['id']=='G3_INPUT_OLD':
    n['numerical_binding']='Separately versioned old-vintage consolidated master after its annual wave adapter, unavailable until upstream adapter and master publication pass.'
    n['planning_status']='upstream_annual_adapter_required_before_analysis'
  for e in a.get('edges',[]):
   e['input_boundary']='wave_input_contract; G0 preparation may read its registered upstream inputs before ready-wave publication.' if rid=='G0' else 'wave_input_contract'
  dod=a.setdefault('definition_of_done',{}).setdefault('operational_checks',[])
  assert not any(x.get('id')==rid+'-WAVE-BOUNDARY' for x in dod)
  dod.append({'id':rid+'-WAVE-BOUNDARY','criterion':'All company analysis descends from the single published consolidated master.',
   'evidence_artifact':'analysis-input-lineage.json','pass_rule':rule,'blocking':True})
  dod.append({'id':rid+'-READABLE-EXECUTION','criterion':'Readable non-executable comments and verified live progress at every nesting level.',
   'evidence_artifact':'code-comments-and-progress-review.json','pass_rule':'Meet code_readability_and_progress_contract without changing the statistical results or control flow.','blocking':True})
  assert a['source']==old['source']
  assert a['row_complete']==old['row_complete']
  assert len(a['edges'])==len(old['edges']) and len(a['exhibits'])==len(old['exhibits'])
  dest=OUT/p.name;dump(dest,a)
  md=OLD/(rid+'.md')
  intro=f'''# Revisi input {rid}: semua angka perusahaan melalui wave\n\n**Ini rencana, bukan hasil eksekusi {rid}.** Permintaan asli, rumus, rencana tabel/grafik dan syarat ilmiahnya tetap berlaku.\n\nSetiap analisis memakai satu dataset gabungan final, `data/analysis/G0_analysis_ready.dta`, atau hasil turunannya. Analisis satu tahun pun memilih baris dari dataset gabungan ini. Wave tahunan hanya dibaca oleh penggabung. Kalau variabel yang dibutuhkan belum ada, perbaiki penyiapan data sebelum dataset gabungan disahkan. Jangan mengambilnya langsung dari file mentah atau dataset lama di tengah analisis.\n\nTahun: 2010–2015 dan 2017–2022. Kunci yang tersedia adalah tahun dan nomor baris sumber; belum identitas perusahaan lintas tahun. Versi baru memuat 4.593 kolom, dengan 4.591 kolom lama tetap sama. Kelulusan versi baru menunggu hasil eksekusi dan pemeriksaan aktual.\n\nSumber harga, kamus, serta keterangan berkas dicatat terpisah sebagai referensi. Data pembanding hanya boleh dibaca oleh pemeriksaan yang tidak menghasilkan input perhitungan. Seluruh proses pada rencana berikut tunduk pada aturan ini.\n\nRencana semula dipertahankan di bawah sebagai konteks; pengikatan input di bagian revisi ini dan JSON revisi menggantikan pengikatan ke kandidat perusahaan lama.\n\n---\n\n'''
  intro=intro.replace('Rencana semula dipertahankan', 'Setiap do-file dan bloknya harus diberi komentar kode yang menjelaskan tujuan, masukan dan hasil dalam bahasa sederhana. Saat berjalan, setiap tingkat mencetak mulai/selesai, posisi, persentase dan durasi dengan ketelitian satu detik. Peluncur dan hasil nyata harus diuji sebelum menyatakan penyiapan siap.\n\nRencana semula dipertahankan')
  (OUT/(rid+'.md')).write_text(intro+(md.read_text() if md.exists() else ''))
  records.append({'row_id':rid,'title':a['title'],'source_plan_sha256':digest(p),
   'revised_plan_sha256':digest(dest),'json':str(dest),'markdown':str(OUT/(rid+'.md')),
   'bound_company_nodes':bound,'source_request_unchanged':True,'planned_edges':len(a['edges']),
   'planned_exhibits':len(a['exhibits']),'row_execution_claim_added':False})
 dump(OUT/'manifest.json',{'status':'44_PLAN_BOUNDARIES_AMENDED_NOT_44_ROWS_EXECUTED','created_at':datetime.datetime.now(datetime.timezone.utc).isoformat(),'count':len(records),'rows':records})
 print('44 plans amended; exact source fields, row completion, edge counts and exhibit counts preserved.')
if __name__=='__main__':main()
