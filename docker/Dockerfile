FROM pytorch/pytorch:2.3.1-cuda12.1-cudnn8-runtime

# Install apt packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget git python3.10 python3.10-venv \
    libgl1-mesa-glx libglib2.0-0 \
    && \
    rm -rf /var/lib/apt/lists/*

# Setup user
ARG UID=0
ARG GID=${UID}
RUN (if [ ${GID} -ne 0 ] ; then groupadd -g ${GID} comfyui ; fi) && \
    (if [ ${UID} -ne 0 ] ; then useradd -l -m -s /bin/bash -u ${UID} -g ${GID} comfyui ; fi)
RUN mkdir -p /comfyui && \
    chown ${UID}:${GID} -R /comfyui
USER ${UID}:${GID}

# Check update
ARG REPO=comfyanonymous/ComfyUI
ARG COMMIT=master

# Setup comfyui
RUN git clone "https://github.com/${REPO}.git" /comfyui/repo && \
    cd /comfyui/repo && \
    git checkout "${COMMIT}" && \
    mkdir -p /comfyui/extra_data /comfyui/repo/output /comfyui/venv /comfyui/cache

COPY --chown=${UID}:${GID} extra_model_paths.yaml /comfyui/repo/extra_model_paths.yaml

ENV PIP_CACHE_DIR=/comfyui/cache/pip
ENV HF_HOME=/comfyui/cache/huggingface
VOLUME [ "/comfyui/venv", "/comfyui/cache" ]
WORKDIR /comfyui/repo
COPY --chown=${UID}:${GID} entrypoint.sh /comfyui/entrypoint.sh
ENTRYPOINT [ "bash", "/comfyui/entrypoint.sh" ]
