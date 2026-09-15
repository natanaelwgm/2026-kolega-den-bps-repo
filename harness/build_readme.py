#!/usr/bin/env python3
"""Generate the owner-facing entrypoint from the source-faithful task registry."""
from pathlib import Path
import json
from urllib.parse import quote
ROOT=Path(__file__).resolve().parents[1]

INTRO='''# Deasy–Imed: Indonesian Manufacturing Research, 2026

**Private research repository · SI 2010–2022 · current work, predecessor code and the complete Deasy backlog.**

Repo ini adalah tempat membaca, meninjau, dan mendelegasikan kajian Deasy–Imed tanpa harus mencari ulang konteks di banyak folder atau percakapan. Isinya mencakup kode Stata/DAG yang sedang dipakai, pekerjaan Data 0/1/2/3, paper dan replikasi CIPS–CSIS terdahulu, bahan LUDI/TOAR/WARAN yang tersedia, Excel hasil agregat, serta **44 folder permintaan Word Deasy** dengan teks asli dan definition of done.

**Dataset perusahaan tidak diunggah.** Kode, kamus, daftar input, checksum yang tersedia, catatan metode, tabel agregat dan referensi tetap disertakan. Pembaca tanpa data bisa memahami dan mereview pekerjaan; eksekusi penuh membutuhkan input yang disambungkan secara terpisah di lingkungan yang diizinkan.

**Status paling penting, 10 September 2026:** Data 0 mempunyai antarmuka data kerja standar, 33.049 rekaman × 3.776 kolom. Definisi sebagian kolom masih provisional dan diberi penanda. Hasil Data 2/3 tersedia untuk versi 9 September; keduanya belum menjadi bukti validasi atas revisi G0 tanggal 10 September. Implementasi TFP lama ada untuk LP, ACF dan Wooldridge, tetapi belum diadaptasikan dan divalidasi pada SI baru. Tidak ada estimator baru yang dijalankan untuk membuat repo ini.

## Jalur baca

| Kalau ingin… | Buka |
|---|---|
| Memahami status sebenarnya dan perbedaan versi | [Current state](docs/CURRENT-STATE.md) |
| Melihat semua baris Deasy, nomor dan PIC asli | [Daftar 44 permintaan](requests/README.md) |
| Mulai dari data utama | [Data 0](requests/data/00-main-dataset/README.md) |
| Memeriksa TFP lama dan apa yang harus diadaptasi | [Data 1 / TFP](requests/data/01-tfp/README.md) |
| Memeriksa kualitas variabel | [Data 2](requests/data/02-quality-checks/README.md) |
| Membandingkan SI lama dan baru | [Data 3](requests/data/03-old-new-si/README.md) |
| Menemukan paper, kode atau Excel terdahulu | [Indeks referensi](references/README.md) dan [katalog file](catalog/README.md) |
| Menugaskan baris tertentu kepada orang/agen lain | [Cara menggunakan harness](docs/WORKING-WITH-AGENTS.md) |
| Memahami input yang belum tersedia | [Dependencies](docs/DEPENDENCIES.md) dan [kebijakan data](data/README.md) |
| Memahami struktur DAG dan snapshot Stata | [DAG dan snapshot](docs/DAG-AND-SNAPSHOTS.md) |
| Memahami keputusan dan perubahan scope | [Kronologi keputusan](docs/DECISIONS.md) |

## 1. Apa kajian ini?

Kajian ini memanfaatkan Survei Industri Besar dan Sedang (SI/IBS) Indonesia untuk mempelajari hubungan internasionalisasi perusahaan—ekspor, penggunaan input impor, dan kepemilikan asing—dengan produktivitas, penggunaan energi, emisi, perubahan produk, tenaga kerja, dan ketahanan saat COVID. Horizon permintaan baru adalah **2010–2022**.

Pekerjaan sebelumnya memberi fondasi yang cukup besar. Cabang **CIPS** berfokus pada produktivitas energi/karbon, misalnya VA/GJ dan VA/CO2. Cabang **CSIS** juga mencakup efisiensi teknis dan TFP. Paper terdahulu memakai desain masuk ke pasar internasional, dengan **BJS sustained-entry** sebagai desain utama dan Sun–Abraham, dCDH, serta CS-DID sebagai pemeriksaan tambahan. Desain dan hasil itu perlu dipahami sebelum menyesuaikannya ke data baru.

Kajian ini berbeda dari paper China-shock/kemiskinan yang memakai unit wilayah dan data rumah tangga/tenaga kerja. Kuesioner IBS dari folder lama tersebut relevan sebagai sumber definisi; seluruh model kemiskinannya tidak otomatis menjadi model paper manufaktur ini. Proposal GreenTrade juga merupakan pekerjaan terpisah.

Pertanyaan Deasy mencakup beberapa tingkat pembuktian. Statistik deskriptif menunjukkan bagaimana sampel/populasi teramati. Accounting decomposition menjelaskan komponen perubahan secara identitas. Regresi FE menunjukkan asosiasi bersyarat kecuali tersedia desain identifikasi tambahan. DiD/event study memerlukan kejadian, pembanding, dukungan sampel dan asumsi tren yang nyata. Repo menjaga perbedaan tersebut di setiap baris.

## 2. Sumber permintaan: Word yang mana?

Sumbernya **[List do file yang perlu dibuat.docx](references/deasy-word/List%20do%20file%20yang%20perlu%20dibuat.docx)**, dibagikan Deasy di Kolega DEN BPS pada 30 Agustus 2026, diperbarui 31 Agustus, dan diunduh melalui Safari pada 8 September sekitar 20:20 WIB.

- Ukuran salinan: **40.820 bytes**.
- SHA256: `027fbf675aa8001a50060561781930440ee4d9697cc790ba593452fe528edd92`.
- [Ekstraksi lengkap](research/1014/04-working-understanding/20260908-deasy-word-review/evidence/source-document-complete.md) menyimpan seluruh tabel, paragraf dan komentar yang diekstrak.
- [Struktur DOCX](research/1014/04-working-understanding/20260908-deasy-word-review/evidence/docx-structure.json) menyimpan nomor tabel/baris, paragraf, PIC dan penomoran internal.
- Setiap `requests/.../SOURCE.md` mempertahankan teks barisnya. Usul manager tidak dicampur ke teks Deasy.

Ada **44 permintaan substantif**, bukan 15 total:

| Bagian | Jumlah | Nomor/ID |
|---|---:|---|
| Data preparation | 4 | Word 0–3 → G0–G3 |
| Deskriptif umum | 19 | Word 4–20 dan dua baris bernomor 21 → G4–G21b |
| Deskriptif dekarbonisasi | 10 | Word 1–10 di tabel kedua → D1–D10 |
| Estimation / research questions | 11 | Word 1–11 di tabel ketiga → R1–R11 |
| **Total** | **44** | **15 inti = 4 Data + 11 Estimation; 29 deskriptif terpisah** |

Word mengulang nomor **21** untuk product scope dan export destination. ID **G21a/G21b** membedakannya dalam harness. Baris 22 kosong dan baris kosong setelah Estimation 11 tidak dihitung. Kolom “sudah/belum” yang kosong tidak ditafsirkan sebagai pernyataan Deasy bahwa implementasinya pasti tidak ada.
'''

