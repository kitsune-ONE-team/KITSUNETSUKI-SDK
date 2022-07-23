# image built from container/sdk_base/Dockerfile
FROM docker.io/yonnji/sdk:base

RUN apt install -y openjdk-11-jre && apt clean
RUN wget -q -O /opt/jenkins.war https://get.jenkins.io/war-stable/2.346.2/jenkins.war
COPY ./run-jenkins /usr/local/bin/run-jenkins

COPY ./builder.yml /opt/builder.yml
RUN \
    /opt/miniconda3/bin/conda env create -f=/opt/builder.yml && \
    /opt/miniconda3/bin/conda clean -a -y && \
    rm -f /opt/builder.yml
