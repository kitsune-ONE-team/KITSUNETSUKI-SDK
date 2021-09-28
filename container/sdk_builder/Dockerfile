# image built from container/sdk_base/Dockerfile
FROM docker.io/yonnji/sdk:base

RUN apt install -y openjdk-11-jre && apt clean

RUN wget -q -O /opt/jenkins.war https://get.jenkins.io/war/2.313/jenkins.war

COPY ./run-jenkins /usr/local/bin/run-jenkins

RUN /opt/miniconda3/bin/pip install jenkins-job-builder && rm -Rf /root/.cache
