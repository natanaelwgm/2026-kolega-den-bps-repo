"""Build source-bound, non-executable Indonesian comments for review."""
from pathlib import Path
import collections
import csv
import hashlib
import json
import re


HERE = Path(__file__).resolve().parent
LOG_ROOT = HERE.parent
SOURCE_ROOT = LOG_ROOT.parent / "G0-wave-foundation-v2"
ORIGINAL_ROOT = SOURCE_ROOT / "provenance/logging-originals"


def sha256(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def source_file(relative_path):
    archived = ORIGINAL_ROOT / relative_path
    return archived if archived.exists() else SOURCE_ROOT / relative_path


source_paths = json.loads((LOG_ROOT / "source-paths.json").read_text())
dag = json.loads((SOURCE_ROOT / "registry/dag-complete.json").read_text())
nodes = {node["id"]: node for node in dag["nodes"]}
edges_by_path = collections.defaultdict(list)
for edge in dag["edges"]:
    edges_by_path[edge["path"]].append(edge)

operands = json.loads((SOURCE_ROOT / "registry/leaf-operands.json").read_text())
leaf_by_path = {}
for family in ("mapped", "working"):
    for operand in operands[family]:
        for role in ("launcher", "method"):
            leaf_by_path[operand[role]] = (family, role, operand)

DERIVATIVE_REGISTRY = SOURCE_ROOT / "correction-planning/registries/derivative_annual_semantics.csv"
derivative_by_id_year = collections.defaultdict(dict)
with DERIVATIVE_REGISTRY.open(newline="") as registry_file:
    for row in csv.DictReader(registry_file):
        derivative_by_id_year[row["derivative_id"]][row["source_year"]] = row


def unique(values):
    return list(dict.fromkeys(values))


def compact(paths):
    paths = unique(paths)
    if len(paths) <= 2:
        return "; ".join(paths)
    return "; ".join(paths[:2]) + f"; dan {len(paths) - 2} masukan lain"


def method_text(operand):
    path = source_file(operand["method"])
    return path.read_text() if path.exists() else ""


def raw_fields(operand, text):
    declared = operand.get("raw_fields") or []
    found = re.findall(r"\b(raw_[A-Za-z0-9_]+)\b", text)
    return unique(declared or found)


def mapped_status_summary(text, variable):
    status = f"vs_{variable}"
    default = re.search(rf"^\s*generate\s+byte\s+{re.escape(status)}=(\d+)", text, re.M)
    parts = []
    if default:
        parts.append(f"{default.group(1)} untuk nilai kosong/penanda yang dibiarkan kosong")
    invalid = re.search(rf"^\s*replace\s+{re.escape(status)}=(\d+)\s+if\s+missing\(real\(", text, re.M)
    if invalid:
        parts.append(f"{invalid.group(1)} untuk teks yang tidak dapat dibaca sebagai angka")
    sign = re.search(
        rf"^\s*replace\s+{re.escape(status)}=cond\({re.escape(variable)}<0,(\d+),cond\({re.escape(variable)}==0,(\d+),(\d+)\)\)",
        text,
        re.M,
    )
    if sign:
        negative, zero, other = sign.groups()
        parts.append(f"{negative} untuk angka negatif, {zero} untuk nol, dan {other} untuk angka lain yang terbaca")
    return f"{status} mencatat " + "; ".join(parts) + "." if parts else f"{status} tetap mengikuti kode status di metode."


def division_rule(text):
    """Return the first literal per-worker formula and its actual guard."""
    match = re.search(
        r"^\s*replace\s+(\w+)\s*=\s*([\w]+)\s*/\s*workers\s+if\s+([^\n]+)",
        text,
        re.M,
    )
    if not match:
        return None
    output, numerator, condition = match.groups()
    return output, numerator, condition.strip()


def derivative_id(path):
    match = re.search(r"\b(CR\d{3})_(?:per_worker|log)\.do$", path)
    return match.group(1) if match else None


def derivative_rule_text(row):
    domain = row["approved_arithmetic_domain"]
    if domain == "finite_signed_over_positive_finite_workers":
        return "pembilang boleh negatif atau nol, tetapi jumlah pekerja harus positif"
    if domain == "finite_nonnegative_over_positive_finite_workers":
        return "pembilang harus nol atau lebih dan jumlah pekerja harus positif"
    if domain == "positive_finite":
        return "input harus berupa angka positif"
    return "registry belum menerima domain hitung untuk turunan ini"


def derivative_release_text(row):
    status = row["release_status"]
    if status == "legacy_candidate_display_only":
        return "Daftar aturan hanya mengizinkan angka ini ditampilkan sebagai kandidat lama; perhitungan belum memastikan arti atau satuannya."
    if status == "unavailable_source_gate":
        if row["source_kind"] == "ambiguous":
            return f"Daftar aturan menandai {row['source_variable']} ambigu; arti atau satuannya belum diterima."
        return "Daftar aturan belum menerima sumber dan domain untuk menghitung variabel ini."
    if status == "retired_nonquantity":
        return "Daftar aturan menandai sumber sebagai kategori, bukan besaran hitung; variabel hasil ini dihentikan."
    return f"Status registri untuk tahun ini: {status}."


def derivative_formulas(text, transform):
    patterns = {
        "per_worker": re.compile(r"^\s*replace\s+(\w+)\s*=\s*(\w+)\s*/\s*workers\s+if\s+([^\n]+)", re.M),
        "log": re.compile(r"^\s*replace\s+(\w+)\s*=\s*ln\((\w+)\)\s+if\s+([^\n]+)", re.M),
    }
    result = {}
    for number, line in enumerate(text.splitlines(), 1):
        match = patterns[transform].match(line)
        if not match:
            continue
        year = re.search(r"source_year\s*==\s*(\d{4})", match.group(3))
        if year:
            result[year.group(1)] = (number, *match.groups())
    return result


def correction_state_variable(text):
    for name in re.findall(r"^\s*generate\s+byte\s+(\w+)\s*=", text, re.M):
        if "state" in name or "status" in name:
            return name
    return None


def registry_correction_purpose(path, text):
    correction = derivative_id(path)
    records = derivative_by_id_year.get(correction or "")
    if not records:
        return None

    first = next(iter(records.values()))
    transform = first["transform"]
    formula_by_year = derivative_formulas(text, transform)
    calculated_years = sorted(formula_by_year)
    held_years = sorted(set(records) - set(calculated_years))
    output = first["repaired_field"]
    source = first["source_variable"]

    if formula_by_year:
        formula_year = calculated_years[0]
        row = records[formula_year]
        _, actual_output, numerator, _condition = formula_by_year[formula_year]
        if transform == "per_worker":
            purpose = (
                f"Hitung {actual_output} sebagai {numerator} per pekerja (dibagi workers) untuk tahun yang memiliki baris perintah; "
                f"syaratnya {derivative_rule_text(row)}. Nilai di luar syarat tetap kosong. "
            )
        else:
            purpose = (
                f"Hitung {actual_output} = ln({numerator}) hanya untuk input positif dan terisi pada tahun "
                "yang memiliki baris perintah; input nol, negatif, atau kosong tidak menghasilkan angka. "
            )

        release_kinds = {records[y]["release_status"] for y in calculated_years}
        if release_kinds == {"legacy_candidate_display_only"}:
            purpose += derivative_release_text(row) + " "
        elif len(release_kinds) > 1:
            purpose += "Penerimaan sumber berubah menurut tahun; catatan per tahun ada di bawah. "

        if held_years:
            state_name = correction_state_variable(text)
            held_states = collections.defaultdict(list)
            for year in held_years:
                match = re.search(
                    rf"^\s*replace\s+{re.escape(state_name or '')}=(\d+)\s+if\s+source_year=={year}\b",
                    text,
                    re.M,
                )
                held_states[match.group(1) if match else "?"].append(year)
            held_summary = "; ".join(
                f"status {state}: {', '.join(years)}" for state, years in held_states.items()
            )
            purpose += (
                f"Tahun {', '.join(held_years)} tidak punya baris hitung; {output} tetap kosong "
                f"dan file memberi {held_summary}."
            )
        return purpose.strip()

    row = records.get("2010", first)
    state_name = correction_state_variable(text) or row["state_field"]
    state_values = sorted(set(re.findall(
        rf"^\s*replace\s+{re.escape(state_name)}=(\d+)\s+if\s+source_year==\d{{4}}",
        text,
        re.M,
    )))
    state_text = ", ".join(f"{state_name}={value}" for value in state_values) or state_name
    if row["release_status"] == "retired_nonquantity":
        transform_name = "nilai per pekerja" if transform == "per_worker" else "log natural"
        return (
            f"Tidak membuat {transform_name} dari {source}: daftar aturan menyebut sumber ini kategori, "
            f"bukan besaran yang boleh diturunkan. {output} tetap kosong di Stata (missing) dan file memberi kode status {state_text}; "
            "jangan baca nilai kosong sebagai nol."
        )
    transform_name = "nilai per pekerja" if transform == "per_worker" else "log natural"
    return (
        f"Tidak membuat {transform_name} dari {source}: {derivative_release_text(row)} "
        f"{output} tetap kosong di Stata (missing) dan file menetapkan kode status {state_text} untuk tiap tahun. "
        "Nilai kosong bukan angka nol."
    )


def correction_purpose(path, text):
    registry_purpose = registry_correction_purpose(path, text)
    if registry_purpose:
        return registry_purpose

    stem = Path(path).stem
    named_purposes = {
        "C010_bind_baseline": "Tetapkan baseline koreksi dari master lokal: periksa kunci tahun/baris, 33.049 baris, larangan tahun 2016, dan bahwa ID perusahaan nyata maupun dummy tidak digunakan; simpan kolom yang dipilih untuk langkah koreksi.",
        "C020_va_domain": "Pisahkan nilai tambah yang teramati (positif, nol, atau negatif) dari nilai kosong/status; nilai bertanda tidak otomatis dibuang.",
        "C030_keep_signed_va": "Teruskan nilai tambah asli hanya untuk baris yang lolos status C020; pemeriksaan memastikan angka terpilih sama dengan sumber.",
        "C040_va_per_worker": "Hitung nilai tambah per pekerja; pembilang bertanda boleh negatif, tetapi jumlah pekerja harus positif dan kedua angka harus tersedia.",
        "C041_va_log": "Hitung log natural nilai tambah hanya saat nilainya positif; nol, negatif, dan missing tetap tanpa hasil log.",
        "C050_signed_tail_threshold": "Untuk tiap tahun, hitung persentil ke-99 dari nilai absolut nilai tambah sebagai ambang uji sensitivitas.",
        "C060_signed_tail_companion": "Tandai nilai tambah yang absolutnya lebih dari 10 kali ambang tahun tersebut; salinan sensitivitas hanya menyimpan nilai yang tidak masuk ekor itu.",
        "C061_energy_cost_subtotal": "Jumlahkan komponen biaya bahan bakar dan listrik yang status sumbernya 0/1 serta nilainya tidak negatif; simpan banyak komponen yang tersedia dan apakah lengkap.",
        "C071_ratio_domain": "Tentukan baris yang layak untuk porsi nilai tambah/output: nilai tambah harus ada dan output harus ada serta positif.",
        "C072_ratio_domain": "Tentukan baris yang layak untuk biaya energi/output: biaya harus ada dan tidak negatif; output harus ada dan positif.",
        "C073_ratio_domain": "Tentukan baris yang layak untuk energi/output: energi harus ada dan tidak negatif; output harus ada dan positif.",
        "C074_ratio_domain": "Tentukan baris yang layak untuk emisi/output: emisi harus ada dan tidak negatif; output harus ada dan positif.",
        "C081_recompute_ratio": "Hitung ulang nilai tambah/output untuk baris yang lolos C071, sambil menyimpan rasio lama dan tanda perubahan.",
        "C082_recompute_ratio": "Hitung ulang biaya energi/output untuk baris yang lolos C072, sambil menyimpan rasio lama dan tanda perubahan.",
        "C083_recompute_ratio": "Hitung ulang energi/output untuk baris yang lolos C073, sambil menyimpan rasio lama dan tanda perubahan.",
        "C084_recompute_ratio": "Hitung ulang emisi/output untuk baris yang lolos C074, sambil menyimpan rasio lama dan tanda perubahan.",
        "C090_own_generation_domain": "Tandai laporan own-generation yang dapat dinilai hanya jika status sumbernya 0/1 dan kWh ada serta tidak negatif; flag positif hanya berlaku untuk nilai di atas nol.",
        "C100_own_generation_delta": "Bandingkan flag own-generation lama dengan indikator nilai kWh positif; simpan apakah indikator tidak diketahui dan apakah hasilnya berbeda.",
        "C110_quantity_flag_states": "Satukan hasil pemeriksaan tanda untuk kuantitas yang diuji ke satu baris per kunci tahun/baris.",
        "C120_flag_logic": "Hitung pemeriksaan yang berlaku, teramati, tidak diketahui, dan negatif; gunakan hitungan itu untuk membentuk keputusan ringkas.",
        "C130_price_flag_scope": "Pertahankan flag ekor harga lama, tetapi biarkan banyak observasi yang dinilai kosong karena penyebut belum diketahui.",
        "C140_assemble_companions": "Gabungkan data baseline dengan kolom domain, turunan, status, dan audit menurut kunci tahun/baris; batasi kolom tambahan yang disimpan.",
        "C150_change_audit": "Bandingkan nilai baseline dengan kolom koreksi dan ringkas perubahan, missing, serta status per variabel/tahun.",
        "C160_publication_summaries": "Bentuk statistik ringkas per tahun dan variabel—jumlah baris, terisi/kosong, nol, negatif, rerata, simpangan baku, rentang, dan persentil—bersama status rilisnya.",
        "C170_flag_rates": "Hitung ya, tidak, dan unknown per tahun; bagian positif memakai penyebut ya+tidak, sedangkan bagian unknown memakai semua baris.",
        "C180_export_roundtrip": "Uji ekspor-impor CSV dengan memeriksa jumlah baris/kolom dan membandingkan kembali semua nilai sebelum memulihkan data awal.",
        "G0_known_answer_fixtures": "Periksa dengan angka contoh yang diketahui bahwa pembagian bertanda/nonnegatif hanya berjalan pada domain yang benar dan nilai tanpa penyebut layak tetap missing.",
    }
    if stem in named_purposes:
        return named_purposes[stem]
    if stem.startswith("CQ") and stem.endswith("_quantity_sign"):
        source = re.search(r"^\s*use\s+source_year\s+source_row\s+(\w+)\s+(\w+)", text, re.M)
        field = source.group(1) if source else "kuantitas"
        return f"Untuk {field}, teruskan status sumber dan tetapkan apakah pemeriksaan berlaku per tahun; nilai negatif dicatat terpisah dari nilai kosong."
    if stem.startswith("CT") and stem.endswith("_recompute_total"):
        if stem == "CT001_recompute_total":
            return "Jumlahkan komponen bahan bakar GJ yang ada dan tidak negatif; simpan berapa komponen yang tersedia agar total parsial dapat dibedakan dari total lengkap."
        if stem == "CT002_recompute_total":
            return "Jumlahkan pembelian listrik PLN dan non-PLN hanya dari komponen yang terisi serta tidak negatif; simpan banyak komponen yang membentuk total."
        if stem == "CT003_recompute_total":
            return "Ubah total pembelian listrik kWh menjadi GJ dengan faktor 0,0036; hasil hanya dibuat bila komponen listrik tersedia."
        if stem == "CT004_recompute_total":
            return "Jumlahkan komponen emisi bahan bakar yang tersedia dan tidak negatif untuk membentuk total cakupan 1; jumlah komponen tetap dicatat."
        if stem == "CT005_recompute_total":
            return "Hitung emisi cakupan 2 sebagai kWh listrik yang dibeli dikali faktor jaringan; kedua komponen harus ada dan tidak negatif."
        if stem == "CT006_recompute_total":
            return "Jumlahkan total GJ bahan bakar dan listrik hanya jika kedua subtotal ada; bila salah satu belum ada, total gabungan dibuat missing."
        if stem == "CT007_recompute_total":
            return "Jumlahkan emisi cakupan 1 dan 2 hanya jika kedua subtotal tersedia; bila salah satu belum ada, total gabungan dibuat missing."

    rule = division_rule(text)
    if rule:
        output, numerator, condition = rule
        guards = []
        if re.search(r"\bworkers\s*>\s*0\b", condition):
            guards.append("jumlah pekerja lebih dari 0")
        if re.search(rf"!missing\([^)]*\b{re.escape(numerator)}\b", condition):
            guards.append(f"{numerator} tidak kosong")
        if re.search(rf"\b{re.escape(numerator)}\s*>=\s*0\b", condition):
            guards.append(f"{numerator} tidak negatif")
        guard_text = " dan ".join(guards) or f"syarat `{condition}` terpenuhi"
        return (
            f"Hitung {output} sebagai {numerator} dibagi workers hanya bila {guard_text}; "
            "kolom state tetap mencatat aturan hasil yang tertulis di kode."
        )

    generated = re.findall(r"^\s*generate\s+(?:double|byte|long|int)\s+(\w+)=", text, re.M)
    state_vars = [name for name in generated if name.endswith("_state") or name.endswith("_status")]
    outputs = [name for name in generated if name not in state_vars]
    if outputs:
        states = f" dan {', '.join(state_vars)}" if state_vars else ""
        return f"Siapkan {', '.join(outputs)}{states}; nilai dan status diisi menurut kondisi koreksi yang tampak pada baris berikut."
    return "Jalankan koreksi yang tertulis di berkas ini; setiap perubahan dibatasi oleh kondisi pada barisnya."


def purpose(path, text, operand_info=None):
    if operand_info:
        family, role, operand = operand_info
        variable = operand["variable"]
        year = operand["year"]
        if role == "method":
            method = text
        else:
            method = method_text(operand)

        if family == "mapped":
            fields = raw_fields(operand, method)
            status = f"vs_{variable}"
            if not fields:
                code = re.search(rf"^\s*generate\s+byte\s+{re.escape(status)}=(\d+)", method, re.M)
                code_text = f"dengan status {code.group(1)}" if code else "dengan status sumber-absen"
                return (
                    f"Untuk {year}, kolom sumber {variable} tidak tersedia pada metode tahun ini; "
                    f"nilai dibiarkan kosong {code_text}."
                )
            if variable == "rd_indicator_raw":
                if year == 2017 and "raw_rnd17" in fields:
                    return (
                        "Ambil jawaban pertanyaan R&D dari raw_rnd17; kode 1/2 adalah jawaban survei, "
                        "bukan uang. Nilai biaya R&D disimpan terpisah di val_costrd. "
                        + mapped_status_summary(method, variable)
                    )
                return (
                    f"Untuk {year}, ambil jawaban pertanyaan R&D dari {', '.join(fields)}; "
                    "ini kolom jawaban, bukan kolom biaya. " + mapped_status_summary(method, variable)
                )
            return (
                f"Untuk {year}, ubah {', '.join(fields)} menjadi {variable}; "
                + mapped_status_summary(method, variable)
            )

        # Working values may copy an existing value or derive a fallback. Keep the
        # description tied to the actual assignment found in the method.
        assignment = re.search(rf"^\s*replace\s+{re.escape(variable)}=(.+?)\s+if\s+", method, re.M)
        source = "aturan sumber tahun ini"
        if assignment:
            source_vars = [
                name for name in re.findall(r"\b[A-Za-z_]\w*\b", assignment.group(1))
                if name not in {variable, "missing", "real", "upper", "strtrim", "cond", "inlist"}
            ]
            if source_vars:
                source = ", ".join(unique(source_vars))
        original = bool(re.search(rf"^\s*clonevar\s+v_{re.escape(variable)}={re.escape(variable)}\b", method, re.M))
        original_note = (
            f"v_{variable} menyimpan salinan nilai awal; "
            if original else f"v_{variable} adalah kolom pembanding yang dibuat terpisah; "
        )
        return (
            f"Untuk {year}, lengkapi {variable} dari {source} hanya saat nilainya kosong dan syarat kode terpenuhi; "
            f"{original_note}vs_{variable} menandai pengisian sesuai aturan yang ada."
        )

    year_match = re.search(r"(20\d{2})", path)
    year = year_match.group(1) if year_match else "tahun terkait"
    if "/merge_mapped_" in path:
        return (
            f"Gabungkan hasil pemetaan kolom tahun {year} ke baris data mentah memakai source_year dan source_row; "
            "wf_merge_guard memeriksa tahun, kunci unik, dan pasangan baris sebelum merge."
        )
    if "/merge_working_" in path:
        return (
            f"Tambahkan nilai kerja tahun {year} ke gelombang terverifikasi memakai source_year dan source_row; "
            "guard memastikan pasangan baris cocok sebelum berkas tahunan disimpan."
        )
    if path.startswith("code/annual/raw_"):
        return f"Ambil data sumber tahun {year}, cek tahun dan keunikan baris, lalu simpan salinan tahunan berkolom raw_*."
    if path.endswith("F090_append_ready.do"):
        return (
            "Satukan 12 file tahunan menjadi data utama G0_analysis_ready; kode memeriksa kunci unik, "
            "33.049 baris, dan 4.593 kolom sebelum menyimpan."
        )
    if path.endswith("F085_publish_waves.do"):
        return (
            "Bagi data koreksi C140 menjadi 12 file tahunan; tiap file hanya berisi satu source_year, "
            "memeriksa source_year/source_row, lalu disimpan."
        )
    if path.endswith("RD17-020.do"):
        return (
            "Ambil baris 2017 untuk proyeksi R&D: rd_indicator_raw menyimpan kode jawaban pertanyaan (1/2), "
            "bukan uang; val_costrd adalah kolom biaya yang terpisah."
        )
    if path.endswith("RD17-030.do"):
        return "Bentuk dan ekspor keputusan kelas R&D 2017 dari proyeksi wave yang sudah disiapkan."
    if path.endswith("RD17-060.do"):
        return "Susun tampilan keluaran keputusan R&D 2017 dengan kolom sumber, kelas, dan status yang tertulis di file."
    if "/corrections/" in path:
        return correction_purpose(path, text)
    if "/publication/" in path:
        publication_purposes = {
            "G0_X01_source_lineage.do": "Impor tabel jejak sumber dan salin ID/sha256 untuk keluaran lineage; ini metadata tentang berkas, bukan nilai analisis.",
            "G0_X02_annual_sample.do": "Hitung jumlah baris per tahun dari master analisis, tandai wave yang tersedia, dan pastikan tahun 2016 tidak ada.",
            "G0_X03_source_inventory.do": "Baca daftar berkas sumber, ubah ukuran byte menjadi angka, dan catat tahun serta metadata inventaris yang dapat dibaca.",
            "G0_X04_variable_year_acceptance.do": "Gabungkan cakupan lama per variabel/tahun dengan status penerimaan dan metadata aturan terbaru; status lama tetap dibedakan dari gerbang baru.",
            "G0_X05_annual_schema_mapping.do": "Impor peta nama sumber-ke-kanonik per tahun dan pastikan satu nama kanonik hanya muncul sekali per wave.",
            "G0_X06_source_state_counts.do": "Susun jumlah observasi menurut tahun, variabel, dan kode status sumber; labelnya menyatakan bahwa masking tidak disimpulkan.",
            "G0_X07_reported_accounting_diagnostics.do": "Tampilkan statistik output, nilai tambah, dan input antara sebagai kandidat laporan; identitas akuntansi input antara tidak disahkan.",
            "G0_X08_worker_denominator_domains.do": "Hitung pekerja positif, nol, negatif, dan missing per tahun agar pembagi yang layak dapat dibedakan dari yang tidak layak.",
            "G0_X09_capital_definition_coverage.do": "Bandingkan cakupan stok modal dengan penambahan modal; field capital_nominal campuran tidak diberi definisi stok.",
            "G0_X10_log_domain_losses.do": "Hitung nilai positif, nol, negatif, kosong, dan yang lolos gerbang untuk tiap log; hanya input positif dapat masuk log.",
            "G0_X11_outlier_sensitivity.do": "Bandingkan statistik nilai tambah bertanda dengan/ tanpa nilai di atas 10 kali ambang persentil ke-99 per tahun.",
            "G0_X12_export_definition_states.do": "Pisahkan jawaban ya, tidak, dan unknown untuk beberapa definisi ekspor; persentase memakai penyebut ya+tidak, dan definisi langsung tetap terpisah dari definisi any.",
            "G0_X13_rd_definition_states.do": "Pisahkan status jawaban R&D dari statistik uang; kode pertanyaan bukan biaya, dan kategori COSTRD tidak diperlakukan sebagai jumlah uang.",
            "G0_X14_identity_acceptance.do": "Pastikan mode identitas perusahaan tetap off, tautan ID nyata tidak diverifikasi, dan ID dummy/terpilih tetap kosong.",
            "G0_X15_classification_acceptance.do": "Impor tabel keputusan klasifikasi per tahun dan pastikan kolom numerik/unknown dapat dibaca sebelum diringkas.",
            "G0_X16_wpi_reference.do": "Rapikan nama kolom pada referensi WPI output—industri, indeks, tahun dasar, dan status sambungan—tanpa menerapkan deflator ke data perusahaan.",
            "G0_X17_company_price_gate.do": "Catat baris per tahun; tidak ada pencocokan harga perusahaan yang diterima dan jumlah yang belum dicoba sama dengan jumlah baris.",
            "G0_X18_nominal_real_gate.do": "Periksa bahwa belum ada deflator diterapkan dan nilai riil masih kosong; laporkan jumlah nominal, yang layak harga, dan nilai riil per tahun.",
            "G0_X19_fuel_unit_acceptance.do": "Impor keputusan unit bahan bakar per tahun dan normalisasi kolom angka; nama field/unit saja tidak membuktikan konversi yang diterima.",
            "G0_X20_energy_component_coverage.do": "Hitung kelengkapan komponen energi dan listrik; tandai jumlah komponen lengkap/parsial serta tes kuantitas yang belum teramati.",
            "G0_X21_electricity_and_own_generation.do": "Ringkas listrik PLN/non-PLN, total pembelian dan konversi GJ, terpisah dari indikator own-generation.",
            "G0_X22_grid_assumption_coverage.do": "Ringkas faktor jaringan dan jumlah kandidat emisi cakupan 2; tidak ada faktor baru yang diterima hanya dari adanya angka.",
            "G0_X23_energy_cost_reconciliation.do": "Bandingkan total biaya bahan bakar yang dilaporkan dengan komponen bahan bakar/listrik yang lolos status dan hitung lengkapnya.",
            "G0_X24_completion_gate.do": "Baca daftar syarat wajib penyelesaian dan ubah kolom keputusan menjadi angka sebelum menghasilkan status gerbang.",
            "G0_support_dictionary.do": "Buat kamus keluaran dari master dan registri rilis; kolom token pertanyaan R&D dikeluarkan dari kamus publik.",
        }
        return publication_purposes.get(Path(path).name, "Bentuk tabel publikasi dari input dan syarat yang disebut langsung di file ini.")
    if "/validation/" in path or "fixtures" in path:
        validation_purposes = {
            "compare_baseline.do": "Bandingkan keluaran baseline dengan master yang dipatok; perbedaan nilai atau kunci menghentikan validasi.",
            "compare_corrected.do": "Bandingkan nilai hasil koreksi dengan berkas keluaran yang diharapkan; pemeriksaan memakai kunci tahun/baris.",
            "compare_leaves.do": "Periksa bahwa tabel hasil tiap leaf cocok dengan keluaran gabungannya per variabel/tahun.",
            "compare_master.do": "Bandingkan master gabungan dengan snapshot pembanding untuk memastikan baris dan kolom sama.",
            "compare_current_wave.do": "Cocokkan klasifikasi token R&D per baris tahun 2017 dan tiga tabel ringkas dengan keluaran kandidat saat ini serta arsip historis. Laporan hanya membuktikan kesamaan keluaran; measurement_admitted tetap 0.",
            "compare_reports.do": "Cocokkan tabel laporan baru dengan keluaran yang dipatok dan hentikan proses jika ada perbedaan.",
            "merge_fixtures.do": "Gunakan contoh kunci cocok/tidak cocok untuk memastikan merge 1:1 menolak duplikasi atau pasangan hilang.",
            "G0_known_answer_fixtures.do": "Uji rumus pembagian dan aturan domain memakai angka contoh yang hasilnya diketahui.",
        }
        return validation_purposes.get(Path(path).name, "Jalankan pemeriksaan pembanding yang tertulis di file ini; kegagalan syarat menghentikan validasi.")
    if "/stages/" in path:
        stage_purposes = {
            "F010_raw.do": "Bentuk satu berkas raw per tahun dari sumber tahunan yang terdaftar, lalu cek kunci tahun/baris.",
            "F030_mapped.do": "Panggil 12 file merge pemetaan tahunan; tiap file mengubah kolom raw menjadi kolom kanonik dan menyimpan wave mapped.",
            "F040_append_intermediate.do": "Append wave mapped yang tersedia menjadi data intermediate gabungan dan memeriksa cakupan tahun/kunci.",
            "F050_compatibility.do": "Siapkan berkas kompatibilitas yang diperlukan oleh langkah kerja berikut dari data intermediate.",
            "F060_finish_working.do": "Lengkapi wave terverifikasi dengan kolom kerja yang disiapkan per variabel/tahun.",
            "F060_working.do": "Bentuk kolom kerja tahunan dari sumber yang terverifikasi, sambil mempertahankan nilai awal dan status pengisian.",
            "F070_baseline.do": "Pilih kolom dasar untuk koreksi dan simpan baseline; pemeriksaan menahan ID perusahaan nyata/dummy.",
            "F080_corrections.do": "Jalankan urutan koreksi, domain, dan ringkasan yang tercantum untuk membentuk pendamping analisis.",
            "F085_publish_waves.do": "Pisahkan master koreksi menjadi wave tahunan dengan kunci source_year/source_row yang tetap unik.",
            "F090_append_ready.do": "Append 12 wave koreksi menjadi G0_analysis_ready, lalu cek kunci, baris, dan kolom sebelum simpan.",
            "F090_reports.do": "Jalankan laporan publikasi dari master analisis setelah file wave siap.",
        }
        return stage_purposes.get(Path(path).name, "Jalankan urutan do-file dan pemeriksaan tahap ini.")
    if path == "code/merge_guard.do":
        return "Sebelum merge, periksa tahun yang diharapkan, keunikan kunci source_year/source_row, kolom tujuan, dan jumlah pasangan baris; kegagalan membuat merge berhenti."
    if path == "code/init.do":
        return "Atur lingkungan Stata, lokasi kerja, batas variabel, dan folder sementara yang dipakai oleh semua do-file tahap ini."
    if "/validation/" in path or "fixtures" in path:
        return "Jalankan pemeriksaan pada berkas contoh atau pembanding yang disebut di kode; file ini menguji aturan, bukan membentuk gelombang tahunan."
    if "/publication/" in path or "/reports/" in path:
        if "postfile" in text or "export delimited" in text or "rd17_export" in text:
            return "Hitung ringkasan yang didefinisikan di file ini dan tulis tabel keluaran pada nama/path yang tercantum di perintah ekspor."
        return "Bentuk tabel atau laporan dari kolom dan kondisi yang tercantum langsung di file ini."
    if path.startswith("rd2017/"):
        return "Jalankan langkah R&D 2017 yang ditunjukkan perintah dan berkas input pada file ini."
    if "/stages/" in path:
        return "Jalankan urutan do-file dan pemeriksaan tahap ini sesuai daftar perintah di dalamnya."
    return "Jalankan perintah yang tercantum di file ini pada data atau argumen yang disediakan pemanggilnya."


def condition_words(condition):
    """Translate common Stata guards without guessing about unfamiliar syntax."""
    original = condition.strip().rstrip("{").strip()
    if re.fullmatch(r"source_year\s*==\s*\d{4}", original):
        year = re.search(r"\d{4}", original).group()
        return f"hanya untuk baris tahun {year}"

    words = original
    words = re.sub(r"!missing\(([^)]*)\)", lambda m: "kolom " + m.group(1).replace(",", " dan ") + " terisi", words)
    words = re.sub(r"missing\(([^)]*)\)", lambda m: "kolom " + m.group(1).replace(",", " dan ") + " kosong", words)
    words = re.sub(r"source_year\s*==\s*(\d{4})", r"tahun \1", words)
    words = re.sub(r"\binlist\((\w+),\s*([^)]*)\)", lambda m: f"{m.group(1)} bernilai salah satu dari {m.group(2)}", words)
    words = words.replace(" & ", " dan ").replace(" | ", " atau ")
    words = words.replace(">=", " setidaknya ").replace("<=", " paling banyak ")
    words = words.replace("==", " sama dengan ").replace(">", " lebih dari ").replace("<", " kurang dari ")
    words = words.replace("!", "bukan ")
    words = re.sub(r"\s+", " ", words).strip()
    # Unknown function calls remain visible as code, so the comment never claims
    # a meaning that is not established by the source.
    return words


def loop_comment(line):
    if re.match(r"^forvalues\b", line):
        match = re.match(r"^forvalues\s+(\w+)\s*=\s*(\d+)\s*/\s*(\d+)", line)
        if match:
            name, first, last = match.groups()
            return f"* Ulangi blok untuk setiap {name} dari {first} sampai {last}."
        return "* Ulangi blok untuk setiap nilai yang ditetapkan di baris forvalues ini."
    match = re.match(r"^foreach\s+(\w+)\s+of\s+(local|global)\s+(\w+)", line)
    if match:
        name, scope, values = match.groups()
        return f"* Ulangi blok untuk tiap {name} dalam daftar {scope} {values}."
    match = re.match(r"^foreach\s+(\w+)\s+in\s+(.+?)\s*\{?$", line)
    if match:
        name, values = match.groups()
        items = values.split()
        if len(items) <= 5:
            return f"* Ulangi blok untuk {name}: {', '.join(items)}."
        return f"* Ulangi blok untuk setiap {name} yang tercantum di daftar pada baris ini."
    if re.match(r"^while\b", line):
        return "* Ulangi blok selama syarat while pada baris ini masih benar."
    return "* Ulangi blok sesuai rentang atau daftar yang ditetapkan di baris ini."


def correction_notes(path, text, add):
    correction = derivative_id(path)
    records = derivative_by_id_year.get(correction or "")
    if records:
        first = next(iter(records.values()))
        formula_by_year = derivative_formulas(text, first["transform"])
        output = first["repaired_field"]
        source = first["source_variable"]
        state_name = correction_state_variable(text)
        lines = text.splitlines()

        def line_number(pattern):
            return next((i for i, line in enumerate(lines, 1) if re.search(pattern, line)), None)

        use = line_number(r"^\s*use\b")
        if use:
            source_file_match = re.search(r'\busing\s+"([^"]+)"', lines[use - 1])
            input_name = source_file_match.group(1) if source_file_match else "berkas sumber"
            add(
                use,
                f"* Ambil source_year, source_row, {source}, dan kolom lain yang disebut di baris ini dari {input_name}; "
                "pasangan tahun dan nomor baris mengenali satu baris, bukan firmID.",
            )

        for number, line in enumerate(lines, 1):
            statement = line.strip()
            if re.match(r"^merge\s+1:1\s+source_year\s+source_row\b", statement):
                add(
                    number,
                    "* Pasangkan baris pada kunci tahun dan nomor baris; `1:1` menolak kunci ganda dan `assert(match)` "
                    "menghentikan proses jika pasangan baris tidak lengkap. Kunci ini bukan firmID.",
                )

        initial_output = line_number(rf"^\s*generate\s+double\s+{re.escape(output)}=\.")
        if initial_output:
            if formula_by_year:
                add(initial_output, f"* Mulai {output} sebagai missing; hanya rumus dan syarat tahun di bawah yang dapat mengisinya.")
            else:
                add(initial_output, f"* Mulai {output} sebagai missing; file ini tidak berisi rumus yang mengisinya.")

        initial_state = line_number(rf"^\s*generate\s+byte\s+{re.escape(state_name or '')}=\d+")
        if initial_state:
            if formula_by_year:
                add(
                    initial_state,
                    f"* Nilai awal {state_name} hanya menjadi titik mulai; baris per tahun berikut menentukan status akhir. "
                    "Tahun yang tertahan gerbang sumber tetap memakai kode 9.",
                )
            else:
                row = records.get("2010", first)
                add(
                    initial_state,
                    f"* {derivative_release_text(row)} File ini tidak menghitung turunan; nilai tetap kosong di Stata (missing) dan status per tahun ditetapkan di bawah.",
                )

        cond_pattern = re.compile(
            r"^\s*replace\s+(\w+)\s*=\s*cond\(missing\((\w+)\),(\d+),cond\(\2<0,(\d+),cond\(\2==0,(\d+),(\d+)\)\)\)\s+if\s+source_year==(\d{4})"
        )
        for number, line in enumerate(lines, 1):
            match = cond_pattern.match(line)
            if match:
                _state, operand, missing, negative, zero, positive, year = match.groups()
                add(
                    number,
                    f"* Tahun {year}: status awal mencatat {missing} bila {operand} kosong, {negative} bila negatif, "
                    f"{zero} bila nol, dan {positive} bila positif; baris sesudahnya dapat mengganti status jika pekerja tidak valid atau hasil berhasil dihitung.",
                )

            state_worker = re.match(
                rf"^\s*replace\s+{re.escape(state_name or '')}=4\s+if\s+source_year==(\d{{4}})\s+&\s+\(workers<=0\s*\|\s*missing\(workers\)\)",
                line,
            )
            if state_worker:
                add(number, f"* Tahun {state_worker.group(1)}: tandai status 4 jika jumlah pekerja nol, negatif, atau kosong; pembagi itu tidak dipakai.")

            state_success = re.match(
                rf"^\s*replace\s+{re.escape(state_name or '')}=0\s+if\s+source_year==(\d{{4}})\s+&\s+!missing\({re.escape(output)}\)",
                line,
            )
            if state_success:
                if first["transform"] == "log":
                    detail = "inputnya positif dan log berhasil dihitung"
                elif records[state_success.group(1)]["approved_arithmetic_domain"] == "finite_signed_over_positive_finite_workers":
                    detail = "hasil terisi, termasuk jika pembilang bertanda negatif atau nol"
                else:
                    detail = "hasil terisi setelah pembilang lolos syarat nonnegatif"
                add(number, f"* Tahun {state_success.group(1)}: bila {output} terisi ({detail}), kode status akhir diubah menjadi 0.")

            held = re.match(
                rf"^\s*replace\s+{re.escape(state_name or '')}=(\d+)\s+if\s+source_year==(\d{{4}})\s*$",
                line,
            )
            if held and held.group(2) in records and held.group(2) not in formula_by_year:
                year = held.group(2)
                row = records[year]
                reason = derivative_release_text(row)
                if row["release_status"] == "retired_nonquantity":
                    text_note = (
                        f"* Tahun {year}: status {held.group(1)} dan nilai missing dipertahankan karena registri menyebut {source} "
                        "kategori, bukan besaran untuk per-pekerja/log; angka kosong bukan nol."
                    )
                else:
                    text_note = (
                        f"* Tahun {year}: status {held.group(1)} dipasang tanpa rumus karena {reason} "
                        f"{output} tetap kosong di Stata (missing); ini bukan nilai nol."
                    )
                add(number, text_note)

        for year, (number, actual_output, numerator, condition) in formula_by_year.items():
            row = records[year]
            if first["transform"] == "per_worker":
                guards = []
                if re.search(r"workers\s*>\s*0", condition):
                    guards.append("workers > 0 agar pembagi tidak nol atau negatif")
                if re.search(rf"!missing\([^)]*\b{re.escape(numerator)}\b", condition):
                    guards.append(f"{numerator} dan workers harus terisi")
                if re.search(rf"\b{re.escape(numerator)}\s*>=\s*0\b", condition):
                    guards.append(f"{numerator} harus nol atau positif")
                else:
                    guards.append("domain registri mengizinkan pembilang bertanda, termasuk nilai negatif")
                add(
                    number,
                    f"* Tahun {year}: hitung {actual_output} = {numerator} / workers hanya bila "
                    f"{' dan '.join(guards)}. {derivative_release_text(row)}",
                )
            else:
                add(
                    number,
                    f"* Tahun {year}: hitung log natural {actual_output} dari {numerator} hanya saat {numerator} > 0 dan terisi; "
                    f"nilai nol, negatif, atau kosong dibiarkan missing. {derivative_release_text(row)}",
                )

        for number, line in enumerate(lines, 1):
            statement = line.strip()
            if re.match(rf"^assert\s+missing\({re.escape(output)}\)\s+if\s+inlist\({re.escape(state_name or '')},8,9\)", statement):
                add(number, f"* Pastikan {output} tetap kosong di Stata (missing) pada status 8/9; kode ini menangkap angka yang terisi tanpa dasar hitung.")
            elif re.match(r"^keep\s+source_year\s+source_row\b", statement):
                add(number, f"* Simpan hanya kunci baris, {output}, dan statusnya agar keluaran tidak membawa kolom sumber lain.")
            elif re.match(r"^g0c_finish\b", statement):
                add(number, "* Tutup log, simpan tabel koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom.")
        return

    # The small set of non-derivative correction programs carry their own
    # domain rules; explain their main transformation beside the actual code.
    if "/corrections/" not in path:
        return
    lines = text.splitlines()
    stem = Path(path).stem
    purpose_by_file = {
        "C020_va_domain": "* Pisahkan nilai tambah bertanda yang teramati dari nilai kosong/status; nilai negatif dan nol tetap termasuk domain, bukan otomatis dibuang.",
        "C030_keep_signed_va": "* Salin nilai tambah apa adanya hanya untuk baris yang dinyatakan eligible; pemeriksaan sesudahnya memastikan salinan sama dengan sumber.",
        "C040_va_per_worker": "* Hitung nilai tambah per pekerja untuk pembilang bertanda; helper menolak pekerja kosong/tidak positif dan menjaga nilai tambah negatif tetap dapat dihitung.",
        "C041_va_log": "* Log natural hanya dihitung untuk nilai tambah positif; nol, negatif, dan missing tidak menghasilkan log.",
        "C050_signed_tail_threshold": "* Hitung persentil ke-99 dari nilai absolut nilai tambah per tahun; ambang dipakai untuk uji sensitivitas, bukan untuk mengubah nilai tambah.",
        "C060_signed_tail_companion": "* Tandai nilai yang absolutnya lebih dari 10 kali ambang persentil ke-99 tahun itu; nilai bertanda asli hanya diteruskan jika bukan ekor tersebut.",
        "C061_energy_cost_subtotal": "* Jumlahkan hanya biaya bahan bakar dan listrik yang status sumbernya 0/1 serta nilainya tidak negatif; hitung berapa dari tiga komponen yang tersedia.",
        "C071_ratio_domain": "* Tentukan apakah pembagian nilai tambah dengan output dapat dihitung: pembilang harus ada dan output harus positif serta terisi.",
        "C072_ratio_domain": "* Tentukan apakah biaya energi per output dapat dihitung: biaya tidak negatif dan output positif, keduanya terisi.",
        "C073_ratio_domain": "* Tentukan apakah energi per output dapat dihitung: energi tidak negatif dan output positif, keduanya terisi.",
        "C074_ratio_domain": "* Tentukan apakah emisi per output dapat dihitung: emisi tidak negatif dan output positif, keduanya terisi.",
        "C081_recompute_ratio": "* Hitung ulang porsi nilai tambah/output pada baris yang lolos pemeriksaan domain; simpan rasio lama untuk membandingkan perubahan.",
        "C082_recompute_ratio": "* Hitung ulang biaya energi/output hanya saat domain biaya dan output memenuhi C072; simpan nilai lama untuk audit perubahan.",
        "C083_recompute_ratio": "* Hitung ulang GJ energi/output hanya saat domain energi dan output memenuhi C073; simpan nilai lama untuk audit perubahan.",
        "C084_recompute_ratio": "* Hitung ulang CO2/output hanya saat domain emisi dan output memenuhi C074; simpan nilai lama untuk audit perubahan.",
        "C090_own_generation_domain": "* Anggap laporan own-generation layak dinilai hanya bila status sumbernya 0/1 dan nilai kWh terisi serta tidak negatif.",
        "C100_own_generation_delta": "* Bandingkan flag own-generation lama dengan indikator positif dari angka yang dilaporkan; simpan tanda unknown dan apakah flag berubah.",
        "C110_quantity_flag_states": "* Satukan status dan indikator berlaku dari seluruh pemeriksaan kuantitas dengan kunci tahun/baris yang sama.",
        "C120_flag_logic": "* Hitung jumlah pemeriksaan kuantitas yang berlaku, teramati, belum diketahui, dan bertanda negatif sebelum membentuk flag ringkas.",
        "C130_price_flag_scope": "* Pertahankan flag ekor harga lama, tetapi jumlah observasi yang dinilai dibiarkan kosong karena denominator belum diketahui.",
        "C140_assemble_companions": "* Gabungkan kolom turunan, domain, status, dan audit ke baris master menurut source_year/source_row; blok berikut membatasi kolom tambahan.",
        "C150_change_audit": "* Ringkas jumlah nilai yang berubah, kosong, atau berbeda dari nilai lama untuk setiap turunan yang ditinjau.",
        "C160_publication_summaries": "* Buat ringkasan per tahun/variabel: jumlah baris, nilai terisi/kosong, nol, negatif, rerata, simpangan baku, rentang, dan persentil; status rilis tetap menyertai angka.",
        "C170_flag_rates": "* Hitung jumlah ya, tidak, dan tidak diketahui; persentase memakai penyebut jawaban ya+tidak, bukan seluruh baris.",
        "C180_export_roundtrip": "* Uji round-trip CSV: ekspor lalu impor kembali, kemudian bandingkan jumlah baris/kolom dan nilai sebelum data asli dipulihkan.",
        "G0_known_answer_fixtures": "* Gunakan angka contoh yang diketahui untuk memastikan pembagian bertanda, pembagian nonnegatif, dan pembagi nol/negatif/kosong memberi hasil yang diharapkan.",
    }
    purpose_note = purpose_by_file.get(stem)
    if purpose_note:
        use = next((i for i, line in enumerate(lines, 1) if re.match(r"\s*use\b", line)), None)
        if use:
            add(use, purpose_note)

    for number, line in enumerate(lines, 1):
        statement = line.strip()
        if re.match(r"^merge\s+1:1\s+source_year\s+source_row\b", statement):
            add(number, "* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap.")
        if stem in {"C040_va_per_worker", "C041_va_log"} and re.match(r"^g0c_(ratio|log)\b", statement):
            if stem == "C040_va_per_worker":
                add(number, "* Helper membagi nilai tambah dengan workers hanya bila keduanya terisi dan workers>0; opsi signed mengizinkan pembilang negatif, sedangkan hasil lain tetap missing.")
            else:
                add(number, "* Helper menghitung ln(nilai tambah) hanya bila nilai tambah>0 dan terisi; hasil lain tetap missing.")
        if stem == "C050_signed_tail_threshold":
            if re.match(r"^generate\s+double\s+__absolute=abs\(va_signed_nominal\)", statement):
                add(number, "* Ubah tanda hanya untuk membuat besar absolut; nilai tambah asli tidak diubah.")
            elif re.match(r"^bysort\s+source_year:.*pctile\(__absolute\),\s*p\(99\)", statement):
                add(number, "* Hitung ambang p99 secara terpisah dalam tiap tahun dari besar absolut nilai tambah.")
            elif re.match(r"^collapse\b", statement):
                add(number, "* Ringkas menjadi satu baris per tahun: jumlah nilai tambah teramati, banyak yang tidak nol, dan ambang p99.")
        if stem == "C060_signed_tail_companion":
            if re.match(r"^merge\s+m:1\s+source_year\b", statement):
                add(number, "* Pasangkan satu ambang p99 per tahun ke tiap baris tahun yang sama.")
            elif re.match(r"^generate\s+byte\s+va_abs_tail_flag=", statement):
                add(number, "* Tandai jika nilai absolut lebih dari 10 kali p99 tahun itu; missing input/ambang tidak diberi flag.")
            elif re.match(r"^generate\s+double\s+va_signed_tail_sensitivity=", statement):
                add(number, "* Pertahankan angka bertanda hanya untuk baris di luar flag ekor; ini kolom sensitivitas, bukan pengganti nilai utama.")
        if stem == "C061_energy_cost_subtotal":
            if re.match(r"^generate\s+double\s+__", statement):
                add(number, "* Salin komponen biaya hanya bila nilai tidak negatif, terisi, dan status sumbernya 0/1.")
            elif re.match(r"^egen\s+byte\s+energy_cost_reported_n=", statement):
                add(number, "* Hitung berapa dari tiga komponen yang memenuhi syarat; angka ini membedakan subtotal parsial dari lengkap.")
            elif re.match(r"^egen\s+double\s+energy_exp_observed_repaired=", statement):
                add(number, "* Jumlahkan komponen yang lolos; opsi missing mencegah semua-komponen-kosong berubah menjadi nol.")
            elif re.match(r"^replace\s+energy_exp_observed_repaired=\.\s+if\s+energy_cost_reported_n==0", statement):
                add(number, "* Pastikan subtotal tetap missing jika tidak ada satu pun komponen yang teramati.")
        if stem.startswith("C07") and stem.endswith("_ratio_domain") and re.match(r"^generate\s+byte\s+\w+_eligible=", statement):
            add(number, "* Tandai hanya baris yang memenuhi batas pembilang/penyebut yang dijelaskan di atas; missing dan penyebut nol tidak lolos.")
        if stem.startswith("C08") and stem.endswith("_recompute_ratio") and re.match(r"^replace\s+\w+_repaired=", statement):
            formula = statement.split(" if ", 1)[0].replace("replace ", "")
            add(number, f"* Hitung ulang {formula} hanya untuk baris yang sudah dinyatakan layak; nilai lain tetap missing.")
        if stem == "C090_own_generation_domain" and re.match(r"^generate\s+byte\s+own_gen_observed_valid=", statement):
            add(number, "* Luluskan nilai hanya jika status sumber 0/1, kWh tidak kosong, dan nilainya tidak negatif.")
        if stem == "C120_flag_logic" and re.match(r"^replace\s+__n_", statement):
            add(number, "* Tambahkan hasil tes ini ke hitungan total hanya jika tesnya berlaku; nilai unknown tidak dihitung sebagai nol negatif.")
        if stem == "C170_flag_rates" and re.match(r"^local\s+n=`yes'\+`no'", statement):
            add(number, "* Penyebut share teramati hanya menjumlahkan jawaban ya+tidak; unknown dikeluarkan dari share itu.")
        if stem == "C170_flag_rates" and re.match(r"^post\s+`p'", statement):
            add(number, "* Simpan share ya di antara jawaban teramati dan share unknown di antara semua baris tahun ini.")
        if stem == "C180_export_roundtrip" and re.match(r"^g0c_roundtrip\b", statement):
            add(number, "* Jalankan uji tulis-baca CSV, cek dimensi dan nilai, lalu pulihkan data yang tersimpan sebelum uji.")
        if stem.startswith("CT") and re.match(r"^(generate|egen|replace)\b", statement):
            if "if" in statement and re.search(r">=0|!missing", statement):
                add(number, "* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan.")
        if re.match(r"^assert\s+_N==33049\b", statement):
            add(number, "* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan.")
        if re.match(r"^g0c_finish\b", statement):
            add(number, "* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom.")


def block_notes(path, text, operand_info=None):
    lines = text.splitlines()
    notes = []

    def add(line, comment):
        if comment and not any(note["line"] == line and note["comment"] == comment for note in notes):
            notes.append({"line": line, "comment": comment})

    for number, source_line in enumerate(lines, 1):
        statement = source_line.strip()
        if not statement or statement.startswith("*"):
            continue
        if re.match(r"^(foreach|forvalues|while)\b.*\{\s*$", statement):
            if path != "rd2017/validation/compare_current_wave.do":
                add(number, loop_comment(statement))
        elif_match = re.match(r"^if\s+(.+?)\s*\{\s*$", statement)
        if elif_match:
            condition = elif_match.group(1)
            add(number, f"* Isi blok hanya dijalankan bila {condition_words(condition)}.")
        if re.match(r"^program\s+(?:define\s+)?", statement):
            match = re.match(r"^program\s+(?:define\s+)?([A-Za-z_][\w]*)", statement)
            name = match.group(1) if match else "ini"
            add(number, f"* Definisikan perintah bantu {name}; isi blok berjalan saat perintah ini dipanggil.")
        if re.match(r"^input\b", statement):
            add(number, "* Nilai setelah baris ini membentuk data contoh yang dipakai untuk pemeriksaan di file ini.")

    if path.endswith("rows/G0/corrections/_utils.do"):
        for number, source_line in enumerate(lines, 1):
            statement = source_line.strip()
            if re.match(r"^program\s+define\s+g0c_begin\b", statement):
                add(number, "* Definisikan pembuka log anak koreksi; id menentukan nama berkas log agar langkah berikut bisa dilacak.")
            elif re.match(r"^program\s+define\s+g0c_finish\b", statement):
                add(number, "* Definisikan penutup koreksi; id/state menentukan nama berkas data keluaran dan pesan jumlah baris/kolom.")
            elif re.match(r"^program\s+define\s+g0c_ratio\b", statement):
                add(number, "* Definisikan pembagian dua angka: hasil mula-mula missing dan hanya terisi bila input ada serta pembagi positif.")
            elif re.match(r"^if\s+.*signed.*replace", statement):
                add(number, "* Dengan opsi signed, izinkan pembilang positif, nol, atau negatif; pembagi tetap harus positif.")
            elif re.match(r"^\s*else\s+replace\b", source_line):
                add(number, "* Tanpa signed, hitung rasio hanya bila pembilang tidak negatif; pembagi positif mencegah pembagian nol/negatif.")
            elif re.match(r"^program\s+define\s+g0c_log\b", statement):
                add(number, "* Definisikan log natural untuk angka positif yang terisi; nilai nol, negatif, dan missing tetap missing.")
            elif re.match(r"^program\s+define\s+g0c_roundtrip\b", statement):
                add(number, "* Definisikan uji ekspor-impor yang bekerja pada salinan data dan mengembalikan tabel awal saat selesai.")
            elif re.match(r"^export\s+delimited\b", statement):
                add(number, "* Tulis salinan CSV dengan format angka yang diminta agar nilai dapat dibandingkan setelah impor.")
            elif re.match(r"^import\s+delimited\b", statement):
                add(number, "* Baca kembali CSV sebagai teks dahulu; angka akan dipulihkan lalu dibandingkan dengan input.")
            elif re.match(r"^cf\s+_all\s+using\b", statement):
                add(number, "* Bandingkan setiap kolom hasil round-trip dengan input awal; perbedaan membuat uji gagal.")

    if path == "code/merge_guard.do":
        for number, source_line in enumerate(lines, 1):
            statement = source_line.strip()
            if re.match(r"^program\s+define\s+wf_merge_guard\b", statement):
                add(number, "* Definisikan pemeriksa sebelum merge: memastikan tahun sesuai, kunci tahun/baris unik, tidak ada kolom tujuan lama, dan semua baris punya pasangan.")
            elif re.match(r"^assert\s+_merge==3", statement):
                add(number, "* Wajibkan setiap baris memiliki pasangan di kedua berkas; jika tidak, merge berhenti alih-alih membuang baris.")

    # Add a few contextual notes to the main data-flow files, not a note on
    # every routine command in every one of the thousands of source files.
    if path.startswith("code/annual/raw_"):
        use = next((i for i, line in enumerate(lines, 1) if re.match(r"\s*use\b", line)), None)
        if use:
            add(use, "* Muat berkas sumber untuk satu tahun; barisnya lalu diberi kunci tahun dan nomor baris.")

    if "/merge_mapped_" in path or "/merge_working_" in path:
        use = next((i for i, line in enumerate(lines, 1) if re.match(r"\s*use\b", line)), None)
        preserve = next((i for i, line in enumerate(lines, 1) if re.match(r"\s*preserve\b", line)), None)
        if use:
            add(use, "* Muat wave tahunan utama; source_year dan source_row mengenali satu baris di wave, bukan firmID.")
        for number, line in enumerate(lines, 1):
            if re.match(r"\s*wf_merge_guard\b", line):
                add(number, "* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan.")
            elif re.match(r"\s*merge\s+1:1\s+source_year\s+source_row\b", line):
                add(number, "* Gabungkan hanya pasangan source_year/source_row yang sama; `1:1` dan `assert(match)` menolak kunci ganda atau baris tanpa pasangan.")
        if preserve:
            add(preserve, "* Simpan data lengkap sementara sebelum pemeriksaan per kolom; hasil antara hanya dipakai untuk membandingkan raw dengan variabel, lalu restore memulihkan wave penuh.")
        for number, line in enumerate(lines, 1):
            if re.match(r"\s*restore\b", line):
                add(number, "* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama.")
            elif re.match(r"\s*save\b", line):
                add(number, "* Simpan wave setelah seluruh pemetaan dan pemeriksaan kunci selesai.")

    if path.endswith("F085_publish_waves.do"):
        preserve = next((i for i, line in enumerate(lines, 1) if re.match(r"\s*preserve\b", line)), None)
        if preserve:
            add(preserve, "* Untuk tiap tahun, pilih baris tahun itu saja, cek source_year/source_row, simpan wave, lalu restore sebelum tahun berikutnya.")

    if path.endswith("F090_append_ready.do"):
        use = next((i for i, line in enumerate(lines, 1) if re.match(r"\s*use\b", line)), None)
        if use:
            add(use, "* Mulai dari wave 2010 lalu append 11 wave lainnya; di akhir, cek kunci unik, jumlah baris/kolom, dan simpan data utama.")

    if path.endswith("RD17-020.do"):
        use = next((i for i, line in enumerate(lines, 1) if re.match(r"\s*use\b", line)), None)
        if use:
            add(use, "* Muat jawaban pertanyaan R&D dan nilai biaya sebagai kolom terpisah; rd_indicator_raw berisi kode jawaban, bukan uang.")
        keep_year = next((i for i, line in enumerate(lines, 1) if re.match(r"\s*keep\s+if\s+source_year==2017\b", line)), None)
        if keep_year:
            add(keep_year, "* Batasi proyeksi ini pada baris tahun 2017.")

    if "/publication/" in path or "/reports/" in path or path.startswith("rd2017/"):
        for number, source_line in enumerate(lines, 1):
            statement = source_line.strip()
            if re.match(r"^postfile\b", statement):
                add(number, "* Siapkan tabel ringkasan; perintah post di bawah menambahkan hitungan atau hasil per kelompok.")
            elif re.match(r"^export\s+delimited\b", statement):
                if path != "rd2017/validation/compare_current_wave.do":
                    add(number, "* Tulis tabel yang sedang terbuka ke CSV pada nama file di perintah ini.")
            elif re.match(r"^rd17_export\b", statement):
                add(number, "* Ekspor tabel R&D dengan nama dasar dan spesifikasi yang tertulis di opsi perintah ini.")

    publication_name = Path(path).name
    if publication_name == "G0_X08_worker_denominator_domains.do":
        for number, line in enumerate(lines, 1):
            if re.match(r"^generate\s+long\s+(positive|zero|negative|missing)_workers_n=", line.strip()):
                add(number, "* Hitung masing-masing pekerja positif, nol, negatif, atau missing; hanya nilai positif terisi yang dapat menjadi pembagi.")
            elif re.match(r"^collapse\b", line.strip()):
                add(number, "* Jumlahkan empat kategori menjadi hitungan per tahun; kategori tidak dilebur ke satu angka pekerja.")
    elif publication_name == "G0_X10_log_domain_losses.do":
        for number, line in enumerate(lines, 1):
            statement = line.strip()
            if re.match(r"^quietly\s+count\s+if\s+.*>0", statement):
                add(number, "* Hitung input positif yang memenuhi syarat log untuk tahun dan variabel pada baris ini.")
            elif re.match(r"^quietly\s+count\s+if\s+.*==0", statement):
                add(number, "* Hitung input tepat nol secara terpisah; log nol tidak didefinisikan.")
            elif re.match(r"^quietly\s+count\s+if\s+.*<0", statement):
                add(number, "* Hitung input negatif secara terpisah; nilai ini tidak masuk log natural.")
            elif re.match(r"^post\s+`p'", statement):
                add(number, "* Simpan jumlah positif/nol/negatif/kosong dan jumlah log sah dalam satu baris laporan.")
    elif publication_name == "G0_X11_outlier_sensitivity.do":
        for number, line in enumerate(lines, 1):
            statement = line.strip()
            if re.match(r"^merge\s+m:1\s+source_year\b", statement):
                add(number, "* Pasangkan satu ambang p99 nilai absolut untuk tiap tahun ke baris master pada tahun sama.")
            elif re.match(r"^generate\s+byte\s+va_abs_tail_flag=", statement):
                add(number, "* Tandai ekor jika besar absolut nilai tambah melewati 10 kali ambang tahun tersebut; hasil tidak mengganti nilai sumber.")
            elif re.match(r"^post\s+`p'", statement):
                add(number, "* Simpan statistik pada kelompok pembanding yang sedang dihitung bersama ambang dan jumlah baris bertanda.")
    elif publication_name in {"G0_X12_export_definition_states.do", "G0_X13_rd_definition_states.do"}:
        for number, line in enumerate(lines, 1):
            statement = line.strip()
            if re.match(r"^local\s+unknown=", statement):
                add(number, "* Unknown adalah sisa dari seluruh baris setelah jawaban ya dan tidak dihitung; missing tidak diubah menjadi tidak.")
            elif publication_name == "G0_X13_rd_definition_states.do" and re.match(r"^post\s+`p'", statement) and '"val_costrd"' in statement:
                add(number, "* Untuk val_costrd, catat hanya keberadaan kategori; nilai mean/p50 dikosongkan karena kategori bukan nominal uang.")
            elif publication_name == "G0_X13_rd_definition_states.do" and re.match(r"^post\s+`p'", statement) and '"rd_cost_nominal"' in statement:
                add(number, "* Untuk rd_cost_nominal, catat jumlah baris, nilai terisi/kosong, rerata, dan p50; ukurannya tetap berlabel kandidat nominal lama, bukan persentase jawaban R&D.")
            elif re.match(r"^post\s+`p'", statement) and "positive_share" not in statement:
                add(number, "* Catat jumlah ya/tidak/unknown dan share ya di antara jawaban yang diketahui; penyebut share tidak memasukkan unknown.")
            elif re.match(r"^generate\s+long\s+observed_denominator=", statement):
                add(number, "* Penyebut teramati adalah ya+tidak; baris unknown tetap dilaporkan terpisah.")
            elif publication_name == "G0_X13_rd_definition_states.do" and re.match(r"^generate\s+str\d+\s+definition_status=", statement):
                add(number, "* Bawa batas interpretasi ke tiap baris: kandidat biaya tidak disamakan dengan kode kategori COSTRD atau prevalensi pertanyaan R&D.")
    elif publication_name == "G0_X14_identity_acceptance.do":
        for number, line in enumerate(lines, 1):
            if re.match(r"^assert\s+identity_mode==", line.strip()):
                add(number, "* Hentikan proses bila mode identitas berubah dari off atau jika ID nyata/dummy muncul.")
    elif publication_name == "G0_X17_company_price_gate.do":
        for number, line in enumerate(lines, 1):
            if re.match(r"^generate\s+long\s+(accepted_match_n|not_attempted_n|ambiguous_n)=", line.strip()):
                add(number, "* Laporkan secara terpisah jumlah pencocokan yang diterima, belum dicoba, dan masih ambigu; tidak ada rasio harga yang dibuat di sini.")
    elif publication_name == "G0_X18_nominal_real_gate.do":
        for number, line in enumerate(lines, 1):
            if re.match(r"^assert\s+deflator_applied==0", line.strip()):
                add(number, "* Pastikan nilai riil tetap kosong dan flag deflator nol; laporan ini memeriksa gerbang, bukan mengubah nominal menjadi riil.")
            elif re.match(r"^post\s+`p'", line.strip()):
                add(number, "* Catat nilai nominal, jumlah yang layak harga, nilai riil, indeks, dan alasan gerbang per tahun.")
    elif publication_name == "G0_X20_energy_component_coverage.do":
        for number, line in enumerate(lines, 1):
            statement = line.strip()
            if re.match(r"^assert\s+energy_all_sources_complete==0", statement):
                add(number, "* Verifikasi flag kelengkapan sumber energi tidak pernah menjadi 1 pada data ini.")
            elif re.match(r"^generate\s+long\s+n_(nine_fuel|two_purchase)_(complete|partial)=", statement):
                add(number, "* Hitung terpisah wave yang lengkap/parsial pada komponen yang disebut; partial bukan nol dan bukan lengkap.")
    elif publication_name == "G0_X21_electricity_and_own_generation.do":
        for number, line in enumerate(lines, 1):
            if re.match(r"^generate\s+long\s+(pln_n|nonpln_n|purchased_n|purchased_gj_n)=", line.strip()):
                add(number, "* Hitung ketersediaan listrik PLN/non-PLN dan total pembelian; ini terpisah dari own-generation.")
    elif publication_name == "G0_X22_grid_assumption_coverage.do":
        for number, line in enumerate(lines, 1):
            if re.match(r"^generate\s+long\s+accepted_factor_n=", line.strip()):
                add(number, "* Catat jumlah faktor jaringan yang diterima; adanya nilai faktor saja tidak menaikkan hitungan penerimaan.")
    elif publication_name == "G0_X23_energy_cost_reconciliation.do":
        for number, line in enumerate(lines, 1):
            if re.match(r"^generate\s+long\s+(reported_fuel_total_n|purchase_component_n|subtotal_n|three_component_complete_n)=", line.strip()):
                add(number, "* Hitung kelengkapan tiap bagian biaya dari nilai terisi, nonnegatif, dan status sumber 0/1; total parsial dibedakan dari lengkap.")

    if operand_info:
        family, role, operand = operand_info
        variable = operand["variable"]
        year = operand["year"]

        def line_number(pattern):
            return next((i for i, line in enumerate(lines, 1) if re.search(pattern, line)), None)

        if role == "launcher":
            use = line_number(r"^\s*use\b")
            check = line_number(r"^\s*assert\s+source_year==")
            metrics = line_number(r"^\s*postfile\b")
            call = line_number(rf"^\s*do\s+.*{re.escape(operand['method'])}")
            if use:
                add(use, f"* Muat kolom sumber untuk {variable} tahun {year}; baris tetap memakai source_year dan source_row.")
            if check:
                add(check, f"* Pastikan setiap baris milik tahun {year}; pemeriksaan isid berikutnya menolak kunci source_year/source_row yang berulang.")
            if metrics:
                add(metrics, "* Buka tabel hitungan diagnostik; isinya mencatat banyak baris dan status, bukan mengubah nilai sumber.")
            if call:
                add(call, f"* Jalankan aturan pembentukan {variable} tahun {year} yang ada di do-file anak ini.")
        else:
            initial = line_number(rf"^\s*(?:generate|clonevar)\s+(?:double|byte|long|int)?\s*{re.escape(variable)}\b|^\s*clonevar\s+v_{re.escape(variable)}=")
            if initial:
                status = f"vs_{variable}"
                start = re.search(rf"^\s*generate\s+byte\s+{re.escape(status)}=(\d+)", text, re.M)
                start_text = f"{status} mulai dari kode {start.group(1)}" if start else f"{status} dimulai menurut kode yang tertulis"
                add(initial, f"* Mulai {variable} sebagai nilai kosong; {start_text}. Baris berikut menerapkan aturan sumber tahun {year}.")

            if family == "mapped":
                parse = line_number(rf"^\s*replace\s+{re.escape(variable)}=.*\braw_[A-Za-z0-9_]+")
                if parse:
                    raw = re.search(r"\b(raw_[A-Za-z0-9_]+)\b", lines[parse - 1])
                    if raw and "subinstr(strtrim(" in lines[parse - 1]:
                        add(parse, f"* Baca {raw.group(1)} setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk {variable}.")
                    else:
                        add(parse, f"* Bentuk {variable} dari kolom sumber pada baris ini; aturan vs_{variable} di bawah mempertahankan perbedaan status.")
            else:
                fill = line_number(rf"^\s*replace\s+{re.escape(variable)}=.*\s+if\s+missing\(")
                if fill:
                    add(fill, f"* Lengkapi {variable} hanya saat nilai utama kosong dan syarat sumber di baris ini terpenuhi; vs_{variable} menandai isian baru.")

            count = line_number(rf"^\s*quietly\s+count\s+if\s+!?missing\({re.escape(variable)}\)")
            if count:
                add(count, f"* Hitung berapa baris {variable} yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data.")

            preserve = line_number(r"^\s*preserve\b")
            if preserve:
                add(preserve, f"* Simpan hanya source_year/source_row, {variable}, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja.")

    if "/corrections/" in path:
        correction_notes(path, text, add)

    if "/stages/" in path:
        for number, source_line in enumerate(lines, 1):
            statement = source_line.strip()
            if re.match(r'^do\s+"[^"\n]+"', statement):
                child = re.search(r'^do\s+"([^"\n]+)"', statement).group(1)
                add(number, f"* Jalankan tahap/berkas anak {child}; tahap ini bergantung pada hasilnya sebelum melanjutkan.")
            elif re.match(r"^save\b", statement):
                add(number, "* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini.")
            elif re.match(r"^append\s+using\b", statement):
                add(number, "* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci.")
            elif re.match(r"^restore\b", statement):
                add(number, "* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh.")

    if path == "rd2017/validation/compare_current_wave.do":
        exact_notes = {
            3: "* Muat kunci baris, dua kolom mentah, dan dua klasifikasi token yang sudah ada dari master; source_year/source_row menunjuk baris, bukan firmID.",
            4: "* Sisakan wave 2017 karena pemeriksaan ini khusus untuk tahun itu.",
            5: "* Pastikan satu pasangan tahun/nomor baris hanya muncul sekali sebelum membuat kandidat pembanding.",
            6: "* Wajibkan tepat 3.357 baris dan semuanya tahun 2017; jumlah lain menghentikan validasi.",
            9: "* Jalankan empat tahap kandidat yang didefinisikan di shared.do: klasifikasi token, status universe, status jawaban, lalu flag audit; semua tetap kandidat dan measurement_admitted bernilai 0.",
            10: "* Terapkan tahap yang sedang dipilih oleh loop untuk membentuk kolom kandidat yang dibandingkan di bawah.",
            12: "* Pastikan klasifikasi token mentah milik wave sama persis dengan kelas token parent yang dibentuk ulang.",
            13: "* Pastikan klasifikasi token mentah pasangan wave sama persis dengan kelas token child yang dibentuk ulang.",
            14: "* Bandingkan kunci, kelas token, status kandidat, dan flag penerimaan dengan outputs/candidate_2017.dta; satu perbedaan menghentikan validasi.",
            15: "* Bandingkan kolom mentah dan hasil kandidat dengan candidate_2017.dta historis; ini pemeriksaan kesamaan isi, bukan persetujuan pengukuran.",
            16: "* Ulangi pemeriksaan arsip untuk tiga tabel ringkas: jumlah kelompok, hitungan gabungan, dan rasio kandidat.",
            17: "* Buka tabel ringkas saat ini yang namanya sedang dipilih loop.",
            18: "* Pastikan semua kolom tabel ringkas sama dengan versi historisnya; perbedaan apa pun menghentikan validasi.",
            20: "* Buang tabel kerja yang baru saja dibandingkan sebelum membentuk satu baris laporan hasil validasi.",
            21: "* Buat satu baris untuk menyimpan hasil pemeriksaan kesamaan.",
            22: "* Beri tanda 1 karena klasifikasi token wave sudah cocok dengan dua kelas kandidat yang dibentuk ulang.",
            23: "* Beri tanda 1 setelah 3.357 baris dan kedua pemeriksaan kelas token di atas lolos.",
            24: "* Beri tanda 1 setelah group_counts, joint_counts, dan candidate_ratios cocok dengan tabel historis.",
            25: "* Tetapkan measurement_admitted=0: hasil yang sama dengan arsip tidak berarti pengukuran diterima.",
            26: "* Simpan satu baris tanda kesetaraan ke berkas DTA validation/equivalence.dta.",
            27: "* Ekspor baris hasil yang sama ke CSV agar status validasi mudah dibaca.",
            28: "* Tampilkan penanda bahwa seluruh perbandingan master dan arsip historis selesai tanpa perbedaan.",
        }
        for line_number, comment in exact_notes.items():
            add(line_number, comment)
    elif "/validation/" in path:
        for number, source_line in enumerate(lines, 1):
            statement = source_line.strip()
            if re.match(r"^cf\b", statement):
                add(number, "* Bandingkan kolom satu per satu dengan berkas pembanding; perbedaan menghentikan pemeriksaan.")
            elif re.match(r"^assert\b", statement):
                add(number, "* Pastikan syarat pembanding ini benar; jika tidak, validasi berhenti di sini.")
            elif re.match(r"^isid\s+source_year\s+source_row\b", statement):
                add(number, "* Pastikan satu pasangan tahun/nomor baris hanya muncul sekali; pasangan ini mengenali baris, bukan firmID.")

    return sorted(notes, key=lambda note: (note["line"], note["comment"]))


entries = []
families = collections.Counter()
for relative_path in source_paths:
    source = source_file(relative_path)
    text = source.read_text()
    edges = edges_by_path[relative_path]
    inputs = [nodes[node_id]["path"] for edge in edges for node_id in edge["inputs"]]
    outputs = [nodes[node_id]["path"] for edge in edges for node_id in edge["outputs"]]

    info = leaf_by_path.get(relative_path)
    if info:
        family, role, operand = info
        inputs = [operand["parent"]] + operand.get("additional_parents", [])
        outputs = [operand["artifact"]]
        if role == "method":
            inputs = [f"Kolom yang dimuat launcher {operand['launcher']} dari {operand['parent']}"]

    if not inputs:
        referenced = re.findall(r'^\s*(?:do|include|use|import delimited)[^\n]*?"([^"\n]+)"', text, re.M)
        inputs = referenced or ["Data atau argumen yang disediakan pemanggil; lihat perintah di file ini."]
    if not outputs:
        outputs = ["Hasil atau perubahan data yang disebut oleh perintah di file ini."]

    if relative_path == "rd2017/validation/compare_current_wave.do":
        inputs = [
            "$RD17_MASTER: source_year, source_row, raw_rnd17, raw_costrd17, rd17_own_token_class, rd17_external_token_class",
            "outputs/candidate_2017.dta serta arsip $RD17_HISTORY/outputs: candidate_2017, group_counts, joint_counts, candidate_ratios",
        ]
        outputs = ["validation/equivalence.dta", "validation/equivalence.csv"]

    family_path = str(Path(relative_path).parent)
    families[family_path] += 1
    entries.append(
        {
            "path": relative_path,
            "source_sha256": sha256(source),
            "family": family_path,
            "header_comments": [
                "* Tujuan: " + purpose(relative_path, text, info),
                "* Input: " + compact(inputs),
                "* Output: " + compact(outputs),
                "* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log.",
            ],
            "block_notes": block_notes(relative_path, text, info),
            "input_paths": unique(inputs),
            "output_paths": unique(outputs),
            "edge_ids": [edge["id"] for edge in edges],
        }
    )


def supplemental_entry(path, archive_path, header_comments, block_notes, existing_source_header=None):
    source = SOURCE_ROOT / archive_path
    return {
        "path": path,
        "source_archive": archive_path,
        "source_sha256": sha256(source),
        "projection": "supplemental_original_science_source_not_in_source_paths_json",
        "header_comments": header_comments,
        "existing_source_header": existing_source_header or [],
        "block_notes": block_notes,
    }


supplemental_entries = []
amended_mapped = {
    "waste_solid_flag_2022": ("raw_sowste22", "waste_solid_flag"),
    "waste_liquid_flag_2022": ("raw_liwste22", "waste_liquid_flag"),
    "waste_hazardous_flag_2022": ("raw_b3wste22", "waste_hazardous_flag"),
}
for stem, (raw_field, variable) in amended_mapped.items():
    archive = f"provenance/raw-predicate-binding-amendment/code/leaves/mapped/{stem}.do"
    relative = f"code/leaves/mapped/{stem}.do"
    supplemental_entries.append(
        supplemental_entry(
            relative,
            archive,
            [
                f"* Tujuan: Jalankan pemetaan {variable} untuk wave 2022 dari kolom sumber {raw_field} dan raw_inspli22; aturan pemetaan berada di do-file anak.",
                "* Input: raw_wave_2022.dta, termasuk source_year/source_row dan dua kolom raw yang disebut di atas.",
                f"* Output: kolom {variable} tahun 2022 dan ringkasan hitungan observed/zeros/invalid/source_absent.",
                "* Jika tahun, kunci baris, atau do-file anak gagal, wave ini belum selesai.",
            ],
            [
                {"line": 2, "comment": f"* Muat hanya kunci baris dan kolom raw {raw_field}/raw_inspli22 yang dipakai untuk pemetaan 2022."},
                {"line": 3, "comment": "* Pastikan semua baris pada berkas ini milik tahun 2022."},
                {"line": 4, "comment": "* Pastikan pasangan source_year/source_row tidak berulang; pasangan ini mengenali baris, bukan firmID."},
                {"line": 7, "comment": "* Siapkan ringkasan diagnostics untuk jumlah baris, nilai teramati, nol, tidak valid, dan sumber yang tidak tersedia."},
                {"line": 8, "comment": f"* Jalankan aturan pemetaan {variable} khusus tahun 2022 pada do-file anak ini."},
                {"line": 9, "comment": "* Tutup tabel hitungan setelah pemetaan selesai agar metrik dapat dibaca sebagai satu hasil."},
            ],
        )
    )

for year in (2017, 2018):
    archive = f"provenance/working-parent-drop-amendment/code/leaves/working/innovation_flag_{year}.do"
    relative = f"code/leaves/working/innovation_flag_{year}.do"
    notes = [
        {"line": 2, "comment": f"* Muat wave terverifikasi tahun {year}; nilai ini menjadi master yang menerima empat flag inovasi dari do-file tunnel."},
        {"line": 3, "comment": f"* Pastikan semua baris milik tahun {year}."},
        {"line": 4, "comment": "* Pastikan satu pasangan source_year/source_row hanya muncul sekali; kunci ini bukan firmID."},
    ]
    for line, variable in ((5, "innovation_product_flag"), (8, "innovation_process_flag"), (11, "innovation_marketing_flag"), (14, "innovation_org_flag")):
        notes.extend([
            {"line": line, "comment": f"* Hapus salinan lama {variable} dan statusnya agar hasil tunnel tahun ini dapat dimasukkan tanpa nama kolom ganda."},
            {"line": line + 2, "comment": f"* Tambahkan {variable} beserta statusnya menurut source_year/source_row; assert(match) menghentikan merge jika ada baris tanpa pasangan."},
        ])
    notes.extend([
        {"line": 19, "comment": "* Siapkan ringkasan per variabel: seluruh baris, nilai teramati, nilai dari sumber terverifikasi saja, dan nilai provisional."},
        {"line": 20, "comment": f"* Jalankan pengisian flag inovasi untuk wave {year}; metode mempertahankan nilai lama dan hanya mengisi yang kosong sesuai syarat di anaknya."},
        {"line": 21, "comment": "* Tutup tabel hitungan setelah semua flag diperiksa."},
    ])
    supplemental_entries.append(
        supplemental_entry(
            relative,
            archive,
            [
                f"* Tujuan: Tambahkan empat flag inovasi untuk wave {year} dari hasil tunnel, setelah mengosongkan salinan lama dengan nama sama.",
                f"* Input: verified_wave_{year}.dta serta empat tabel tunnel product/process/marketing/organization yang dipasangkan per source_year/source_row.",
                f"* Output: wave {year} dengan empat flag dan status masing-masing, plus ringkasan teramati/verified-only/provisional.",
                "* Jika satu pasangan kunci tidak ditemukan, merge berhenti dan wave belum siap.",
            ],
            notes,
        )
    )

tail_archive = "provenance/f030-tail-resume/code/stages/F030_resume_tail.do"
tail_source = SOURCE_ROOT / tail_archive
tail_lines = tail_source.read_text().splitlines()
supplemental_entries.append(
    supplemental_entry(
        "code/stages/F030_resume_tail.do",
        tail_archive,
        [],
        [
            {"line": 5, "comment": "* Siapkan lingkungan Stata yang sama dengan tahap wave lainnya."},
            {"line": 6, "comment": "* Lanjutkan variabel waste solid 2022 yang belum dibuat pada proses sebelumnya."},
            {"line": 7, "comment": "* Lanjutkan variabel waste liquid 2022 yang belum dibuat pada proses sebelumnya."},
            {"line": 8, "comment": "* Lanjutkan variabel waste hazardous 2022 yang belum dibuat pada proses sebelumnya."},
            {"line": 9, "comment": "* Lanjutkan konversi bahan bakar gas alam ke MMBtu untuk 2022."},
            {"line": 10, "comment": "* Lanjutkan variabel kuantitas biomassa 2022."},
            {"line": 11, "comment": "* Gabungkan seluruh hasil mapped 2022 menjadi wave tahunan setelah lima leaf tersisa selesai."},
            {"line": 12, "comment": "* Tampilkan penanda selesai yang dipakai runner untuk mengenali akhir tail."},
        ],
        existing_source_header=tail_lines[:4],
    )
)

manifest = {
    "status": "DRAFT_FACTUAL_NONEXECUTABLE_COMMENTS_NOT_INSTALLED",
    "source_paths_sha256": sha256(LOG_ROOT / "source-paths.json"),
    "registry_sha256": sha256(SOURCE_ROOT / "registry/dag-complete.json"),
    "files": len(entries),
    "block_notes": sum(len(entry["block_notes"]) for entry in entries),
    "family_coverage": dict(families),
    "supplemental_original_projection_count": len(supplemental_entries),
    "supplemental_original_projections": supplemental_entries,
    "entries": entries,
}
(HERE / "comment-manifest.json").write_text(json.dumps(manifest, ensure_ascii=False, indent=2) + "\n")

sample_paths = [
    "code/annual/raw_2022.do",
    "code/leaves/mapped/workers_2017.do",
    "code/leaves/working/rd_activity_flag_2017.do",
    "dag/edges/word_rows/G0/variable_year/workers_2017.do",
    "code/annual/merge_mapped_2017.do",
    "code/annual/merge_working_2017.do",
    "code/merge_guard.do",
    "code/stages/F090_append_ready.do",
    "code/stages/F085_publish_waves.do",
    "code/validation/compare_reports.do",
    "rd2017/validation/compare_current_wave.do",
    "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do",
    "rows/G0/corrections/_utils.do",
    "rows/G0/corrections/C061_energy_cost_subtotal.do",
    "rows/G0/corrections/CT005_recompute_total.do",
    "rows/G0/corrections/CQ001_quantity_sign.do",
    "rows/G0/corrections/CR001_per_worker.do",
    "rows/G0/corrections/CR005_per_worker.do",
    "rows/G0/corrections/CR026_per_worker.do",
    "rows/G0/corrections/CR027_per_worker.do",
    "rows/G0/corrections/CR160_log.do",
    "rows/G0/corrections/CR169_log.do",
    "rows/G0/corrections/C160_publication_summaries.do",
    "rows/G0/corrections/C170_flag_rates.do",
    "rows/G0/publication/G0_X08_worker_denominator_domains.do",
    "rows/G0/publication/G0_X12_export_definition_states.do",
    "rows/G0/publication/G0_X13_rd_definition_states.do",
    "rows/G0/publication/G0_X18_nominal_real_gate.do",
    "rd2017/rows/G0/RD2017/RD17-020.do",
    "rd2017/rows/G0/RD2017/RD17-030.do",
]
samples = [entry for entry in entries if entry["path"] in sample_paths]
samples.extend(supplemental_entries)
(HERE / "samples.json").write_text(json.dumps(samples, ensure_ascii=False, indent=2) + "\n")

print(
    json.dumps(
        {
            "files": manifest["files"],
            "block_notes": manifest["block_notes"],
            "families": manifest["family_coverage"],
            "manifest_sha256": sha256(HERE / "comment-manifest.json"),
            "supplemental_original_projections": len(supplemental_entries),
            "sample_paths": [sample["path"] for sample in samples],
        },
        ensure_ascii=False,
        indent=2,
    )
)
