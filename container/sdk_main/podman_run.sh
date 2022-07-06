#!/bin/sh

podman run \
       --tty --interactive \
       --name sdk_main \
       --volume /home/${USERNAME}/Dev/Panda3D:/home/${USERNAME}/Dev/Panda3D:z \
       --env HOME=/home/${USERNAME} \
       docker.io/yonnji/sdk:main \
       bash --init-file /etc/profile

podman rm sdk_main
