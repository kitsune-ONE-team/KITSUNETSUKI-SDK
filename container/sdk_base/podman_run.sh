#!/bin/sh

podman run \
    --tty --interactive \
    --name sdk_base \
    --volume /home/${USERNAME}/Dev/panda:/home/${USERNAME}/Dev/panda:z \
    --env HOME=/home/${USERNAME} \
    docker.io/yonnji/sdk:base \
    bash --init-file /etc/profile

podman rm sdk_base
