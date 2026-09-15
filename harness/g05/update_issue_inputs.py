#!/usr/bin/env python3
"""Prepare G0.5 v3 edits from a fresh GitHub issue snapshot; no network writes.

Preserve original quoted requests, PIC, module acceptance and quality requirements.
The caller publishes these exact body files and verifies GitHub readback separately.
"""
import argparse
import hashlib
import json
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[2]
REPO = 'https://github.com/natanaelwgm/deasy-imed-si-research-2026'
OLD_RULE = ('Gunakan hanya G0.5 atau turunan development yang lineage-nya disahkan. '
            '`obs_id` adalah ID observasi; `psid` saat ini seluruhnya missing. '
            'Cabang panel wajib `require_panel=True` atau pemeriksaan Stata setara; '
            'jangan mengarang firm linkage atau kalender 2016. Semua tabel/chart/laporan '
            'diberi label **G0.5 DEVELOPMENT**, bukan temuan empiris final. Actual '
            'finalisation memilih input actual lokal secara eksplisit lalu menjalankan '
            'ulang kode yang sama. Jangan mengambil actual lama dari riwayat Git sebagai fallback.')
NEW_RULE = ('Gunakan hanya G0.5 v3 atau turunan development dengan lineage yang disahkan. '
            '`obs_id` mengenali observasi, `dev_cluster_id` mengenali cluster tahunan, '
            'dan `psid` adalah ID perusahaan fiktif lintas tahun yang **sudah terisi '
            'di seluruh 33.049 observasi** dengan `psid_status="synthetic_development"`. '
            'Terdapat **10.395 perusahaan fiktif dan 22.654 sambungan**; provinsi × '
            'sektor wajib sama, dengan sembilan variabel kontinu untuk cluster/matching. '
            'Cabang panel development memakai `require_panel=True` atau pemeriksaan '
            'Stata setara (`isid psid source_year`); gunakan ID resmi paket ini. '
            'Semua tabel/chart/laporan diberi label **G0.5 DEVELOPMENT**. Finalisasi '
            'memilih actual lokal dan menjalankan ulang kode yang sama; actual tidak '
            'mewarisi ID/link fiktif dan tetap memerlukan linkage nyata yang diterima. '
            'Jangan mengambil actual lama dari riwayat Git sebagai fallback.')

GATES = {
    9: ('Panel psid, kalender lag, dukungan investasi/material, konsep modal dan deflator harus sah sebelum estimator terkait dijalankan.',
        'Panel development memakai psid fiktif resmi G0.5 v3; validasi firm-year dan kalender lag. Dukungan investasi/material, konsep modal dan deflator tetap harus memenuhi syarat estimator.'),
    10: ('Sebagian audit cross-sectional dapat berjalan tanpa panel. Jangan membuat mask longitudinal atau menyatakan psid valid.',
         'Audit cross-sectional dan longitudinal development dapat memakai psid fiktif resmi G0.5 v3, dengan pemeriksaan firm-year/kalender. Jangan menyatakan bahwa ID ini membuktikan linkage actual.'),
    12: ('Panel branch tetap memerlukan psid terverifikasi, exposure pre-event dan konsep harga yang sah.',
         'Panel development memakai psid fiktif resmi G0.5 v3; exposure pre-event dan konsep harga tetap harus sesuai kontrak. Panel actual memerlukan linkage nyata terverifikasi.'),
    13: ('Current psid belum terverifikasi. First observed participation bukan first-ever entry; 2015→2017 bukan lag satu tahun. Jangan membuat riwayat perusahaan sintetis untuk melewati syarat.',
         'Gunakan psid fiktif resmi G0.5 v3 untuk event-study development. First observed participation bukan first-ever entry; 2015→2017 bukan lag satu tahun. Jangan membuat ID tambahan ad hoc atau menyajikan continuity simulasi sebagai histori actual.'),
    14: ('FE/perubahan antarwaktu memerlukan psid sah.',
         'FE/perubahan antarwaktu development memakai psid fiktif resmi G0.5 v3 dan kalender asli; actual memerlukan linkage nyata yang diterima.'),
    16: ('Destination/product linkage, policy data dan panel identity masih harus dibuktikan.',
         'Panel development memakai psid fiktif resmi G0.5 v3. Destination/product linkage dan policy data tetap harus dibuktikan; identitas panel actual juga memerlukan verifikasi tersendiri.'),
    17: ('R2 event registry dan psid terverifikasi diperlukan untuk cabang event study.',
         'Cabang event study development memerlukan R2 event registry pada versi G0.5 yang sama dan memakai psid fiktif resmi v3; actual memerlukan linkage nyata terverifikasi.'),
    18: ('psid dan bukti perubahan ownership belum otomatis tersedia dari G0.5.',
         'psid fiktif resmi G0.5 v3 tersedia untuk development; bukti perubahan ownership tetap harus diperiksa pada field yang relevan.'),
    19: ('Memerlukan R2, psid sah dan data produk dengan lineage G0.5 yang kompatibel.',
         'Development memerlukan R2, psid fiktif resmi v3 dan data produk dengan lineage G0.5 yang kompatibel; actual memerlukan linkage nyata tersendiri.'),
    21: ('Bergantung pada cohort R4 dan psid yang sah.',
         'Development bergantung pada cohort R4 di versi input yang sama dan psid fiktif resmi G0.5 v3; actual memerlukan linkage nyata yang diterima.'),
    22: ('psid, wage coverage dan deflator perlu dibuktikan.',
         'psid fiktif resmi G0.5 v3 tersedia untuk development; wage coverage, definisi kompensasi dan deflator tetap perlu dibuktikan. Pemakaian payroll sebagai proxy matching bukan pengesahan definisi upah.'),
}


