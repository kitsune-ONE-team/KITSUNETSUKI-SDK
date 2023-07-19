#!/bin/sh

DIR=$(dirname ${0})

echo -en "\033]0;sdk\a"

podman run \
    --tty --interactive \
    --name sdk \
    --volume $(realpath ${DIR}/jenkins):/root/jenkins:z \
    --volume /home/${USER}/Dev/Panda3D:/home/${USER}/Dev/Panda3D:z \
    --volume $(realpath ${DIR}/itch):/home/${USER}/.config/itch:z \
    --env HOME=/home/${USER} \
    docker.io/yonnji/sdk \
    bash

podman rm sdk