AFTER='''
## 6. Kode dan referensi lama yang disertakan

| Koleksi | Mengapa perlu dibaca |
|---|---|
| [1014 saat ini](research/1014/README.md) | Kode/DAG, review Word, rencana, hasil dan paket lokal yang lolos screening; riwayat perubahan tetap bertanggal |
| [LUDI handover](references/ludi-handover/HANDOVER-README%20FIRST.md) | 27 do-file, konstruksi energi/emisi dari SI lama, faktor, unit, cleaning/sensitivity, WPI, tabel/chart/workbook; 37 DTA arsip tidak diunggah |
| [Replikasi Juli end-to-end](references/july-end-to-end/README.md) | Controller Stata dan source_scripts; folder asli TOAR dan pendukung WARAN/SCHALKE; codebook, final artifacts dan validasi |
| [Replikasi paper Juli](references/july-replication/README.md) | Manuskrip, tabel final, frozen sources dan mapping paper-to-result; cakupannya berbeda dari paket end-to-end |
| [Revisi CSIS Agustus](references/csis-august/README.md) | Triage, rejoinder, estimasi set, annex DAG dan hasil Excel, termasuk revisi lanjutan |
| [CIPS–CSIS mirror](references/cips-harness/_map/MAP.md) | Kode predecessor yang root lamanya sudah tidak tersedia, termasuk C850 TFP, paper, metode dan evidence mirror |
| Revisi komentar Deasy 9 Agustus | Versi komentar, tabel dan dokumen bernama/tanggal asli; lihat indeks koleksi |
| [Kuesioner IBS lama](references/old-deasy/) | Form IBS 2009–2012 untuk memeriksa definisi; cabang kemiskinan di drive yang sama tidak dicampurkan |

Gunakan [indeks referensi](references/README.md) untuk entrypoint spesifik dan [indeks dokumen](catalog/documents.csv) untuk versi teks yang bisa dicari. Dokumen asli tetap otoritas untuk tabel, layout, gambar, persamaan dan track changes. Ekstraksi teks tidak menyatakan bahwa seluruh isi setiap paper sudah direview secara substantif.

Semua file yang disertakan mempunyai original path dan SHA256 di [source-files.csv](catalog/source-files.csv). Duplikasi versi dipertahankan saat merupakan bagian paket/histori; hash membantu mengetahui salinan identik. Cakupan koleksi dibatasi pada root penelitian yang ditelusuri dan dicatat; tidak ada klaim bahwa seluruh attachment WhatsApp atau file cloud yang pernah dibicarakan sudah ditemukan.

## 7. Data dan batas kesiapan

Input mencakup 12 wave sampel aman, old SI2010 reference, concordances, data tahunan lama, panel/referensi predecessor, WPI dan modul detail jika nantinya tersedia. [Daftar ketergantungan](docs/DEPENDENCIES.md) memisahkan yang tersedia lokal, belum diintegrasikan, dan belum ditemukan.

File DTA/DBF/parquet, panel CSV dan raw sample Excel—termasuk yang dimasking—tidak diunggah. Workbook yang memuat mismatch per perusahaan juga tidak lolos sebagai tabel agregat. Daftar pengecualian dan alasan ada di katalog. Spreadsheet price-index, codebook/concordance dan hasil agregat yang lolos pemeriksaan tetap tersedia. Salinan dokumen asli tidak otomatis mendapat lisensi baru; repo tetap private.

Belum tersedia bukan selalu berarti tidak mungkin diperoleh. Toar pernah menyatakan WPI diunggah; file baru itu belum terbukti terhubung di sini. Panel sempat diperdebatkan lalu Deasy mengoreksi bahwa bisa; safe-sample yang ada tetap belum memberi crosswave firm link yang tervalidasi. Repo menjaga kedua fakta tersebut.

Beberapa keputusan kecil berdampak nyata: Word memakai **>100**, bukan >=100; nol berbeda dari missing; unknown ekspor/impor tidak otomatis nontrader; FDI ≥10% berbeda dari any foreign ownership; GJ/VA harus membedakan nilai nominal dan riil; jumlah safe sample tidak otomatis total Indonesia. Semua masuk ke kontrak, bukan pilihan tersembunyi di kode.

## 8. Folder dan harness

```text
README.md                    konteks lengkap dan jalur baca
AGENTS.md                    aturan untuk pekerja berikutnya
requests/                    44 paket tugas + registry JSON/CSV
docs/                        status, dependencies, keputusan, DAG, cara delegasi
data/                        kontrak input lokal; tanpa dataset
research/1014/               snapshot tersaring seluruh kerja 1014
references/                  LUDI, TOAR/replication, CIPS–CSIS, paper, teks dokumen
catalog/                     file/source/hash, code, document dan workbook indices
harness/                     CLI review, generator paket, screening, validator
agent-history/               keputusan dan bukti publikasi repo ini
```

```sh
python3 harness/manage.py list
python3 harness/manage.py show G0
python3 harness/manage.py show R2
python3 harness/manage.py prompt G1
python3 harness/manage.py validate
```

Perintah tersebut membaca atau memvalidasi harness; tidak menjalankan estimator. Python menangani indeks, packaging dan validasi; perhitungan penelitian tetap di Stata. Untuk reproduksi analitis, baca primary/input contract, hubungkan data di lingkungan yang diizinkan, lalu lakukan run yang secara eksplisit diminta. Jangan menjalankan orchestrator demo Agustus untuk menganggap backlog baru selesai.

Di workspace asli, root ini terhubung ke repo baru; kode kerja lama pada `05-analysis/analytical-dag/` tetap dipertahankan. Salinan GitHub berada di `research/1014/`. [Aturan sinkronisasi](docs/WORKING-WITH-AGENTS.md) menjelaskan cara menghindari dua salinan yang berubah tanpa rekonsiliasi. Sumber lama disalin dengan byte/hash asli; tautan absolut historis dapat dipetakan melalui katalog, sedangkan navigasi baru memakai jalur relatif repo.

## 9. Syarat selesai sebuah baris

Sebuah baris selesai ketika semua subpermintaan sumber mempunyai hasil atau status tidak tersedia yang dibenarkan, primary Stata yang bekerja, input/version dan sample yang jelas, tabel/chart yang bisa ditelusuri, QA bermakna, serta interpretasi sesuai tingkat pembuktiannya. Kode tersedia, run berhasil, hasil sah, dan pertanyaan terjawab adalah empat hal berbeda.

Untuk statistik/estimasi, catat unit, price basis, denominator, grouping, weighting, observed N, missing/unknown, estimator/specification, ketidakpastian dan cakupan. Untuk TFP, simpan estimation-sample dan prediction-coverage secara terpisah. Untuk decomposition, komponen menjumlah ke perubahan agregat. Untuk event study, dukungan cohort/control dan kalender harus terbukti.

Manager memeriksa hasil, menyelesaikan dampak lintas baris, memperbarui triage/decision dan agent-history, lalu menyinkronkan versi yang diterima ke private main. Nama tabel dalam rencana atau screenshot di folder belum memenuhi kontrak.

## 10. Backlog berikutnya yang paling berguna

1. **Satukan versi data:** integrasikan fragmen G0 10 September; refresh G2 dan cek dampak pada G3; freeze satu input downstream dengan receipt baru.
2. **Tutup input dasar:** temukan WPI yang dimaksud Toar, cocokkan cakupan/base year/industri, klarifikasi panel asli dan annual semantics yang tersisa.
3. **Bahas TFP memakai kode yang tersedia:** review C850, kapital/VA/materials/energy, kalender dan sample selection; ajukan implementasi terbatas sebelum estimasi.
4. **Pilih deskriptif pertama:** G4/G7–G11 dan D8 punya fondasi dekat setelah versi data disatukan; tampilkan missing/provisional dan TFP yang belum ada secara jujur.
5. **Mulai penelitian dengan reuse kuat:** R2 lalu R6 setelah entry/panel/outcome valid; R3/R11 sebagai asosiasi dan R9/D4 sebagai decomposition setelah data mendukung.
6. **Pisahkan permintaan input tambahan:** product/Proman, bahan baku detail, destinasi, akuisisi dan closure/universe survey. Jangan membuat proxy seolah modul aslinya tersedia.

Ini prioritas untuk diskusi selanjutnya; pembuatan repo tidak mengeksekusi backlog tersebut. Tunjuk folder request yang tepat untuk memberi tugas: konteks, teks sumber, evidence dan target hasil sudah ada di sana.
'''

