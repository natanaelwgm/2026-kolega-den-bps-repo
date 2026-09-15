#!/usr/bin/env python3
"""Render the reader report from the released Stata aggregates and receipts."""
import html
import json
from pathlib import Path
import pandas as pd

HERE=Path(__file__).resolve().parent


def table(frame, columns, names=None):
    names=names or columns
    result='| '+' | '.join(names)+' |\n| '+' | '.join(['---']*len(columns))+' |\n'
    for row in frame[columns].itertuples(index=False,name=None):
        values=[]
        for column,v in zip(columns,row):
            if pd.notna(v) and isinstance(v,(int,float)) and (column.startswith("N") or column in ("source_year","year")):
                values.append(format(v,".0f" if column in ("source_year","year") else ",.0f"))
                continue
            if pd.notna(v) and column in ("beta_L","beta_K","returns_to_scale"):
                values.append(format(v,".4f"))
                continue
            values.append('—' if pd.isna(v) else (f'{v:.3f}' if isinstance(v,float) else str(v)))
        result+='| '+' | '.join(values)+' |\n'
    return result


def main():
    out=HERE/'release/outputs'
    manifest=json.loads((HERE/'release/run-manifest.json').read_text())
    audit=json.loads((HERE/'release/qa/numeric-validation.json').read_text())
    master=json.loads((HERE/'release/qa/full-master-validation.json').read_text())
    fits=pd.read_csv(out/'nominal_coefficients.csv',dtype={'sector':str})
    primary=fits[fits.variant.eq('primary')]
    good=primary[primary.status.eq('fit_success')]
    boot=pd.read_csv(out/'nominal_bootstrap_summary.csv',dtype={'sector':str})
    att=pd.read_csv(out/'nominal_master_attachment.csv')
    support=pd.read_csv(out/'nominal_sample_support.csv',dtype={'sector':str})
    own=support[support.sample_id.eq('own')]
    op=own[own.method.eq('op')]
    pair=pd.read_csv(out/'nominal_pairwise_comparisons.csv',dtype={'sector':str})
    shared=pair[pair.sector.eq('ALL') & pair.comparison_scope.eq('pairwise')]
    # WFDOC: Ringkasan mempertahankan method dan sample_id terpisah; jumlah sektor/observasi antar-cell tidak dijumlahkan sebagai perusahaan unik.
    counts=good.groupby(['method','sample_id']).agg(sectors=('sector','nunique'),N=('N','sum')).reset_index()
    summary=table(counts,['method','sample_id','sectors','N'],['Metode','Sampel','Sektor berhasil','Observasi fit'])
    annual=table(att,['source_year','N_source','N_op','N_lp','N_acf','N_wrdg'],['Tahun','Sumber','Prediksi OP','Prediksi LP','Prediksi ACF','Prediksi Wooldridge'])
    spec=json.loads((HERE/'nominal-specification.json').read_text())
    deep=json.loads((HERE/'deep-release/qa/deep-validation.json').read_text())
    # WFDOC: Report hanya memuat appendix setelah receipt deep PASS dan base_run cocok dengan run manifest yang sama.
    assert fits.specification_id.eq(spec['specification_id']).all(), 'Result specification mismatch'
    assert Path(deep['base_run']).name==manifest['run_id'], 'Diagnostic receipt belongs to another base run'
    assert deep['status']=='PASS', 'Diagnostic validation not accepted'
    method_names={'op':'Olley–Pakes','lp':'Levinsohn–Petrin','acf':'Ackerberg–Caves–Frazer','wrdg':'Wooldridge'}
    counts['method']=counts.method.map(method_names)
    summary=table(counts,['method','sample_id','sectors','N'],['Metode','Sampel','Sektor berhasil','Observasi fit'])
    own_fit=good[good.sample_id.eq('own')]
    common_fit=good[good.sample_id.eq('common')]
    lpw=shared[shared.sample_id.eq('own') & shared.method_a.eq('lp') & shared.method_b.eq('wrdg')].iloc[0]
    lpa=shared[shared.sample_id.eq('own') & shared.method_a.eq('lp') & shared.method_b.eq('acf')].iloc[0]
    failures=table(primary.groupby(['method','sample_id','status','reason']).size().reset_index(name='N'),['method','sample_id','status','reason','N'])
    ftable=table(good,['sector','method','sample_id','N','beta_L','beta_K','returns_to_scale'],['Sektor dilaporkan','Metode','Sampel','N fit seluruh tahun','β tenaga kerja','β modal awal','Jumlah elastisitas'])
    pairtable=table(shared,['sample_id','method_a','method_b','N_compared','N_four_method','rho_spearman','pearson_centered'],['Sampel','Metode A','Metode B','Observasi pasangan','Irisan empat metode','Spearman','Pearson residual dipusatkan'])
    report=f'''# G1 — estimasi fungsi produksi

**G0.5 DEVELOPMENT — perturbed data; fictional company panel; not final empirical findings.**

Empat metode yang diminta dijalankan pada semua tahun yang didukung oleh asumsi stok modal akhir tahun. Run ini menghasilkan **{len(good)} model utama yang berhasil**: {len(own_fit)} pada sampel masing-masing metode dan {len(common_fit)} pada sampel bersama empat metode, disertai {int((fits.variant.ne('primary') & fits.status.eq('fit_success')).sum())} fit sensitivitas yang berhasil. Sebanyak **{int(boot.successful.sum()):,}/{int(boot.requested.sum()):,} draw bootstrap** berhasil. Tabel berikut memisahkan metode dan sampel, sehingga jumlah sektor atau observasi tidak disamaratakan.

{summary}

Hasil tersambung ke turunan lengkap 33.049 observasi × 4.396 kolom input. Kegagalan dukungan atau optimizer tetap tercatat; hasil tidak diganti OLS atau nol. Penyelesaian perhitungan development dengan asumsi owner ini terpisah dari **spesifikasi riil utama issue #9**, yang tetap memerlukan data dan harga riil yang diterima.

Ini perkembangan atas audit v1 yang tersimpan di [arsip historis](history/v1/README.md). **ID perusahaan fiktif resmi G0.5 v3 sudah diterima untuk development:** seluruh 33.049 observasi memiliki `psid`, membentuk 10.395 perusahaan fiktif. Tidak ada duplikat perusahaan–tahun. Ketiadaan linkage perusahaan nyata berlaku pada finalisasi actual, bukan alasan menghentikan cabang development ini.

## Appendix teknis

[Appendix PDF](publication/G1-Appendix.pdf) menjelaskan setiap metode beserta sumber variabel, tahun, missingness, rumus, sampel, tabel koefisien dan standard error, distribusi serta sensitivitas. [Dua belas berkas agregat diagnostik](deep-release/outputs/) merangkum koefisien dan hasil yang sama. Setiap prediksi dibedakan dari observasi yang benar-benar masuk tahap estimasi dinamis; tidak ada estimasi terpisah per tahun yang diklaim. Acuan normalisasi adalah rata-rata residual pada seluruh observasi estimasi dalam sektor×metode×sampel, tetap sama di semua tahun.

{annual}

[Validasi diagnostik](deep-release/qa/deep-validation.json) mencatat status **{deep['status']}** dan cakupan pemeriksaan yang benar-benar dijalankan. Tabel regresi memakai standard error bootstrap seluruh proses; interval persentil 95 persen hanya ditampilkan ketika jumlah draw berhasil memenuhi ambang yang telah ditetapkan.

## Input, kalender dan cakupan

Run `{manifest['run_id']}` memakai `g05-external-excel-panel-v3`, SHA256 manifest `{manifest['input']['input_sha256']}`. Adapter bersama memeriksa bagian data dan metadata sebelum ekspor. Kode, sumber, log, tabel, gambar dan intermediate mempunyai hash dalam [run manifest](release/run-manifest.json). Dataset asli dan G0 tidak diubah. Tidak ada data aktual lama atau fixture metode yang menjadi input hasil ini.

![Seluruh wave](release/figures/coverage_by_year.svg)

Ada 12 wave pada 2010–2015 dan 2017–2022. Seluruh 33.049 catatan merupakan denominator audit sumber, bukan ukuran populasi manufaktur nasional. Pemeriksaan kalender menemukan 20.579 pasangan t−1 dan 15.991 pasangan t−2. Sambungan 2015→2017 tetap berjarak dua tahun; tidak ada observasi atau lag 2016 yang dibuat. Matching fiktif mempertahankan provinsi × sektor sesuai generator. Kode sektor yang digunakan dalam estimasi merupakan awalan dua digit yang dilaporkan; padanan antarversi klasifikasi belum menjadi klaim terverifikasi.

Audit marginal menghasilkan {audit['domain_cells']} sel variabel×tahun dan {audit['funnel_cells']:,} sel alur metode×tahun×kelompok×tahap. Positif, nol, negatif dan missing dipisahkan serta direkonsiliasi ke denominator. Flag konsep stok modal tidak otomatis mengesahkan unit pemasok atau harga.

![Domain sumber](release/figures/input_domains.svg)

## Spesifikasi yang benar-benar dijalankan

Cabang terdaftar [{spec['specification_id']}](nominal-specification.json) memakai persamaan `y_it = β_L l_it + β_K k_it + ω_it + ε_it`. Outcome adalah log nilai tambah nominal positif; labor adalah log pekerja positif. Sesuai instruksi owner, kita **mengasumsikan stok modal yang dilaporkan merupakan stok akhir tahun pada seluruh tahun sumber**. Modal awal tahun t memakai stok positif pada akhir kalender t−1 di perusahaan fiktif yang sama. Flag dokumentasi asli dipertahankan sebagai bukti sumber, tanpa menjadi penghalang baru pada asumsi yang telah disetujui.

Kandidat tahun produksi adalah 2011–2015 dan 2018–2022. Estimasi dinamis memerlukan observasi produksi pada t dan t−1, sehingga kandidat akhir transisi adalah 2012–2015 dan 2019–2022. Tidak ada tahun 2009 atau 2016 yang dibuat. Kita mengestimasi koefisien dan fungsi kontrol yang konstan dalam sektor dengan semua transisi yang didukung; tidak ada efek tetap tahun tambahan. Harga nominal dan perubahan komposisi masih dapat memengaruhi perbandingan tahunan.

OP memakai tambahan modal positif sebagai **kandidat investasi yang diasumsikan secara terpisah**, bukan selisih dua stok. LP, ACF dan Wooldridge memakai `val_rtlvcu` positif sebagai kandidat bahan baku. Total pengeluaran tidak otomatis menggantikan bahan baku. Log tidak dihitung atas nol/negatif; nilai kosong tidak diisi. Sampel own memakai domain setiap metode; common memakai irisan domain keempat metode sebelum operator lag. Wrapper membentuk lag kalender tepat sekali.

**Tidak ada deflasi dalam cabang ini.** Konsistensi satuan positif per variabel dalam cell teknologi adalah konvensi development yang dipertahankan. Pergeseran satuan konstan tercermin pada level/intercept; salah satuan yang berubah antarperusahaan atau tahun tetap menjadi risiko. Residual memuat harga, error pengukuran dan gangguan sementara, sehingga tidak disebut ukuran efisiensi teknis riil yang terverifikasi. Label nominal menyertai tabel dan kolom hasil.

Median setiap log input/outcome dibekukan dalam domain cell untuk membantu kondisi numerik. Polinomial lengkap mempertahankan span saat koordinat digeser. Setelah estimasi, residual dihitung kembali dari log input asli; centering numerik tidak mengubah definisi residual.

## Empat metode dan aturan fit

- **OP:** first stage partially linear memakai modal/investasi; second stage memproyeksikan produktivitas dan seleksi. Risk interval fiktif dibuat untuk setiap perusahaan pada pasangan tahun sumber yang berurutan, termasuk assignment yang tidak tersambung; tidak ada interval melintasi 2016 atau setelah 2022. Hilangnya assignment adalah outcome simulasi, bukan bukti perusahaan nyata tutup. Universe risiko dipertahankan sebelum filter produksi; tidak ada fallback OP tanpa koreksi seleksi.
- **LP:** first stage partially linear memakai proxy bahan baku. Second stage nonlinear least squares memakai hukum produktivitas cubic sesuai implementasi yang dipatok. Output LP tidak dilabeli ulang sebagai ACF.
- **ACF:** first stage polinomial lengkap labor/modal/proxy; koefisien labor dan modal ditentukan melalui inovasi produktivitas dan moment dengan instrumen lag labor serta modal kini menurut kontrak timing. Rank instrumen dan Jacobian moment diperiksa terpisah.
- **Wooldridge:** dua persamaan diestimasi bersama melalui GMM. Implementasi memakai satu vektor koefisien fungsi proxy pada persamaan kini dan lag, dengan konstanta berbeda. Ini spesialisasi random walk dengan drift yang membatasi persistensi menjadi satu dalam pendekatan proxy, sebagaimana dijelaskan dalam kuliah penulis; bukan transisi produktivitas umum yang tidak dibatasi.

[Audit metode](METHOD-AUDIT.md), [kontrak persamaan](registries/method-contracts.md) dan [mode pengukuran/seleksi](stata/methods/MEASUREMENT-MODES.md) memberi rincian sumber. Referensi primer: [Olley–Pakes](https://www.nber.org/papers/w3977), [Levinsohn–Petrin](https://www.nber.org/papers/w7819), [ACF](https://www.econometricsociety.org/publications/econometrica/2015/11/01/identification-properties-recent-production-function-estimators), [Wooldridge](https://doi.org/10.1016/j.econlet.2009.04.026), dan [implementasi Stata Journal](https://www.stata-journal.com/article.html?article=st0537).

Primary memakai polinomial derajat 3 dan start OLS. Start labor rendah/tinggi dan polinomial derajat 2 merupakan tiga sensitivitas tetap; sensitivitas sukses tidak menggantikan primary gagal. OLS hanya titik awal numerik. Koefisien negatif atau jumlah elastisitas yang tidak nyaman tidak dipotong. Objective antarjenis estimator memiliki definisi berbeda sehingga tidak diurutkan seolah satu ukuran kecocokan.

## Dukungan sampel dan OP

![Dukungan nominal](publication/figures/sample_support.svg)

Setiap cell memerlukan minimal 100 observasi domain first stage, 50 transisi dan 50 perusahaan dinamis. OP tambahan memerlukan 100 observasi seleksi, 10 assignment yang hilang dan 10 yang berlanjut. Ambang dibekukan sebelum melihat koefisien. Seluruh 24 sektor sumber × empat metode × own/common × empat varian dicatat, termasuk skip. Tabel tidak menghapus sektor yang gagal.

Ledger berikut menunjukkan hasil nyata setiap metode dan sampel, termasuk alasan dukungan atau kegagalan optimizer. Maksimum universe seleksi OP per sektor adalah **{int(op.N_selection.max())}** observasi; maksimum disappearance yang teramati pada universe tersebut adalah **{int(op.N_disappearance.max())}**. Jumlah ini berasal dari seluruh interval kalender yang tersedia, bukan hanya satu tahun.

{failures}

Hasil own dan common dipertahankan terpisah. Filter positif LP/ACF/Wooldridge sama, tetapi persamaan dan asumsi metodenya berbeda. Kita tidak menggabungkan sektor atau menurunkan ambang setelah melihat hasil.

## Koefisien dan ketidakpastian

{ftable}
![Koefisien dan interval](publication/figures/coefficients.svg)

Koefisien pada tabel merupakan hasil spesifikasi utama yang telah ditetapkan. Koefisien negatif dan jumlah elastisitas yang jauh dari satu tetap dipertahankan; convergence dan rank numerik tidak membuktikan asumsi proxy, timing, harga atau teknologi benar. Bab metode dan tabel sensitivitas menjelaskan perbedaan yang didukung hasil ini.

Bootstrap mengambil ulang seluruh perusahaan fiktif sebagai klaster, memberi ID baru pada klaster duplikat, lalu mengulang first stage, transisi, instrumen dan fit. Perhitungan ulang OP menyertakan universe risiko yang diperlukan oleh persamaan seleksinya. Ada 99 draw per model primary; point estimate tidak dihitung sebagai draw. Kovarians memakai pembagi `B_success−1`; interval persentil 95% hanya diterima untuk eksplorasi jika sedikitnya 95 dari 99 draw berhasil. Jumlah model yang memenuhi ambang interval adalah {int(boot.interval_admitted.sum())} dari {len(boot)}. Setiap kegagalan tetap masuk denominator draw yang diminta.

Lebar interval dan variasi koefisien antar-start harus dibaca dari hasil setiap sektor. Keberhasilan numerik sendiri tidak membuat interval presisi atau membuktikan optimum global. Inference ini bersyarat pada satu assignment fiktif dan konvensi nominal; ketidakpastian generator tidak di-bootstrap. **99 draw eksploratif tidak memenuhi kewajiban 999 draw untuk spesifikasi riil utama.** Seluruh draw, return code, koefisien, objective dan N tersedia pada [tabel bootstrap](release/outputs/bootstrap_draws/).

## Residual dan perbandingan

Residual sebelum dipusatkan adalah `r_it = ln(VA_nominal_it) − β_L ln(L_it) − β_K ln(K_begin_it)`. Versi centered mengurangi rata-rata residual pada seluruh sampel fit dinamis **sektor×metode×sampel**. Centering ini menormalkan level, bukan mengubah ranking dalam cell. Residual tidak disamakan dengan latent omega atau dengan ukuran kuantitas TFP riil.

![Distribusi](publication/figures/distribution.svg)

Histogram memakai bin 0,5 log poin dan mempertahankan seluruh ekor. Tabel kuantil membedakan raw/centered dan own/common, termasuk baris N=0 untuk keluaran tidak tersedia. Denominator histogram ini adalah observasi yang masuk estimasi dinamis, bukan seluruh prediksi yang lebih luas maupun seluruh 33.049 input. Prediksi di luar fit dianalisis secara terpisah pada tabel tahunan appendix.

Sampel bersama membatasi input sebelum mengambil lag dan mengestimasi ulang setiap metode. Karena itu, jumlah observasi dinamis yang sama tidak selalu berarti first stage atau koefisien sama dengan sampel masing-masing metode. Grafik berikut menunjukkan distribusi residual dari keempat estimasi sampel bersama pada catatan yang sama.

![Distribusi sampel bersama](publication/figures/deep_common_distribution.svg)

{pairtable}

LP dan Wooldridge memberikan peringkat yang hampir sama pada {int(lpw.N_compared):,} observasi bersama: korelasi Spearman {lpw.rho_spearman:.3f}. Korelasi LP–ACF adalah {lpa.rho_spearman:.3f}. Ini membandingkan urutan catatan, bukan membuktikan bahwa koefisien input, level residual atau produktivitas fisik sama. Pasangan yang melibatkan OP memakai irisan lebih kecil, yang tetap terlihat pada tabel.

![Rank](publication/figures/rank_comparison.svg)

Perbandingan pairwise memakai catatan asli yang sama untuk setiap pasangan; irisan empat metode dicatat sebagai scope terpisah dengan jumlah yang tersedia pada run ini. Korelasi pada N=0 tetap missing. CSV scatter berisi rata-rata bin peringkat dengan minimal lima catatan per bin; bin kecil tidak diterbitkan sebagai titik perusahaan. Jumlah catatan yang terwakili direkonsiliasi dengan tabel pairwise.

## Sambungan master dan bukti kualitas

`analysis/G1_main_with_tfp.dta` di direktori run eksternal menyimpan seluruh **{master['source_columns']:,} kolom input dan {master['rows']:,} observasi**, ditambah kolom `dev_nominal_tfp_*`, centered, common, eligibility/prediction serta ID spesifikasi/normalisasi. Semua prediksi domain primary pada seluruh tahun yang didukung masuk kolom utama, disertai penanda terpisah apakah observasi masuk fit dinamis. Semua sensitivitas tetap ada pada sidecar panjang terpisah. Prediksi yang tidak tersedia tetap missing beserta alasan dukungan atau kegagalan; tidak diganti nol.

Pemeriksaan independen membandingkan **{master['source_cells_compared_exactly']:,} nilai sumber persis** dan urutan asli setelah merge. `obs_id`/tahun dipakai untuk attachment satu-ke-satu; `psid`/tahun dipakai untuk estimasi. Tidak ada interval risiko buatan yang ditambahkan ke master sumber. File perusahaan tetap lokal; repository memuat agregat, kode dan receipt.

Satu primary Stata menyediakan 19 tahap audit, tujuh tahap estimasi nominal, dan enam tahap diagnostik tambahan melalui mode diagnostics. [DAG](dag/G1.svg) mengikat node triage/decision, grain, kunci, unit, denominator dan keluaran. [24 keluarga exhibit](registries/exhibits.csv) tetap direkonsiliasi satu per satu. Dedicated Luna/max memasukkan komentar bahasa Indonesia; diff dan snapshot membuktikan bagian executable tetap sama. Uji metode empat cabang memakai fixture independen, sedangkan laporan ini hanya memakai hasil G0.5. [Quality review](quality-review.md) membandingkan kedalaman, angka, komentar, chart dan reproduksi dengan G0 secara konkret.

## Harga, pekerjaan tersisa dan finalisasi

Audit menemukan harga BPS yang dapat mendukung **pendekatan riil kasar development terpisah** pada 2010–2012: indeks output manufaktur, bahan baku end-use dan barang modal, base 2005=100. [Audit ekonomi v3](qa/v3-economic-prerequisites.md) mencatat 12 sel harga dan bukti visual enam halaman sumber. Penyiapan nonland memakai seluruh komponen raw yang konsisten; tidak mengurangi raw tanah dari total modal yang sudah dijitter.

Pendekatan itu tetap mempunyai keterbatasan deflasi VA dengan indeks output dan harga barang modal yang luas untuk aset heterogen. Audit dukungan awal menemukan tidak ada observasi investasi nonland positif tambahan di luar investasi canonical positif; temuan ini hanya menjelaskan audit persiapan 2010–2012 tersebut dan tidak menggantikan hasil OP semua tahun pada run sekarang. Spesifikasi dan preparation disimpan, tetapi tidak diklaim sebagai fit riil pada laporan ini.

Spesifikasi riil utama masih memerlukan definisi/unit dan harga yang diterima, padanan teknologi, dukungan investasi dan seleksi pada input riil, mask G2 dengan hash yang sama, serta inference yang dipersyaratkan. Hasil empat metode dan sampel bersama pada cabang development sekarang tersedia; hasil itu tidak menggantikan bukti yang harus dibangun ulang pada data riil. Finalisasi actual tetap belum diterima. Finalisasi harus memilih input actual lokal dengan linkage nyata dan menjalankan ulang kode serta keluaran terkait. Mengganti label hasil development tidak memenuhi syarat tersebut.
'''
    (HERE/'report.md').write_text(report)
    import markdown
    body=markdown.markdown(report,extensions=['tables','fenced_code'])
    (HERE/'report.html').write_text('<!doctype html><html lang="id"><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>G1 — G0.5 DEVELOPMENT</title><style>body{font:17px/1.65 system-ui,sans-serif;color:#163047;max-width:1120px;margin:40px auto;padding:0 24px}h1,h2{line-height:1.22}h2{margin-top:48px}img{width:100%;height:auto}table{border-collapse:collapse;width:100%;font-size:15px}th,td{padding:9px;border-bottom:1px solid #dbe4ed;text-align:left}a{color:#006a86}code{font-size:.88em}pre{white-space:pre-wrap}</style><main>'+body+'</main></html>')
    print('Generated G0.5 v3 result report from released Stata outputs')


if __name__=='__main__': main()
