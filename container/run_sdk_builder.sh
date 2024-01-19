#!/bin/sh

DIR=$(dirname ${0})

echo -en "\033]0;sdk_builder\a"

chcon -R system_u:object_r:container_file_t:s0 $(realpath ${DIR}/jenkins)

podman run \
       --tty --interactive \
       --name sdk_builder \
       --volume $(realpath ${DIR}/jenkins):/root/jenkins:z \
       --volume $(realpath ${DIR}/../jenkins-jobs):/root/jenkins-jobs:z \
       --volume ${HOME}/.config/jenkins_jobs/:/root/.config/jenkins_jobs:z \
       --publish 0.0.0.0:8080:8080 \
       docker.io/yonnji/sdk \
       run-jenkins

podman rm sdk_builder
