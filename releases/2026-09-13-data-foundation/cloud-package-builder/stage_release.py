"""Stage only the reviewed source and privacy-screened derived dataset."""
from pathlib import Path
import argparse, hashlib, json, shutil
HERE=Path(__file__).resolve().parent
F=HERE.parent/'G0-wave-foundation-v2'
CHECKOUT=HERE.parent/'github-release'
def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
 a=argparse.ArgumentParser();a.add_argument('--package',type=Path,required=True);a=a.parse_args()
 receipt=json.loads((HERE/'master-acceptance.json').read_text());assert receipt['status']=='passed' and receipt['owned_process_exited']
 package=json.loads((a.package/'manifest.json').read_text());assert package['status']=='PASS'
 assert package['source_execution_receipt_sha256']==sha(HERE/'master-acceptance.json')
 out=CHECKOUT/'releases/2026-09-13-data-foundation'
 assert not out.exists(), 'Choose an explicit update strategy for an existing release.'
 selected=[]
 for folder in ['code','rows','dag/edges','scripts','registry','plans','row-plans','correction-planning/registries']:
  for p in (F/folder).rglob('*'):
   if p.is_file() and p.suffix in {'.do','.ado','.py','.json','.csv','.md'} and '__pycache__' not in p.parts:
    selected.append(p)
 for name in ['PLAN.md','README.md','plan-freeze.json','run_guarded.py','run_preparation.command','implementation-manifest.json','implementation-review/static-review.json']:
  selected.append(F/name)
 for p in (F/'rd2017').rglob('*'):
  rel=p.relative_to(F/'rd2017')
  if any(part in {'runtime','history','scratch','states','outputs','validation','__pycache__'} for part in rel.parts):continue
  if p.is_file() and p.suffix in {'.do','.ado','.py','.json','.md'}:selected.append(p)
  elif p.is_file() and p.suffix=='.csv' and 'fixtures' in rel.parts:selected.append(p)
 # These are immutable constructed test inputs, not observed company records.
 for name in ['literal-parser-fixtures.csv','ratio-fixtures.csv','truth25-literal-inputs.csv','shared-25case-truth-table.csv']:
  selected.append(F/'rd2017/inputs'/name)
 selected.append(F/'rd2017/validation/compare_current_wave.do')
 # These six generated tables describe fields, sources and acceptance rules.
 # They contain no individual company observations.
 for name in ['annual_schema_mapping','classification_acceptance','completion_gate','fuel_unit_acceptance','source_inventory','source_lineage']:
  selected.append(F/'corrections/metadata'/f'{name}.csv')
 # Every sealed executable source must be present in the publication.
 implementation=json.loads((F/'implementation-manifest.json').read_text())
 selected_paths={str(p.relative_to(F)) for p in selected}
 for item in implementation['code_files']:
  assert item['path'] in selected_paths, f"Missing sealed source: {item['path']}"
  assert sha(F/item['path'])==item['sha256'], f"Changed sealed source: {item['path']}"
 records=[]
 for p in sorted(set(selected)):
  relative=p.relative_to(F);dest=out/'stata-preparation'/relative;dest.parent.mkdir(parents=True,exist_ok=True)
  shutil.copy2(p,dest);records.append({'path':str(dest.relative_to(out)),'sha256':sha(dest),'bytes':dest.stat().st_size})
 # Copy only the exact passed data/metadata records and the fixed reader docs.
 # An unrelated company file in the package directory must never hitch a ride.
 package_files={item['path']:item['sha256'] for item in package['parts']+package['metadata_files']}
 package_files.update({name:sha(a.package/name) for name in ['manifest.json','load_data.py','README.md','GPT-PRO-PROMPT.md']})
 for name,expected in sorted(package_files.items()):
  source=a.package/name
  assert not Path(name).is_absolute() and '..' not in Path(name).parts
  assert source.is_file() and not source.is_symlink() and sha(source)==expected
  assert source.stat().st_size<45*1024**2
  dest=out/'cloud-data'/name;dest.parent.mkdir(parents=True,exist_ok=True)
  shutil.copy2(source,dest);assert sha(dest)==expected
  records.append({'path':str(dest.relative_to(out)),'sha256':expected,'bytes':dest.stat().st_size})
 for name in ['accept_master.py','master-acceptance.json','build_package.py','stage_release.py','load_data.py','PLAN.md','privacy-field-proposal.json','bounded-source-review.json','bounded-source-review-closure.json']:
  source=HERE/name;dest=out/'cloud-package-builder'/name
  dest.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(source,dest)
  records.append({'path':str(dest.relative_to(out)),'sha256':sha(dest),'bytes':dest.stat().st_size})
 (out/'publication-manifest.json').write_text(json.dumps({'status':'STAGED_NOT_PUSHED','files':records,'master_ready_receipt_sha256':sha(HERE/'master-acceptance.json'),'data_scope':'screened derivative only; no original company data, DTA or runtime logs'},indent=2)+'\n')
 (out/'README.md').write_text('# Dataset gabungan dan kode penyiapan\n\nMulai dari `cloud-data/README.md` untuk membuka seluruh data sebagai satu dataset di Python. Data perusahaan berasal dari satu master yang telah diperiksa; salinan cloud mengeluarkan kolom dalam daftar eksplisit. Tidak ada angka ekonomi yang diberi noise.\n\n`stata-preparation/` berisi kode, komentar tiap blok, rencana44modul dan bukti pemeriksaan kode. Menjalankan ulang penyiapan Stata memerlukan sumber lokal dan Stata berlisensi; file sumber itu tidak diunggah. Jalur lokal dalam daftar sumber adalah catatan asal proses.\n\nData baru ini tidak berarti seluruh44modul telah selesai dianalisis. Identitas perusahaan lintas tahun dan beberapa definisi/satuan sumber masih mempunyai syarat yang harus diselesaikan sebelum analisis terkait.\n')
 print(json.dumps({'status':'STAGED','path':str(out),'files':len(records),'bytes':sum(x['bytes'] for x in records)}))
if __name__=='__main__':main()
