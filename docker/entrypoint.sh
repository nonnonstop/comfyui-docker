#!/usr/bin/env bash
set -Eeuo pipefail
if [[ ! -f /comfyui/venv/bin/activate ]]; then
    python3 -m venv /comfyui/venv
    source /comfyui/venv/bin/activate
    pip install -U pip wheel
    pip install -r requirements.txt
    if [[ ! -d /comfyui/repo/custom_nodes/ComfyUI-Manager ]]; then
        git clone https://github.com/ltdrdata/ComfyUI-Manager.git /comfyui/repo/custom_nodes/ComfyUI-Manager
    fi
else
    source /comfyui/venv/bin/activate
fi
git reset --hard
exec python3 main.py "$@"
