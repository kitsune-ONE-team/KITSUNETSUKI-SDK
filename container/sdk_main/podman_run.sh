#!/bin/sh

podman run \
       --tty --interactive \
       --name sdk_main \
       --volume /home/${USERNAME}/Dev/panda:/home/${USERNAME}/Dev/panda:z \
       --env HOME=/home/${USERNAME} \
       docker.io/yonnji/sdk:main \
       bash --init-file /etc/profile

podman rm sdk_main
