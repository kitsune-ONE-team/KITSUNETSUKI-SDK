#!/bin/sh

DIR=$(dirname ${0})

podman run \
       --tty --interactive \
       --name sdk_base \
       --volume $(realpath ${DIR}/conda):/home/${USERNAME}/.conda:z \
       --volume /home/${USERNAME}/Dev/kitsunetsuki:/home/${USERNAME}/Dev/kitsunetsuki:z \
       --volume /home/${USERNAME}/Dev/vtuber_webcam:/home/${USERNAME}/Dev/vtuber_webcam:z \
       --volume /home/${USERNAME}/Dev/yonnji:/home/${USERNAME}/Dev/yonnji:z \
       --volume /home/${USERNAME}/Dev/kdata:/home/${USERNAME}/Dev/kdata:z \
       --env HOME=/home/${USERNAME} \
       docker.io/yonnji/sdk:main \
       bash --init-file /etc/profile

podman rm sdk_base
