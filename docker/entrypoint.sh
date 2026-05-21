#!/usr/bin/env bash
set -Eeuo pipefail
if [[ ! -f /comfyui/venv/bin/activate ]]; then
    CUDA_MAJOR=$(echo "$CUDA_VERSION" | cut -d. -f1)
    CUDA_MINOR=$(echo "$CUDA_VERSION" | cut -d. -f2)
    python3.12 -m venv /comfyui/venv
    source /comfyui/venv/bin/activate
    pip install -U pip wheel
    pip install torch torchvision torchaudio --extra-index-url "https://download.pytorch.org/whl/cu${CUDA_MAJOR}${CUDA_MINOR}"
    pip install -r requirements.txt -r manager_requirements.txt
    git reset --hard
else
    source /comfyui/venv/bin/activate
fi
exec python3.12 main.py "$@"
