#!/bin/sh

DIR=$(dirname ${0})

echo -en "\033]0;sdk\a"

podman run \
    --tty --interactive \
    --name sdk \
    --volume /home/${USER}/Dev/Panda3D:/home/${USER}/Dev/Panda3D:z \
    --volume $(realpath ${DIR}/itch):/home/${USER}/.config/itch:z \
    --volume $(realpath ${DIR}/conda/envs):/opt/miniconda3/envs:z \
    --env HOME=/home/${USER} \
    docker.io/yonnji/sdk \
    bash --init-file /etc/profile

podman rm sdk