def main():
    rows=json.loads((ROOT/'requests/registry.json').read_text());text=INTRO
    labels={
      'bounded_working_interface_published':'Data kerja tersedia; panel/WPI dan sebagian verifikasi belum selesai',
      'legacy_reuse_design_pending':'Kode TFP lama tersedia; adaptasi ke SI baru belum dijalankan',
      'baseline_complete_refresh_needed':'Hasil 9 September tersedia; perlu refresh terhadap G0 terbaru',
      'baseline_diagnostics_available':'Perbandingan awal tersedia; old2015 dan kesetaraan cakupan belum selesai',
      'awaiting_owner_selection':'Menunggu pilihan owner untuk eksekusi',
      'planning_only':'Rencana tersedia; belum dieksekusi pada SI baru'}
    for title,pred in [
        ('3. Empat pekerjaan data',lambda t:t['family']=='data'),
        ('4. Sebelas pertanyaan estimasi',lambda t:t['family']=='estimation'),
        ('5. Semua deskriptif: dicatat lengkap, belum seluruhnya dipilih untuk run',lambda t:t['family']=='descriptive')]:
        text+='\n## '+title+'\n\n'
        if 'deskriptif' in title:
            text+='Ada 19 deskriptif umum dan 10 tambahan dekarbonisasi. Setiap folder mempunyai spesifikasi tabel/chart dan acceptance criteria sendiri. Sharing child code boleh dilakukan tanpa menghilangkan cakupan masing-masing baris.\n\n'
        if 'estimasi' in title:
            text+='Ini backlog penelitian, bukan sebelas hasil SI baru yang sudah selesai. Strategi di bawah mengikuti Word; proposal tambahan dan batas identifikasi ada di folder masing-masing.\n\n'
        text+='| ID / nomor asli | PIC Word | Permintaan | '+('Metode Word' if 'estimasi' in title else 'Status')+' |\n|---|---|---|---|\n'
        selected=[t for t in rows if pred(t)]
        for t in selected:
            desc=t['source_strategy'].strip().replace('\n',' ').replace('|','/') if 'estimasi' in title else labels.get(t['execution_stage'],t['execution_stage'])
            text+='| '+t['request_id']+' / '+t['source_number']+' | '+(t['source_pic'].strip() or 'kosong')+' | ['+t['title']+']('+t['folder']+'/README.md) | '+(desc or 'Tidak diisi')+' |\n'
        if 'pekerjaan data' in title:
            for t in selected:text+='\n### '+t['request_id']+' — '+t['title']+'\n\n'+t['current_assessment']+'\n'
            text+='\nBaca “ready” sebagai tiga pertanyaan: schema standar, nilai tersedia, dan definisi terverifikasi. G0 menyediakan bentuk kerja tetap; field tanpa nilai atau belum verified tetap ditandai. Nilai nominal tidak diberi label real sebelum WPI yang tepat tersedia.\n'
    text+=AFTER
    (ROOT/'README.md').write_text(text)
    print('README words',len(text.split()),'bytes',len(text.encode()))

if __name__=='__main__':main()
