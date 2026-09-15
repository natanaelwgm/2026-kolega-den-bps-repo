#!/usr/bin/env python3
"""Prepare fourteen source-bound GitHub issue bodies; never execute research."""
from datetime import datetime
import hashlib
import json
from pathlib import Path
import shutil
from urllib.parse import quote
from zoneinfo import ZoneInfo

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / 'work-items/github-issues/g05-20260913'
REPO = 'https://github.com/natanaelwgm/deasy-imed-si-research-2026'
BASIS = '86b37b85da07459b219b7274ee6869270e4c16e6'
IDS = ['G1', 'G2', 'G3'] + [f'R{i}' for i in range(1, 12)]
PLAN = 'releases/2026-09-13-data-foundation/stata-preparation/row-plans'

SPEC = {
 'G1': {
  'title': 'Hitung TFP dengan OP, LP, ACF dan Wooldridge',
  'work': ['Adaptasi empat estimator yang berbeda secara ilmiah; gunakan sumber/metode pendahulu dan dokumentasikan pilihan value-added versus gross-output, proxy, capital stock dan deflator.',
           'Pisahkan konstruksi sampel/proxy, OP, LP, ACF, Wooldridge, pembandingan dan penggabungan TFP menjadi edge yang dapat diperiksa.',
           'Simpan koefisien, TFP per observasi, eligibility, attrition, identifikasi/instrument support, convergence dan sensitivitas; jangan mengganti metode yang gagal dengan OLS demo.',
           'Gabungkan ukuran TFP ke turunan G0.5 dengan kunci yang sah dan ID estimator/specification; jangan menimpa input G0.5.'],
  'charts': ['Flow/coverage sampel eligible per metode, sektor dan tahun.', 'Koefisien input/returns to scale dan interval ketidakpastian yang didukung.', 'Distribusi TFP per metode pada sampel sendiri dan sampel bersama.', 'Perbandingan rank/scatter metode serta ringkasan kegagalan/convergence.'],
  'gate': 'Panel psid, kalender lag, dukungan investasi/material, konsep modal dan deflator harus sah sebelum estimator terkait dijalankan. G2 menyediakan pemeriksaan eligibility pada versi input yang sama.'},
 'G2': {
  'title': 'Audit kualitas modal, energi, R&D, perdagangan dan FDI',
  'work': ['Refresh audit pada G0.5 untuk modal, setiap komponen energi Scope 1/2, R&D, ekspor/impor, nilai ekspor dan FDI; jangan memakai receipt G2 tanggal 9 September sebagai audit data sekarang.',
           'Bangun registry variable × year dan pisahkan source absence, ordinary missing, masked/invalid, reported zero, negative/domain failure dan provisional/verified status.',
           'Rekonsiliasi komponen dan total, batas share, satuan dan nilai ekspor pprxp × output berdasarkan skala sumber yang dibuktikan.',
           'Hasilkan eligibility masks dan alasan per observasi, aggregate exception tables, prioritas perbaikan serta rekomendasi input untuk setiap cabang analisis.'],
  'charts': ['Heatmap kualitas/kelengkapan variable × year dengan denominator.', 'Distribusi dan outlier variabel utama menurut tahun, sebelum/sesudah mask.', 'Chart rekonsiliasi accounting, share dan konversi nilai ekspor.', 'Flow jumlah sampel eligible dan alasan pengecualian per keluarga analisis.'],
  'gate': 'Sebagian audit cross-sectional dapat berjalan tanpa panel. Jangan membuat mask longitudinal atau menyatakan psid valid. Audit G0.5 tidak mengesahkan kualitas actual; finalisasi mengulang G2 pada input actual.'},
 'G3': {
  'title': 'Bandingkan SI baru dan lama untuk 2010–2015',
  'work': ['Gunakan subset 2010–2015 dari G0.5 sebagai sisi data baru dan deklarasikan input pembanding lama yang kompatibel untuk development.',
           'Bekukan universe/frame, definisi, satuan, klasifikasi dan kesebandingan sebelum menghitung perbedaan; sample baru tidak boleh dikali sepuluh lalu disebut populasi lama.',
           'Susun perbandingan enam tahun, distribusi/deskriptif, pasangan field serta status comparable/unavailable/noncomparable; matched-record analysis hanya jika kunci sah tersedia.',
           'Simpan alasan perbedaan dan keputusan kesebandingan. Pengujian kesamaan actual lama/baru dilakukan ulang lokal saat finalisasi; noise G0.5 bukan bukti discrepancy sumber.'],
  'charts': ['Matriks cakupan enam tahun dan variabel kedua vintage.', 'Paired means/quantiles atau distribusi lama-baru pada universe yang sebanding.', 'Heatmap perbedaan menurut variable × year dengan satuan/toleransi.', 'Rekonsiliasi matched/add/drop jika linkage sah, atau coverage/ketidakbandingan yang dinyatakan jelas.'],
  'gate': 'Paket G0.5 tidak menyediakan otomatis comparator lama yang telah diperturbasi. Jika belum ada, catat kebutuhan input kompatibel dan lanjutkan kode/registry/diagnostik sisi baru; jangan memasukkan actual lama sebagai fallback cloud, memakai G0.5 sebagai kedua sisi, atau mengarang old2015.'},
 'R1': {
  'title': 'Paris Agreement dan respons perusahaan terinternasionalisasi',
  'work': ['Pisahkan yearly adjusted gaps (matching/balancing) dari panel differential/event-study estimand; jelaskan kelompok exporter/importer/FDI dan denominator masing-masing.',
           'Bekukan exposure sebelum Paris untuk cabang panel, perlakukan 2015 sebagai transisi sesuai spesifikasi, dan tampilkan 2016 sebagai tahun tidak tersedia.',
           'Definisikan outcome energi, emisi, produktivitas/intensitas dan komponen Scope 1/2; prespesifikasi outcome utama serta kebijakan pengujian banyak outcome.',
           'Sediakan balance, overlap, bobot/effective sample size, attrition, dukungan kalender, pretrend dan sensitivitas. Paris sebagai satu tanggal bersama tidak otomatis menjadi staggered DiD.'],
  'charts': ['Tren kelompok sebelum/sesudah Paris dengan coverage.', 'Yearly adjusted gaps dan interval ketidakpastian.', 'Panel differential/event-study plot pada waktu yang benar-benar teramati.', 'Balance/overlap serta sampel dan bobot per group × year.'],
  'gate': 'Yearly cross-sectional branch dapat dikembangkan terpisah jika field dan support tersedia. Panel branch tetap memerlukan psid terverifikasi, exposure pre-event dan konsep harga yang sah.'},
 'R2': {
  'title': 'Replikasi internasionalisasi dan efisiensi energi dengan event study',
  'work': ['Baca spesifikasi paper/kode pendahulu dan buat compatibility branch; catat eksplisit perubahan yang diperlukan untuk SI 2010–2022.',
           'Bangun satu registry entry export/import/FDI, cohort, risk set, controls, reversal, left/interval censoring, calendar support dan weights.',
           'Implementasikan desain utama pendahulu yang telah ditelaah serta pembanding yang benar-benar sebanding; jangan menukar nama estimator tanpa menyamakan estimand, sample dan weighting.',
           'Simpan group-time/event-time results, dukungan, pretrend/placebo, sensitivity dan registry reusable untuk R6/R8.'],
  'charts': ['Flow cohort/treatment/control dan attrition.', 'Heatmap cohort × calendar/event time dan dukungan estimasi.', 'Dynamic effects dengan interval ketidakpastian dan reference period.', 'Perbandingan spesifikasi/metode pada common estimand dan sample.'],
  'gate': 'Current psid belum terverifikasi. First observed participation bukan first-ever entry; 2015→2017 bukan lag satu tahun. Jangan membuat riwayat perusahaan sintetis untuk melewati syarat.'},
 'R3': {
  'title': 'Determinan penurunan energi/emisi dan impor environmental goods',
  'work': ['Definisikan pengurangan dalam level, log dan intensitas sebagai outcome berbeda, dengan baseline, sampel dan kalender perubahan yang jelas.',
           'Implementasikan FE/first-difference associations yang didukung; pisahkan kontribusi output growth, energi dan emisi serta risiko regression to the mean.',
           'Buat registry environmental-goods list, product-year concordance, linkage dan coverage; bandingkan definisi broad/narrow jika sumber mendukung.',
           'Simpan semua hasil dan sensitivitas definisi, attrition, missingness/collinearity, serta interpretasi yang eksplisit nonkausal.'],
  'charts': ['Distribusi perubahan level versus intensitas.', 'Coefficient plots asosiasi dengan satuan dan interval.', 'Coverage linkage environmental goods serta perbedaan list definition.', 'Sensitivitas baseline/outlier/sample dan rekonsiliasi komponen rasio.'],
  'gate': 'FE/perubahan antarwaktu memerlukan psid sah. Data/list EG yang belum tersedia atau tidak cocok tetap unknown; barang yang diimpor tidak otomatis merupakan teknologi yang dipasang/digunakan.'},
 'R4': {
  'title': 'COVID: survival, kehilangan observasi dan pemulihan perusahaan',
  'work': ['Bekukan cohort sebelum COVID dan buat trajectory registry reusable; bedakan entry frame, observed absence, kembali teramati, verified closure, survive-shrink dan survive-grow.',
           'Gunakan karakteristik sebelum shock; tetapkan waktu-at-risk, censoring dan horizon observasi sampai 2022 tanpa future leakage.',
           'Pilih hazard/survival model hanya jika status mendukung; gunakan model multinomial trajectory sesuai pertanyaan dan evidence, bukan untuk menyamarkan closure yang tidak diketahui.',
           'Rekonsiliasi seluruh denominator, periksa rare outcomes/separation/calibration, dan pisahkan hasil survivor-conditional dari populasi baseline.'],
  'charts': ['Flow cohort dan trajectory sepanjang 2017–2022.', 'Kurva survival/observation yang diberi label sesuai status yang diketahui.', 'Probabilitas trajectory atau hazard menurut karakteristik baseline dengan ketidakpastian.', 'Chart censoring, temporary gaps, closure evidence dan perubahan denominator.'],
  'gate': 'Hilang dari survei bukan bukti mati/tutup. Cohort longitudinal memerlukan psid dan frame/status evidence; kode harus mempertahankan unknown. Registry yang diterima menjadi input R10.'},
 'R5': {
  'title': 'Kebijakan iklim negara tujuan ekspor dan respons perusahaan',
  'work': ['Audit kelayakan linkage firm × destination/product × year dan kesesuaian nilai dengan ekspor perusahaan.',
           'Bangun policy timing/applicability registry dengan sumber primer dan bekukan baseline destination/product shares sebelum shock.',
           'Nyatakan exposure/estimand, timing dan counterfactual; pisahkan kebijakan iklim dari demand atau shock tujuan yang lain.',
           'Analisis konsentrasi exposure, dominant shocks, support/pretrend dan inference pada level shock yang tepat; simpan sensitivitas terhadap tujuan dominan.'],
  'charts': ['Baseline destination shares dan konsentrasi exposure.', 'Timeline kebijakan, applicability dan available support.', 'Exposure-response/event profile dengan ketidakpastian yang didukung.', 'Leave-major-destination-out sensitivity dan coverage linkage.'],
  'gate': 'Destination/product linkage, policy data dan panel identity masih harus dibuktikan. Jangan mengarang exposure dari negara tujuan yang tidak tersedia atau menjadikan tanggal kebijakan saja sebagai identifikasi kausal.'},
 'R6': {
  'title': 'Margin penyesuaian dekarbonisasi setelah perusahaan mulai ekspor',
  'work': ['Gunakan registry event/control R2 yang diterima; pertahankan common estimand/sample/weights saat membandingkan komponen, dengan outcome-specific exceptions yang dinyatakan.',
           'Hitung profil VA/output, GJ, CO2 dan rasio produktivitas; rekonsiliasi identitas log pada sample/estimator/weights yang sama.',
           'Pisahkan fuel mix, Scope 1/2, electricity dan own generation; cegah double counting bahan bakar/pembangkit dan lakukan constant-grid-factor sensitivity.',
           'Simpan margin results, sample exceptions, dukungan, pretrend dan batas interpretasi mekanisme.'],
  'charts': ['Panel event-study komponen output/VA, energi dan emisi.', 'Identitas productivity gain versus numerator/denominator changes.', 'Perubahan fuel mix, scope dan own generation.', 'Common-sample/support serta constant-grid-factor sensitivity.'],
  'gate': 'R2 event registry dan psid terverifikasi diperlukan untuk cabang event study. Component correlations tidak otomatis mengidentifikasi mekanisme kausal.'},
 'R7': {
  'title': 'Akuisisi asing, teknologi lebih hijau dan perbedaan setelah Paris',
  'work': ['Validasi ownership events: akuisisi kontrol, perubahan minoritas/threshold, reversal, reorganisasi dan recording changes harus dibedakan.',
           'Bangun acquisition-specific cohorts/control risk sets, lalu event study energi/emisi/intensitas dengan horizon observasi yang sebanding.',
           'Bandingkan cohort sebelum/sesudah Paris pada common event horizons dan support; audit anticipatory trends, selection, co-transitions dan attrition.',
           'Simpan ownership-threshold/definition sensitivity dan constant-grid-factor results; angka paper terdahulu bukan target hasil yang harus dicocokkan.'],
  'charts': ['Flow validasi acquisition events dan coverage.', 'Acquisition event effects pada level dan intensitas dengan interval.', 'Perbandingan cohort pre/post-Paris pada horizon yang sama.', 'Sensitivitas threshold, co-transitions dan sample support.'],
  'gate': 'psid dan bukti perubahan ownership belum otomatis tersedia dari G0.5. First observed FDI atau threshold crossing tidak boleh disebut akuisisi yang diketahui tanpa bukti.'},
 'R8': {
  'title': 'Export entry dan restrukturisasi produk perusahaan',
  'work': ['Deklarasikan grain firm × product × year, kunci, duplicate/other-product rules, reporting thresholds dan annual code bridge sebelum agregasi.',
           'Bangun product count, product-value HHI, entry/exit dan core-product share; rekonsiliasi product values dengan firm output.',
           'Terapkan registry export-entry R2 dengan outcome-specific product masks/weights yang jelas, tanpa mengubah cohort/event secara diam-diam.',
           'Simpan event effects serta sensitivitas kode/threshold/coverage/attrition dan batas klaim mekanisme.'],
  'charts': ['Coverage product reporting dan rekonsiliasi ke output.', 'Distribusi product count, HHI dan core share.', 'Event-study product scope/restructuring dengan interval.', 'Product entry/exit versus recoding/reporting sensitivity.'],
  'gate': 'Memerlukan R2, psid sah dan data produk dengan lineage G0.5 yang kompatibel. Missing product module bukan nol produk; recoding bukan product entry nyata.'},
 'R9': {
  'title': 'Dekomposisi dekarbonisasi: within, reallocation, entry dan exit',
  'work': ['Nyatakan terlebih dahulu aggregate intensity identity, numerator/denominator dan weights pada universe eligible yang sama.',
           'Implementasikan FHK dan Melitz–Polanec sebagai accounting decompositions; jaga cross term dan covariance scaling, lalu petakan komponen ke label utama dengan transparan.',
           'Rekonsiliasi seluruh komponen dengan perubahan agregat pada setiap interval/group; pertahankan kategori unsupported/empty.',
           'Uji kasus numerik yang dapat dihitung tangan dan sensitivitas membership sector/trade/FDI, entrant/exit evidence serta moving versus fixed groups.'],
  'charts': ['Tren intensitas agregat dengan universe/weights.', 'Waterfall/stacked contributions within, reallocation, cross, entry dan exit.', 'Perbandingan konvensi FHK dan Melitz–Polanec.', 'Reconciliation residuals, entry/exit evidence dan sensitivitas grouping.'],
  'gate': 'Ini termasuk 11 baris Estimation dalam Word tetapi merupakan accounting, bukan causal regression. Dynamic decomposition memerlukan psid dan valid entry/exit; jangan menyimpulkan exit dari missing survey.'},
 'R10': {
  'title': 'Internasionalisasi dan ketahanan perusahaan saat COVID',
  'work': ['Gunakan cohort/trajectory R4 yang diterima dan bekukan exporter/importer/FDI exposure sebelum shock, sesuai aturan baseline yang dinyatakan.',
           'Tampilkan jalur 2017–2022 serta definisi pre/reference/post; jangan memilih kelompok berdasarkan status dagang setelah COVID.',
           'Pisahkan survival/observation dari output, employment, productivity dan participation outcomes; rekonsiliasi intensive-margin/survivor samples dengan baseline.',
           'Simpan differential paths, overlap/selection/attrition dan outcome/exposure sensitivities dengan batas identifikasi yang tepat.'],
  'charts': ['Cohort dan exposure groups sebelum COVID.', 'Differential recovery/event-time paths dengan interval.', 'Survival versus intensive-margin outcome comparison.', 'Perubahan denominator, attrition, overlap dan sensitivitas exposure.'],
  'gate': 'Bergantung pada cohort R4 dan psid yang sah. Missing output tidak sama dengan nol; produktivitas setelah verified closure tidak otomatis terdefinisi.'},
 'R11': {
  'title': 'Dekarbonisasi, pekerjaan, upah dan komposisi tenaga kerja',
  'work': ['Audit cakupan/definisi pekerja, wages, komponen dan deflator menurut tahun; rekonsiliasi komponen tenaga kerja dengan total.',
           'Implementasikan FE/first-difference associations antara perubahan kinerja lingkungan dan employment/wages/composition pada kalender dan sampel yang sah.',
           'Bandingkan ratio measures dengan komponen CO2, GJ, VA/output dan workers agar common numerator/denominator tidak disalahartikan sebagai hubungan ekonomi.',
           'Simpan lag/domain/attrition/sensitivity checks serta interpretasi nonkausal; causal extension membutuhkan desain shock tersendiri yang dibuktikan.'],
  'charts': ['Coverage pekerja/upah/komponen per tahun.', 'Tren outcome tenaga kerja dan ukuran lingkungan pada sampel yang dinyatakan.', 'Coefficient plots asosiasi dan interval dalam satuan bermakna.', 'Ratio-versus-component serta sample/lag/deflator sensitivity.'],
  'gate': 'psid, wage coverage dan deflator perlu dibuktikan. Wage fields yang tidak tersedia, termasuk coverage sesudah 2018, tidak boleh menjadi nol; asosiasi FE bukan bukti kausal.'},
}


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def link(path, label, *, pinned=False):
    assert (ROOT / path).exists(), path
    return f'[{label}]({REPO}/blob/{BASIS if pinned else "main"}/{quote(path, safe="/")})'


