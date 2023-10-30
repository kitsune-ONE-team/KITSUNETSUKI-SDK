#!/bin/sh

DIR=$(dirname ${0})

echo -en "\033]0;sdk\a"

if [[ "${1}" = "chcon" ]]; then
    chcon -Rv system_u:object_r:container_file_t:s0 ${DIR}/jenkins
fi

podman run \
    --name sdk \
    --tty --interactive \
    --volume $(realpath ${DIR}/jenkins):/root/jenkins:z \
    --volume /home/${USER}/Dev/Panda3D:/home/${USER}/Dev/Panda3D:z \
    --volume $(realpath ${DIR}/itch):/home/${USER}/.config/itch:z \
    --env HOME=/home/${USER} \
    --env PATH=/root/jenkins/workspace/sdk-lynx64/dist/sdk/bin:/usr/bin \
    docker.io/yonnji/sdk \
    bash

podman rm sdk
