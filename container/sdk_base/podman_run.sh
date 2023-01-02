#!/bin/sh

DIR=$(dirname ${0})

podman run \
    --tty --interactive \
    --name sdk_base \
    --volume /home/${USERNAME}/Dev/Panda3D:/home/${USERNAME}/Dev/Panda3D:z \
    --volume $(realpath ${DIR}/itch):/home/${USERNAME}/.config/itch:z \
    --volume $(realpath ${DIR}/conda/envs):/opt/miniconda3/envs:z \
    --env HOME=/home/${USERNAME} \
    docker.io/yonnji/sdk:base \
    bash --init-file /etc/profile

podman rm sdk_base