def digest(text):
    return hashlib.sha256(text.encode()).hexdigest()


def prepare(snapshot, commit, output):
    if not re.fullmatch(r'[0-9a-f]{40}', commit):
        raise ValueError('Use the verified full data commit SHA')
    output = Path(output)
    if output.exists(): raise ValueError('Use a new issue-edit directory')
    data = json.loads(Path(snapshot).read_text())
    issues = sorted([i for i in data if 9 <= i['number'] <= 22 and 'pull_request' not in i], key=lambda i:i['number'])
    if [i['number'] for i in issues] != list(range(9,23)): raise ValueError('Expected all 14 issues exactly once')
    manifest_path = ROOT/'data/g0-5-development/manifest.json'
    manifest = json.loads(manifest_path.read_text())
    if manifest['version'] != 'g05-external-excel-panel-v3' or manifest['identity']['synthetic_firms'] != 10395:
        raise ValueError('This migration is bound to the accepted v3 release')
    msha = hashlib.sha256(manifest_path.read_bytes()).hexdigest()
    output.mkdir(parents=True)
    receipts=[]
    for issue in issues:
        old=issue['body']; body=old
        if body.count(OLD_RULE)!=1: raise ValueError(f'Unexpected current ID paragraph in #{issue["number"]}; reconcile fresh changes')
        body=body.replace(OLD_RULE,NEW_RULE)
        body,n=re.subn(r'Versi acuan repo `[0-9a-f]{40}`; SHA256 manifest G0\.5 `[0-9a-f]{64}`\. Data: \*\*33\.049 observasi × 4\.379 kolom, 12 wave, 2010–2015 dan 2017–2022\*\*\. Perubahan versi harus eksplisit dalam receipt\.',
                       f'Versi input G0.5 **{manifest["version"]}**, commit `{commit}`; SHA256 manifest `{msha}`. Data: **33.049 observasi × 4.396 kolom, 12 wave, 2010–2015 dan 2017–2022**. Perubahan versi harus eksplisit dalam receipt.',body)
        if n!=1: raise ValueError('Unexpected version paragraph')
        # Current input and row-plan links advance; historical original requests
        # and G0 quality references retain their previous immutable source pins.
        pattern = re.escape(REPO)+r'/blob/(?:[0-9a-f]{40}|main)/(data/g0-5-development/[^)\s]+|docs/(?:DATA-MODES|DATA-IDENTIFIERS|G05-ANALYSIS-STANDARD)\.md|releases/2026-09-13-data-foundation/stata-preparation/row-plans/[^)\s]+)'
        body=re.sub(pattern,lambda m:f'{REPO}/blob/{commit}/{m[1]}',body)
        if issue['number'] in GATES:
            a,b=GATES[issue['number']]
            if body.count(a)!=1: raise ValueError(f'Unexpected module gate in #{issue["number"]}')
            body=body.replace(a,b)
        correction=(f'\n\n**Koreksi owner — workflow di luar G0:** baca [workflow lengkap]({REPO}/blob/{commit}/harness/g05/EXTERNAL-WORKFLOW.md) '
                    f'dan [bukti panel]({REPO}/blob/{commit}/data/g0-5-development/panel-generation.json). '
                    'Identity disiapkan dari Excel sebelum G0 bila diperlukan, memakai ulang ID yang layak bila tersedia, lalu di-porting lewat lineage yang diverifikasi. '
                    'G0 dan Excel asli tidak diubah. `C_REAL_PANEL` pada rencana sumber tetap syarat finalisasi actual; pada cabang development gunakan kontrak panel G0.5 di atas. '
                    'Frasa sumber “No synthetic lags” melarang tahun/lag buatan: 2016 tetap tidak ada dan 2015→2017 tetap gap dua tahun. '
                    'Continuity, entry/exit, pretrend dan hasil estimasi dari panel ini adalah simulasi development; syarat harga, modal, treatment, produk dan status perusahaan tetap berlaku. '
                    'Perbaikan input ini tidak otomatis menjalankan atau melanjutkan task yang dipause owner.\n')
        body=body.replace('\n## Permintaan asli dan sumber kerja',correction+'\n## Permintaan asli dan sumber kerja',1)
        if [x for x in old.splitlines() if x.startswith('>')] != [x for x in body.splitlines() if x.startswith('>')]:
            raise ValueError('Original quoted request changed')
        for required in ['analytical-dag','gpt-5.6-luna','QJE/AER','McKinsey','24 keluarga exhibit']:
            if required not in body: raise ValueError('Quality requirement lost')
        name=f'issue-{issue["number"]}.md'; (output/name).write_text(body)
        receipts.append({'number':issue['number'],'title':issue['title'],'file':name,
                         'prior_body_sha256':digest(old),'body_sha256':digest(body),'body_bytes':len(body.encode()),
                         'prior_updated_at':issue['updated_at'],'source_quotes_preserved':True})
    (output/'manifest.json').write_text(json.dumps({'status':'PREPARED_NOT_PUBLISHED','data_commit':commit,
                      'data_manifest_sha256':msha,'count':14,'issues':receipts},indent=2)+'\n')
    print(json.dumps({'status':'PREPARED_NOT_PUBLISHED','count':len(receipts),'data_commit':commit}))


if __name__ == '__main__':
    p=argparse.ArgumentParser();p.add_argument('--snapshot',type=Path,required=True)
    p.add_argument('--commit',required=True);p.add_argument('--output',type=Path,required=True)
    a=p.parse_args();prepare(a.snapshot,a.commit,a.output)
