#!/bin/sh

DIR=$(dirname ${0})

echo -en "\033]0;sdk_builder\a"

podman run \
       --tty --interactive \
       --name sdk_builder \
       --volume $(realpath ${DIR}/jenkins):/root/jenkins:z \
       --publish 0.0.0.0:8080:8080 \
       docker.io/yonnji/sdk \
       run-jenkins

podman rm sdk_builder
