# image built from container/sdk_base.Dockerfile
FROM docker.io/yonnji/sdk:base

RUN \
    /opt/m3/bin/conda install -y conda==4.8.3 conda-build cmake && \
    /opt/m3/bin/conda clean -a -y && \
    /opt/m3/bin/pip install jenkins-job-builder

RUN \
    wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | \
        apt-key add - && \
    add-apt-repository -y "deb https://pkg.jenkins.io/debian binary/" && \
    apt update -y && \
    apt install -y openjdk-11-jre jenkins

COPY ./run-jenkins /usr/local/bin/run-jenkins
