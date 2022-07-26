#!/bin/sh

DIR=$(dirname ${0})

podman run \
       --tty --interactive \
       --name sdk_main \
       --volume /home/${USERNAME}/Dev/Panda3D:/home/${USERNAME}/Dev/Panda3D:z \
       --volume $(realpath ${DIR}/itch):/home/${USERNAME}/.config/itch:z \
       --env HOME=/home/${USERNAME} \
       docker.io/yonnji/sdk:main \
       bash --init-file /etc/profile

podman rm sdk_main
