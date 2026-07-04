#!/usr/bin/env bash
#
# Generate HomeKit camera-still PNGs (English + Norwegian per room) from the
# GIMP template using GIMP's batch (headless) Script-Fu interpreter.
#
# Usage:
#   ./generate_icons.sh                 # defaults: 1920x1080 -> ./output
#   HK_W=2560 HK_H=1440 ./generate_icons.sh
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Locate the GIMP console binary (3.x). Override with GIMP_BIN if needed.
GIMP_BIN="${GIMP_BIN:-/Applications/GIMP.app/Contents/MacOS/gimp-console}"
if [[ ! -x "$GIMP_BIN" ]]; then
  if command -v gimp-console >/dev/null 2>&1; then
    GIMP_BIN="$(command -v gimp-console)"
  elif command -v gimp >/dev/null 2>&1; then
    GIMP_BIN="$(command -v gimp)"
  else
    echo "error: could not find gimp-console. Set GIMP_BIN=/path/to/gimp-console" >&2
    exit 1
  fi
fi

export HK_SRC="${HK_SRC:-$SCRIPT_DIR/src/homekit_camera_still_template.xcf}"
export HK_OUT="${HK_OUT:-$SCRIPT_DIR/output}"
export HK_TRANS="${HK_TRANS:-$SCRIPT_DIR/src/translations.scm}"
export HK_W="${HK_W:-1920}"
export HK_H="${HK_H:-1080}"

mkdir -p "$HK_OUT"

echo "Rendering ${HK_W}x${HK_H} stills into: $HK_OUT"

# Feed the script over stdin so EOF terminates the batch cleanly.
"$GIMP_BIN" -i --batch-interpreter plug-in-script-fu-eval -b - \
  < "$SCRIPT_DIR/src/generate_icons.scm"

echo "Done. Files:"
ls -1 "$HK_OUT"
