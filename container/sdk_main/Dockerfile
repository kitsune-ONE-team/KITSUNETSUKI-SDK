# image built from container/sdk_base/Dockerfile
FROM docker.io/yonnji/sdk:base

RUN apt install -y cloc && apt clean

COPY ./sdk.sh /etc/profile.d/sdk.sh
COPY ./sdk.yml /opt/sdk.yml
RUN \
    /opt/miniconda3/bin/conda env create -f=/opt/sdk.yml && \
    /opt/miniconda3/bin/conda clean -a -y && \
    rm -f /opt/sdk.yml
