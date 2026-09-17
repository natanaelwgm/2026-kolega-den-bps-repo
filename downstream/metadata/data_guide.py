#!/usr/bin/env python3
"""E067: describe the validated delivery and offer nonbinding analysis starting points.

Reads final data and receipts; writes documentation only. Does not filter,
transform, refit, remask or modify any DTA. Paths in distributable metadata
are relative to the delivery folder; no owner-private locations are emitted.
"""
import argparse
import csv
import datetime
import json
from pathlib import Path
import pandas as pd
from compile_metadata import sha, write_json

VERSION = 'g1-data-guide-v1'
FINAL = 'analysis_obscured_with_g1.dta'
PRIOR = 'intermediate/G05_obscured_panel.dta'
METHODS = {'op':'Olley-Pakes', 'lp':'Levinsohn-Petrin', 'acf':'Ackerberg-Caves-Frazer', 'wrdg':'Wooldridge'}

def recommendations(final_name=FINAL):
    # Advisory only: these fields do not prescribe an estimand or analysis sample.
    return [
        dict(purpose='Mulai membaca data, membuat tabel, atau mengembangkan kode',
             file=final_name,variables=['obs_id','firm_id','year','workers','value_added_nominal','gross_output_nominal'],
             suggestion='Mulai dari master G1 berlabel agar fitur G0, panel G0.5, hasil G1 dan status sumber berada dalam satu file.',
             qualification='Angka sudah diobscure; tabel mendeskripsikan versi development ini, bukan besaran aktual/populasi.'),
        dict(purpose='Eksplorasi produktivitas dan perbandingan metode',
             file=final_name,variables=['dev_nominal_tfp_'+m for m in METHODS]+['dev_nominal_in_fit_'+m for m in METHODS],
             suggestion='Pilih metode dan sampel sesuai pertanyaan. Untuk meniru ringkasan estimasi, pertimbangkan in_fit metode tersebut; untuk hasil pada sampel bersama, lihat keluarga dev_nominal_common_*.',
             qualification='Residual nominal pada panel fiktif; pred adalah flag tersedianya residual. TFP missing bukan nol. Own dan common merupakan sampel berbeda; tidak ada satu filter wajib.'),
        dict(purpose='Eksplorasi energi, emisi dan intensitas',
             file=final_name,variables=['total_gj_s1','co2_total_s1','co2_total_complete','energy_cost_reported_n','energy_coverage_status'],
             suggestion='Mulai dengan cakupan komponen per tahun, lalu pilih subtotal atau subset lengkap sesuai tujuan.',
             qualification='Cakupan sembilan bahan bakar dan listrik dibeli; complete berarti lengkap untuk subset itu. CO2 bukan CO2e; own generation tidak ditambahkan dua kali. Unit/faktor tetap mengikuti evidence tahun.'),
        dict(purpose='Eksplorasi per tahun, provinsi atau industri',
             file=final_name,variables=['year','province_code','district_code','industry_code','industry2_reported','industry_bridge_verified'],
             suggestion='Tabel tahunan/provinsi/industri dapat menjadi titik awal pemeriksaan pola pada data development.',
             qualification='Ketersediaan kode dihitung dalam metadata. Kolom kosong tidak memberi informasi wilayah. Kode industri lintas vintage belum dijembatani; agregat sampel tidak otomatis estimasi populasi.'),
        dict(purpose='Menguji kode panel, lag, atau transisi',
             file=final_name,variables=['firm_id','year','dev_prev_obs_id','dev_prev_year','dev_link_status'],
             suggestion='Gunakan firm_id dan year untuk pengujian struktur panel. Pertahankan jarak kalender asli ketika membuat lag.',
             qualification='ID konsisten dalam rilis ini, namun keterkaitan perusahaan bersifat fiktif. Tidak semua perusahaan muncul tiap tahun; 2016 tidak tersedia. Identitas tidak dijamin tetap pada rebuild dengan input baru.'),
        dict(purpose='Mencoba estimasi G1 atau spesifikasi lain dari input sebelum G1',
             file=PRIOR,variables=['obs_id','psid','source_year','workers','value_added_nominal','capital_stock_nominal','capital_additions_nominal','val_rtlvcu'],
             suggestion='Jika file intermediate disertakan, gunakan G0.5 obscured sebagai input awal dan simpan output percobaan secara terpisah.',
             qualification='Ini input sebelum G1, bukan alternatif hasil G1 final. Placeholder hasil G1 di file ini tidak boleh dibaca sebagai estimasi. Tidak diperlukan untuk sekadar membaca master final.')]

