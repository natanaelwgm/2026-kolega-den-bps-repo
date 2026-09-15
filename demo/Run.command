#!/bin/zsh
set -eu
RUN_FOLDER="${0:A:h}"
cd "$RUN_FOLDER"
exec python3 "$RUN_FOLDER/scripts/launch.py" "$RUN_FOLDER"
