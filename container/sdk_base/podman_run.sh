#!/bin/sh

podman run \
    --tty --interactive \
    --name sdk_base \
    --volume /home/${USERNAME}/Dev/Panda3D:/home/${USERNAME}/Dev/Panda3D:z \
    --env HOME=/home/${USERNAME} \
    docker.io/yonnji/sdk:base \
    bash --init-file /etc/profile

podman rm sdk_base