def inspect(path, include_results):
    with pd.io.stata.StataReader(path) as reader:
        labels=reader.variable_labels()
    wanted=['obs_id','firm_id','psid','year','source_year','province_code','district_code','industry_code','workers','value_added_nominal','gross_output_nominal','capital_stock_nominal','capital_additions_nominal','val_rtlvcu','total_gj_s1','co2_total_s1','g1_results_attached']
    if include_results:
        wanted += [p+m for m in METHODS for p in ['dev_nominal_tfp_','dev_nominal_c_','dev_nominal_pred_','dev_nominal_in_fit_','dev_nominal_common_tfp_','dev_nominal_common_in_fit_']]
    cols=[n for n in wanted if n in labels]
    df=pd.read_stata(path,columns=cols,convert_categoricals=False)
    yr='year' if 'year' in df else 'source_year'
    firm='firm_id' if 'firm_id' in df else 'psid'
    duplicate_keys=int(df.duplicated([firm,yr]).sum())
    assert duplicate_keys==0 and df.obs_id.is_unique
    waves=df.groupby(firm)[yr].nunique()
    stats=dict(rows=len(df),variables=len(labels),grain='one fictional company per observed calendar year',
        unique_observation_key=['obs_id'],panel_key=[firm,yr],duplicate_panel_keys=duplicate_keys,
        fictional_firms=int(df[firm].nunique()),years=sorted(int(x) for x in df[yr].unique()),
        rows_by_year={str(int(y)):int(n) for y,n in df.groupby(yr).size().items()},
        panel_type='long format, unbalanced, fictional company linkage',
        observed_wave_count_distribution={str(int(k)):int(v) for k,v in waves.value_counts().sort_index().items()},
        firms_in_multiple_waves=int(waves.ge(2).sum()),
        firms_in_every_available_wave=int(waves.eq(df[yr].nunique()).sum()),
        nonblank_source_codes={n:int(df[n].fillna('').str.strip().ne('').sum()) for n in ['province_code','district_code','industry_code']},
        selected_variable_coverage={n:dict(observed=int(df[n].notna().sum()),missing=int(df[n].isna().sum())) for n in cols if pd.api.types.is_numeric_dtype(df[n])},
        all_variable_labels_nonempty=all(bool(s.strip()) for s in labels.values()))
    if include_results:
        stats['g1_coverage']={m:dict(method=method,residual_nonmissing=int(df['dev_nominal_tfp_'+m].notna().sum()),
            own_dynamic_fit_rows=int(df['dev_nominal_in_fit_'+m].eq(1).sum()),
            common_residual_nonmissing=int(df['dev_nominal_common_tfp_'+m].notna().sum()),
            common_dynamic_fit_rows=int(df['dev_nominal_common_in_fit_'+m].eq(1).sum())) for m,method in METHODS.items()}
        assert df.g1_results_attached.eq(1).all()
    else:
        assert df.g1_results_attached.eq(0).all()
    return stats,labels

