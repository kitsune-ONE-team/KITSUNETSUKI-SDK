# image built from container/sdk_base.Dockerfile
FROM docker.io/yonnji/sdk:base

COPY ./sdk.yaml /opt/sdk.yaml

RUN \
    /opt/m3/bin/conda env update -n base -f /opt/sdk.yaml && \
    /opt/m3/bin/conda clean -a -y
