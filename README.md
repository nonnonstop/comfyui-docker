# ComfyUI - Docker

## Requirement

* Docker (docker-ce)
* NVIDIA Container Toolkit (nvidia-docker2)

Tested on Ubuntu 22.04 on WSL2.

## Installation

1. Create docker-compose.override.yml for overriding settings

   ```yaml
   services:
     nvidia:
       build:
         args:
           UID: "1000"
       user: "1000:1000"
       volumes:
         - /mnt/c/sd_comfyui_data/output:/comfyui/repo/output
         - /mnt/c/sd_comfyui_data/input:/comfyui/repo/input
         - /mnt/c/sd_comfyui_data/models:/comfyui/repo/models
         - /mnt/c/sd_comfyui_data/custom_nodes:/comfyui/repo/custom_nodes
         - /mnt/c/sd_webui_data:/comfyui/extra_data
   ```

2. Build image

       docker compose build --build-arg COMMIT=master

## Usage

1. Run ComfyUI

       docker compose up

2. Access to http://localhost:8188