def quote_block(value):
    # Preserve source words and paragraph breaks; omit Word's invisible line-end spaces.
    return '\n'.join(('> ' + line.rstrip()) if line.strip() else '>' for line in value.strip().splitlines())


def build():
    if (OUT / 'publication-verification.json').exists():
        raise SystemExit('Published issue packets are immutable to this builder; edit and synchronise the existing issues explicitly.')
    if (OUT / 'packets.json').exists():
        existing = json.loads((OUT / 'packets.json').read_text())
        if any(packet.get('issue_url') for packet in existing.get('issues', [])):
            raise SystemExit('GitHub issues are already registered; refusing to overwrite their bodies or receipts.')
    OUT.mkdir(parents=True, exist_ok=True)
    reference = OUT / 'reference'; reference.mkdir(exist_ok=True)
    skill = Path('/Users/natanaelmassie/.codex/skills/analytical-dag/SKILL.md')
    shutil.copy2(skill, reference / 'analytical-dag-SKILL.md')
    (reference / 'source.json').write_text(json.dumps({'captured_at': datetime.now(ZoneInfo('Asia/Jakarta')).isoformat(),
        'source_path': str(skill), 'sha256': sha(skill), 'purpose': 'Repo-readable owner-required skill; current owner/repository instructions take precedence.'}, indent=2) + '\n')
    (OUT / 'OWNER-REQUEST.md').write_text('''# Owner request — 13 September 2026

> ok bs minta buatkan jadi baik 1 2 3 dan 11 masnig2 ada issue github masing2? tp di specifiy pakai data hasi g0.5

> dan buat mereka pakai skill kesukaan gw analytical dag.. commented lunamax ala sebelah... full dibilin ada chart dan harus sbeagus qje aer mckinsey etc

> dan buklang refrensi hasil dan kualitasnya minimal se yg di G0 sebelah if not much better

Scope: create 14 separately tracked issues, G1–G3 and R1–R11, with G0.5 input, the analytical-dag workflow, a Luna/max commenting pass, complete charts/reports, QJE/AER research care and McKinsey presentation clarity. G0 is the explicit minimum quality reference. This issue-preparation task does not execute fourteen analyses or change original Word PIC/completion fields.
''')
    rows = {r['request_id']: r for r in json.loads((ROOT / 'requests/registry.json').read_text())}
    g05 = json.loads((ROOT / 'data/g0-5-development/manifest.json').read_text())
    manifest_hash = sha(ROOT / 'data/g0-5-development/manifest.json')
    assert g05['rows'] == 33049 and g05['columns'] == 4379
    packets = []
    for rid in IDS:
        r, spec = rows[rid], SPEC[rid]
        plan_path = f'{PLAN}/{rid}.json'
        plan = json.loads((ROOT / plan_path).read_text())
        assert plan['source']['request'] == r['source_request'] and plan['row_complete'] is False
        assert plan['execution_input_policy']['development_mode'] == 'development'
        title = f'[{rid}][G0.5] {spec["title"]}'
        body = f'<!-- deasy-g05-work-item:{rid} -->\n\n'
        body += f'Implementasikan **{spec["title"]}** sebagai modul lengkap berbasis **hasil G0.5**, dengan hasil yang dapat dibaca, ditelusuri dan dijalankan ulang. **Mutu minimum harus setara G0 sebelah; tingkatkan kualitasnya jika relevan.**\n\n'
        body += f'Word: **{rid} / nomor {r["source_number"]}**, PIC asli **{r["source_pic"].strip() or "belum diisi"}**. PIC Word dipertahankan sebagai atribusi; issue ini tidak menetapkan GitHub assignee baru.\n\n'
        body += '## Input wajib: G0.5\n\n'
        body += link('data/g0-5-development/README.md', 'Paket data', pinned=True) + ' · ' + link('data/g0-5-development/manifest.json', 'manifest', pinned=True) + ' · ' + link('docs/DATA-MODES.md', 'adapter Python/Stata', pinned=True) + ' · ' + link('docs/DATA-IDENTIFIERS.md', 'ID/psid', pinned=True) + '\n\n'
        body += f'Versi acuan repo `{BASIS}`; SHA256 manifest G0.5 `{manifest_hash}`. Data: **33.049 observasi × 4.379 kolom, 12 wave, 2010–2015 dan 2017–2022**. Perubahan versi harus eksplisit dalam receipt.\n\n'
        body += '```python\nfrom harness.data_source import load_data\ndata = load_data(mode="development")\n```\n\n'
        body += 'Gunakan hanya G0.5 atau turunan development yang lineage-nya disahkan. `obs_id` adalah ID observasi; `psid` saat ini seluruhnya missing. Cabang panel wajib `require_panel=True` atau pemeriksaan Stata setara; jangan mengarang firm linkage atau kalender 2016. Semua tabel/chart/laporan diberi label **G0.5 DEVELOPMENT**, bukan temuan empiris final. Actual finalisation memilih input actual lokal secara eksplisit lalu menjalankan ulang kode yang sama. Jangan mengambil actual lama dari riwayat Git sebagai fallback.\n\n'
        body += '## Permintaan asli dan sumber kerja\n\n' + quote_block(r['source_request']) + '\n\n'
        body += 'Baca ' + ' · '.join([link(r['folder']+'/SOURCE.md', 'SOURCE/strategi/catatan', pinned=True), link(r['folder']+'/README.md', 'kontrak pembacaan', pinned=True), link(r['folder']+'/task.json', 'task dan acceptance asli', pinned=True), link(r['folder']+'/EVIDENCE.md', 'kode/bukti pendahulu', pinned=True), link(plan_path, 'rencana DAG/exhibit terbaru', pinned=True)]) + '. Teks dan PIC asli tidak diganti oleh interpretasi implementasi di bawah.\n\n'
        body += '## Pekerjaan khusus modul\n\n' + '\n'.join('- [ ] ' + x for x in spec['work']) + '\n\n'
        body += '## Workflow wajib: analytical-dag dan Luna/max\n\n'
        body += '- [ ] Pakai skill **`analytical-dag`**: satu primary Stata, computational edges yang granular, kontrak grain/key/unit/input/output/denominator, node `triage.md` → `decision.md`, registri edge/triage/evidence, DAG Mermaid/SVG, logs dan hash-bound run receipts. Pisahkan setiap keputusan yang bisa mengubah angka; reuse plan/kode yang sudah ada.\n'
        body += '- [ ] Lakukan dedicated **Luna/max** (`gpt-5.6-luna`, effort `max`) comment pass seperti G0: header akurat dan penjelasan bahasa Indonesia untuk setiap blok hitung, formula, sampel, merge, konversi, asumsi, validasi dan keluaran. Sertakan progress log yang terbaca, coverage manifest dan review; buktikan commentary pass tidak mengubah executable/scientific code. Catat runtime yang benar-benar dipakai.\n'
        body += '- [ ] Ikuti ' + link('docs/G05-ANALYSIS-STANDARD.md', 'standar lengkap 14 issue') + ' dan ' + link('work-items/github-issues/g05-20260913/reference/analytical-dag-SKILL.md', 'snapshot skill yang dapat dibaca di GitHub') + '. Semua persyaratan pada standar tersebut merupakan bagian dari issue ini.\n\n'
        body += '## Chart dan kualitas hasil\n\n'
        body += '**Wajib ada chart yang dihitung dari hasil modul**, bukan sekadar template, tabel atau screenshot. Stata menghasilkan angka/CSV; Python/R membuat SVG + PNG dari CSV tersebut. Setiap exhibit memiliki pertanyaan, takeaway, satuan, sample/denominator, periode, sumber, ketidakpastian bila relevan, dan label G0.5. Simpan plot code, chart-data CSV dan bukti numeric/visual QA.\n\n'
        body += '\n'.join(f'- [ ] {rid}-C{i}: {x}' for i, x in enumerate(spec['charts'], 1)) + '\n\n'
        body += f'Ini set chart minimum yang spesifik untuk modul. Rekonsiliasi juga **{len(plan["exhibits"])} keluarga exhibit** pada rencana yang ditautkan: delivered, digabung dengan alasan yang jelas, atau blocked dengan bukti. Jangan membuat estimasi/grafik palsu ketika data atau linkage belum mendukung.\n\n'
        body += '**QJE/AER:** estimand/identity, definisi dan asumsi eksplisit; metode bersumber; sample losses, inference, diagnostics dan robustness lengkap; klaim kausal/association/accounting dibedakan. **McKinsey:** alur jawaban jelas, satu pesan per chart, tipografi/palette/spacing konsisten, label terbaca dan kesimpulan sesuai bukti.\n\n'
        body += '**Referensi minimum G0 yang wajib dibaca:** ' + ' · '.join([
            link('releases/2026-09-13-g0/README.md', 'buku/atlas/hasil G0', pinned=True),
            link('releases/2026-09-13-g0/results/1014-research/G0-RD2017/README.md', 'contoh pembahasan dan chart R&D', pinned=True),
            link('releases/2026-09-13-data-foundation/README.md', 'G0 terbaru: kode dan pemeriksaan', pinned=True),
            link('releases/2026-09-13-data-foundation/execution-evidence/comment-review/root-review.json', 'bukti review komentar Luna/max', pinned=True)]) + '.\n\n'
        body += 'Buat `quality-review.md` yang membandingkan hasil modul dengan G0 pada kedalaman penjelasan, ketelitian angka, komentar, chart, sumber dan reproduksibilitas; perbaiki kekurangan material. Gunakan G0 sebagai acuan mutu, **jangan menyalin angka/grafik aktualnya sebagai hasil G0.5**. Tidak ada kuota halaman; tidak cukup hanya menempel label “publication quality”.\n\n'
        body += '## Paket keluaran lengkap\n\n'
        body += f'Primary yang direncanakan: `{plan["primary_do"]}`; lokasi dapat mengikuti workspace modul dengan pemetaan yang dinyatakan. Pisahkan run development dan actual. Minimum mencakup:\n\n'
        body += '- [ ] README + perintah reproduksi; laporan Markdown/HTML lengkap dengan overview, metode/rumus, hasil/exhibit, interpretasi, limitations dan next actions. Tidak membuat PDF baru kecuali diminta eksplisit.\n'
        body += '- [ ] Kode Stata/Python/R berkomentar, DAG/node registries, variable/specification registry, intermediate inventory, output tables, plot CSV, SVG/PNG, logs/failures, acceptance/run manifests dan agent-history.\n'
        body += '- [ ] Hasil spesifik yang tercatat pada kontrak sumber (ikat ke mode development dan simpan record-level intermediates sesuai kebijakan repo):\n\n' + '\n'.join('  - `' + p + '`' for p in r['planned_outputs']) + '\n\n'
        body += '## Acceptance khusus dari kontrak sumber\n\n' + '\n'.join('- [ ] ' + x for x in r['definition_of_done']) + '\n\n'
        body += 'Terapkan acceptance di atas pada implementation/development yang diberi label; persyaratan actual-data acceptance tetap harus dibuktikan ulang saat finalisasi. Bedakan code readiness, development result readiness dan actual-finalisation status.\n\n'
        body += '## Dependensi dan batas saat ini\n\n' + spec['gate'] + '\n\n'
        source_deps = [d['id'] for d in plan['dependencies']]
        body += 'Registry input/metode: ' + ', '.join('`' + d + '`' for d in source_deps) + '. Detail ada pada rencana DAG yang ditautkan. Terapkan syarat pada cabang yang memerlukannya; lanjutkan kode/DAG/diagnostik independen yang memang dapat dikerjakan.\n\n'
        body += 'Issue belum selesai hanya karena scaffold, unit tests, komentar atau desain chart tersedia. Berikan bukti output dan pemeriksaan yang benar-benar dijalankan. Jika cabang inti belum bisa dipenuhi, catat blocker tepatnya dan pertahankan status terbuka.\n\n'
        body += '<!-- ISSUE-LINKS-START -->\nIssue dependencies akan ditautkan setelah batch 14 issue terdaftar; lihat dahulu ID dan rencana sumber di atas.\n<!-- ISSUE-LINKS-END -->\n'
        path = OUT / f'{rid}.md'; path.write_text(body)
        assert len(body.encode()) < 50000
        packet_sources = [r['folder']+'/'+p for p in ['SOURCE.md','README.md','task.json','EVIDENCE.md']] + [plan_path]
        packets.append({'work_item':rid,'title':title,'body_path':str(path.relative_to(ROOT)),
            'body_sha256':sha(path),'body_bytes':path.stat().st_size,'source_pic':r['source_pic'],
            'source_packet_hashes':{p:sha(ROOT/p) for p in packet_sources},
            'related_batch_work_items':[x for x in source_deps if x in IDS and x!=rid],
            'minimum_charts':spec['charts'],'planned_exhibit_families':len(plan['exhibits']),
            'source_definition_of_done_preserved':True})
    index={'status':'PREPARED_NOT_YET_PUBLISHED_AS_ISSUES','repository':REPO,'basis_commit':BASIS,
        'owner_scope':IDS,'count':len(packets),'data_mode':'development','dataset':'G0.5',
        'data_manifest_sha256':manifest_hash,'mandatory_skill':'analytical-dag','comment_model':'gpt-5.6-luna',
        'comment_reasoning_effort':'max','minimum_quality_reference':'G0 adjacent work; improve where relevant',
        'research_benchmark':['QJE','AER'],'presentation_benchmark':'McKinsey','issues':packets}
    (OUT/'packets.json').write_text(json.dumps(index,ensure_ascii=False,indent=2)+'\n')
    (OUT/'README.md').write_text('# G0.5 — 14 GitHub issue packets\n\nG1–G3 and R1–R11: three data tasks and eleven Word estimation/research requests. No G0, G0.5 or descriptive-row issue is added by this batch.\n\nEvery issue requires G0.5, analytical-dag, Luna/max commentary, complete charts/reports, QJE/AER research care, McKinsey communication, and quality at least as good as the linked G0 reference. [Full standard](../../../docs/G05-ANALYSIS-STANDARD.md), [owner request](OWNER-REQUEST.md), [machine index](packets.json).\n\n'+ '\n'.join(f'- [{p["work_item"]}]({p["work_item"]}.md) — {SPEC[p["work_item"]]["title"]}' for p in packets)+'\n')
    print(json.dumps({'packets':len(packets),'total_body_bytes':sum(p['body_bytes'] for p in packets),
        'max_body_bytes':max(p['body_bytes'] for p in packets),'minimum_charts':sum(len(p['minimum_charts']) for p in packets),
        'original_rows_unmodified':44},indent=2))


if __name__ == '__main__':
    build()