def write_data_guide(directory, output_dir=None, final_name=FINAL):
    directory=Path(directory).resolve();out=Path(output_dir or directory)
    out.mkdir(parents=True,exist_ok=True);(out/'metadata').mkdir(exist_ok=True)
    assert Path(final_name).name==final_name and final_name.endswith(".dta"), "Use a DTA basename"
    final=directory/final_name
    validation=json.loads((directory/'metadata/VALIDATION.json').read_text())
    assert validation['status']=='PASS'
    before_hash=sha(final)
    assert before_hash==validation['final_sha256'], 'Final DTA no longer matches accepted metadata validation'
    variables=list(csv.DictReader((directory/'metadata/variable_dictionary.csv').open()))
    stats,labels=inspect(final,True)
    assert {r['name']:r['label'] for r in variables}==labels
    catalogue=[dict(file=final_name,role='recommended starting dataset',recommendation='advisory_nonbinding',
        stage='G0 -> G0.25 obscure -> G0.5 fictional panel -> G1 nominal estimation -> labels',
        sha256=before_hash,bytes=final.stat().st_size,contains_fresh_g1_results=True,**stats)]
    prior=directory/PRIOR
    if prior.exists():
        prior_stats,_=inspect(prior,False)
        catalogue.append(dict(file=PRIOR,role='optional pre-G1 input',recommendation='advisory_nonbinding',
            stage='G0 -> G0.25 obscure -> G0.5 fictional panel',sha256=sha(prior),bytes=prior.stat().st_size,
            contains_fresh_g1_results=False,**prior_stats))
    available={r['file'] for r in catalogue}
    advice=[dict(r,available_in_delivery=r['file'] in available,binding=False) for r in recommendations(final_name)]
    assert all(set(r['variables'])<=set(labels) for r in advice)
    supporting=['metadata/variable_dictionary.csv','metadata/CODEBOOK.md','metadata/contract.json','metadata/VALIDATION.json']
    supporting += [p for p in ['LINEAGE.json','masking-reports/equations.json','masking-reports/column_policy_and_changes.csv','masking-reports/privacy_checks.json'] if (directory/p).exists()]
    metadata=dict(schema_version=VERSION,title='Obscured manufacturing panel with G1 nominal-development results',
        generated_at=datetime.datetime.now().astimezone().isoformat(),language_of_guide='id',
        dataset_id='kolega-g025-g05-g1-'+before_hash[:12],recommended_entry_file=final_name,
        recommendations_are_binding=False,recommendation_scope='Suggested starting points; collaborators may choose other variables, samples or models with their own documented rationale.',
        dataset_catalogue=catalogue,downstream_starting_points=advice,
        variable_dictionary='metadata/variable_dictionary.csv',full_definitions='metadata/CODEBOOK.md',
        supporting_files={p:sha(directory/p) for p in supporting},
        numeric_release_scope='obscured nominal development; not verified actual-company/real-input TFP',
        important_interpretation=dict(actual_values_in_this_folder=False,company_linkage='fictional within this dataset version',
            numeric_masking='Seeded +/-20-30% primary changes; rounded count and boundary exceptions; derived formulas rebuilt before G1.',
            source_categories='Retained. Source status and threshold flags are not automatically recalculated from masked numeric values.',
            actual_empirical_readiness='Not asserted by these advisory recommendations.',
            sharing_scope='Original data, original-key mappings, private seed and recovery material are outside this folder. Retained categories mean the masked release is not guaranteed anonymous.'),
        automation=dict(edge='E067',producer='downstream/metadata/data_guide.py',producer_sha256=sha(Path(__file__))))
    write_json(out/'METADATA.json',metadata)
    file_rows='\n'.join(f'| [`{r["file"]}`]({r["file"]}) | {r["role"]} | {r["rows"]:,} x {r["variables"]} | '+('Ya' if r['contains_fresh_g1_results'] else 'Belum; sebelum estimasi')+' |' for r in catalogue)
    counts='\n'.join(f'| {m.upper()} — {v["method"]} | {v["residual_nonmissing"]:,} | {v["own_dynamic_fit_rows"]:,} | {v["common_residual_nonmissing"]:,} |' for m,v in stats['g1_coverage'].items())
    advice_rows='\n'.join(f'| {r["purpose"]} | `{r["file"]}`'+(' (tidak disertakan dalam paket ini)' if not r['available_in_delivery'] else '')+f' | {r["suggestion"]} | {r["qualification"]} |' for r in advice)
    years=', '.join(map(str,stats['years']))
    readme=f'''# Data final G0–G1: titik awal analisis

**Mulai dari [`{final_name}`]({final_name})** jika ingin membaca data, mengembangkan analisis,
atau bekerja bersama coauthor. File ini menyatukan fitur G0, panel G0.5, hasil G1,
label yang terbaca, dan definisi variabel lengkap.

**Rekomendasi dalam README ini bersifat opsional dan tidak mengikat.** Ini bukan
rencana analisis wajib, pilihan model final, atau satu sampel yang harus dipakai.
Coauthor boleh memilih file, variabel, sampel, dan metode lain sesuai pertanyaan
riset, sambil mencatat pilihan dan alasannya. Keterangan tentang isi data tetap
berlaku apa pun pilihan analisisnya.

## File mana untuk apa?

| File | Peran yang disarankan | Baris x variabel | Ada hasil G1? |
|---|---|---:|---|
{file_rows}

File G0.5 adalah alternatif input untuk mencoba estimasi baru. Jika hanya ingin
menganalisis keluaran yang sudah tersedia, master final biasanya cukup; seluruh
fitur yang diperlukan untuk membacanya sudah berada dalam satu file.

Data aktual milik owner dan bahan pemulihan tidak disertakan di paket ini.
Untuk penelitian dengan angka aktual, gunakan cabang actual yang dikelola
terpisah dan evaluasi kembali kesiapan linkage, satuan, deflator, serta estimasi
G1. Rekomendasi ini tidak menyatakan cabang actual sudah menjadi panel dengan TFP.

## Apa isi dan cakupannya?

- **{stats['rows']:,} baris, {stats['variables']} variabel, {stats['fictional_firms']:,} ID perusahaan fiktif**.
- Satu baris = satu ID perusahaan fiktif pada satu tahun observasi. Format panjang,
  panel tidak seimbang. Kunci unik: `obs_id`; pasangan panel: `firm_id year`.
- Tahun tersedia: **{years}**. Tahun 2016 tidak tersedia dan tidak diisi otomatis.
- {stats['firms_in_multiple_waves']:,} ID muncul pada lebih dari satu tahun;
  {stats['firms_in_every_available_wave']:,} muncul pada seluruh tahun yang tersedia.
- Kode provinsi terisi pada {stats['nonblank_source_codes']['province_code']:,} baris;
  kode kabupaten pada {stats['nonblank_source_codes']['district_code']:,} baris;
  kode industri pada {stats['nonblank_source_codes']['industry_code']:,} baris.
  Kolom kabupaten yang kosong tidak dapat dipakai untuk menghasilkan analisis kabupaten.

Keluarga isi utama: tenaga kerja; output dan nilai tambah nominal; input, modal,
perdagangan dan kepemilikan; energi/emisi; R&D/inovasi/lingkungan; status sumber,
kelayakan dan missingness; identitas panel; residual dan indikator sampel G1.

## Saran titik awal, boleh diubah

| Kebutuhan | File awal | Saran | Konteks untuk menafsirkan |
|---|---|---|---|
{advice_rows}

Tidak ada filter yang diterapkan oleh README atau metadata ini. Tidak perlu
membuang seluruh baris hanya karena satu metode TFP atau satu fitur belum tersedia.
Pilih denominator dan sampel sesuai masing-masing pertanyaan.

## Cakupan hasil G1 saat ini

| Metode | Residual own tersedia | Baris fit dinamis own | Residual common tersedia |
|---|---:|---:|---:|
{counts}

`dev_nominal_tfp_*` adalah residual log nominal yang belum dicenter;
`dev_nominal_c_*` mengurangi rerata sampel fit per sektor/metode.
`dev_nominal_pred_*` adalah **flag tersedianya residual**, bukan predicted output.
`dev_nominal_in_fit_*` mencatat keikutsertaan dalam estimasi. Keluarga
`dev_nominal_common_*` berasal dari model pada domain bersama, bukan sekadar
salinan own setelah difilter. Angka tabel adalah jumlah baris, bukan jumlah perusahaan.

## Cara membuka dan membaca definisi

Dari folder data ini, jalankan di Stata:

```stata
use "{final_name}", clear
isid firm_id year
xtset firm_id year
browse
notes workers
notes dev_nominal_tfp_lp
```

Contoh eksplorasi opsional, bukan aturan sampel universal:

```stata
tabulate year, missing
summarize workers value_added_nominal
summarize dev_nominal_tfp_lp if dev_nominal_in_fit_lp == 1
```

Klik variabel di Data Browser untuk melihat **Label** dan **Notes**.
[Dictionary CSV](metadata/variable_dictionary.csv) memuat label, definisi, satuan,
rumus yang tersedia, sumber, serta perlakuan obscuring untuk seluruh variabel.
[Codebook](metadata/CODEBOOK.md) menyediakan versi yang bisa dibaca sebagai dokumen.
[METADATA.json](METADATA.json) memuat katalog file, hash, grain, kunci, cakupan,
dan saran analisis dalam format yang dapat dibaca program.

## Cara menafsirkan versi ini

Urutan data: **G0 → G0.25 obscuring → G0.5 panel fiktif → G1 estimasi ulang →
label/notes → panduan ini**. Angka input yang terlihat adalah angka yang dipakai
G1. Tidak ada obscuring tambahan setelah estimasi.

Angka primer diubah dengan target +/-20–30%, dengan pengecualian pembulatan count
dan batas persentase; variabel turunan dihitung kembali. Status sumber dan kategori
tertentu dipertahankan, sehingga flag ambang dari sumber tidak harus sama dengan
flag yang dihitung ulang dari angka obscured. Missing, nol, dan tidak tersedia
merupakan keadaan yang berbeda.

ID perusahaan konsisten dalam versi ini tetapi fiktif; belum membuktikan hubungan
perusahaan aktual lintas tahun atau kesinambungan ID pada rebuild mendatang.
TFP adalah residual **nominal development**, belum TFP input riil. Pengukuran
energi/emisi mencakup subset yang didokumentasikan; satuan dan klasifikasi lintas
tahun mengikuti bukti sumber masing-masing. Label baru tidak mengubah status tersebut.

Gunakan versi ini sebagai titik awal pengembangan, eksplorasi dan reproduksi
hasil development. Keputusan untuk interpretasi empiris aktual mengikuti data
aktual dan bukti yang relevan bagi analisis tersebut. Kategori yang dipertahankan
berarti obscuring bukan jaminan anonimitas penuh.

## Versi dan reproduksi

- ID rilis data: `{metadata['dataset_id']}`.
- SHA256 DTA final: `{before_hash}`.
- Bukti metadata tanpa perubahan angka: [VALIDATION.json](metadata/VALIDATION.json).
- Dokumentasi ini dibuat otomatis oleh edge **E067** setelah DTA final tervalidasi.
- Rekomendasi tidak mengubah nilai, filter, hasil estimasi atau indikator kesiapan.
'''
    (out/'README.md').write_text(readme)
    # Verify serialization, links, factual counts and immutable data after output.
    saved=json.loads((out/'METADATA.json').read_text())
    assert saved['recommendations_are_binding'] is False
    assert all(r['binding'] is False for r in saved['downstream_starting_points'])
    assert sum(stats['rows_by_year'].values())==stats['rows']
    assert sum(int(w)*n for w,n in stats['observed_wave_count_distribution'].items())==stats['rows']
    assert all(v['observed']+v['missing']==stats['rows'] for v in stats['selected_variable_coverage'].values())
    for r in catalogue:
        assert sha(directory/r['file'])==r['sha256']
    receipt=dict(status='PASS',version=VERSION,edge='E067',final_sha256=before_hash,
        generated_at=metadata['generated_at'],dataset_files=len(catalogue),dictionary_variables=len(variables),
        recommendations=len(advice),recommendations_are_binding=False,dta_bytes_unchanged=True,
        observed_counts_reconciled=True,variables_and_links_verified=True,producer_sha256=sha(Path(__file__)),
        files={p:sha(out/p) for p in ['README.md','METADATA.json']})
    write_json(out/'metadata/DATA_GUIDE_VALIDATION.json',receipt)
    print('E067 PASS | README + METADATA.json; '+str(len(catalogue))+' dataset files; recommendations are nonbinding',flush=True)
    return receipt

if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('delivery',type=Path);p.add_argument('--output-dir',type=Path);p.add_argument('--final-file',default=FINAL)
    a=p.parse_args();write_data_guide(a.delivery,a.output_dir,final_name=a.final_file)
