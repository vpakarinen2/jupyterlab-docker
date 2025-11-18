# Basic JupyterLab image

FROM python:3.11-slim

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Create non-root user
ARG NB_USER=jupyter
ARG NB_UID=1000
ARG NB_GID=1000

RUN groupadd -g ${NB_GID} ${NB_USER} \
    && useradd -m -s /bin/bash -N -u ${NB_UID} -g ${NB_GID} ${NB_USER}

# Install system deps
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       build-essential \
       curl \
       ca-certificates \
    && pip install --no-cache-dir jupyterlab \
    && apt-get purge -y build-essential \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# Working directory
WORKDIR /home/${NB_USER}/work
RUN chown -R ${NB_UID}:${NB_GID} /home/${NB_USER}

# Jupyter configuration
ENV JUPYTER_TOKEN="" \
    JUPYTER_PORT=8888 \
    JUPYTER_ALLOW_ROOT="false" \
    JUPYTER_ENABLE_LAB=yes

EXPOSE 8888

USER ${NB_USER}

CMD ["bash", "-lc", "jupyter lab \
  --ServerApp.ip=0.0.0.0 \
  --ServerApp.port=${JUPYTER_PORT} \
  --ServerApp.open_browser=False \
  --ServerApp.token=${JUPYTER_TOKEN} \
  --ServerApp.allow_root=${JUPYTER_ALLOW_ROOT} \
  --ServerApp.allow_remote_access=True"]
