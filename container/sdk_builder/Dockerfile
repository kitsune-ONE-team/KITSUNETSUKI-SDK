# image built from container/sdk_base/Dockerfile
FROM docker.io/yonnji/sdk:base

RUN apt install -y openjdk-11-jre

RUN wget -q -O /opt/jenkins.war https://get.jenkins.io/war-stable/2.289.3/jenkins.war

COPY ./run-jenkins /usr/local/bin/run-jenkins

RUN /opt/miniconda3/bin/pip install jenkins-job-builder
