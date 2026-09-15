/*****************************************************************************
 KONFIGURASI INPUT PER TAHUN — dipakai bila RUN_INPUT = custom.

 Excel: nama kolom adalah TEKS HEADER ASLI, termasuk spasi dan huruf besar.
        Alternatif: "@A", "@BC" untuk huruf kolom Excel.
 DTA:   nama kolom adalah nama variabel Stata, bukan variable label.

 FIRM ID TIDAK DI-DESTRING: "00123" tetap berbeda dari "123".
 Tahun boleh berasal dari nama file atau kolom yang dipetakan; keduanya dicek.
 Kolom lain tetap disimpan sebagai src_*; semua nama asal ada di source_columns.csv.
*****************************************************************************/

global INPUT_YEARS "2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"
* Optional shortcut: set folder and filename pattern once. Per-year FILE overrides below still win.
global INPUT_FOLDER ""
global INPUT_FILE_PATTERN "survey_{year}.xlsx"
global INPUT_FORMAT "excel"
global INPUT_SHEET ""              // kosong = sheet pertama
global INPUT_HEADER_ROW 1
global INPUT_FIRST_DATA_ROW 2       // harus sesudah baris header
global INPUT_FILTER_YEAR 0         // 1 bila satu file berisi beberapa tahun
global INPUT_LAST_DATA_ROW 0        // 0 = sampai baris terakhir workbook

* Nama standar di kiri TETAP. Teks di kanan adalah nama kolom di file sumber.
* Kosongkan nama opsional bila datanya memang tidak tersedia.
global COL_FIRM_ID "psid"
global COL_OBS_ID "obs_id"
global COL_YEAR "source_year"
global COL_PROVINCE "province_code"
global COL_SECTOR "industry_code"
global COL_WORKERS "workers"
global COL_OUTPUT "gross_output_nominal"
global COL_VALUE_ADDED "value_added_nominal"
global COL_INPUTS "intermediate_inputs_nominal"
global COL_MATERIALS "val_rtlvcu"
global COL_FUEL_COST "val_efuvcu"
global COL_ELECTRICITY "elec_pln_kwh"
global COL_PAYROLL_PROD "val_zpdvcu"
global COL_PAYROLL_OTHER "val_zndvcu"

* Hanya token ini yang diperlakukan missing untuk variabel kontinu.
* Tanda koma TIDAK dibuang otomatis: pilih "comma_thousands" jika memang 1,234.
global INPUT_MISSING_TOKENS ". NA N/A"
global INPUT_EXTRA_FIELDS "capital_stock_nominal capital_additions_nominal"
global COL_CAPITAL_STOCK "capital_stock_nominal"
global COL_CAPITAL_ADDITIONS "capital_additions_nominal"

global INPUT_NUMBER_STYLE "plain"   // plain | comma_thousands | comma_decimal

* Default tiap tahun; semua bisa diganti satu per satu di bawah.
foreach y of global INPUT_YEARS {
    global FILE_`y' ""
    if "$INPUT_FOLDER"!="" {
        local annual_name : subinstr global INPUT_FILE_PATTERN "{year}" "`y'", all
        global FILE_`y' "$INPUT_FOLDER/`annual_name'"
    }
    global FORMAT_`y' "$INPUT_FORMAT"
    global SHEET_`y' "$INPUT_SHEET"
    global HEADER_`y' $INPUT_HEADER_ROW
    global FIRST_`y' $INPUT_FIRST_DATA_ROW
    global LAST_`y' $INPUT_LAST_DATA_ROW
    global FILTER_YEAR_`y' $INPUT_FILTER_YEAR
    local extra_number=0
    foreach field of global INPUT_EXTRA_FIELDS {
        local ++extra_number
        global EXTRA`extra_number'_`y' ""
    }
    global EXTRA1_`y' "$COL_CAPITAL_STOCK"
    global EXTRA2_`y' "$COL_CAPITAL_ADDITIONS"
    foreach role in FIRM_ID OBS_ID YEAR PROVINCE SECTOR WORKERS OUTPUT VALUE_ADDED INPUTS MATERIALS FUEL_COST ELECTRICITY PAYROLL_PROD PAYROLL_OTHER {
        global MAP_`role'_`y' "${COL_`role'}"
    }
}

* CONTOH — hapus tanda * dan ganti sesuai file kita:
* global FILE_2010 "/lokasi/data/survei2010.xlsx"
* global SHEET_2010 "Data pabrik"
* global HEADER_2010 3
* global FIRST_2010 4
* global MAP_FIRM_ID_2010 "perusahaan_ID"
* global MAP_WORKERS_2010 "Jumlah tenaga kerja"
*
* global FILE_2011 "/lokasi/data/survei2011.dta"
* global FORMAT_2011 "dta"
* global MAP_FIRM_ID_2011 "firm_identifier"
* global MAP_WORKERS_2011 "employment"
*
* Jika TIDAK ada firm ID: global COL_FIRM_ID "" di atas loop default,
* atau global MAP_FIRM_ID_2010 "" untuk tahun tersebut.
* ID parsial/duplikat tidak diam-diam diganti. Pesan error akan menyebut tahunnya.

* Menambah variabel standar tanpa mengedit kode di bawah:
* 1. Isi INPUT_EXTRA_FIELDS di atas loop, mis. "capital_stock_nominal".
* 2. Di bawah loop: global EXTRA1_2010 "Nilai aset"
*    dan petakan tahun-tahun lain. EXTRA1 = variabel pertama dalam INPUT_EXTRA_FIELDS;
*    EXTRA2 = variabel kedua, dst. Kolom yang tidak dipetakan tetap missing.

* G1: if a particular annual file uses different capital headers:
* global EXTRA1_2010 "Closing capital stock"
* global EXTRA2_2010 "Capital expenditure"
