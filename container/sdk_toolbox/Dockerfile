# image built from container/sdk_base/Dockerfile
FROM docker.io/yonnji/sdk:base

COPY ./sdk.yml /opt/sdk.yml

RUN \
    /opt/miniconda3/bin/conda env update -n base -f /opt/sdk.yml && \
    /opt/miniconda3/bin/conda clean -a -y
