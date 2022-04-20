#!/bin/sh

DIR=$(dirname ${0})

podman run \
       --tty --interactive \
       --name sdk_builder \
       --volume $(realpath ${DIR}/jenkins):/root/jenkins:z \
       --volume $(realpath ${DIR}/jenkins_jobs):/root/.config/jenkins_jobs:z \
       --volume $(realpath ${DIR}/binstar):/root/.config/binstar:z \
       --publish 0.0.0.0:8080:8080 \
       docker.io/yonnji/sdk:builder \
       run-jenkins

podman rm sdk_builder
