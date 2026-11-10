#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENDOR_DIR="$ROOT_DIR/vendor"
GROK_DIR="$VENDOR_DIR/grok-1"

mkdir -p "$VENDOR_DIR"

if [ ! -d "$GROK_DIR/.git" ]; then
  echo "Cloning xai-org/grok-1 into $GROK_DIR"
  git clone https://github.com/xai-org/grok-1.git "$GROK_DIR"
else
  echo "Existing Grok-1 checkout found at $GROK_DIR"
  git -C "$GROK_DIR" pull --ff-only
fi

cd "$GROK_DIR"

python3 -m pip install --upgrade pip
python3 -m pip install "huggingface_hub[hf_transfer]"
python3 -m pip install -r requirements.txt

mkdir -p checkpoints

if [ "${SKIP_WEIGHTS:-0}" = "1" ]; then
  echo "SKIP_WEIGHTS=1, skipping model checkpoint download."
  exit 0
fi

huggingface-cli download xai-org/grok-1 \
  --repo-type model \
  --include "ckpt-0/*" \
  --local-dir checkpoints \
  --local-dir-use-symlinks False

echo
printf 'Setup complete.\n'
printf 'Next steps:\n'
printf '  cd %s\n' "$GROK_DIR"
printf '  python run.py\n'
