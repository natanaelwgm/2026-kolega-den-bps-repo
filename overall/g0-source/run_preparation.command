#!/bin/zsh
# Jalankan persiapan data dari sumber lokal sampai dataset utama dan tabel.
# Setiap file dan blok mencetak kemajuan; berhenti bila suatu pemeriksaan gagal.
set -eu
ROOT="${0:A:h}"
PYTHON='/Users/natanaelmassie/.cache/codex-runtimes/codex-primary-runtime/dependencies/python/bin/python3'
cd /private/tmp
exec "$PYTHON" "$ROOT/run_guarded.py" "$@"
